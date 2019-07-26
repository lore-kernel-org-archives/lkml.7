Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7B621852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p8YIubdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbfGZWYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:24:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3585 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfGZWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564179870; x=1595715870;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=if3brqcdHB/fxxSNFjpR7EE+qJbzAZzvUpJK8gt9Dh8=;
  b=p8YIubdmm3b0IHKhSmDCE1aHVdajmHG9DGC1kbf+dy/maXctGQkXBIgx
   TrQAWfTJ99XFi73LOKTwhLGbaA0Tnjcyv+IEG3qosB1nkiCyCQGiRxADo
   ks/pgn5N8VXhJcx0jEz1Cmky0xS2gK3C0wUhNQMvojCx9kWJgZOtz+rM6
   rMTrSjkvUrStL3PtpgJEhBfkyVAJvtm/NmGVGK+85jl+Iul6vZakgEOrx
   e224GKmACp3WLZValFZoQYexaSOvwgkDd5/SeXXb60Z0GP+0PgJyOfyzb
   OLoUN0If4WA9E7HMuyLyDNy+ULO2hDVG+Ul07QxxWLTdZbTLcAK7haTRd
   Q==;
IronPort-SDR: 4WFVCFba+z+Fy0G9WNZGJMNUpq8Fwvo/sSATHAV2pLtZniKpFwvwIy2Y4nvWZI9YYR+LbycPgr
 4s8T7WnkKqSihun2+n7D1VtxYZb/cvoxkTgiJhTTc6K6zG1PnxgG/+ye1dvkarcoXZ2Yt+P3fg
 hav4CN2r0nufDJOf/xncZ94GwUIWRUgNDg7Lf0rDzd+eD4oeSB9J0/Vcd80Mw1bMTSV+YYMgdb
 vPmwj6mMQjlHdyZNbQDS8vq4zijy2PRPWWRjOXIZyYbbSeiSGq9f+FapJVeJcqyUy5NLdnybpZ
 mUY=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="115280892"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 06:24:30 +0800
IronPort-SDR: d7GaB12dGZu9LsY2v07NwI825WDG08la0pWr9n0cwMKLeJFdP7/Y6eSqsyswfdYN3rU+KciiOw
 JQRVBbmVNHAnPsvk9vKhmZcNoMJBWco7m5vYIoxQTRHNJNKFIMqGfW29apC4Mj+7tfOqmAHDMb
 z9SIeUWVnsnNIUFhU8iRubHMRxMeVsYR88E03SaiQZLCbpTqmsbguy3fyITxzbESBACKDirSLq
 OTqSldX7EnH8qXevnukQXl6X+N2IAVyHYnZZoEmQGocUzmizLshSe5uL+InigeeRlIiMKfDwYt
 nbKapwhtWfACLMHgl9gRdnJw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jul 2019 15:22:38 -0700
IronPort-SDR: jRa8eOdP/YuKfEzPjVyDpyFtNg+MPlqfk2n4XP6iJpn3/YPiLpWo2zO1hehiqWcxAZoTWjXrOS
 PMiNzCPi9bKZujDpYd8JGTCq3CXFvimIPZGZVgKpJvCipV8kZ5xKQY/gMnZZ0L5LBw/5/Ewi9E
 DDOaSpHgzou0PU1mik3wZdm5gyNssOF/044AidN0g/98RaHIjx8fg7+6BX11AYs+5IlC67Z9ND
 ReDmbdOQZovtt4wDXzhyLz/ZLfZ++jQSeS2q1QoXkx7YR1DKeloXqM7zVlasNSC0Y9euP9wISO
 rxI=
