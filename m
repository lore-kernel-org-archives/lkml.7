Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1DDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35343206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VN/qJlFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLCFia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:38:30 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42086 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCFia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:38:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id j22so2157476oij.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxKEkxDBia5ioBHm8RVlU4uUCE2gbjwJh83vCZ7hmfs=;
        b=VN/qJlFTMiKIOyz/f6dXusZ23v2/RNQY8O+QxV1cdLRjyPIXIQ1tgU7l7ssMK4Xswr
         d4nvAG1H2SxlaWeTSQAKYwju0/RSGOjmNRKqSvfbfnDO5oLoJoNUjBWEXKaGDp7wnuWh
         HIIonmMjcT4LaroBmHqnSjDUk0Jauysh/Z+6iNEqv69Xqxarx7UK3qe6efABgbT/DVV7
         DS5E9h7hgRotmEdRre90KoAnGzu2GbsuB3m86dIcjwKBVe5FQtGdn+tDKxLm6oCR0nNF
         8sUocBp03T5yBnEqskXALqgNYgA+9HsmKJ10YJ3dekrOdXLD/UjM+Ue76VeGKaaNRkIY
         NnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxKEkxDBia5ioBHm8RVlU4uUCE2gbjwJh83vCZ7hmfs=;
        b=CEKav9Dc3+My0Qv2snTQGe/RaVTHSrZpnbYYehleLjtguMumf03Nm8WEmAoC/iMdKk
         OMTffhxazJnZQq8l/rzlBcgx9JY2v7wsijJIwtAbujfyeecfsDc97or2Uv/SXXb/FU27
         tA7D+LXS1sfgg7PBP509XgtFDOGY3uGcRFw2t9zsfANyBjfxgJMY0zk7sQX5nc3EMbnQ
         pD0OytJ5jt3aaJBY0GOjoISupEp+fVNiXojFLSDvKB9jP53YMGsVOs185UdI5RjSJy5+
         fCpTJx37SIJr6ah/HR+LdJgXG5y+gJWFsjG5ydgRZPDDPdK4Xe1rcQsPfsQR/vZEuV7x
         4dxg==
X-Gm-Message-State: APjAAAXQMDPVFfqTw3avxzKY7Zj6sxxF0x78fA23URYZsaAVv0UYxDl9
        N0CL742zJFZHf1y7OKPw+/crmJjHhMhsz5Edd6aWbQ==
X-Google-Smtp-Source: APXvYqzOyctit94qUVdAD4+2E8DY1i265rqYPtq5w6+szwRcFQzPYSx1OiO04ERZDP2PnVBnzvSIzms9Y8NBmrpy+Ko=
X-Received: by 2002:aca:c551:: with SMTP id v78mr2310770oif.161.1575351508779;
 Mon, 02 Dec 2019 21:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
 <20190911182546.17094-4-nsaenzjulienne@suse.de> <CALAqxLVVcsmFrDKLRGRq7GewcW405yTOxG=KR3csVzQ6bXutkA@mail.gmail.com>
In-Reply-To: <CALAqxLVVcsmFrDKLRGRq7GewcW405yTOxG=KR3csVzQ6bXutkA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 2 Dec 2019 21:38:17 -0800
Message-ID: <CALAqxLUkPNf9JYyt+_VOrxq=Zq03veb1y-7aDx+_Vw+fF9i82A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, wahrenst@gmx.net,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Nicolas Dechense <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 9:08 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Sep 11, 2019 at 11:26 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > So far all arm64 devices have supported 32 bit DMA masks for their
> > peripherals. This is not true anymore for the Raspberry Pi 4 as most of
> > it's peripherals can only address the first GB of memory on a total of
> > up to 4 GB.
> >
> > This goes against ZONE_DMA32's intent, as it's expected for ZONE_DMA32
> > to be addressable with a 32 bit mask. So it was decided to re-introduce
> > ZONE_DMA in arm64.
> >
> > ZONE_DMA will contain the lower 1G of memory, which is currently the
> > memory area addressable by any peripheral on an arm64 device.
> > ZONE_DMA32 will contain the rest of the 32 bit addressable memory.
> >
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Hey Nicolas,
>   Testing the db845c with linus/master, I found a regression causing
> system hangs in early boot:
>
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> [    0.000000] Linux version 5.4.0-mainline-10675-g957a03b9e38f
> (docker@a4ec90a1e72c) (gcc version 7.4.0 (Ubuntu/Linaro
> 7.4.0-1ubuntu1~18.04.1)) #1209 SMP PREEMPT Tue Dec 3 00:23:15 UTC 2019
> [    0.000000] Machine model: Thundercomm Dragonboard 845c
> [    0.000000] earlycon: qcom_geni0 at MMIO 0x0000000000a84000
> (options '115200n8')
> [    0.000000] printk: bootconsole [qcom_geni0] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 16 MiB at 0x00000000ff000000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.0
> [    0.000000] psci: OSI mode supported.
> [    0.000000] percpu: Embedded 31 pages/cpu s87512 r8192 d31272 u126976
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: detected: GIC system register CPU interface
> [    0.000000] CPU features: kernel page table isolation forced ON by KASLR
> [    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
> [    0.000000] ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware
> [    0.000000] CPU features: detected: Hardware dirty bit management
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: -188245
> [    0.000000] Kernel command line: earlycon
> firmware_class.path=/vendor/firmware/ androidboot.hardware=db845c
> init=/init androidboot.boot_devices=soc/1d84000.ufshc
> printk.devkmsg=on buildvariant=userdebug root=/dev/sda2
> androidboot.bootdevice=1d84000.ufshc androidboot.serialno=c4e1189c
> androidboot.baseband=sda
> msm_drm.dsi_display0=dsi_lt9611_1080_video_display:
> androidboot.slot_suffix=_a skip_initramfs rootwait ro init=/init
>
> <hangs indefinitely here>
>
> I bisected the issue down to this patch (1a8e1cef7603 upstream - the
> previous patch a573cdd7973d works though I need to apply the
> arm64_dma_phys_limit bit from this one as the previous patch doesn't
> build on its own).
>
> In the above log:
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: -188245
> looks the most suspect, and going back to the working a573cdd7973d +
> build fix I see:
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 957419
>
> Do you have any suggestions for what might be going wrong?

Digging further, it seems the error is found in calculate_node_totalpages()
 real_size = size - zone_absent_pages_in_node(pgdat->node_id, i,
                                                  node_start_pfn, node_end_pfn,
                                                  zholes_size);

Where for zone DMA32 size is 262144, but real_size is calculated as -883520.

I've not traced through to figure out why zone_absent_pages_in_node is
coming up with such a large number yet, but I'm about to crash so I
wanted to share.

thanks
-john
