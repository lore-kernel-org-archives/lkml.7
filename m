Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7840C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C6920656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bSz+OIIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfDVIdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:33:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:33:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3M8SIpl1558007
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Apr 2019 01:28:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3M8SIpl1558007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555921699;
        bh=xPwTE4TGEH4exT6FP4jnZFtEvK7TrmsrsO81phHIJiE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bSz+OIIa2TK48NGiej4Oda34vXEos7K+aAaxXLAkMNi/pVx1V0l2gc1PHSU0FrOkJ
         F2VD7gi26AOyuJfJgrGRGBicMCeZOTpNTRKHOevmSzBBmqePqy+syvLT6Vk0th8NFa
         t0acU6ZK+vf5z2jZzgdleyRrl2jMgjwpDfYpxz7Qy0Sf//4GeinCRnSlc09kXJ2Qby
         f55WVNLv/VtwMhBX1BFiNuypI4nuP8OsEcCqBZkDrgbvW0eSzQ3WMMhGLNFw3K9ANW
         iw99RbOLG3gpiBZHTdLDsf07UzkaZ4ejeq4lAi+qVsgISU18OZva0xyLwSvRVYh0zK
         RKJKM8XzcGsEw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3M8SHw51558004;
        Mon, 22 Apr 2019 01:28:17 -0700
Date:   Mon, 22 Apr 2019 01:28:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Young <tipbot@zytor.com>
Message-ID: <tip-9ca5c8e632ce8f144ec6d00da2dc5e16b41d593c@git.kernel.org>
Cc:     dyoung@redhat.com, x86@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ptesarik@suse.cz,
        dhowells@redhat.com, bhe@redhat.com, jgross@suse.com,
        tglx@linutronix.de, kookoo.gu@intel.com, ebiederm@xmission.com,
        hpa@zytor.com, bp@suse.de, linuxram@us.ibm.com,
        okaya@codeaurora.org, mingo@kernel.org, dave.hansen@intel.com,
        yinghai@kernel.org
Reply-To: linuxram@us.ibm.com, okaya@codeaurora.org, tglx@linutronix.de,
          hpa@zytor.com, ebiederm@xmission.com, kookoo.gu@intel.com,
          bp@suse.de, yinghai@kernel.org, mingo@kernel.org,
          dave.hansen@intel.com, x86@kernel.org, mingo@redhat.com,
          linux-kernel@vger.kernel.org, ptesarik@suse.cz,
          dyoung@redhat.com, jgross@suse.com, dhowells@redhat.com,
          bhe@redhat.com
In-Reply-To: <20190421035058.943630505@redhat.com>
References: <20190421035058.943630505@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/kdump: Have crashkernel=X reserve under 4G by
 default
Git-Commit-ID: 9ca5c8e632ce8f144ec6d00da2dc5e16b41d593c
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

Commit-ID:  9ca5c8e632ce8f144ec6d00da2dc5e16b41d593c
Gitweb:     https://git.kernel.org/tip/9ca5c8e632ce8f144ec6d00da2dc5e16b41d593c
Author:     Dave Young <dyoung@redhat.com>
AuthorDate: Sun, 21 Apr 2019 11:50:59 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 22 Apr 2019 10:15:16 +0200

x86/kdump: Have crashkernel=X reserve under 4G by default

The kdump crashkernel low reservation is limited to under 896M even for
X86_64. This obscure and miserable limitation exists for compatibility
with old kexec-tools but the reason is not documented anywhere.

Some more tests/investigations about the background:

a) Previously, old kexec-tools could only load purgatory to memory under
   2G. Eric removed that limitation in 2012 in kexec-tools:

     b4f9f8599679 ("kexec x86_64: Make purgatory relocatable anywhere
		   in the 64bit address space.")

b) Back in 2013 Yinghai removed all the limitations in new kexec-tools,
   bzImage64 can be loaded anywhere:

     82c3dd2280d2 ("kexec, x86_64: Load bzImage64 above 4G")

c) Test results with old kexec-tools with old and latest kernels:

  1. Old kexec-tools can not build with modern toolchain anymore,
     I built it in a RHEL6 vm.

  2. 2.0.0 kexec-tools does not work with the latest kernel even with
     memory under 896M and gives an error:

     "ELF core (kcore) parse failed"

     For that it needs below kexec-tools fix:

       ed15ba1b9977 ("build_mem_phdrs(): check if p_paddr is invalid")

  3. Even with patched kexec-tools which fixes 2),  it still needs some
     other fixes to work correctly for KASLR-enabled kernels.

So the situation is:

* Old kexec-tools is already broken with latest kernels.

* We can not keep these limitations forever just for compatibility with very
  old kexec-tools.

* If one must use old tools then he/she can choose crashkernel=X@Y.

* People have reported bugs where crashkernel=384M failed because KASLR
  makes the 0-896M space sparse.

* Crashkernel can reserve in low or high area, it is natural to understand
  low as memory under 4G.

Hence drop the 896M limitation and change crashkernel low reservation to
reserve under 4G by default.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Petr Tesarik <ptesarik@suse.cz>
Cc: piliu@redhat.com
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: vgoyal@redhat.com
Cc: x86-ml <x86@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Zhimin Gu <kookoo.gu@intel.com>
Link: https://lkml.kernel.org/r/20190421035058.943630505@redhat.com
---
 arch/x86/kernel/setup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a527cd9..daf7c5650c18 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -71,6 +71,7 @@
 #include <linux/tboot.h>
 #include <linux/jiffies.h>
 #include <linux/mem_encrypt.h>
+#include <linux/sizes.h>
 
 #include <linux/usb/xhci-dbgp.h>
 #include <video/edid.h>
@@ -448,18 +449,17 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #ifdef CONFIG_KEXEC_CORE
 
 /* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		(16 << 20)
+#define CRASH_ALIGN		SZ_16M
 
 /*
  * Keep the crash kernel below this limit.  On 32 bits earlier kernels
  * would limit the kernel to the low 512 MiB due to mapping restrictions.
- * On 64bit, old kexec-tools need to under 896MiB.
  */
 #ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	(512 << 20)
-# define CRASH_ADDR_HIGH_MAX	(512 << 20)
+# define CRASH_ADDR_LOW_MAX	SZ_512M
+# define CRASH_ADDR_HIGH_MAX	SZ_512M
 #else
-# define CRASH_ADDR_LOW_MAX	(896UL << 20)
+# define CRASH_ADDR_LOW_MAX	SZ_4G
 # define CRASH_ADDR_HIGH_MAX	MAXMEM
 #endif
 
