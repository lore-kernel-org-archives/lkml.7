Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D8C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E202F2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FXpm5HYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfDVJrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:47:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:47:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3M9kHQr1583071
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Apr 2019 02:46:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3M9kHQr1583071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555926377;
        bh=gVN5PFdLqBPjOEas9IPy4XzmRXxWiBb42yRgJiJIe7I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FXpm5HYjwvG/Lt0tK7r4Y9sQIQyoXqw1sAG7+q06Unfc7XB5jHXTVBMTAeNfQqeFb
         zkHKR3km2taofW8BIPy13+iCtczW9R1Hn0xHJTw8pZpAfI7SJxhU5Vs27Ltzcav9cv
         DpYbZwOtPHRl7j+RmQM9UZkWEaIHoF+EkW2Ik+DxHljo1OINX1Xgz+vwO70qfV5xqq
         /jV0TS/XrA9OzErbmhc98wnrRKvKTiEs+0EYjVPznkG4U4h7ahB9uHhzGoJ3GyM/hO
         RNrhGAkKM/2qFV95CITMZyW+WHf454QbRU9D0fczgFHh5p/K1WMq1cSv7YK77cGZil
         nOwUTfJqTKtig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3M9kGGR1583068;
        Mon, 22 Apr 2019 02:46:16 -0700
Date:   Mon, 22 Apr 2019 02:46:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-36f0c423552dacaca152324b8e9bda42a6d88865@git.kernel.org>
Cc:     thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        mingo@kernel.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com, bp@suse.de,
        jgross@suse.com, fanc.fnst@cn.fujitsu.com, bhe@redhat.com
Reply-To: jgross@suse.com, bp@suse.de, fanc.fnst@cn.fujitsu.com,
          bhe@redhat.com, ard.biesheuvel@linaro.org,
          linux-kernel@vger.kernel.org, mingo@redhat.com,
          kirill.shutemov@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
          dave.hansen@linux.intel.com, thomas.lendacky@amd.com,
          tglx@linutronix.de, keescook@chromium.org, x86@kernel.org
In-Reply-To: <20190419141952.GE10324@zn.tnic>
References: <20190419141952.GE10324@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Disable RSDP parsing temporarily
Git-Commit-ID: 36f0c423552dacaca152324b8e9bda42a6d88865
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

Commit-ID:  36f0c423552dacaca152324b8e9bda42a6d88865
Gitweb:     https://git.kernel.org/tip/36f0c423552dacaca152324b8e9bda42a6d88865
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 19 Apr 2019 15:40:14 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 22 Apr 2019 11:36:43 +0200

x86/boot: Disable RSDP parsing temporarily

The original intention to move RDSP parsing very early, before KASLR
does its ranges selection, was to accommodate movable memory regions
machines (CONFIG_MEMORY_HOTREMOVE) to still be able to do memory
hotplug.

However, that broke kexec'ing a kernel on EFI machines because depending
on where the EFI systab was mapped, on at least one machine it isn't
present in the kexec mapping of the second kernel, leading to a triple
fault in the early code.

Fixing this properly requires significantly involved surgery and we
cannot allow ourselves to do that, that close to the merge window.

So disable the RSDP parsing code temporarily until it is fixed properly
in the next release cycle.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190419141952.GE10324@zn.tnic
---
 arch/x86/boot/compressed/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..5a237e8dbf8d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
 	/* Save RSDP address for later use. */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	/* boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
 
 	sanitize_boot_params(boot_params);
 
