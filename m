Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B6ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5995F20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfJOJ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:28:30 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:39098 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:28:29 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKJ80-0004I8-1f; Tue, 15 Oct 2019 10:28:28 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKJ7z-0005by-JO; Tue, 15 Oct 2019 10:28:27 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/signal.c: spare fix on copy_siginfo_from_user_any()
Date:   Tue, 15 Oct 2019 10:28:27 +0100
Message-Id: <20191015092827.21527-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_siginfo_from_user_any() should have __user attribute
on the siginfo_t *info pointer. Fix the following sparse warnings
by adding __user.

kernel/signal.c:3676:46: warning: incorrect type in argument 2 (different address spaces)
kernel/signal.c:3676:46:    expected struct siginfo const [noderef] [usertype] <asn:1> *from
kernel/signal.c:3676:46:    got struct siginfo [usertype] *info
kernel/signal.c:3736:58: warning: incorrect type in argument 2 (different address spaces)
kernel/signal.c:3736:58:    expected struct siginfo [usertype] *info
kernel/signal.c:3736:58:    got struct siginfo [noderef] [usertype] <asn:1> *info

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-kernel@vger.kernel.org
---
 kernel/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c4da1ef56fdf..94985c756693 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3661,7 +3661,8 @@ static bool access_pidfd_pidns(struct pid *pid)
 	return true;
 }
 
-static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
+static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
+				      siginfo_t __user *info)
 {
 #ifdef CONFIG_COMPAT
 	/*
-- 
2.23.0

