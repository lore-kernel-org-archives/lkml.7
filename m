Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E2021670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D9wHI0Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFZRTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:19:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65340 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZRTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561569589; x=1593105589;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YArOACS7Pt9cfK3TC8bvDp6g5llYMH0JjFNDYT/p8Ck=;
  b=D9wHI0Lhvuc4l46LCJwcpiNHpxREuhr52AZxoe8H88Ze4sdKlf2mlBdy
   6My618QPYzEoyeeBmgfHEorAtc3ChIcfIDSUgevEV3kOJhRzelq2UrRFd
   Pjn+S/Pn3bNCrCnj65MJAEuGV7QNSRVeZbOUtHu3oosVs5zZ41P38vi9O
   RrW9L0elY0uci4DSZYTS80ADIhFGykN8sOscs1NGGgC8VpjXd0YBtLMzb
   ozIsFsCy5B1YwXCs3vB/BBVKRah7fF64nM5QMxUH8UFyJg5hBMO358F1D
   WIBepYQNZ66wcGFVq3J5rtF2HH/BM3IWislQOmeNFhlfwS8vSQIok2knb
   g==;
X-IronPort-AV: E=Sophos;i="5.63,420,1557158400"; 
   d="scan'208";a="116486148"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 01:19:49 +0800
IronPort-SDR: cEFCOxy+2mPuqO4dgH5OlbVBobtJGREkqJk6P73wEiX2xl+2tAlmIFQkSplNK7HxO3hkQT31ZW
 fQjWb/pv2thQJT0hfE+zZGGeS7Fzm6wMnDoJHOYtZs+sVbI8Uy/qR5ktSBze1MMqBxH5zu2yyo
 5QeDEDbIYqZV5ayWfXqVK+ph2352bqi8W+vOYTJwUEn3R/X3qsncqx+rp5J3KC2qr9cah4/7Gf
 9faTrHsQELlB1GoKW+Le8UFqcQYONBCW/90tZsZ7iE7vvDXlwu8xnk3EzOERNyHeJWWUUnIM6M
 keUlDsdKcFkN3rrjjFNs47b7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2019 10:18:57 -0700
IronPort-SDR: 97Y0CgH4RPL5+r/YWrQsEcdpYD7Tdl/IW1PK0Xnwrz+gVnxzZ3NIeAmzFX7xzF1yIEpdM5bRgT
 8kOIW12rZp063Fs0PG9VhtG4IxdoYPHbJuJBlPGaqA6JYSZf69MwsOdVDrXrhx7UxL88j1Uvml
 0tdiAvwcqliGhHP6LdkTTnumGKc5T5GTDh3shc7kh4ut2qvXRxVqa02AIXZedyR4F33x8wJt7B
 J+6eMQuWmbeMJ3nFDB2jXuuk8ImaPMgZgAf61ZHpZF+8VYVOjUmTannXDXpNl4fJgHW+qH6KvW
 Uyo=
Received: from usa005100.ad.shared (HELO [10.225.99.96]) ([10.225.99.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jun 2019 10:19:48 -0700
Subject: Re: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190625225636.9288-1-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1906260858130.21507@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <576048c8-f987-2fba-2c59-77af21779789@wdc.com>
Date:   Wed, 26 Jun 2019 10:19:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1906260858130.21507@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 9:00 AM, Paul Walmsley wrote:
> On Tue, 25 Jun 2019, Atish Patra wrote:
> 
>> Currently, riscv upstream defconfig doesn't let you boot
>> through userspace if rootfs is on the SD card.
>>
>> Let's enable MMC & SPI drivers as well so that one can boot
>> to the user space using default config in upstream kernel.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> Thanks.  The patch also enables CONFIG_DEVTMPFS_MOUNT, but doesn't mention
> it, so the following is what I've queued for v5.2-rc.  Let me know if you
> object to it.
> 

Apologies for forgetting about CONFIG_DEVTMPFS_MOUNT in the commit text. 
Thanks for the update.

> 
> - Paul
> 
> 
> From: Atish Patra <atish.patra@wdc.com>
> Date: Tue, 25 Jun 2019 15:56:36 -0700
> Subject: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V
> 
> Currently, riscv upstream defconfig doesn't let you boot
> through userspace if rootfs is on the SD card.
> 
> Let's enable MMC & SPI drivers as well so that one can boot
> to the user space using default config in upstream kernel.
> 
> While here, enable automatic mounting of devtmpfs to simplify
> kernel testing with minimal root filesystems. (pjw)
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> [paul.walmsley@sifive.com: mention the DEVTMPFS_MOUNT change in the
>   patch description]
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>   arch/riscv/configs/defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4f02967e55de..04944fb4fa7a 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -69,6 +69,7 @@ CONFIG_VIRTIO_MMIO=y
>   CONFIG_CLK_SIFIVE=y
>   CONFIG_CLK_SIFIVE_FU540_PRCI=y
>   CONFIG_SIFIVE_PLIC=y
> +CONFIG_SPI_SIFIVE=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
>   CONFIG_AUTOFS4_FS=y
> @@ -84,4 +85,8 @@ CONFIG_ROOT_NFS=y
>   CONFIG_CRYPTO_USER_API_HASH=y
>   CONFIG_CRYPTO_DEV_VIRTIO=y
>   CONFIG_PRINTK_TIME=y
> +CONFIG_SPI=y
> +CONFIG_MMC_SPI=y
> +CONFIG_MMC=y
> +CONFIG_DEVTMPFS_MOUNT=y
>   # CONFIG_RCU_TRACE is not set
> 


-- 
Regards,
Atish
