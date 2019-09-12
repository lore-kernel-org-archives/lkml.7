Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65711C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4378120692
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfILKfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:35:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47479 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730470AbfILKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:35:04 -0400
X-UUID: db49a7ec7fa84b9c9ce2069bd83947ed-20190912
X-UUID: db49a7ec7fa84b9c9ce2069bd83947ed-20190912
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 469677759; Thu, 12 Sep 2019 18:34:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Sep 2019 18:34:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Sep 2019 18:34:52 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] psi: put NULL char correctly in psi_write()
Date:   Thu, 12 Sep 2019 18:34:52 +0800
Message-ID: <20190912103452.13281-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When passing a equal or more then 32 bytes long string to psi_write(),
psi_write() copies 31 bytes to its buf and overwrites buf[30]
with '\0'. Which makes the input string 1 byte shorter than
it should be.

Fix it by copying sizeof(buf) bytes when nbytes >= sizeof(buf).

This does not cause problems in normal use case like:
"some 500000 10000000" or "full 500000 10000000" because they
are less than 32 bytes in length.

	/* assuming nbytes == 35 */
	char buf[32];

	buf_size = min(nbytes, (sizeof(buf) - 1)); /* buf_size = 31 */
	if (copy_from_user(buf, user_buf, buf_size))
		return -EFAULT;

	buf[buf_size - 1] = '\0'; /* buf[30] = '\0' */

Before:
%cd /proc/pressure/
%echo "123456789|123456789|123456789|1234" > memory
[   22.473497] nbytes=35,buf_size=31
[   22.473775] 123456789|123456789|123456789| (print 30 chars)
%sh: write error: Invalid argument

%echo "123456789|123456789|123456789|1" > memory
[   64.916162] nbytes=32,buf_size=31
[   64.916331] 123456789|123456789|123456789| (print 30 chars)
%sh: write error: Invalid argument

After:
%cd /proc/pressure/
%echo "123456789|123456789|123456789|1234" > memory
[  254.837863] nbytes=35,buf_size=32
[  254.838541] 123456789|123456789|123456789|1 (print 31 chars)
%sh: write error: Invalid argument

%echo "123456789|123456789|123456789|1" > memory
[ 9965.714935] nbytes=32,buf_size=32
[ 9965.715096] 123456789|123456789|123456789|1 (print 31 chars)
%sh: write error: Invalid argument

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 6e52b67b420e..517e3719027e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1198,7 +1198,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
-	buf_size = min(nbytes, (sizeof(buf) - 1));
+	buf_size = min(nbytes, sizeof(buf));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
 
-- 
2.18.0

