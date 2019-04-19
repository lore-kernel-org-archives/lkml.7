Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2867DC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 01:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A0D214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 01:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZvPzltre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfDSBE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 21:04:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22988 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfDSBE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 21:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555635896; x=1587171896;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=JNCt4ralk0VadV9rI8zNMEe1OWC5/ViM+mry1FGDxlM=;
  b=ZvPzltre0G/L7sLTSotNiafGmZre0dCG2tG7hcxBvXtmJNN9qOTbdNN0
   yv6fc8a3AGODjQCNR2vt2nlLzbbPCSJSJTHaRuPLDh/5PYRjNeCsCycgD
   HogVqq1XaGRldbSmjE+nU2GhpTL0RVe5FrsUxd8GhFmNgpDNyTUjk3Tnr
   INW+Ba6ocR1pH+AyUVpAb1xTPmRtu6zAIFKZQwLUCda7pPIiFflbkkm4N
   xx9Vkj3aEhUo48fPnbLwj+e8ieXYKhc9M5zZa7niak9J/f9gU3y85Pwh0
   +1lwHPqy/LeEF8o8qFql8BGYt5MG8Dz/AyP5zLi/19rIoTSyGMteAIIfF
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,368,1549900800"; 
   d="scan'208";a="212085422"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2019 09:04:36 +0800
IronPort-SDR: +vxX5KAOsYkY9Pjub9Q8F9Bu3pUt93VBp2Hpy+UZOnom9i8ahrPR72k82HNOa4FyuP1bHC1oFG
 BvO5H9lKuMq9BSRNe1KCgGJv/bvCeIvbAb4WgAAZlxsPazj5DQy0rYkbSsA7JKZpHGhWsNnQpN
 IlEgbMOQ/ugseyKL4WBIhlVSr6HvDyswE2aUpqWJH0X0pZ0Pk9ckc9PRAzNNsaEw7ZXQVSSohg
 DRlfhs5e4mIIfQYJpvhK5mbZAYRzNrcG0WLzSzfeWaiT1R6O0z0VrG64AbTmiKtEuD4FwsC7Wo
 XoECFlZ1M/AR68wuHb6gKNLC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Apr 2019 17:43:25 -0700
IronPort-SDR: PQR7nOItCqyBJzQYvRhU0UFx1nEetSzlPMBSxEpDHPcrR/bWebKsjXtP4/6ZOR9NjIxVlo15VQ
 CF4wNaEv3BDEJmG3ShBB7joswaPwzgIvA7mHYOEFQGGJfeO8ZjCMrbgUpp2UP4HW7cEPMjQibG
 Vs2mRJCPcV3BtuM48t/1J9KJOyVeOjG+I2gMivURKmXU9g0y8Soj9kYhGgCDZpFcqHaBlScf14
 CTcRrgbN4djH750Tr12ON6tuwzNoyKc9kPld8Q0HpRougXQOeHZATi2BW2HBDOgEm6Bo3G3OzL
 0Ro=
Received: from usa003981.ad.shared (HELO [10.86.53.90]) ([10.86.53.90])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Apr 2019 18:04:36 -0700
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for
 the SiFive FU540 UART
To:     Kevin Hilman <khilman@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
 <7hmukmew5j.fsf@baylibre.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
Date:   Thu, 18 Apr 2019 18:04:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7hmukmew5j.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 4:22 PM, Kevin Hilman wrote:
> Hi Paul,
> 
> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
>> This series adds a serial driver, with console support, for the
>> UART IP block present on the SiFive FU540 SoC.  The programming
>> model is straightforward, but unique.
>>
>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>> open-source FSBL (with appropriate patches to the DT data).
>>
>> This fifth version fixes a bug in the set_termios handler,
>> found by Andreas Schwab <schwab@suse.de>.
>>
>> The patches in this series can also be found, with the PRCI patches,
>> DT patches, and DT prerequisite patch, at:
>>
>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
> 
> I tried this branch, and it doesn't boot on my unleashed board.
> 
> Here's the boot log when I pass the DT built from your branch via
> u-boot: https://termbin.com/rfp3.
> 

Unfortunately, that won't work. The current DT modifications by OpenSBI.

1. Change hart status to "masked" from "okay".
2. M-mode interrupt masking in PLIC node.
3. Add a chosen node for serial access in U-Boot.

You can ignore 3 for your use case. However, if you pass a dtb built 
from source code, that will have hart0 enabled and M-mode interrupts 
enabled in DT.

Not sure if we should do these DT modifications in U-Boot as well.

I also noticed that your kernel is booting only 1 hart.
Just FYI: RISC-V SMP for U-Boot patches are merged in master. So you 
should be able to boot all cpus. You can ingore FU540_ENABLED_HART_MASK 
in OpenSBI build as well.

Regards,
Atish
> I also tried the same thing, but using the DT that's hard-coded into
> SBI/u-boot.  That doesn't boot fully either[1], but one thing I noted is
> that with the DT from the kernel tree, the printk timestamps aren't
> moving.  Maybe I'm still missing some kconfig options to enable the
> right clock and/or IRQ controllers? I'm using this fragment[2] on top of
> the default defconfig (arch/riscv/configs/defconfig).
> 
> Could you share the defconfig you're using when testing your branch?
> 
> Also for reference, I'm able to successfully build/boot the
> 5.1-rc1-unleashed branch from Atish's tree[3] using that kconfig
> fragment[2] (and the hard-coded DT from u-boot/SBI).  Full log here[4].
> 
> Thanks,
> 
> Kevin
> 
> [1] https://termbin.com/wuc9
> [2]
> CONFIG_CLK_SIFIVE=y
> CONFIG_CLK_SIFIVE_FU540_PRCI=y
> 
> CONFIG_SERIAL_SIFIVE=y
> CONFIG_SERIAL_SIFIVE_CONSOLE=y
> 
> CONFIG_SIFIVE_PLIC=y
> CONFIG_SPI=y
> CONFIG_SPI_SIFIVE=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIO_SIFIVE=y
> CONFIG_PWM_SIFIVE=y
> 
> CONFIG_CLK_U54_PRCI=y
> CONFIG_CLK_GEMGXL_MGMT=y
> 
> [3] https://github.com/atishp04/linux/tree/5.1-rc1-unleashed
> [4] https://termbin.com/12bg
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

