Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC44420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551988565;
	bh=DzIjhbmbGed7quhe0kPQeN/+yooUZVT7xuxlLEHTaiA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zvEHHwC9/8ffw/Q0EYw4v+tegkCS1EqoG2rXJoDq4AW5B48BfOsT1GNQRUrPA2YCY
	 1xnCp653aZQWmT0iqBKuOniIWZ3dplfQ9RWCNDHajW4f2o9XgR8IZAYyR5vm8sfv0n
	 BNu3S4M7zGEYqlPZeKlq8alp7pblOXTyQbX1+QTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCGT4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:56:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38908 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGT4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:56:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id a188so10395527wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rv2BW4JrvDZXPoDqT0VTg44Us2+VEvByjwkF2p7LzSE=;
        b=bAYqxtMTvtrRQhAVKNGCZfu1aW/myCsjcyPXwT7w3LC2hNIfTz/+UGqxmW5EdZCo67
         8FKpvacUZJ3NUMoPLrK+3ZmD2bOtdzHjSTDyOf/XclfzKJKPffTqUfUtL14cW33ZZWFS
         0prcxoIgzLaLro0cQaRG2kxFpMiSNJ2y9eVvW0hn6tODVT+9kZPi37qqvFynyC1AfsCV
         BJ6Ga/12Amt/qyDLSkmA/rJyvg82NjyOtsQiALroaQ2FtY58uKDMuvqf4EAKbZUS5tfn
         i/JkuRuz2tiq0x1yRquORZG+BBDG7uHh09yKvQ73xJC5c0GC/6MW/0uUOfzL+FaYhQbu
         mUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=rv2BW4JrvDZXPoDqT0VTg44Us2+VEvByjwkF2p7LzSE=;
        b=mJgWbhoZ5UVRYWENDMMWLgL0FwNfizCk+5XfN51o5pb/FQe+GVbhGuc99ocrs2yieP
         Ct73EVIOtpM7NVONJ89vfgOvoe8IYjlZcbPM4qYlAnUXf7/mE/jFLBkXWMkvAzAgerO4
         5h9WNjhmKmTy1lGcfScLcpulldoidSfaUb4FtildEspTlLSCaGgrbPzTLub8EmPj85gE
         pNIZW4Uu7058NJKjIw5764iH1UN7ZjUBRLleRg4jYymf3AXf8hx+mg4GeqOP/+2c2F7b
         oXzGg5LMo1DC3/L9AAS234uOFEOpDBRJZhpBJXcnbG0VLQ9g3EHkf798A8hogs5WhASd
         rLkQ==
X-Gm-Message-State: APjAAAXm2spJKM4D+Ju1VIeQ2src0Z8ByZZTjGTjOZIq61vBHDy8gzW4
        4RwdAKqJ7nPkMaMm4um2Lw1+DIbd
X-Google-Smtp-Source: APXvYqwCve0uXNCF7Gx7w9ocAeel66Sm21WEl8ewoAKc8hZa/vKeDjdpfQozxiQm8Tk+sbyBkLxVjQ==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr6319486wmd.132.1551988561674;
        Thu, 07 Mar 2019 11:56:01 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f13sm4916866wmj.29.2019.03.07.11.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 11:56:01 -0800 (PST)
Date:   Thu, 7 Mar 2019 20:55:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/uv changes for v5.1
Message-ID: <20190307195559.GA112460@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-uv-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-uv-for-linus

   # HEAD: 8945d96f7b3ead56e053ac79b8f7b0de98a30bfe x86/platform/UV: Use efi_enabled() instead of test_bit()

Three UV related cleanups.

 Thanks,

	Ingo

------------------>
Hedi Berriche (3):
      x86/platform/UV: Remove unnecessary #ifdef CONFIG_EFI
      x86/platform/UV: Remove uv_bios_call_reentrant()
      x86/platform/UV: Use efi_enabled() instead of test_bit()


 arch/x86/include/asm/uv/bios.h |  5 -----
 arch/x86/platform/uv/bios_uv.c | 16 +---------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index e652a7cc6186..8c6ac271b5b3 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -140,7 +140,6 @@ enum uv_memprotect {
  */
 extern s64 uv_bios_call(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 extern s64 uv_bios_call_irqsave(enum uv_bios_cmd, u64, u64, u64, u64, u64);
-extern s64 uv_bios_call_reentrant(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 
 extern s64 uv_bios_get_sn_info(int, int *, long *, long *, long *, long *);
 extern s64 uv_bios_freq_base(u64, u64 *);
@@ -151,11 +150,7 @@ extern s64 uv_bios_change_memprotect(u64, u64, enum uv_memprotect);
 extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
-#ifdef CONFIG_EFI
 extern void uv_bios_init(void);
-#else
-void uv_bios_init(void) { }
-#endif
 
 extern unsigned long sn_rtc_cycles_per_second;
 extern int uv_type;
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4a6a5a26c582..38a2e3431fc6 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -44,7 +44,7 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
 	 * callback method, which uses efi_call() directly, with the kernel page tables:
 	 */
-	if (unlikely(test_bit(EFI_OLD_MEMMAP, &efi.flags)))
+	if (unlikely(efi_enabled(EFI_OLD_MEMMAP)))
 		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
 	else
 		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
@@ -66,18 +66,6 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	return ret;
 }
 
-s64 uv_bios_call_reentrant(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
-					u64 a4, u64 a5)
-{
-	s64 ret;
-
-	preempt_disable();
-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
-	preempt_enable();
-
-	return ret;
-}
-
 
 long sn_partition_id;
 EXPORT_SYMBOL_GPL(sn_partition_id);
@@ -188,7 +176,6 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 }
 EXPORT_SYMBOL_GPL(uv_bios_set_legacy_vga_target);
 
-#ifdef CONFIG_EFI
 void uv_bios_init(void)
 {
 	uv_systab = NULL;
@@ -218,4 +205,3 @@ void uv_bios_init(void)
 	}
 	pr_info("UV: UVsystab: Revision:%x\n", uv_systab->revision);
 }
-#endif
