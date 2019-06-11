Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7523C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49E0207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391417AbfFKJ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:57:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbfFKJ5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:57:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893EC337;
        Tue, 11 Jun 2019 02:57:02 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 796C63F73C;
        Tue, 11 Jun 2019 02:58:43 -0700 (PDT)
Subject: Re: [PATCH 07/15] binfmt_flat: use __be32 for the on-disk format
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-8-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <462a7406-19df-7910-4499-8f0acd52bc82@arm.com>
Date:   Tue, 11 Jun 2019 10:57:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> So far binfmt_flat has onl been supported on 32-bit platforms, so the
			^^^^
			only
> variable size of the fields didn't matter.  But the upcoming RISC-V
> nommu port supports 64-bit CPUs, and we now have a conflict between
> the elf2flt creation tool that always uses 32-bit fields and the kernel
> that uses (unsigned) long field.  Switch to the userspace view as the
> rest of the binfmt_flat format is completely architecture neutral,
> and binfmt_flat isn't the right binary format for huge executables to
> start with.
> 
> While we're at it also ensure these fields are using __be types as
> they big endian and are byteswapped when loaded.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> wip
  ^^^
Unintended?

> ---
>  include/linux/flat.h | 48 ++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)


With comment message fixed:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

> 
> diff --git a/include/linux/flat.h b/include/linux/flat.h
> index 21d901ba191b..59e892d5fadb 100644
> --- a/include/linux/flat.h
> +++ b/include/linux/flat.h
> @@ -24,26 +24,26 @@
>   */
>  
>  struct flat_hdr {
> -	char magic[4];
> -	unsigned long rev;          /* version (as above) */
> -	unsigned long entry;        /* Offset of first executable instruction
> -	                               with text segment from beginning of file */
> -	unsigned long data_start;   /* Offset of data segment from beginning of
> -	                               file */
> -	unsigned long data_end;     /* Offset of end of data segment
> -	                               from beginning of file */
> -	unsigned long bss_end;      /* Offset of end of bss segment from beginning
> -	                               of file */
> +	char	magic[4];
> +	__be32	rev;          /* version (as above) */
> +	__be32	entry;        /* Offset of first executable instruction
> +				 with text segment from beginning of file */
> +	__be32	data_start;   /* Offset of data segment from beginning of
> +				 file */
> +	__be32	data_end;     /* Offset of end of data segment from beginning
> +				 of file */
> +	__be32	bss_end;      /* Offset of end of bss segment from beginning
> +				 of file */
>  
>  	/* (It is assumed that data_end through bss_end forms the bss segment.) */
>  
> -	unsigned long stack_size;   /* Size of stack, in bytes */
> -	unsigned long reloc_start;  /* Offset of relocation records from
> -	                               beginning of file */
> -	unsigned long reloc_count;  /* Number of relocation records */
> -	unsigned long flags;
> -	unsigned long build_date;   /* When the program/library was built */
> -	unsigned long filler[5];    /* Reservered, set to zero */
> +	__be32	stack_size;   /* Size of stack, in bytes */
> +	__be32	reloc_start;  /* Offset of relocation records from beginning of
> +				 file */
> +	__be32	reloc_count;  /* Number of relocation records */
> +	__be32	flags;
> +	__be32	build_date;   /* When the program/library was built */
> +	__u32	filler[5];    /* Reservered, set to zero */
>  };
>  
>  #define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
> @@ -67,19 +67,19 @@ struct flat_hdr {
>  #define OLD_FLAT_RELOC_TYPE_BSS		2
>  
>  typedef union {
> -	unsigned long	value;
> +	u32		value;
>  	struct {
>  # if defined(mc68000) && !defined(CONFIG_COLDFIRE)
> -		signed long offset : 30;
> -		unsigned long type : 2;
> +		s32	offset : 30;
> +		u32	type : 2;
>  #   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
>  # elif defined(__BIG_ENDIAN_BITFIELD)
> -		unsigned long type : 2;
> -		signed long offset : 30;
> +		u32	type : 2;
> +		s32	offset : 30;
>  #   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
>  # elif defined(__LITTLE_ENDIAN_BITFIELD)
> -		signed long offset : 30;
> -		unsigned long type : 2;
> +		s32	offset : 30;
> +		u32	type : 2;
>  #   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
>  # else
>  #   	error "Unknown bitfield order for flat files."
> 

