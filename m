Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF0C20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfC1Lmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:42:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34480 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1Lmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:42:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so7055001wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 04:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5Z3iuqigYL5OSOtCwI97WwldI8RZNjp6Zf9iWgjUaw=;
        b=XGGXkGo4gzg4AYK2CY0LF1N2HhPwXzDJbu+Fu6fUkXEBizgEeJ442s0PVQUnVmz+8V
         IsKeix/kPgAIsBhnhHwDr6b0aML9mXz91b4qUzg7K6lgBP6j9Eh30T87ER8GLDHybBhS
         xemtN1bYwvfaY2Qd3Q55oM6Sd/eQaZjKLQMbr2QteUrr042omChIHx6u+fE7E/Q0j/Ay
         C76Gx40JUtRv6GwfQrjMDmUWcoXgU+nOEtE6XdMPtN+jn/vjPt/mDsyAPCvnbDMSunYO
         hlzS4gJ3d0PEOpWz8oMNxS19IWGs3OavMb3vJiRyc05SvpEajIs+L7ZiLI4fZLd58SSs
         PPww==
X-Gm-Message-State: APjAAAUDztr9K/MpKXcCZ1q98X0z5YCqFIy/WZoTNuePVoIhW5BFItuk
        i0SnR+kC5HliucK7k27N7cg52w==
X-Google-Smtp-Source: APXvYqxitslx2u0PXkZukrn5OiHl9o8IakcosW/rzeYLcKH6ipPsG2KpFzUwAebMByKV7Omo/dh5qg==
X-Received: by 2002:a1c:d0c7:: with SMTP id h190mr16439817wmg.17.1553773355495;
        Thu, 28 Mar 2019 04:42:35 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id g10sm3988622wrq.2.2019.03.28.04.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 04:42:34 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org, linux-efi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] x86: remove unused argument from set_real_mode_mem()
Date:   Thu, 28 Mar 2019 12:42:33 +0100
Message-Id: <20190328114233.27835-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following commit b929a500d684 ("x86/realmode: Don't leak the trampoline
kernel address"), set_real_mode_mem() is a trivial function with a
unused argument.
Remove the unused argument and move it into an header file, so it can be
inlined.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/x86/include/asm/realmode.h | 6 +++++-
 arch/x86/platform/efi/quirks.c  | 2 +-
 arch/x86/realmode/init.c        | 9 +--------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 63b3393bd98e..c53682303c9c 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -77,7 +77,11 @@ static inline size_t real_mode_size_needed(void)
 	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
 }
 
-void set_real_mode_mem(phys_addr_t mem, size_t size);
+static inline void set_real_mode_mem(phys_addr_t mem)
+{
+	real_mode_header = (struct real_mode_header *) __va(mem);
+}
+
 void reserve_real_mode(void);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 458a0e2bcc57..a25a9fd987a9 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -449,7 +449,7 @@ void __init efi_free_boot_services(void)
 		 */
 		rm_size = real_mode_size_needed();
 		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
-			set_real_mode_mem(start, rm_size);
+			set_real_mode_mem(start);
 			start += rm_size;
 			size -= rm_size;
 		}
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 47d097946872..7dce39c8c034 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -15,13 +15,6 @@ u32 *trampoline_cr4_features;
 /* Hold the pgd entry used on booting additional CPUs */
 pgd_t trampoline_pgd_entry;
 
-void __init set_real_mode_mem(phys_addr_t mem, size_t size)
-{
-	void *base = __va(mem);
-
-	real_mode_header = (struct real_mode_header *) base;
-}
-
 void __init reserve_real_mode(void)
 {
 	phys_addr_t mem;
@@ -40,7 +33,7 @@ void __init reserve_real_mode(void)
 	}
 
 	memblock_reserve(mem, size);
-	set_real_mode_mem(mem, size);
+	set_real_mode_mem(mem);
 }
 
 static void __init setup_real_mode(void)
-- 
2.20.1

