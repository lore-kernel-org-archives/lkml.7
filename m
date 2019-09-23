Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D840DC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CF220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bPp7hz00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfIWSuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:50:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59455 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfIWSuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:50:37 -0400
Received: from [IPv6:2601:646:8600:3281:8026:d242:8b48:df7f] ([IPv6:2601:646:8600:3281:8026:d242:8b48:df7f])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8NInsIc2769713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 23 Sep 2019 11:49:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8NInsIc2769713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1569264598;
        bh=JqM1cbZCFR8BmT5KlE1PpxD4ZxB6ezuyvqNDHNfwAOA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=bPp7hz00c5vkfxlCdw1lKz5hwx2gjuDGqv32wCBcVdujA9JyNhMxm47WRbCqFVYa/
         tXB3O77zPknTNEUiM7JmEdTbrbJddp6b4yCLqHReB2j2Q+alDAjUPFzWDgw/zaHTSl
         ShwnbzKUZGut3Zuwq5L7neWVonquhCmUrcWeJ0y5DQN3SQm0awH8fMCjo0GhHaUKle
         wybmNshXOuZ3USmdJqGzLeBlHglgXlMBK9f04e9Nd6BP30CcQrQfnsW5w8r9jPpuno
         wZfRlsB5Slm1kr+qFE74OiBBAWHHvsoYIQWT9COFZ+FMkkRfmrsSjfIAJINqN2gA02
         fuRlqI+QbODlw==
Date:   Mon, 23 Sep 2019 11:49:44 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <51b87d62e0cade3c46a69706b9be249190abc7bd.1569004923.git.steve.wahl@hpe.com>
References: <cover.1569004922.git.steve.wahl@hpe.com> <51b87d62e0cade3c46a69706b9be249190abc7bd.1569004923.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area.
To:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
CC:     Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
From:   hpa@zytor.com
Message-ID: <75F03666-AB27-4C72-B3FF-67B1C7BE8575@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 23, 2019 11:15:20 AM PDT, Steve Wahl <steve=2Ewahl@hpe=2Ecom> =
wrote:
>Our hardware (UV aka Superdome Flex) has address ranges marked
>reserved by the BIOS=2E Access to these ranges is caught as an error,
>causing the BIOS to halt the system=2E
>
>Initial page tables mapped a large range of physical addresses that
>were not checked against the list of BIOS reserved addresses, and
>sometimes included reserved addresses in part of the mapped range=2E
>Including the reserved range in the map allowed processor speculative
>accesses to the reserved range, triggering a BIOS halt=2E
>
>Used early in booting, the page table level2_kernel_pgt addresses 1
>GiB divided into 2 MiB pages, and it was set up to linearly map a full
>1 GiB of physical addresses that included the physical address range
>of the kernel image, as chosen by KASLR=2E  But this also included a
>large range of unused addresses on either side of the kernel image=2E
>And unlike the kernel image's physical address range, this extra
>mapped space was not checked against the BIOS tables of usable RAM
>addresses=2E  So there were times when the addresses chosen by KASLR
>would result in processor accessible mappings of BIOS reserved
>physical addresses=2E
>
>The kernel code did not directly access any of this extra mapped
>space, but having it mapped allowed the processor to issue speculative
>accesses into reserved memory, causing system halts=2E
>
>This was encountered somewhat rarely on a normal system boot, and much
>more often when starting the crash kernel if "crashkernel=3D512M,high"
>was specified on the command line (this heavily restricts the physical
>address of the crash kernel, in our case usually within 1 GiB of
>reserved space)=2E
>
>The solution is to invalidate the pages of this table outside the
>kernel image's space before the page table is activated=2E  This patch
>has been validated to fix this problem on our hardware=2E
>
>Signed-off-by: Steve Wahl <steve=2Ewahl@hpe=2Ecom>
>Cc: stable@vger=2Ekernel=2Eorg
>---
>Changes since v1:
>  * Added comment=2E
>  * Reworked changelog text=2E
>
> arch/x86/kernel/head64=2Ec | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/head64=2Ec b/arch/x86/kernel/head64=2Ec
>index 29ffa495bd1c=2E=2Eee9d0e3e0c46 100644
>--- a/arch/x86/kernel/head64=2Ec
>+++ b/arch/x86/kernel/head64=2Ec
>@@ -222,13 +222,27 @@ unsigned long __head __startup_64(unsigned long
>physaddr,
> 	 * we might write invalid pmds, when the kernel is relocated
> 	 * cleanup_highmap() fixes this up along with the mappings
> 	 * beyond _end=2E
>+	 *
>+	 * Only the region occupied by the kernel image has so far
>+	 * been checked against the table of usable memory regions
>+	 * provided by the firmware, so invalidate pages outside that
>+	 * region=2E  A page table entry that maps to a reserved area of
>+	 * memory would allow processor speculation into that area,
>+	 * and on some hardware (particularly the UV platform) even
>+	 * speculative access to some reserved areas is caught as an
>+	 * error, causing the BIOS to halt the system=2E
> 	 */
>=20
> 	pmd =3D fixup_pointer(level2_kernel_pgt, physaddr);
>-	for (i =3D 0; i < PTRS_PER_PMD; i++) {
>+	for (i =3D 0; i < pmd_index((unsigned long)_text); i++)
>+		pmd[i] &=3D ~_PAGE_PRESENT;
>+
>+	for (; i <=3D pmd_index((unsigned long)_end); i++)
> 		if (pmd[i] & _PAGE_PRESENT)
> 			pmd[i] +=3D load_delta;
>-	}
>+
>+	for (; i < PTRS_PER_PMD; i++)
>+		pmd[i] &=3D ~_PAGE_PRESENT;
>=20
> 	/*
> 	 * Fixup phys_base - remove the memory encryption mask to obtain

What does your MTRR setup look like, and what memory map do you present, i=
n exact detail? The BIOS is normally expected to mark the relevant ranges a=
s UC in the MTRRs (that is the remaining, legitimate usage of MTRRs=2E)

I'm somewhat sceptical that chopping off potentially several megabytes is =
a good thing=2E We also have the memory type interfaces which can be used t=
o map these as UC in the page tables=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
