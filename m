Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D462AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFDE2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GC2PYmS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfB1XMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:39 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54158 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbfB1XMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:35 -0500
Received: by mail-pl1-f202.google.com with SMTP id t1so16188243plo.20
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wtblv7CT5Upf5j4F9ZDp7ozjiqhluHRrt49GDLKpkfY=;
        b=GC2PYmS9jR6nrnqlMzH2aZd92rT/QgV0RAhZ9ntx1vuRcVG6IiFngBTZeNuw6bzV6u
         f1pYzZ5m8GDX7LMG6N7JOdwb7tlBpa71/HnuLlEM5zohtke23Lfg98b3gWZ808IkMshv
         +u7wbW4DFyB5r+jTTvUf1akuE0xU5IU9EuYQ6XotCTFddmLeVB1/G8piCZ8dLMfsVsP4
         yR1UimMKwYlWQvulSSd57CUFEeFvJ8gAjhzdOW2iajytFiwvnYtyfS2qQN8xEhE7G6Zr
         IEWt45+L5WvUWk35DQMLxlvFcW5hT5hehluPIQpjuQCysapZ21ZzdDgcj5ZteEuwXysG
         FdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wtblv7CT5Upf5j4F9ZDp7ozjiqhluHRrt49GDLKpkfY=;
        b=M0njUtWyfNw7fQxh5O+m9nD6eDAMC0oaXEIvNBl7ap0R1B6ZKOc6qk1gbEF8m0aKMn
         uVQiynxfj/IVTRX8HspjjgtFMXsAGyqeMRVQ7LtAMHMYm4gtnycYHxTVVQtXJdicK2/y
         XDDy4rZdzUkrzoi9VpbGbg35SKFQbtERCVWIg0pqBHqbITSvRTNymBzWN5PmHxUXna24
         ZTH6kEkMogH3BwO3clTBpOoyhL4z/PNOlh2LRtAkpFLtrXcDvwYUBqxtQT2ud6MljRQ9
         0uomOTyJPwDRMHoZqI50A1yM25dRXpqVCUfAXdhclYUamAq2I8J4Pns3oDiu83n637XV
         tBmQ==
X-Gm-Message-State: APjAAAX6f6Xt0ZNZJjwbxfb0qYPH0s9GKewV7E0yLwsc+RE0lP5UXsY1
        xOdS6qcAuya+0gIJeUDXlPoCm1D9hZIsVYaoHToWwg==
X-Google-Smtp-Source: APXvYqzrGA7dIkJjpqwmFqWlyr4b6N/5jE4dyLWuDOrDg08GA7j64lKrGinC5H0wOfNXX1Q2F3Gb7VxNeHL5AryL7HAfWQ==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr671197plb.108.1551395554796;
 Thu, 28 Feb 2019 15:12:34 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:48 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 12/27] x86: Lock down IO port access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

IO port access would permit users to gain access to PCI configuration
registers, which in turn (on a lot of hardware) give access to MMIO
register space. This would potentially permit root to trigger arbitrary
DMA, so lock it down by default.

This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
KDDISABIO console ioctls.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: x86@kernel.org
---
 arch/x86/kernel/ioport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 0fe1c8782208..abc702a6ae9c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -31,7 +31,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
+			kernel_is_locked_down("ioperm")))
 		return -EPERM;
 
 	/*
@@ -126,7 +127,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    kernel_is_locked_down("iopl"))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
-- 
2.21.0.352.gf09ad66450-goog

