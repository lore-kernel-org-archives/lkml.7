Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2CFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD75C21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbfJYBRm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:17:42 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:27930 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388515AbfJYBRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:17:42 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id BC3DD28BE11A04C8D11B;
        Fri, 25 Oct 2019 09:17:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x9P1HJub089559;
        Fri, 25 Oct 2019 09:17:19 +0800 (GMT-8)
        (envelope-from zhong.shiqi@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102509175316-119804 ;
          Fri, 25 Oct 2019 09:17:53 +0800 
From:   zhongshiqi <zhong.shiqi@zte.com.cn>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        zhongshiqi <zhong.shiqi@zte.com.cn>
Subject: [PATCH v3] coccicheck: Support search for SmPL scripts within selected directory hierarchy
Date:   Fri, 25 Oct 2019 09:19:34 +0800
Message-Id: <1571966374-42566-1-git-send-email-zhong.shiqi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-25 09:17:53,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-25 09:17:24
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl2.zte.com.cn x9P1HJub089559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow defining COCCI as a directory to search SmPL scripts. Start a
corresponding file determination if the environment variable “COCCI”
contains an acceptable path.

Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
---
Changes in v3:
	1:rewrite change description
	2:fix patch subject
	3:modify commit log

Changes in v2:
	1.fix patch subject according to the reply by Markus
	<Markus.Elfring@web.de>
	2.change description in “imperative mood”
 
 scripts/coccicheck | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328..a1c4197 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -257,6 +257,10 @@ if [ "$COCCI" = "" ] ; then
     for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
 	coccinelle $f
     done
+elif [ -d "$COCCI" ] ; then
+    for f in `find $COCCI/ -name '*.cocci' -type f | sort`; do
+	coccinelle $f
+    done
 else
     coccinelle $COCCI
 fi
-- 
2.9.5

