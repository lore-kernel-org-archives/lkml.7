Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1790C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B338F20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tvbq54yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfGJUTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:19:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42868 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfGJUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:19:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so1598158pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=xuwo4gvqE3MCOIjmfp65QB1d2BsETVoFBxxN7PO8YcI=;
        b=Tvbq54yjRqp2I+DxgbkQIx4zGd6t7zDvvfx9lAy0Msq6znsJqpAYLEZqYqvbWJtdZz
         hffI0l+kfvKidecFMTHTCnifFRoJU0ZM5SqxC1WqlPWtTUwIRbeogRwx58V5oHbcd7f0
         1BVE3PkzL2uQxTliRKV2sWjdOPJ0C4DFs82676AzcHqNPtuWtbHHatSjNHJWHOvQj8ZZ
         yK8vJWMC7jXZHOY6Yq32UMK8tTyG3ecoBIaOPTWdIgmZAP1dYnD5hAEzqYLx2r97ggzr
         JioIB340IzkpFQuIoohu9f/eCxLQp+G2pm3xaGB/HEBPi/ELXE3lp/N3gdvZGDUQvTWQ
         N52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=xuwo4gvqE3MCOIjmfp65QB1d2BsETVoFBxxN7PO8YcI=;
        b=HQzKesZZkDiypaa+PFVx+nBwiOtQzxXX1gOIGtreafc5FfbAR6TSx6Atnua9hSZKdJ
         h9b5kQ1NBfrXu8a052uk7wnGMUvSOVfMcjev/+g6qCWwb8yrUbWi68pqwEEtNWe5abYE
         pigXMU7ooylKRTh7jtCpUEjI4/MRJnJCNpeWxSdwY0qTgSsf+bHi4Hb+fM8KdIM3bbX3
         7zpZkyjsg9VegKq1Xkl1FSawwCotQtGriKXY98pmBYVqlWAsRqOSF5qgSLPxkUH1tXXJ
         +8B0UnnJqWrHcbfdy81uHsXpR4LN05rLAxKJL5BfoLoRnXiPpve7SF39MuqD6nNSqvL9
         ZIJg==
X-Gm-Message-State: APjAAAWExqt7DsLAC/iZtiwEEmtrVZ1eD9wbw2Qr3xoMP3WPAYyligkX
        lFB4YFRGgD26cCC1d8d6qT988A==
X-Google-Smtp-Source: APXvYqxOcy8UJaeHMYjeCxs4ajxDqnRITKwkZzivFvUPLokeX6ryc9P/bCPLiTekdLu409UslmrrNw==
X-Received: by 2002:a17:90a:2706:: with SMTP id o6mr257907pje.62.1562789977015;
        Wed, 10 Jul 2019 13:19:37 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c130sm2954552pfc.184.2019.07.10.13.19.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 13:19:36 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:19:35 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
cc:     Cfir Cohen <cfir@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [patch] x86/mm: Free sme_early_buffer after init
Message-ID: <alpine.DEB.2.21.1907101318170.197432@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to clear the contents of sme_early_buffer after
__sme_early_enc_dec() because it is used to move encrypted and decrypted
data, but since __sme_early_enc_dec() is __init we can simply free this
buffer after init.

This saves a page that is otherwise unreferenced after init.

Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/mm/mem_encrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -41,7 +41,7 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
 bool sev_enabled __section(.data);
 
 /* Buffer used for early in-place encryption by BSP, no locking needed */
-static char sme_early_buffer[PAGE_SIZE] __aligned(PAGE_SIZE);
+static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
 /*
  * This routine does not change the underlying encryption setting of the
