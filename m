Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A266C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F0217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WNtGSl3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfFZNCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:02:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZNCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:02:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QD2gk94112661
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 06:02:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QD2gk94112661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561554162;
        bh=2KdsEmoK84RYDcktQ94XY4dfpIi6hmLKPNkgF9bi94s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WNtGSl3vQx7+BojyBlp2vs1ljTt6ciGcld018QJKftvw0qVec5g7mgzUQ9egjlTSm
         eS5HMlCSh47Fd2L21Xg0UHnFALiPMrtXwGEFhJ6wpviqgakChwztcaDS9wVjCQ3ftL
         9wcDZE8ctU+OLIa/aolw2wWLgPNfvpg5GZ2NzLF79hRWNDaL525F0ERVccaKniTM7B
         mXp60IMGwd45XjLfC94iB3IrYKbGe/6G0ad2hJkDB9AkadXKME+YRr5mXGTG2nTtp4
         puJFlM4CAzLm2rg5g5RuEXdq7qmsGDDMl9obpGgSDhkqyYxZsN0P4MPjPUV84QOJLB
         r/2udOVRdJuaw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QD2fpv4112658;
        Wed, 26 Jun 2019 06:02:41 -0700
Date:   Wed, 26 Jun 2019 06:02:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ferdinand Blomqvist <tipbot@zytor.com>
Message-ID: <tip-a343536f8f482be6932803a023f46d0fa723ae56@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        ferdinand.blomqvist@gmail.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, ferdinand.blomqvist@gmail.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190620141039.9874-4-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-4-ferdinand.blomqvist@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rslib] rslib: decode_rs: Fix length parameter check
Git-Commit-ID: a343536f8f482be6932803a023f46d0fa723ae56
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a343536f8f482be6932803a023f46d0fa723ae56
Gitweb:     https://git.kernel.org/tip/a343536f8f482be6932803a023f46d0fa723ae56
Author:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
AuthorDate: Thu, 20 Jun 2019 17:10:35 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:55:46 +0200

rslib: decode_rs: Fix length parameter check

The length of the data load must be at least one. Or in other words,
there must be room for at least 1 data and nroots parity symbols after
shortening the RS code.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-4-ferdinand.blomqvist@gmail.com

---
 lib/reed_solomon/decode_rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 3313bf944ff1..22006eaa41e6 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -39,7 +39,7 @@
 
 	/* Check length parameter for validity */
 	pad = nn - nroots - len;
-	BUG_ON(pad < 0 || pad >= nn);
+	BUG_ON(pad < 0 || pad >= nn - nroots);
 
 	/* Does the caller provide the syndrome ? */
 	if (s != NULL)
