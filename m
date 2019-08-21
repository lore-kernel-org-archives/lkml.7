Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E411BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66A722D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mQwhDt5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfHUSUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:20:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10329 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfHUSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:20:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d8b720000>; Wed, 21 Aug 2019 11:20:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 11:20:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 11:20:34 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:20:34 +0000
Received: from [10.2.161.131] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:20:33 +0000
Subject: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
To:     Neil MacLeod <neil@nmacleod.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Ingo Molnar" <mingo@redhat.com>
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
X-Nvconfidentiality: public
Message-ID: <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
Date:   Wed, 21 Aug 2019 11:18:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566411634; bh=zq/3CbtGM5A3Wis08nZQ3zdlILcNQZyDz8Ni82+vWiM=;
        h=X-PGP-Universal:Subject:To:References:From:CC:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mQwhDt5QOjFblr9Gmzl6vk3BJ+P7Nt2bnRFSNYVGqEkFWNGJ6jqR8D5CDCzwcRdxa
         b66lx/qrmGhUpOAlDWwMDgcINSp2fCunnzgaL3eO86U8DmRMqlcXXx23A/eL6X0JnF
         0huSeuynzyb+UFVccNTCdxCmYmkj8MSCbCwTId5LxRUITrBVYa/4hcmxuU0szCTB4F
         1KSOwaA8c0KHjoxpFdVKqLF6E5MK9kx8aj6mdKko7w5ferb9ZqshNuRyGCS2SAg3KQ
         uRSZnkUo4cVuqiyyvalQvFw/Mv1fyUjURBoWb/z9hurTsXuDrCqnxuFwCUCoFNztOI
         +C1OwwmVIOBEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/19 10:05 AM, Neil MacLeod wrote:
> Hi John
> 
> The following bug might be of interest:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=204645
> 
> Let me know if I can be of any help.
> 

Hi Neil,

First of all, I'm pasting in the bug information so that it's directly available
here:

===================================================================
Description: Neil MacLeod 2019-08-21 16:29:19 UTC
System: Intel i5 Skylake NUC (NUC6i5SYH)

This system boots fine from internal M2 (128GB) drive with 5.3-rc4.

With 5.3-rc5, it does not boot from M2 and is stuck on the Intel splash screen (no other text is displayed, no panic etc.). It will boot 5.3-rc5 from a USB flash memory stick (via the F10 boot menu), but not from the internal M2.

Bisecting between 5.3-rc4 and 5.3-rc5, the bad commit is:

neil@nm-linux:~/projects/pullrequest_repos/torvalds-linux$ git bisect bad
a90118c445cc7f07781de26a9684d4ec58bfcfd1 is the first bad commit
commit a90118c445cc7f07781de26a9684d4ec58bfcfd1
Author: John Hubbard <jhubbard@nvidia.com>
Date:   Tue Jul 30 22:46:27 2019 -0700

     x86/boot: Save fields explicitly, zero out everything else

     Recent gcc compilers (gcc 9.1) generate warnings about an out of bounds
     memset, if the memset goes accross several fields of a struct. This
     generated a couple of warnings on x86_64 builds in sanitize_boot_params().

     Fix this by explicitly saving the fields in struct boot_params
     that are intended to be preserved, and zeroing all the rest.

     [ tglx: Tagged for stable as it breaks the warning free build there as well ]

     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
     Suggested-by: H. Peter Anvin <hpa@zytor.com>
     Signed-off-by: John Hubbard <jhubbard@nvidia.com>
     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
     Cc: stable@vger.kernel.org
     Link: https://lkml.kernel.org/r/20190731054627.5627-2-jhubbard@nvidia.com

:040000 040000 e0963edca990540dd759765a3d765af4698df892 d07e645eb3a500c31bd65526205e286ff6941187 M      arch

Comment 1 Neil MacLeod 2019-08-21 16:31:35 UTC
The kernel is built with gcc-9.2.0.

Comment 2 Neil MacLeod 2019-08-21 16:55:48 UTC

5.3-rc5 with "x86/boot: Save fields explicitly, zero out everything else" reverted will build with gcc-9.2.0, and boot from M2.
===================================================================

I'm also CC'ing the lists, so they know that the patch has caused a regression, and
also out of hope that they can help me choose the shortest path forward to debugging
this. My first reaction is that the list of BOOT_PARAM_PRESERVE() fields is
flawed--by which I include cases of  "the system improperly relied on a field that the spec said
should be zeroed". (After all, the boot_params->sentinel is set, which already means
the system is not really doing it right.)

So I'm going to cheat and ask right now if anyone notices either ommissions
or wrong entries here:

static void sanitize_boot_params(struct boot_params *boot_params)
{
...
		const struct boot_params_to_save to_save[] = {
			BOOT_PARAM_PRESERVE(screen_info),
			BOOT_PARAM_PRESERVE(apm_bios_info),
			BOOT_PARAM_PRESERVE(tboot_addr),
			BOOT_PARAM_PRESERVE(ist_info),
			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
			BOOT_PARAM_PRESERVE(hd0_info),
			BOOT_PARAM_PRESERVE(hd1_info),
			BOOT_PARAM_PRESERVE(sys_desc_table),
			BOOT_PARAM_PRESERVE(olpc_ofw_header),
			BOOT_PARAM_PRESERVE(efi_info),
			BOOT_PARAM_PRESERVE(alt_mem_k),
			BOOT_PARAM_PRESERVE(scratch),
			BOOT_PARAM_PRESERVE(e820_entries),
			BOOT_PARAM_PRESERVE(eddbuf_entries),
			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
			BOOT_PARAM_PRESERVE(e820_table),
			BOOT_PARAM_PRESERVE(eddbuf),
		};

If not, then I think we need to bisect by...well, let's start with the
theory that we zeroed out too much, so we could start adding more fields
to preserve.  If that doesn't find the problem, then it's more complicated,
and might be better to go the other direction: starting without my commit,
and zeroing out fields until we see the failure.

Are you able to test patches? It would take some time, since there are quite a
few fields. Alternately, if you provide some more system information details
(especially if we have any other notes about other failures and passes), then
I might be able to borrow a Skylake system and attempt a repro.


thanks,
-- 
John Hubbard
NVIDIA
