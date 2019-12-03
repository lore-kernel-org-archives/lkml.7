Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA93AC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC00620640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLCJcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:32:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:46220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCJcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:32:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E96CBAF13;
        Tue,  3 Dec 2019 09:32:13 +0000 (UTC)
Subject: Re: [PATCH 1/6] dt-bindings: clock: add bindings for RTD1619 clocks
To:     James Tai <james.tai@realtek.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org,
        cylee12 <cylee12@realtek.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20191203074513.9416-1-james.tai@realtek.com>
 <20191203074513.9416-2-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <f069747b-7f10-f47c-684d-11138b8fd129@suse.de>
Date:   Tue, 3 Dec 2019 10:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203074513.9416-2-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James and Cheng-Yu,

Am 03.12.19 um 08:45 schrieb James Tai:
> From: cylee12 <cylee12@realtek.com>

Please fix the author (git commit --amend --author="...") and use an
appropriate git config setting (and communication to your team) to avoid
this reoccurring for new commits - already pointed out to James.

BTW I wonder why we have so many seemingly unrelated people in CC
(Mediatek, RISC-V) that the patches and responses keep hanging in
mailing list moderation?

> 
> Add devicetree binding for Realtek RTD1619 clocks.
> 
> Signed-off-by: Cheng-Yu Lee <cylee12@realtek.com>
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  include/dt-bindings/clock/rtk,clock-rtd1619.h | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 include/dt-bindings/clock/rtk,clock-rtd1619.h
> 
> diff --git a/include/dt-bindings/clock/rtk,clock-rtd1619.h b/include/dt-bindings/clock/rtk,clock-rtd1619.h
> new file mode 100644
> index 000000000000..497f9b914857
> --- /dev/null
> +++ b/include/dt-bindings/clock/rtk,clock-rtd1619.h

NAK for the filename. "rtk," is not a registered vendor prefix [1], so
you cannot use it anywhere in bindings. Please use the registered prefix
"realtek," and compare the other Realtek bindings headers that got
accepted already. The order of SoC vs. name seems wrong.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/vendor-prefixes.yaml

> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Why restrict these trivial numbers to GPLv2? Please compare the .dtsi
and .yaml files where this may get #include'd, and keep non-Linux OSes
such as BSDs in mind for any DT bindings; it's supposed to be an
OS-neutral interface contract that anyone can implement.

> +#ifndef __DT_BINDINGS_RTK_CLOCK_RTD1619_H
> +#define __DT_BINDINGS_RTK_CLOCK_RTD1619_H

May need adjustments based on the filename, same for the #endif.

> +
> +#define CC_PLL_SCPU 0
> +#define CC_PLL_BUS 2

Please tab-indent the indices for readability.

> +#define CC_CLK_SYS 3
> +#define CC_CLK_SYS_SB2 4
> +#define CC_PLL_DCSB 5
> +#define CC_CLK_SYSH 6
> +#define CC_PLL_DDSA 7
> +#define CC_PLL_DDSB 8
> +#define CC_PLL_GPU 9
> +#define CC_CLK_GPU 10
> +#define CC_PLL_VE1 11
> +#define CC_PLL_VE2 12
> +#define CC_CLK_VE1 13
> +#define CC_CLK_VE2 14
> +#define CC_CLK_VE3 15
> +#define CC_CLK_VE2_BPU 16
> +#define CC_PLL_DIF 17
> +#define CC_PLL_PSAUD1A 18
> +#define CC_PLL_PSAUD2A 19
> +
> +#define CC_CKE_MISC 33
> +#define CC_CKE_PCIE0 34
> +#define CC_CKE_GSPI 35
> +#define CC_CKE_SDS 36
> +#define CC_CKE_HDMI 37
> +#define CC_CKE_LSADC 38
> +#define CC_CKE_SE 39
> +#define CC_CKE_CP 40
> +#define CC_CKE_MD 41
> +#define CC_CKE_TP 42
> +#define CC_CKE_RSA 43
> +#define CC_CKE_NF 44
> +#define CC_CKE_EMMC 45
> +#define CC_CKE_SD 46
> +#define CC_CKE_SDIO_IP 47
> +#define CC_CKE_MIPI 48
> +#define CC_CKE_EMMC_IP 49
> +#define CC_CKE_SDIO 50
> +#define CC_CKE_SD_IP 51
> +#define CC_CKE_CABLERX 52
> +#define CC_CKE_TPB 53
> +#define CC_CKE_SC1 54
> +#define CC_CKE_I2C3 55
> +#define CC_CKE_JPEG 56
> +#define CC_CKE_SC0 57
> +#define CC_CKE_HDMIRX 58
> +#define CC_CKE_HSE 59
> +#define CC_CKE_UR2 60
> +#define CC_CKE_UR1 61
> +#define CC_CKE_FAN 62
> +#define CC_CKE_SATA_WRAP_SYS 63
> +#define CC_CKE_SATA_WRAP_SYSH 64
> +#define CC_CKE_SATA_MAC_SYSH 65
> +#define CC_CKE_R2RDSC 66
> +#define CC_CKE_PCIE1 67
> +#define CC_CKE_I2C4 68
> +#define CC_CKE_I2C5 69
> +#define CC_CKE_EDP 70
> +#define CC_CKE_TSIO_TRX 71
> +#define CC_CKE_TVE 72
> +#define CC_CKE_VO 73
> +
> +#define CC_CLK_MAX 74
> +
> +
> +#define IC_CKE_CEC0 2
> +#define IC_CKE_CBUSRX_SYS 3
> +#define IC_CKE_CBUSTX_SYS 4
> +#define IC_CKE_CBUS_SYS 5
> +#define IC_CKE_CBUS_OSC 6
> +#define IC_CKE_IR 7
> +#define IC_CKE_UR0 8
> +#define IC_CKE_I2C0 9
> +#define IC_CKE_I2C1 10
> +#define IC_CKE_ETN_250M 11
> +#define IC_CKE_ETN_SYS 12
> +#define IC_CKE_USB_DRD 13
> +#define IC_CKE_USB_HOST 14
> +#define IC_CKE_USB_U3_HOST 15
> +#define IC_CKE_USB 16
> +#define IC_CLK_MAX 17
> +
> +#endif /* __DT_BINDINGS_RTK_CLOCK_RTD1619_H */
> +

Trailing empty line.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
