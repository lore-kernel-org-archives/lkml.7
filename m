Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEDC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F935214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BRVoQSTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfHUSvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:51:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12599 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfHUSvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:51:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d92a70001>; Wed, 21 Aug 2019 11:51:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 11:51:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 11:51:19 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:51:19 +0000
Received: from [10.2.161.131] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:51:18 +0000
Subject: Re: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
To:     Neil MacLeod <neil@nmacleod.com>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
 <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
 <CAFbqK8kWUdoEStTRe+a4mk9dMf4W4vk7aZhT_uTqS6jgAqYJ0A@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0091d78f-7add-f435-52ca-ccffedebf9a4@nvidia.com>
Date:   Wed, 21 Aug 2019 11:49:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFbqK8kWUdoEStTRe+a4mk9dMf4W4vk7aZhT_uTqS6jgAqYJ0A@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566413479; bh=0z9O/+D59xIBY8tVYgXl6FqEXreUHsd+z7KnCnrrdBQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BRVoQSTtE2NPH7LU/6wIwVlXdkOm4RBgVttkV8ZCubSW6qPB9ysgUB8eEKgjQrcfE
         XfkbLaEEBQ/ydLOevgjCTI+RqQ7ejZTyAZ9MrqyAMx3D56yFemMNcfXIsyPXdeS83l
         Uq078hjSdJXeszoYIqYcdXhCoV5ItJIDk7bxLreHPdPU8UkTWGEWy+dPqN/8wmgLjD
         TJAeWG6FutmFtqCaH9egFB6ImT1UbUImbv2OCFx7fifkHyZscktUakZdf5IG029euU
         P8RIWgm1ahkG0NhARWncaaHIl6+GXjwN0TZVDtnOZ7v26YZBfUSVqpV1AXJ/jppyOu
         2w9kYo1komQvQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/19 11:32 AM, Neil MacLeod wrote:
> Hi John
> 
> I can test any patches given a link to the diff, and am happy to do so.
> 
> If I've understood your suggestion correctly, I will try commenting
> out all of the entries, then add them back one-by-one until I get a
> non-booting situation. I'll let you know how I get on.
> 

I was actually going the other direction. Note that the BOOT_PARAM_PRESERVE
entries indicate what *not* to zero out. So if you remove them all, then
everything gets zeroed, including lots of critical fields, and you
definitely won't boot up. (The tricky part is we don't yet know whether
fields are missing, need to be added--or both.)

So I was heading toward adding most (but not all--important) of these fields,
as BOOT_PARAM_PRESERVE entries, as a first bisect step. Let me work that up
and post a patch for that.

struct boot_params {
	struct screen_info screen_info;			/* 0x000 */
	struct apm_bios_info apm_bios_info;		/* 0x040 */
	__u8  _pad2[4];					/* 0x054 */
	__u64  tboot_addr;				/* 0x058 */
	struct ist_info ist_info;			/* 0x060 */
	__u64 acpi_rsdp_addr;				/* 0x070 */
	__u8  _pad3[8];					/* 0x078 */
	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
	struct olpc_ofw_header olpc_ofw_header;		/* 0x0b0 */
	__u32 ext_ramdisk_image;			/* 0x0c0 */
	__u32 ext_ramdisk_size;				/* 0x0c4 */
	__u32 ext_cmd_line_ptr;				/* 0x0c8 */
	__u8  _pad4[116];				/* 0x0cc */
	struct edid_info edid_info;			/* 0x140 */
	struct efi_info efi_info;			/* 0x1c0 */
	__u32 alt_mem_k;				/* 0x1e0 */
	__u32 scratch;		/* Scratch field! */	/* 0x1e4 */
	__u8  e820_entries;				/* 0x1e8 */
	__u8  eddbuf_entries;				/* 0x1e9 */
	__u8  edd_mbr_sig_buf_entries;			/* 0x1ea */
	__u8  kbd_status;				/* 0x1eb */
	__u8  secure_boot;				/* 0x1ec */
	__u8  _pad5[2];					/* 0x1ed */
	/*
	 * The sentinel is set to a nonzero value (0xff) in header.S.
	 *
	 * A bootloader is supposed to only take setup_header and put
	 * it into a clean boot_params buffer. If it turns out that
	 * it is clumsy or too generous with the buffer, it most
	 * probably will pick up the sentinel variable too. The fact
	 * that this variable then is still 0xff will let kernel
	 * know that some variables in boot_params are invalid and
	 * kernel should zero out certain portions of boot_params.
	 */
	__u8  sentinel;					/* 0x1ef */
	__u8  _pad6[1];					/* 0x1f0 */
	struct setup_header hdr;    /* setup header */	/* 0x1f1 */
	__u8  _pad7[0x290-0x1f1-sizeof(struct setup_header)];
	__u32 edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 0x290 */
	struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
	__u8  _pad8[48];				/* 0xcd0 */
	struct edd_info eddbuf[EDDMAXNR];		/* 0xd00 */
	__u8  _pad9[276];				/* 0xeec */
} __attribute__((packed));



thanks,
-- 
John Hubbard
NVIDIA


> The OS I'm testing is LibreELEC, which is a custom x86_64 build, and
> this hasn't shown any problems on this Skylake i5 NUC in all the years
> I've been using it as a test system (since at least 4.15.y). So far
> 5.3-rc has been trouble-free until 5.3-rc5. As I mentioned in the bug,
> I've been able to boot 5.3-rc5 from a USB memory stick, but can't boot
> 5.3-rc5 from the internal M2 drive unless I revert this commit.
> 
