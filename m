Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05326C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A8021726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwtO8Y0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEHUoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:44:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42451 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfEHUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:44:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so53324pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YYyoKQzwtxr9MifM5oym/pC4UmAt0s6fSNFjRNQVLRo=;
        b=gwtO8Y0bubAMhz9zxXsOtqaL0DI1zXLSHYBYM/Z804yvYg8XIgUu6q1UOM69XENTTl
         mgmsv17uve0OWx0fXibqjyBbI4CEtJUDVIUfha79ep88QBJQgb+JzUJawBcj182IU+ul
         07bYNAQogmHK0O3pNF7YU9Quh/zJJLmWbzlPCrxRhW1OoxdXU0L9BHL7MSQH63Jp3uIh
         KoBwuZv9fiI/GODXoz3ObByp4U6CGjhnUzzQShFXcJ8jodJWLkJmclXz0Na85M8h5Qva
         RZiUug47mxWA/6MWL14HZvv+F8PZdoE3F8Jfnf6I0sDWvsJwPuBC/Rz9eYpWarFkcd9/
         0CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YYyoKQzwtxr9MifM5oym/pC4UmAt0s6fSNFjRNQVLRo=;
        b=sC5nkDbK+MCx6GX9zSaWgcVFklXSKEMqSIGYI/iVrDGZV+pynyLe8vr/BoTwQLFcF5
         wo4dTH++MpeC5oTqYhIyzqSVcCV4uh/ugFY2CaPgJsmxqeBGOCj17Ld803S9bBNWTZVP
         sIqsGT6wp9RIAn3nncYrf4HFJk+kCC5DHL7/XsqzgeMoVTWOKSycqI8TgYYKm4YI9U6N
         VhvSkRxKm9EJZ6SwSaXlPfPdhCZUaXJ0PuHEEf6q0av+bX2oR7YuZF2pKnxC4t/Cil2l
         S6vGPi4bjYcJ/bc1jdG2gtIGUD2K634gg5vXL4Ugz2c7z6J/6vwFE/qd/0fyxo6u0R7G
         7NjQ==
X-Gm-Message-State: APjAAAVq/RyDFjXp/Ah1OTsdZ3I+czaSh6omr6aXFze3OQv2ARaHOcqO
        JQgFDHxl8KJlYIuzEHXzoOA=
X-Google-Smtp-Source: APXvYqzoiar0i2NxWfO9Gjo41XQ6H+7CmgQOaVLAB3REYxNuAgc4W2POVCZ/yjIv4nHriaUdjs9B8w==
X-Received: by 2002:a65:430a:: with SMTP id j10mr201131pgq.133.1557348254734;
        Wed, 08 May 2019 13:44:14 -0700 (PDT)
Received: from localhost ([2601:640:0:ebed:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id 8sm128977pfn.158.2019.05.08.13.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 13:44:14 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Yury Norov <ynorov@marvell.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: fix double definition for __VIRTUAL_MASK_SHIFT
Date:   Wed,  8 May 2019 13:44:11 -0700
Message-Id: <20190508204411.13452-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__VIRTUAL_MASK_SHIFT is defined twice to the same valie in
arch/x86/include/asm/page_32_types.h. Fix it.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 arch/x86/include/asm/page_32_types.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index 0d5c739eebd7..9bfac5c80d89 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -28,6 +28,8 @@
 #define MCE_STACK 0
 #define N_EXCEPTION_STACKS 1
 
+#define __VIRTUAL_MASK_SHIFT	32
+
 #ifdef CONFIG_X86_PAE
 /*
  * This is beyond the 44 bit limit imposed by the 32bit long pfns,
@@ -36,11 +38,8 @@
  * The real limit is still 44 bits.
  */
 #define __PHYSICAL_MASK_SHIFT	52
-#define __VIRTUAL_MASK_SHIFT	32
-
 #else  /* !CONFIG_X86_PAE */
 #define __PHYSICAL_MASK_SHIFT	32
-#define __VIRTUAL_MASK_SHIFT	32
 #endif	/* CONFIG_X86_PAE */
 
 /*
-- 
2.17.1