Received: from unknown (HELO [10.225.104.231]) ([10.225.104.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 15:24:29 -0700
Subject: Re: [PATCH] docs: riscv: convert boot-image-header.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Karsten Merker <merker@debian.org>
References: <57eaa99a-d644-7b79-7177-a45d3ef1e71a@wdc.com>
 <1eaeb3fbb74de55af0b3f6d93ab40776dcbbb5c8.1564174903.git.mchehab+samsung@kernel.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <40e0f516-402b-29eb-d69b-fda1af26801e@wdc.com>
Date:   Fri, 26 Jul 2019 15:24:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1eaeb3fbb74de55af0b3f6d93ab40776dcbbb5c8.1564174903.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 2:02 PM, Mauro Carvalho Chehab wrote:
> Convert this small file to ReST format by:
>     - Using a proper markup for the document title;
>     - marking a code block as such;
>     - use tags for Author and date;
>     - use tables for bit map fields.
> 
> While here, fix a broken reference for a document with is
> planned but is not here yet.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>   ...image-header.txt => boot-image-header.rst} | 39 ++++++++++++-------
>   Documentation/riscv/index.rst                 |  1 +
>   2 files changed, 26 insertions(+), 14 deletions(-)
>   rename Documentation/riscv/{boot-image-header.txt => boot-image-header.rst} (72%)
> 
> diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.rst
> similarity index 72%
> rename from Documentation/riscv/boot-image-header.txt
> rename to Documentation/riscv/boot-image-header.rst
> index 1b73fea23b39..43e9bd0731d5 100644
> --- a/Documentation/riscv/boot-image-header.txt
> +++ b/Documentation/riscv/boot-image-header.rst
> @@ -1,22 +1,25 @@
> -				Boot image header in RISC-V Linux
> -			=============================================
> +=================================
> +Boot image header in RISC-V Linux
> +=================================
>   
> -Author: Atish Patra <atish.patra@wdc.com>
> -Date  : 20 May 2019
> +:Author: Atish Patra <atish.patra@wdc.com>
> +:Date:   20 May 2019
>   
>   This document only describes the boot image header details for RISC-V Linux.
> -The complete booting guide will be available at Documentation/riscv/booting.txt.
>   
> -The following 64-byte header is present in decompressed Linux kernel image.
> +TODO:
> +  Write a complete booting guide.
> +
> +The following 64-byte header is present in decompressed Linux kernel image::
>   
>   	u32 code0;		  /* Executable code */
> -	u32 code1; 		  /* Executable code */
> +	u32 code1;		  /* Executable code */
>   	u64 text_offset;	  /* Image load offset, little endian */
>   	u64 image_size;		  /* Effective Image size, little endian */
>   	u64 flags;		  /* kernel flags, little endian */
>   	u32 version;		  /* Version of this header */
> -	u32 res1  = 0;		  /* Reserved */
> -	u64 res2  = 0;    	  /* Reserved */
> +	u32 res1 = 0;		  /* Reserved */
> +	u64 res2 = 0;		  /* Reserved */
>   	u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
>   	u32 res3;		  /* Reserved for additional RISC-V specific header */
>   	u32 res4;		  /* Reserved for PE COFF offset */
> @@ -25,16 +28,21 @@ This header format is compliant with PE/COFF header and largely inspired from
>   ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
>   header in future.
>   
> -Notes:
> +Notes
> +=====
> +
>   - This header can also be reused to support EFI stub for RISC-V in future. EFI
>     specification needs PE/COFF image header in the beginning of the kernel image
>     in order to load it as an EFI application. In order to support EFI stub,
>     code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
>     point to the rest of the PE/COFF header.
>   
> -- version field indicate header version number.
> -	Bits 0:15  - Minor version
> -	Bits 16:31 - Major version
> +- version field indicate header version number
> +
> +	==========  =============
> +	Bits 0:15   Minor version
> +	Bits 16:31  Major version
> +	==========  =============
>   
>     This preserves compatibility across newer and older version of the header.
>     The current version is defined as 0.1.
> @@ -44,7 +52,10 @@ Notes:
>     extension for RISC-V in future. For current version, it is set to be zero.
>   
>   - In current header, the flag field has only one field.
> -	Bit 0: Kernel endianness. 1 if BE, 0 if LE.
> +
> +	=====  ====================================
> +	Bit 0  Kernel endianness. 1 if BE, 0 if LE.
> +	=====  ====================================
>   
>   - Image size is mandatory for boot loader to load kernel image. Booting will
>     fail otherwise.
> diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
> index e3ca0922a8c2..215fd3c1f2d5 100644
> --- a/Documentation/riscv/index.rst
> +++ b/Documentation/riscv/index.rst
> @@ -5,6 +5,7 @@ RISC-V architecture
>   .. toctree::
>       :maxdepth: 1
>   
> +    boot-image-header
>       pmu
>   
>   .. only::  subproject and html
> 

Thanks for the quick patch.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
