Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D37218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfCUL36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:29:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfCUL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:29:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LBTZT1107262
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:29:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LBTYlq107259;
        Thu, 21 Mar 2019 04:29:34 -0700
Date:   Thu, 21 Mar 2019 04:29:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Aditya Pakki <tipbot@zytor.com>
Message-ID: <tip-2e84f116afca3719c9d0a1a78b47b48f75fd5724@git.kernel.org>
Cc:     hpa@zytor.com, keescook@chromium.org, pakki001@umn.edu,
        mingo@kernel.org, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, roland@purestorage.com,
        nstange@suse.de, joe@perches.com
Reply-To: tglx@linutronix.de, pakki001@umn.edu, keescook@chromium.org,
          hpa@zytor.com, mingo@kernel.org, bp@alien8.de, nstange@suse.de,
          joe@perches.com, linux-kernel@vger.kernel.org,
          roland@purestorage.com
In-Reply-To: <20190319021958.17275-1-pakki001@umn.edu>
References: <20190319021958.17275-1-pakki001@umn.edu>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hpet: Prevent potential NULL pointer
 dereference
Git-Commit-ID: 2e84f116afca3719c9d0a1a78b47b48f75fd5724
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

Commit-ID:  2e84f116afca3719c9d0a1a78b47b48f75fd5724
Gitweb:     https://git.kernel.org/tip/2e84f116afca3719c9d0a1a78b47b48f75fd5724
Author:     Aditya Pakki <pakki001@umn.edu>
AuthorDate: Mon, 18 Mar 2019 21:19:56 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:24:38 +0100

x86/hpet: Prevent potential NULL pointer dereference

hpet_virt_address may be NULL when ioremap_nocache fail, but the code lacks
a check.

Add a check to prevent NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kjlu@umn.edu
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joe Perches <joe@perches.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Roland Dreier <roland@purestorage.com>
Link: https://lkml.kernel.org/r/20190319021958.17275-1-pakki001@umn.edu

---
 arch/x86/kernel/hpet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index dfd3aca82c61..fb32925a2e62 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -905,6 +905,8 @@ int __init hpet_enable(void)
 		return 0;
 
 	hpet_set_mapping();
+	if (!hpet_virt_address)
+		return 0;
 
 	/*
 	 * Read the period and check for a sane value:
