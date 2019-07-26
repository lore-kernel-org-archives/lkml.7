Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9656EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4C5229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149241;
	bh=mrGgpuMBbWwM5rUiv/Ioh0bwJaXjLkqd/P/eLi2l8gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qn49yhQZEMLb5+aJ73Nge3kLap2nw6AGI31hby53y4T/BOTbL3Kd0OYIwS11BwLJ6
	 3YYhhTT06OWGzYFhV7a4dY26M9ChVAHm6w/npZrKLAotfVSJk0LuK+TmrBbGunvpru
	 mkN4qOIGfAx81xZYqoO6do1NgMbwdR7v6xnh1BMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfGZNyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbfGZNnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBFD22CD9;
        Fri, 26 Jul 2019 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148587;
        bh=mrGgpuMBbWwM5rUiv/Ioh0bwJaXjLkqd/P/eLi2l8gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuQPUrSEdKBiJY4EJnFGd5Tr/hfXPsTUfFZdSAnqYxjMPXPeLrRe5yDPAP1Zn/xZa
         88f4t5CZR6PvLFlpHFdVAGWRdvmprKvr0gH459lCoik3fVFn6hlMaBn4nw0aekGMrp
         zNwSicLcDNeJqLiestwEH3J8RDHpTvpR8c8Ukzb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Fabian Frederick <fabf@skynet.be>,
        Mikko Rapeli <mikko.rapeli@iki.fi>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, codalist@coda.cs.cmu.edu
Subject: [PATCH AUTOSEL 4.19 33/47] coda: add error handling for fget
Date:   Fri, 26 Jul 2019 09:41:56 -0400
Message-Id: <20190726134210.12156-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 02551c23bcd85f0c68a8259c7b953d49d44f86af ]

When fget fails, the lack of error-handling code may cause unexpected
results.

This patch adds error-handling code after calling fget.

Link: http://lkml.kernel.org/r/2514ec03df9c33b86e56748513267a80dd8004d9.1558117389.git.jaharkes@cs.cmu.edu
Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Fabian Frederick <fabf@skynet.be>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coda/psdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c21b539..55824cba3245 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -187,8 +187,11 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 	if (req->uc_opcode == CODA_OPEN_BY_FD) {
 		struct coda_open_by_fd_out *outp =
 			(struct coda_open_by_fd_out *)req->uc_data;
-		if (!outp->oh.result)
+		if (!outp->oh.result) {
 			outp->fh = fget(outp->fd);
+			if (!outp->fh)
+				return -EBADF;
+		}
 	}
 
         wake_up(&req->uc_sleep);
-- 
2.20.1

