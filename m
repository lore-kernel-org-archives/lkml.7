Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F3C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C075A206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCKBpN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:45:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54145 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfCKBpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:45:13 -0400
Received: from [IPv6:2601:646:8680:2bb1:b911:67c8:ac46:1844] ([IPv6:2601:646:8680:2bb1:b911:67c8:ac46:1844])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2B1ilYF3742446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 10 Mar 2019 18:44:49 -0700
Date:   Sun, 10 Mar 2019 18:44:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190310061840.GA21641@kroah.com>
References: <20190308124902.257040783@linuxfoundation.org> <20190308124904.216497374@linuxfoundation.org> <CED6E6E5-00E5-4FFD-A8C9-254EA3A5288E@zytor.com> <20190310061840.GA21641@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 5.0 30/46] x86/boot/compressed/64: Do not read legacy ROM on EFI system
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pitam Mitra <pitamm@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bockjoo Kim <bockjoo@phys.ufl.edu>, bp@alien8.de
From:   hpa@zytor.com
Message-ID: <FB07447E-B597-41D1-B795-E220F17018FE@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 9, 2019 10:18:40 PM PST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>On Sat, Mar 09, 2019 at 10:10:19PM -0800, hpa@zytor.com wrote:
>> On March 8, 2019 4:50:03 AM PST, Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>> >5.0-stable review patch.  If anyone has any objections, please let
>me
>> >know.
>> >
>> >------------------
>> >
>> >From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> >
>> >commit 6f913de3231e1d70a871135b38219da7810df218 upstream.
>> >
>> >EFI systems do not necessarily provide a legacy ROM. If the ROM is
>> >missing
>> >the memory is not mapped at all.
>> >
>> >Trying to dereference values in the legacy ROM area leads to a crash
>on
>> >Macbook Pro.
>> >
>> >Only look for values in the legacy ROM area for non-EFI system.
>> >
>> >Fixes: 3548e131ec6a ("x86/boot/compressed/64: Find a place for
>32-bit
>> >trampoline")
>> >Reported-by: Pitam Mitra <pitamm@gmail.com>
>> >Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> >Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> >Tested-by: Bockjoo Kim <bockjoo@phys.ufl.edu>
>> >Cc: bp@alien8.de
>> >Cc: hpa@zytor.com
>> >Cc: stable@vger.kernel.org
>> >Link:
>>
>>https://lkml.kernel.org/r/20190219075224.35058-1-kirill.shutemov@linux.intel.com
>> >Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202351
>> >Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> >---
>> > arch/x86/boot/compressed/pgtable_64.c |   19 ++++++++++++++++---
>> > 1 file changed, 16 insertions(+), 3 deletions(-)
>> >
>> >--- a/arch/x86/boot/compressed/pgtable_64.c
>> >+++ b/arch/x86/boot/compressed/pgtable_64.c
>> >@@ -1,5 +1,7 @@
>> >+#include <linux/efi.h>
>> > #include <asm/e820/types.h>
>> > #include <asm/processor.h>
>> >+#include <asm/efi.h>
>> > #include "pgtable.h"
>> > #include "../string.h"
>> > 
>> >@@ -37,9 +39,10 @@ int cmdline_find_option_bool(const char
>> > 
>> > static unsigned long find_trampoline_placement(void)
>> > {
>> >-	unsigned long bios_start, ebda_start;
>> >+	unsigned long bios_start = 0, ebda_start = 0;
>> > 	unsigned long trampoline_start;
>> > 	struct boot_e820_entry *entry;
>> >+	char *signature;
>> > 	int i;
>> > 
>> > 	/*
>> >@@ -47,8 +50,18 @@ static unsigned long find_trampoline_pla
>> > 	 * This code is based on reserve_bios_regions().
>> > 	 */
>> > 
>> >-	ebda_start = *(unsigned short *)0x40e << 4;
>> >-	bios_start = *(unsigned short *)0x413 << 10;
>> >+	/*
>> >+	 * EFI systems may not provide legacy ROM. The memory may not be
>> >mapped
>> >+	 * at all.
>> >+	 *
>> >+	 * Only look for values in the legacy ROM for non-EFI system.
>> >+	 */
>> >+	signature = (char *)&boot_params->efi_info.efi_loader_signature;
>> >+	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
>> >+	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
>> >+		ebda_start = *(unsigned short *)0x40e << 4;
>> >+		bios_start = *(unsigned short *)0x413 << 10;
>> >+	}
>> > 
>> > 	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
>> > 		bios_start = BIOS_START_MAX;
>> 
>> Only one objection: the explanation is nonsensical. 
>
>Heh, take it up with the original submitter, I don't change the
>changelog text after it hits Linus's tree :)
>
>greg k-h

:)
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
