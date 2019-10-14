Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000BAC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8201420663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM0QWwh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbfJNJv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:51:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53062 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfJNJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:51:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so16540559wmh.2;
        Mon, 14 Oct 2019 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3amM+++KgPyVWItVLe4nXSS6B7AVpkdWqke4AyiC21M=;
        b=VM0QWwh7SscgzU9Nx2Fw+c9MOB2ba0KAMICZVHSXbI3NLSoBipsJZFv5RMC6PQZHfY
         SjXWiGLPybGuPcS3UdcLQtij+z5noShg7pIOU8FHiLyOckdGGYXuUR504Z5vAvtMz1qQ
         q9aeLW8Fp6E+QyDfsDfdJm4N9TbXTR4JJdcuSKmKE84VfF8mHFScHCzTqYdEDuoBbzE+
         KfqQ4Py99GpHlMHSa0cssJ1Byuo3UI7fd384ZrqiaI9KiBLB8nS0h+w5vyAz9GWqoj5Z
         Za9XLU31LDbS2X2GGc8PnxZu4BynRviqITYlSckp/6FYGALH6lbc/97rqEr3oGXYijtM
         pu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3amM+++KgPyVWItVLe4nXSS6B7AVpkdWqke4AyiC21M=;
        b=Rncn1jbqwCBS+mYTe0JigAKUknGjtEAcyUuKbhO3qthDazJsg0LTHu2/H1gUdlmJsQ
         Nvw6gnnMfrBTEGkU8WrBFbYIUf7lTijpwpFsjfhM/iEZvo5Om5P9cMNulEeDGC84XGtA
         FsXqfUt6DAUOtmvapzU4Zmu9tYpIowu08oHSJWnt4KywNnjpyJ4bFe0PH8GveLZmhHNf
         DQUigpyQJZvVtH7/odeFXzFVl54dhbNWOz5kEdhy587dMohBdCUv0B2q5Y+3Ie6kN5AQ
         66gQXAKrMQ8y3ZdyAghZC8cRFLa/wrSgMtxeyUQSOGv/nkpoxAqpNJ4mk06PwN0gyQS/
         v8mw==
X-Gm-Message-State: APjAAAXfrmYxRAC5kIsWg+29nIB3OOhTYT1ak8dJAdW7UlgYA/JoCObA
        yJavkQMy0+mQhcUCThLClGV0JXGN
X-Google-Smtp-Source: APXvYqyPWKz6AWWOI91rTZAoR9gE08nPotw7JMUHmdbauJo/V+Vrs7hK0wcpT+bRe83I801t5bmYNA==
X-Received: by 2002:a1c:7219:: with SMTP id n25mr13801494wmc.33.1571046679209;
        Mon, 14 Oct 2019 02:51:19 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id a2sm19517687wrp.11.2019.10.14.02.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 02:51:17 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:51:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V10 7/8] usb: gadget: Add UDC driver for tegra XUSB
 device mode controller
Message-ID: <20191014095116.GA419598@ulmo>
References: <1569227152-3030-1-git-send-email-nkristam@nvidia.com>
 <1569227152-3030-8-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1569227152-3030-8-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 01:55:51PM +0530, Nagarjuna Kristam wrote:
> This patch adds UDC driver for tegra XUSB 3.0 device mode controller.
> XUSB device mode controller supports SS, HS and FS modes
>=20
> Based on work by:
>   Mark Kuo <mkuo@nvidia.com>
>   Hui Fu <hfu@nvidia.com>
>   Andrew Bresticker <abrestic@chromium.org>
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/usb/gadget/udc/Kconfig      |   11 +
>  drivers/usb/gadget/udc/Makefile     |    1 +
>  drivers/usb/gadget/udc/tegra-xudc.c | 3787 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 3799 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/tegra-xudc.c

Felipe,

do you have any further comments on this, or do you think you can pick
this up for v5.5?

There's a build time dependency from this driver on the PHY driver
changes earlier in the series, so would you be able to pick up those
patches as well if Kishon acked them?

Thanks,
Thierry

>=20
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kcon=
fig
> index d7e6116..9160a6a 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -441,6 +441,17 @@ config USB_GADGET_XILINX
>  	  dynamically linked module called "udc-xilinx" and force all
>  	  gadget drivers to also be dynamically linked.
> =20
> +config USB_TEGRA_XUDC
> +	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	depends on PHY_TEGRA_XUSB
> +	help
> +	 Enables NVIDIA Tegra USB 3.0 device mode controller driver.
> +
> +	 Say "y" to link the driver statically, or "m" to build a
> +	 dynamically linked module called "tegra_xudc" and force all
> +	 gadget drivers to also be dynamically linked.
> +
>  source "drivers/usb/gadget/udc/aspeed-vhub/Kconfig"
> =20
>  #
> diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Mak=
efile
> index 897f648..f6777e6 100644
> --- a/drivers/usb/gadget/udc/Makefile
> +++ b/drivers/usb/gadget/udc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_USB_BCM63XX_UDC)	+=3D bcm63xx_udc.o
>  obj-$(CONFIG_USB_FSL_USB2)	+=3D fsl_usb2_udc.o
>  fsl_usb2_udc-y			:=3D fsl_udc_core.o
>  fsl_usb2_udc-$(CONFIG_ARCH_MXC)	+=3D fsl_mxc_udc.o
> +obj-$(CONFIG_USB_TEGRA_XUDC)	+=3D tegra-xudc.o
>  obj-$(CONFIG_USB_M66592)	+=3D m66592-udc.o
>  obj-$(CONFIG_USB_R8A66597)	+=3D r8a66597-udc.o
>  obj-$(CONFIG_USB_RENESAS_USB3)	+=3D renesas_usb3.o
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc=
/tegra-xudc.c
> new file mode 100644
> index 0000000..5124f61
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -0,0 +1,3787 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NVIDIA Tegra XUSB device mode controller
> + *
> + * Copyright (c) 2013-2019, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2015, Google Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/tegra/xusb.h>
> +#include <linux/pm_domain.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/role.h>
> +#include <linux/workqueue.h>
> +
> +/* XUSB_DEV registers */
> +#define SPARAM 0x000
> +#define  SPARAM_ERSTMAX_MASK GENMASK(20, 16)
> +#define  SPARAM_ERSTMAX(x) (((x) << 16) & SPARAM_ERSTMAX_MASK)
> +#define DB 0x004
> +#define  DB_TARGET_MASK GENMASK(15, 8)
> +#define  DB_TARGET(x) (((x) << 8) & DB_TARGET_MASK)
> +#define  DB_STREAMID_MASK GENMASK(31, 16)
> +#define  DB_STREAMID(x) (((x) << 16) & DB_STREAMID_MASK)
> +#define ERSTSZ 0x008
> +#define  ERSTSZ_ERSTXSZ_SHIFT(x) ((x) * 16)
> +#define  ERSTSZ_ERSTXSZ_MASK GENMASK(15, 0)
> +#define ERSTXBALO(x) (0x010 + 8 * (x))
> +#define ERSTXBAHI(x) (0x014 + 8 * (x))
> +#define ERDPLO 0x020
> +#define  ERDPLO_EHB BIT(3)
> +#define ERDPHI 0x024
> +#define EREPLO 0x028
> +#define  EREPLO_ECS BIT(0)
> +#define  EREPLO_SEGI BIT(1)
> +#define EREPHI 0x02c
> +#define CTRL 0x030
> +#define  CTRL_RUN BIT(0)
> +#define  CTRL_LSE BIT(1)
> +#define  CTRL_IE BIT(4)
> +#define  CTRL_SMI_EVT BIT(5)
> +#define  CTRL_SMI_DSE BIT(6)
> +#define  CTRL_EWE BIT(7)
> +#define  CTRL_DEVADDR_MASK GENMASK(30, 24)
> +#define  CTRL_DEVADDR(x) (((x) << 24) & CTRL_DEVADDR_MASK)
> +#define  CTRL_ENABLE BIT(31)
> +#define ST 0x034
> +#define  ST_RC BIT(0)
> +#define  ST_IP BIT(4)
> +#define RT_IMOD	0x038
> +#define  RT_IMOD_IMODI_MASK GENMASK(15, 0)
> +#define  RT_IMOD_IMODI(x) ((x) & RT_IMOD_IMODI_MASK)
> +#define  RT_IMOD_IMODC_MASK GENMASK(31, 16)
> +#define  RT_IMOD_IMODC(x) (((x) << 16) & RT_IMOD_IMODC_MASK)
> +#define PORTSC 0x03c
> +#define  PORTSC_CCS BIT(0)
> +#define  PORTSC_PED BIT(1)
> +#define  PORTSC_PR BIT(4)
> +#define  PORTSC_PLS_SHIFT 5
> +#define  PORTSC_PLS_MASK GENMASK(8, 5)
> +#define  PORTSC_PLS_U0 0x0
> +#define  PORTSC_PLS_U2 0x2
> +#define  PORTSC_PLS_U3 0x3
> +#define  PORTSC_PLS_DISABLED 0x4
> +#define  PORTSC_PLS_RXDETECT 0x5
> +#define  PORTSC_PLS_INACTIVE 0x6
> +#define  PORTSC_PLS_RESUME 0xf
> +#define  PORTSC_PLS(x) (((x) << PORTSC_PLS_SHIFT) & PORTSC_PLS_MASK)
> +#define  PORTSC_PS_SHIFT 10
> +#define  PORTSC_PS_MASK GENMASK(13, 10)
> +#define  PORTSC_PS_UNDEFINED 0x0
> +#define  PORTSC_PS_FS 0x1
> +#define  PORTSC_PS_LS 0x2
> +#define  PORTSC_PS_HS 0x3
> +#define  PORTSC_PS_SS 0x4
> +#define  PORTSC_LWS BIT(16)
> +#define  PORTSC_CSC BIT(17)
> +#define  PORTSC_WRC BIT(19)
> +#define  PORTSC_PRC BIT(21)
> +#define  PORTSC_PLC BIT(22)
> +#define  PORTSC_CEC BIT(23)
> +#define  PORTSC_WPR BIT(30)
> +#define  PORTSC_CHANGE_MASK (PORTSC_CSC | PORTSC_WRC | PORTSC_PRC | \
> +			     PORTSC_PLC | PORTSC_CEC)
> +#define ECPLO 0x040
> +#define ECPHI 0x044
> +#define MFINDEX 0x048
> +#define  MFINDEX_FRAME_SHIFT 3
> +#define  MFINDEX_FRAME_MASK GENMASK(13, 3)
> +#define PORTPM 0x04c
> +#define  PORTPM_L1S_MASK GENMASK(1, 0)
> +#define  PORTPM_L1S_DROP 0x0
> +#define  PORTPM_L1S_ACCEPT 0x1
> +#define  PORTPM_L1S_NYET 0x2
> +#define  PORTPM_L1S_STALL 0x3
> +#define  PORTPM_L1S(x) ((x) & PORTPM_L1S_MASK)
> +#define  PORTPM_RWE BIT(3)
> +#define  PORTPM_U2TIMEOUT_MASK GENMASK(15, 8)
> +#define  PORTPM_U1TIMEOUT_MASK GENMASK(23, 16)
> +#define  PORTPM_FLA BIT(24)
> +#define  PORTPM_VBA BIT(25)
> +#define  PORTPM_WOC BIT(26)
> +#define  PORTPM_WOD BIT(27)
> +#define  PORTPM_U1E BIT(28)
> +#define  PORTPM_U2E BIT(29)
> +#define  PORTPM_FRWE BIT(30)
> +#define  PORTPM_PNG_CYA BIT(31)
> +#define EP_HALT 0x050
> +#define EP_PAUSE 0x054
> +#define EP_RELOAD 0x058
> +#define EP_STCHG 0x05c
> +#define DEVNOTIF_LO 0x064
> +#define  DEVNOTIF_LO_TRIG BIT(0)
> +#define  DEVNOTIF_LO_TYPE_MASK GENMASK(7, 4)
> +#define  DEVNOTIF_LO_TYPE(x) (((x) << 4)  & DEVNOTIF_LO_TYPE_MASK)
> +#define  DEVNOTIF_LO_TYPE_FUNCTION_WAKE 0x1
> +#define DEVNOTIF_HI 0x068
> +#define PORTHALT 0x06c
> +#define  PORTHALT_HALT_LTSSM BIT(0)
> +#define  PORTHALT_HALT_REJECT BIT(1)
> +#define  PORTHALT_STCHG_REQ BIT(20)
> +#define  PORTHALT_STCHG_INTR_EN BIT(24)
> +#define PORT_TM	0x070
> +#define EP_THREAD_ACTIVE 0x074
> +#define EP_STOPPED 0x078
> +#define HSFSPI_COUNT0 0x100
> +#define HSFSPI_COUNT13 0x134
> +#define  HSFSPI_COUNT13_U2_RESUME_K_DURATION_MASK GENMASK(29, 0)
> +#define  HSFSPI_COUNT13_U2_RESUME_K_DURATION(x) ((x) & \
> +				HSFSPI_COUNT13_U2_RESUME_K_DURATION_MASK)
> +#define BLCG 0x840
> +#define SSPX_CORE_CNT0 0x610
> +#define  SSPX_CORE_CNT0_PING_TBURST_MASK GENMASK(7, 0)
> +#define  SSPX_CORE_CNT0_PING_TBURST(x) ((x) & SSPX_CORE_CNT0_PING_TBURST=
_MASK)
> +#define SSPX_CORE_CNT30 0x688
> +#define  SSPX_CORE_CNT30_LMPITP_TIMER_MASK GENMASK(19, 0)
> +#define  SSPX_CORE_CNT30_LMPITP_TIMER(x) ((x) & \
> +					SSPX_CORE_CNT30_LMPITP_TIMER_MASK)
> +#define SSPX_CORE_CNT32 0x690
> +#define  SSPX_CORE_CNT32_POLL_TBURST_MAX_MASK GENMASK(7, 0)
> +#define  SSPX_CORE_CNT32_POLL_TBURST_MAX(x) ((x) & \
> +					SSPX_CORE_CNT32_POLL_TBURST_MAX_MASK)
> +#define SSPX_CORE_PADCTL4 0x750
> +#define  SSPX_CORE_PADCTL4_RXDAT_VLD_TIMEOUT_U3_MASK GENMASK(19, 0)
> +#define  SSPX_CORE_PADCTL4_RXDAT_VLD_TIMEOUT_U3(x) ((x) & \
> +				SSPX_CORE_PADCTL4_RXDAT_VLD_TIMEOUT_U3_MASK)
> +#define  BLCG_DFPCI BIT(0)
> +#define  BLCG_UFPCI BIT(1)
> +#define  BLCG_FE BIT(2)
> +#define  BLCG_COREPLL_PWRDN BIT(8)
> +#define  BLCG_IOPLL_0_PWRDN BIT(9)
> +#define  BLCG_IOPLL_1_PWRDN BIT(10)
> +#define  BLCG_IOPLL_2_PWRDN BIT(11)
> +#define  BLCG_ALL 0x1ff
> +#define CFG_DEV_SSPI_XFER 0x858
> +#define  CFG_DEV_SSPI_XFER_ACKTIMEOUT_MASK GENMASK(31, 0)
> +#define  CFG_DEV_SSPI_XFER_ACKTIMEOUT(x) ((x) & \
> +					CFG_DEV_SSPI_XFER_ACKTIMEOUT_MASK)
> +#define CFG_DEV_FE 0x85c
> +#define  CFG_DEV_FE_PORTREGSEL_MASK GENMASK(1, 0)
> +#define  CFG_DEV_FE_PORTREGSEL_SS_PI 1
> +#define  CFG_DEV_FE_PORTREGSEL_HSFS_PI 2
> +#define  CFG_DEV_FE_PORTREGSEL(x) ((x) & CFG_DEV_FE_PORTREGSEL_MASK)
> +#define  CFG_DEV_FE_INFINITE_SS_RETRY BIT(29)
> +
> +/* FPCI registers */
> +#define XUSB_DEV_CFG_1 0x004
> +#define  XUSB_DEV_CFG_1_IO_SPACE_EN BIT(0)
> +#define  XUSB_DEV_CFG_1_MEMORY_SPACE_EN BIT(1)
> +#define  XUSB_DEV_CFG_1_BUS_MASTER_EN BIT(2)
> +#define XUSB_DEV_CFG_4 0x010
> +#define  XUSB_DEV_CFG_4_BASE_ADDR_MASK GENMASK(31, 15)
> +#define XUSB_DEV_CFG_5 0x014
> +
> +/* IPFS registers */
> +#define XUSB_DEV_CONFIGURATION_0 0x180
> +#define  XUSB_DEV_CONFIGURATION_0_EN_FPCI BIT(0)
> +#define XUSB_DEV_INTR_MASK_0 0x188
> +#define  XUSB_DEV_INTR_MASK_0_IP_INT_MASK BIT(16)
> +
> +struct tegra_xudc_ep_context {
> +	__le32 info0;
> +	__le32 info1;
> +	__le32 deq_lo;
> +	__le32 deq_hi;
> +	__le32 tx_info;
> +	__le32 rsvd[11];
> +};
> +
> +#define EP_STATE_DISABLED 0
> +#define EP_STATE_RUNNING 1
> +#define EP_STATE_HALTED 2
> +#define EP_STATE_STOPPED 3
> +#define EP_STATE_ERROR 4
> +
> +#define EP_TYPE_INVALID 0
> +#define EP_TYPE_ISOCH_OUT 1
> +#define EP_TYPE_BULK_OUT 2
> +#define EP_TYPE_INTERRUPT_OUT 3
> +#define EP_TYPE_CONTROL 4
> +#define EP_TYPE_ISCOH_IN 5
> +#define EP_TYPE_BULK_IN 6
> +#define EP_TYPE_INTERRUPT_IN 7
> +
> +#define BUILD_EP_CONTEXT_RW(name, member, shift, mask)			\
> +static inline u32 ep_ctx_read_##name(struct tegra_xudc_ep_context *ctx)	\
> +{									\
> +	return (le32_to_cpu(ctx->member) >> (shift)) & (mask);		\
> +}									\
> +static inline void							\
> +ep_ctx_write_##name(struct tegra_xudc_ep_context *ctx, u32 val)		\
> +{									\
> +	u32 tmp;							\
> +									\
> +	tmp =3D le32_to_cpu(ctx->member) & ~((mask) << (shift));		\
> +	tmp |=3D (val & (mask)) << (shift);				\
> +	ctx->member =3D cpu_to_le32(tmp);					\
> +}
> +
> +BUILD_EP_CONTEXT_RW(state, info0, 0, 0x7)
> +BUILD_EP_CONTEXT_RW(mult, info0, 8, 0x3)
> +BUILD_EP_CONTEXT_RW(max_pstreams, info0, 10, 0x1f)
> +BUILD_EP_CONTEXT_RW(lsa, info0, 15, 0x1)
> +BUILD_EP_CONTEXT_RW(interval, info0, 16, 0xff)
> +BUILD_EP_CONTEXT_RW(cerr, info1, 1, 0x3)
> +BUILD_EP_CONTEXT_RW(type, info1, 3, 0x7)
> +BUILD_EP_CONTEXT_RW(hid, info1, 7, 0x1)
> +BUILD_EP_CONTEXT_RW(max_burst_size, info1, 8, 0xff)
> +BUILD_EP_CONTEXT_RW(max_packet_size, info1, 16, 0xffff)
> +BUILD_EP_CONTEXT_RW(dcs, deq_lo, 0, 0x1)
> +BUILD_EP_CONTEXT_RW(deq_lo, deq_lo, 4, 0xfffffff)
> +BUILD_EP_CONTEXT_RW(deq_hi, deq_hi, 0, 0xffffffff)
> +BUILD_EP_CONTEXT_RW(avg_trb_len, tx_info, 0, 0xffff)
> +BUILD_EP_CONTEXT_RW(max_esit_payload, tx_info, 16, 0xffff)
> +BUILD_EP_CONTEXT_RW(edtla, rsvd[0], 0, 0xffffff)
> +BUILD_EP_CONTEXT_RW(seq_num, rsvd[0], 24, 0xff)
> +BUILD_EP_CONTEXT_RW(partial_td, rsvd[0], 25, 0x1)
> +BUILD_EP_CONTEXT_RW(cerrcnt, rsvd[1], 18, 0x3)
> +BUILD_EP_CONTEXT_RW(data_offset, rsvd[2], 0, 0x1ffff)
> +BUILD_EP_CONTEXT_RW(numtrbs, rsvd[2], 22, 0x1f)
> +BUILD_EP_CONTEXT_RW(devaddr, rsvd[6], 0, 0x7f)
> +
> +static inline u64 ep_ctx_read_deq_ptr(struct tegra_xudc_ep_context *ctx)
> +{
> +	return ((u64)ep_ctx_read_deq_hi(ctx) << 32) |
> +		(ep_ctx_read_deq_lo(ctx) << 4);
> +}
> +
> +static inline void
> +ep_ctx_write_deq_ptr(struct tegra_xudc_ep_context *ctx, u64 addr)
> +{
> +	ep_ctx_write_deq_lo(ctx, lower_32_bits(addr) >> 4);
> +	ep_ctx_write_deq_hi(ctx, upper_32_bits(addr));
> +}
> +
> +struct tegra_xudc_trb {
> +	__le32 data_lo;
> +	__le32 data_hi;
> +	__le32 status;
> +	__le32 control;
> +};
> +
> +#define TRB_TYPE_RSVD 0
> +#define TRB_TYPE_NORMAL 1
> +#define TRB_TYPE_SETUP_STAGE 2
> +#define TRB_TYPE_DATA_STAGE 3
> +#define TRB_TYPE_STATUS_STAGE 4
> +#define TRB_TYPE_ISOCH 5
> +#define TRB_TYPE_LINK 6
> +#define TRB_TYPE_TRANSFER_EVENT 32
> +#define TRB_TYPE_PORT_STATUS_CHANGE_EVENT 34
> +#define TRB_TYPE_STREAM 48
> +#define TRB_TYPE_SETUP_PACKET_EVENT 63
> +
> +#define TRB_CMPL_CODE_INVALID 0
> +#define TRB_CMPL_CODE_SUCCESS 1
> +#define TRB_CMPL_CODE_DATA_BUFFER_ERR 2
> +#define TRB_CMPL_CODE_BABBLE_DETECTED_ERR 3
> +#define TRB_CMPL_CODE_USB_TRANS_ERR 4
> +#define TRB_CMPL_CODE_TRB_ERR 5
> +#define TRB_CMPL_CODE_STALL 6
> +#define TRB_CMPL_CODE_INVALID_STREAM_TYPE_ERR 10
> +#define TRB_CMPL_CODE_SHORT_PACKET 13
> +#define TRB_CMPL_CODE_RING_UNDERRUN 14
> +#define TRB_CMPL_CODE_RING_OVERRUN 15
> +#define TRB_CMPL_CODE_EVENT_RING_FULL_ERR 21
> +#define TRB_CMPL_CODE_STOPPED 26
> +#define TRB_CMPL_CODE_ISOCH_BUFFER_OVERRUN 31
> +#define TRB_CMPL_CODE_STREAM_NUMP_ERROR 219
> +#define TRB_CMPL_CODE_PRIME_PIPE_RECEIVED 220
> +#define TRB_CMPL_CODE_HOST_REJECTED 221
> +#define TRB_CMPL_CODE_CTRL_DIR_ERR 222
> +#define TRB_CMPL_CODE_CTRL_SEQNUM_ERR 223
> +
> +#define BUILD_TRB_RW(name, member, shift, mask)				\
> +static inline u32 trb_read_##name(struct tegra_xudc_trb *trb)		\
> +{									\
> +	return (le32_to_cpu(trb->member) >> (shift)) & (mask);		\
> +}									\
> +static inline void							\
> +trb_write_##name(struct tegra_xudc_trb *trb, u32 val)			\
> +{									\
> +	u32 tmp;							\
> +									\
> +	tmp =3D le32_to_cpu(trb->member) & ~((mask) << (shift));		\
> +	tmp |=3D (val & (mask)) << (shift);				\
> +	trb->member =3D cpu_to_le32(tmp);					\
> +}
> +
> +BUILD_TRB_RW(data_lo, data_lo, 0, 0xffffffff)
> +BUILD_TRB_RW(data_hi, data_hi, 0, 0xffffffff)
> +BUILD_TRB_RW(seq_num, status, 0, 0xffff)
> +BUILD_TRB_RW(transfer_len, status, 0, 0xffffff)
> +BUILD_TRB_RW(td_size, status, 17, 0x1f)
> +BUILD_TRB_RW(cmpl_code, status, 24, 0xff)
> +BUILD_TRB_RW(cycle, control, 0, 0x1)
> +BUILD_TRB_RW(toggle_cycle, control, 1, 0x1)
> +BUILD_TRB_RW(isp, control, 2, 0x1)
> +BUILD_TRB_RW(chain, control, 4, 0x1)
> +BUILD_TRB_RW(ioc, control, 5, 0x1)
> +BUILD_TRB_RW(type, control, 10, 0x3f)
> +BUILD_TRB_RW(stream_id, control, 16, 0xffff)
> +BUILD_TRB_RW(endpoint_id, control, 16, 0x1f)
> +BUILD_TRB_RW(tlbpc, control, 16, 0xf)
> +BUILD_TRB_RW(data_stage_dir, control, 16, 0x1)
> +BUILD_TRB_RW(frame_id, control, 20, 0x7ff)
> +BUILD_TRB_RW(sia, control, 31, 0x1)
> +
> +static inline u64 trb_read_data_ptr(struct tegra_xudc_trb *trb)
> +{
> +	return ((u64)trb_read_data_hi(trb) << 32) |
> +		trb_read_data_lo(trb);
> +}
> +
> +static inline void trb_write_data_ptr(struct tegra_xudc_trb *trb, u64 ad=
dr)
> +{
> +	trb_write_data_lo(trb, lower_32_bits(addr));
> +	trb_write_data_hi(trb, upper_32_bits(addr));
> +}
> +
> +struct tegra_xudc_request {
> +	struct usb_request usb_req;
> +
> +	size_t buf_queued;
> +	unsigned int trbs_queued;
> +	unsigned int trbs_needed;
> +	bool need_zlp;
> +
> +	struct tegra_xudc_trb *first_trb;
> +	struct tegra_xudc_trb *last_trb;
> +
> +	struct list_head list;
> +};
> +
> +struct tegra_xudc_ep {
> +	struct tegra_xudc *xudc;
> +	struct usb_ep usb_ep;
> +	unsigned int index;
> +	char name[8];
> +
> +	struct tegra_xudc_ep_context *context;
> +
> +#define XUDC_TRANSFER_RING_SIZE 64
> +	struct tegra_xudc_trb *transfer_ring;
> +	dma_addr_t transfer_ring_phys;
> +
> +	unsigned int enq_ptr;
> +	unsigned int deq_ptr;
> +	bool pcs;
> +	bool ring_full;
> +	bool stream_rejected;
> +
> +	struct list_head queue;
> +	const struct usb_endpoint_descriptor *desc;
> +	const struct usb_ss_ep_comp_descriptor *comp_desc;
> +};
> +
> +struct tegra_xudc_sel_timing {
> +	__u8 u1sel;
> +	__u8 u1pel;
> +	__le16 u2sel;
> +	__le16 u2pel;
> +};
> +
> +enum tegra_xudc_setup_state {
> +	WAIT_FOR_SETUP,
> +	DATA_STAGE_XFER,
> +	DATA_STAGE_RECV,
> +	STATUS_STAGE_XFER,
> +	STATUS_STAGE_RECV,
> +};
> +
> +struct tegra_xudc_setup_packet {
> +	struct usb_ctrlrequest ctrl_req;
> +	unsigned int seq_num;
> +};
> +
> +struct tegra_xudc_save_regs {
> +	u32 ctrl;
> +	u32 portpm;
> +};
> +
> +struct tegra_xudc {
> +	struct device *dev;
> +	const struct tegra_xudc_soc *soc;
> +	struct tegra_xusb_padctl *padctl;
> +
> +	spinlock_t lock;
> +
> +	struct usb_gadget gadget;
> +	struct usb_gadget_driver *driver;
> +
> +#define XUDC_NR_EVENT_RINGS 2
> +#define XUDC_EVENT_RING_SIZE 4096
> +	struct tegra_xudc_trb *event_ring[XUDC_NR_EVENT_RINGS];
> +	dma_addr_t event_ring_phys[XUDC_NR_EVENT_RINGS];
> +	unsigned int event_ring_index;
> +	unsigned int event_ring_deq_ptr;
> +	bool ccs;
> +
> +#define XUDC_NR_EPS 32
> +	struct tegra_xudc_ep ep[XUDC_NR_EPS];
> +	struct tegra_xudc_ep_context *ep_context;
> +	dma_addr_t ep_context_phys;
> +
> +	struct device *genpd_dev_device;
> +	struct device *genpd_dev_ss;
> +	struct device_link *genpd_dl_device;
> +	struct device_link *genpd_dl_ss;
> +
> +	struct dma_pool *transfer_ring_pool;
> +
> +	bool queued_setup_packet;
> +	struct tegra_xudc_setup_packet setup_packet;
> +	enum tegra_xudc_setup_state setup_state;
> +	u16 setup_seq_num;
> +
> +	u16 dev_addr;
> +	u16 isoch_delay;
> +	struct tegra_xudc_sel_timing sel_timing;
> +	u8 test_mode_pattern;
> +	u16 status_buf;
> +	struct tegra_xudc_request *ep0_req;
> +
> +	bool pullup;
> +
> +	unsigned int nr_enabled_eps;
> +	unsigned int nr_isoch_eps;
> +
> +	unsigned int device_state;
> +	unsigned int resume_state;
> +
> +	int irq;
> +
> +	void __iomem *base;
> +	resource_size_t phys_base;
> +	void __iomem *ipfs;
> +	void __iomem *fpci;
> +
> +	struct regulator_bulk_data *supplies;
> +
> +	struct clk_bulk_data *clks;
> +
> +	enum usb_role device_mode;
> +	struct usb_role_switch *usb_role_sw;
> +	struct work_struct usb_role_sw_work;
> +
> +	struct phy *usb3_phy;
> +	struct phy *utmi_phy;
> +
> +	struct tegra_xudc_save_regs saved_regs;
> +	bool suspended;
> +	bool powergated;
> +
> +	struct completion disconnect_complete;
> +
> +	bool selfpowered;
> +
> +#define TOGGLE_VBUS_WAIT_MS 100
> +	struct delayed_work plc_reset_work;
> +	bool wait_csc;
> +
> +	struct delayed_work port_reset_war_work;
> +	bool wait_for_sec_prc;
> +};
> +
> +#define XUDC_TRB_MAX_BUFFER_SIZE 65536
> +#define XUDC_MAX_ISOCH_EPS 4
> +#define XUDC_INTERRUPT_MODERATION_US 0
> +
> +static struct usb_endpoint_descriptor tegra_xudc_ep0_desc =3D {
> +	.bLength =3D USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType =3D USB_DT_ENDPOINT,
> +	.bEndpointAddress =3D 0,
> +	.bmAttributes =3D USB_ENDPOINT_XFER_CONTROL,
> +	.wMaxPacketSize =3D cpu_to_le16(64),
> +};
> +
> +struct tegra_xudc_soc {
> +	const char * const *supply_names;
> +	unsigned int num_supplies;
> +	const char * const *clock_names;
> +	unsigned int num_clks;
> +	bool u1_enable;
> +	bool u2_enable;
> +	bool lpm_enable;
> +	bool invalid_seq_num;
> +	bool pls_quirk;
> +	bool port_reset_quirk;
> +	bool has_ipfs;
> +};
> +
> +static inline u32 fpci_readl(struct tegra_xudc *xudc, unsigned int offse=
t)
> +{
> +	return readl(xudc->fpci + offset);
> +}
> +
> +static inline void fpci_writel(struct tegra_xudc *xudc, u32 val,
> +			       unsigned int offset)
> +{
> +	writel(val, xudc->fpci + offset);
> +}
> +
> +static inline u32 ipfs_readl(struct tegra_xudc *xudc, unsigned int offse=
t)
> +{
> +	return readl(xudc->ipfs + offset);
> +}
> +
> +static inline void ipfs_writel(struct tegra_xudc *xudc, u32 val,
> +			       unsigned int offset)
> +{
> +	writel(val, xudc->ipfs + offset);
> +}
> +
> +static inline u32 xudc_readl(struct tegra_xudc *xudc, unsigned int offse=
t)
> +{
> +	return readl(xudc->base + offset);
> +}
> +
> +static inline void xudc_writel(struct tegra_xudc *xudc, u32 val,
> +			       unsigned int offset)
> +{
> +	writel(val, xudc->base + offset);
> +}
> +
> +static inline int xudc_readl_poll(struct tegra_xudc *xudc,
> +				  unsigned int offset, u32 mask, u32 val)
> +{
> +	u32 regval;
> +
> +	return readl_poll_timeout_atomic(xudc->base + offset, regval,
> +					 (regval & mask) =3D=3D val, 1, 100);
> +}
> +
> +static inline struct tegra_xudc *to_xudc(struct usb_gadget *gadget)
> +{
> +	return container_of(gadget, struct tegra_xudc, gadget);
> +}
> +
> +static inline struct tegra_xudc_ep *to_xudc_ep(struct usb_ep *ep)
> +{
> +	return container_of(ep, struct tegra_xudc_ep, usb_ep);
> +}
> +
> +static inline struct tegra_xudc_request *to_xudc_req(struct usb_request =
*req)
> +{
> +	return container_of(req, struct tegra_xudc_request, usb_req);
> +}
> +
> +static inline void dump_trb(struct tegra_xudc *xudc, const char *type,
> +			    struct tegra_xudc_trb *trb)
> +{
> +	dev_dbg(xudc->dev,
> +		"%s: %p, lo =3D %#x, hi =3D %#x, status =3D %#x, control =3D %#x\n",
> +		type, trb, trb->data_lo, trb->data_hi, trb->status,
> +		trb->control);
> +}
> +
> +static void tegra_xudc_device_mode_on(struct tegra_xudc *xudc)
> +{
> +	int err;
> +
> +	pm_runtime_get_sync(xudc->dev);
> +
> +	err =3D phy_power_on(xudc->utmi_phy);
> +	if (err < 0)
> +		dev_err(xudc->dev, "utmi power on failed %d\n", err);
> +
> +	err =3D phy_power_on(xudc->usb3_phy);
> +	if (err < 0)
> +		dev_err(xudc->dev, "usb3 phy power on failed %d\n", err);
> +
> +	dev_dbg(xudc->dev, "device mode on\n");
> +
> +	tegra_xusb_padctl_set_vbus_override(xudc->padctl, true);
> +
> +	xudc->device_mode =3D USB_ROLE_DEVICE;
> +}
> +
> +static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
> +{
> +	bool connected =3D false;
> +	u32 pls, val;
> +	int err;
> +
> +	dev_dbg(xudc->dev, "device mode off\n");
> +
> +	connected =3D !!(xudc_readl(xudc, PORTSC) & PORTSC_CCS);
> +
> +	reinit_completion(&xudc->disconnect_complete);
> +
> +	tegra_xusb_padctl_set_vbus_override(xudc->padctl, false);
> +
> +	pls =3D (xudc_readl(xudc, PORTSC) & PORTSC_PLS_MASK) >>
> +		PORTSC_PLS_SHIFT;
> +
> +	/* Direct link to U0 if disconnected in RESUME or U2. */
> +	if (xudc->soc->pls_quirk && xudc->gadget.speed =3D=3D USB_SPEED_SUPER &&
> +	    (pls =3D=3D PORTSC_PLS_RESUME || pls =3D=3D PORTSC_PLS_U2)) {
> +		val =3D xudc_readl(xudc, PORTPM);
> +		val |=3D PORTPM_FRWE;
> +		xudc_writel(xudc, val, PORTPM);
> +
> +		val =3D xudc_readl(xudc, PORTSC);
> +		val &=3D ~(PORTSC_CHANGE_MASK | PORTSC_PLS_MASK);
> +		val |=3D PORTSC_LWS | PORTSC_PLS(PORTSC_PLS_U0);
> +		xudc_writel(xudc, val, PORTSC);
> +	}
> +
> +	xudc->device_mode =3D USB_ROLE_NONE;
> +
> +	/* Wait for disconnect event. */
> +	if (connected)
> +		wait_for_completion(&xudc->disconnect_complete);
> +
> +	/* Make sure interrupt handler has completed before powergating. */
> +	synchronize_irq(xudc->irq);
> +
> +	err =3D phy_power_off(xudc->utmi_phy);
> +	if (err < 0)
> +		dev_err(xudc->dev, "utmi_phy power off failed %d\n", err);
> +
> +	err =3D phy_power_off(xudc->usb3_phy);
> +	if (err < 0)
> +		dev_err(xudc->dev, "usb3_phy power off failed %d\n", err);
> +
> +	pm_runtime_put(xudc->dev);
> +}
> +
> +static void tegra_xudc_usb_role_sw_work(struct work_struct *work)
> +{
> +	struct tegra_xudc *xudc =3D container_of(work, struct tegra_xudc,
> +					       usb_role_sw_work);
> +
> +	if (!xudc->usb_role_sw ||
> +		usb_role_switch_get_role(xudc->usb_role_sw) =3D=3D USB_ROLE_DEVICE)
> +		tegra_xudc_device_mode_on(xudc);
> +	else
> +		tegra_xudc_device_mode_off(xudc);
> +
> +}
> +
> +static int tegra_xudc_usb_role_sw_set(struct device *dev, enum usb_role =
role)
> +{
> +	struct tegra_xudc *xudc =3D dev_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	dev_dbg(dev, "%s role is %d\n", __func__, role);
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	if (!xudc->suspended)
> +		schedule_work(&xudc->usb_role_sw_work);
> +
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void tegra_xudc_plc_reset_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork =3D to_delayed_work(work);
> +	struct tegra_xudc *xudc =3D container_of(dwork, struct tegra_xudc,
> +					       plc_reset_work);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	if (xudc->wait_csc) {
> +		u32 pls =3D (xudc_readl(xudc, PORTSC) & PORTSC_PLS_MASK) >>
> +			PORTSC_PLS_SHIFT;
> +
> +		if (pls =3D=3D PORTSC_PLS_INACTIVE) {
> +			dev_info(xudc->dev, "PLS =3D Inactive. Toggle VBUS\n");
> +			tegra_xusb_padctl_set_vbus_override(xudc->padctl,
> +							      false);
> +			tegra_xusb_padctl_set_vbus_override(xudc->padctl, true);
> +			xudc->wait_csc =3D false;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +}
> +
> +static void tegra_xudc_port_reset_war_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork =3D to_delayed_work(work);
> +	struct tegra_xudc *xudc =3D
> +		container_of(dwork, struct tegra_xudc, port_reset_war_work);
> +	unsigned long flags;
> +	u32 pls;
> +	int ret;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	if ((xudc->device_mode =3D=3D USB_ROLE_DEVICE)
> +			      && xudc->wait_for_sec_prc) {
> +		pls =3D (xudc_readl(xudc, PORTSC) & PORTSC_PLS_MASK) >>
> +			PORTSC_PLS_SHIFT;
> +		dev_dbg(xudc->dev, "pls =3D %x\n", pls);
> +
> +		if (pls =3D=3D PORTSC_PLS_DISABLED) {
> +			dev_dbg(xudc->dev, "toggle vbus\n");
> +			/* PRC doesn't complete in 100ms, toggle the vbus */
> +			ret =3D tegra_phy_xusb_utmi_port_reset(xudc->utmi_phy);
> +			if (ret =3D=3D 1)
> +				xudc->wait_for_sec_prc =3D 0;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +}
> +
> +static dma_addr_t trb_virt_to_phys(struct tegra_xudc_ep *ep,
> +				   struct tegra_xudc_trb *trb)
> +{
> +	unsigned int index;
> +
> +	index =3D trb - ep->transfer_ring;
> +
> +	if (WARN_ON(index >=3D XUDC_TRANSFER_RING_SIZE))
> +		return 0;
> +
> +	return (ep->transfer_ring_phys + index * sizeof(*trb));
> +}
> +
> +static struct tegra_xudc_trb *trb_phys_to_virt(struct tegra_xudc_ep *ep,
> +					       dma_addr_t addr)
> +{
> +	struct tegra_xudc_trb *trb;
> +	unsigned int index;
> +
> +	index =3D (addr - ep->transfer_ring_phys) / sizeof(*trb);
> +
> +	if (WARN_ON(index >=3D XUDC_TRANSFER_RING_SIZE))
> +		return NULL;
> +
> +	trb =3D &ep->transfer_ring[index];
> +
> +	return trb;
> +}
> +
> +static void ep_reload(struct tegra_xudc *xudc, unsigned int ep)
> +{
> +	xudc_writel(xudc, BIT(ep), EP_RELOAD);
> +	xudc_readl_poll(xudc, EP_RELOAD, BIT(ep), 0);
> +}
> +
> +static void ep_pause(struct tegra_xudc *xudc, unsigned int ep)
> +{
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, EP_PAUSE);
> +	if (val & BIT(ep))
> +		return;
> +	val |=3D BIT(ep);
> +
> +	xudc_writel(xudc, val, EP_PAUSE);
> +
> +	xudc_readl_poll(xudc, EP_STCHG, BIT(ep), BIT(ep));
> +
> +	xudc_writel(xudc, BIT(ep), EP_STCHG);
> +}
> +
> +static void ep_unpause(struct tegra_xudc *xudc, unsigned int ep)
> +{
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, EP_PAUSE);
> +	if (!(val & BIT(ep)))
> +		return;
> +	val &=3D ~BIT(ep);
> +
> +	xudc_writel(xudc, val, EP_PAUSE);
> +
> +	xudc_readl_poll(xudc, EP_STCHG, BIT(ep), BIT(ep));
> +
> +	xudc_writel(xudc, BIT(ep), EP_STCHG);
> +}
> +
> +static void ep_unpause_all(struct tegra_xudc *xudc)
> +{
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, EP_PAUSE);
> +
> +	xudc_writel(xudc, 0, EP_PAUSE);
> +
> +	xudc_readl_poll(xudc, EP_STCHG, val, val);
> +
> +	xudc_writel(xudc, val, EP_STCHG);
> +}
> +
> +static void ep_halt(struct tegra_xudc *xudc, unsigned int ep)
> +{
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, EP_HALT);
> +	if (val & BIT(ep))
> +		return;
> +	val |=3D BIT(ep);
> +	xudc_writel(xudc, val, EP_HALT);
> +
> +	xudc_readl_poll(xudc, EP_STCHG, BIT(ep), BIT(ep));
> +
> +	xudc_writel(xudc, BIT(ep), EP_STCHG);
> +}
> +
> +static void ep_unhalt(struct tegra_xudc *xudc, unsigned int ep)
> +{
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, EP_HALT);
> +	if (!(val & BIT(ep)))
> +		return;
> +	val &=3D ~BIT(ep);
> +	xudc_writel(xudc, val, EP_HALT);
> +
> +	xudc_readl_poll(xudc, EP_STCHG, BIT(ep), BIT(ep));
> +
> +	xudc_writel(xudc, BIT(ep), EP_STCHG);
> +}
> +
> +static void ep_unhalt_all(struct tegra_xudc *xudc)
> +{
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, EP_HALT);
> +	if (!val)
> +		return;
> +	xudc_writel(xudc, 0, EP_HALT);
> +
> +	xudc_readl_poll(xudc, EP_STCHG, val, val);
> +
> +	xudc_writel(xudc, val, EP_STCHG);
> +}
> +
> +static void ep_wait_for_stopped(struct tegra_xudc *xudc, unsigned int ep)
> +{
> +	xudc_readl_poll(xudc, EP_STOPPED, BIT(ep), BIT(ep));
> +	xudc_writel(xudc, BIT(ep), EP_STOPPED);
> +}
> +
> +static void ep_wait_for_inactive(struct tegra_xudc *xudc, unsigned int e=
p)
> +{
> +	xudc_readl_poll(xudc, EP_THREAD_ACTIVE, BIT(ep), 0);
> +}
> +
> +static void tegra_xudc_req_done(struct tegra_xudc_ep *ep,
> +				struct tegra_xudc_request *req, int status)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +
> +	dev_dbg(xudc->dev, "completing request %p on EP %u with status %d\n",
> +		 req, ep->index, status);
> +
> +	if (likely(req->usb_req.status =3D=3D -EINPROGRESS))
> +		req->usb_req.status =3D status;
> +
> +	list_del_init(&req->list);
> +
> +	if (usb_endpoint_xfer_control(ep->desc)) {
> +		usb_gadget_unmap_request(&xudc->gadget, &req->usb_req,
> +					 (xudc->setup_state =3D=3D
> +					  DATA_STAGE_XFER));
> +	} else {
> +		usb_gadget_unmap_request(&xudc->gadget, &req->usb_req,
> +					 usb_endpoint_dir_in(ep->desc));
> +	}
> +
> +	spin_unlock(&xudc->lock);
> +	usb_gadget_giveback_request(&ep->usb_ep, &req->usb_req);
> +	spin_lock(&xudc->lock);
> +}
> +
> +static void tegra_xudc_ep_nuke(struct tegra_xudc_ep *ep, int status)
> +{
> +	struct tegra_xudc_request *req;
> +
> +	while (!list_empty(&ep->queue)) {
> +		req =3D list_first_entry(&ep->queue, struct tegra_xudc_request,
> +				       list);
> +		tegra_xudc_req_done(ep, req, status);
> +	}
> +}
> +
> +static unsigned int ep_available_trbs(struct tegra_xudc_ep *ep)
> +{
> +	if (ep->ring_full)
> +		return 0;
> +
> +	if (ep->deq_ptr > ep->enq_ptr)
> +		return ep->deq_ptr - ep->enq_ptr - 1;
> +
> +	return XUDC_TRANSFER_RING_SIZE - (ep->enq_ptr - ep->deq_ptr) - 2;
> +}
> +
> +static void tegra_xudc_queue_one_trb(struct tegra_xudc_ep *ep,
> +				     struct tegra_xudc_request *req,
> +				     struct tegra_xudc_trb *trb,
> +				     bool ioc)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +	dma_addr_t buf_addr;
> +	size_t len;
> +
> +	len =3D min_t(size_t, XUDC_TRB_MAX_BUFFER_SIZE, req->usb_req.length -
> +		    req->buf_queued);
> +	if (len > 0)
> +		buf_addr =3D req->usb_req.dma + req->buf_queued;
> +	else
> +		buf_addr =3D 0;
> +
> +	trb_write_data_ptr(trb, buf_addr);
> +
> +	trb_write_transfer_len(trb, len);
> +	trb_write_td_size(trb, req->trbs_needed - req->trbs_queued - 1);
> +
> +	if (req->trbs_queued =3D=3D req->trbs_needed - 1 ||
> +		(req->need_zlp && req->trbs_queued =3D=3D req->trbs_needed - 2))
> +		trb_write_chain(trb, 0);
> +	else
> +		trb_write_chain(trb, 1);
> +
> +	trb_write_ioc(trb, ioc);
> +
> +	if (usb_endpoint_dir_out(ep->desc) ||
> +	    (usb_endpoint_xfer_control(ep->desc) &&
> +	     (xudc->setup_state =3D=3D DATA_STAGE_RECV)))
> +		trb_write_isp(trb, 1);
> +	else
> +		trb_write_isp(trb, 0);
> +
> +	if (usb_endpoint_xfer_control(ep->desc)) {
> +		if (xudc->setup_state =3D=3D DATA_STAGE_XFER ||
> +		    xudc->setup_state =3D=3D DATA_STAGE_RECV)
> +			trb_write_type(trb, TRB_TYPE_DATA_STAGE);
> +		else
> +			trb_write_type(trb, TRB_TYPE_STATUS_STAGE);
> +
> +		if (xudc->setup_state =3D=3D DATA_STAGE_XFER ||
> +		    xudc->setup_state =3D=3D STATUS_STAGE_XFER)
> +			trb_write_data_stage_dir(trb, 1);
> +		else
> +			trb_write_data_stage_dir(trb, 0);
> +	} else if (usb_endpoint_xfer_isoc(ep->desc)) {
> +		trb_write_type(trb, TRB_TYPE_ISOCH);
> +		trb_write_sia(trb, 1);
> +		trb_write_frame_id(trb, 0);
> +		trb_write_tlbpc(trb, 0);
> +	} else if (usb_ss_max_streams(ep->comp_desc)) {
> +		trb_write_type(trb, TRB_TYPE_STREAM);
> +		trb_write_stream_id(trb, req->usb_req.stream_id);
> +	} else {
> +		trb_write_type(trb, TRB_TYPE_NORMAL);
> +		trb_write_stream_id(trb, 0);
> +	}
> +
> +	trb_write_cycle(trb, ep->pcs);
> +
> +	req->trbs_queued++;
> +	req->buf_queued +=3D len;
> +
> +	dump_trb(xudc, "TRANSFER", trb);
> +}
> +
> +static unsigned int tegra_xudc_queue_trbs(struct tegra_xudc_ep *ep,
> +					  struct tegra_xudc_request *req)
> +{
> +	unsigned int i, count, available;
> +	bool wait_td =3D false;
> +
> +	available =3D ep_available_trbs(ep);
> +	count =3D req->trbs_needed - req->trbs_queued;
> +	if (available < count) {
> +		count =3D available;
> +		ep->ring_full =3D true;
> +	}
> +
> +	/*
> +	 * To generate zero-length packet on USB bus, SW needs schedule a
> +	 * standalone zero-length TD. According to HW's behavior, SW needs
> +	 * to schedule TDs in different ways for different endpoint types.
> +	 *
> +	 * For control endpoint:
> +	 * - Data stage TD (IOC =3D 1, CH =3D 0)
> +	 * - Ring doorbell and wait transfer event
> +	 * - Data stage TD for ZLP (IOC =3D 1, CH =3D 0)
> +	 * - Ring doorbell
> +	 *
> +	 * For bulk and interrupt endpoints:
> +	 * - Normal transfer TD (IOC =3D 0, CH =3D 0)
> +	 * - Normal transfer TD for ZLP (IOC =3D 1, CH =3D 0)
> +	 * - Ring doorbell
> +	 */
> +
> +	if (req->need_zlp && usb_endpoint_xfer_control(ep->desc) && count > 1)
> +		wait_td =3D true;
> +
> +	if (!req->first_trb)
> +		req->first_trb =3D &ep->transfer_ring[ep->enq_ptr];
> +
> +	for (i =3D 0; i < count; i++) {
> +		struct tegra_xudc_trb *trb =3D &ep->transfer_ring[ep->enq_ptr];
> +		bool ioc =3D false;
> +
> +		if ((i =3D=3D count - 1) || (wait_td && i =3D=3D count - 2))
> +			ioc =3D true;
> +
> +		tegra_xudc_queue_one_trb(ep, req, trb, ioc);
> +		req->last_trb =3D trb;
> +
> +		ep->enq_ptr++;
> +		if (ep->enq_ptr =3D=3D XUDC_TRANSFER_RING_SIZE - 1) {
> +			trb =3D &ep->transfer_ring[ep->enq_ptr];
> +			trb_write_cycle(trb, ep->pcs);
> +			ep->pcs =3D !ep->pcs;
> +			ep->enq_ptr =3D 0;
> +		}
> +
> +		if (ioc)
> +			break;
> +	}
> +
> +	return count;
> +}
> +
> +static void tegra_xudc_ep_ring_doorbell(struct tegra_xudc_ep *ep)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +	u32 val;
> +
> +	if (list_empty(&ep->queue))
> +		return;
> +
> +	val =3D DB_TARGET(ep->index);
> +	if (usb_endpoint_xfer_control(ep->desc)) {
> +		val |=3D DB_STREAMID(xudc->setup_seq_num);
> +	} else if (usb_ss_max_streams(ep->comp_desc) > 0) {
> +		struct tegra_xudc_request *req;
> +
> +		/* Don't ring doorbell if the stream has been rejected. */
> +		if (ep->stream_rejected)
> +			return;
> +
> +		req =3D list_first_entry(&ep->queue, struct tegra_xudc_request,
> +				       list);
> +		val |=3D DB_STREAMID(req->usb_req.stream_id);
> +	}
> +
> +	dev_dbg(xudc->dev, "ring doorbell: %#x\n", val);
> +	xudc_writel(xudc, val, DB);
> +}
> +
> +static void tegra_xudc_ep_kick_queue(struct tegra_xudc_ep *ep)
> +{
> +	struct tegra_xudc_request *req;
> +	bool trbs_queued =3D false;
> +
> +	list_for_each_entry(req, &ep->queue, list) {
> +		if (ep->ring_full)
> +			break;
> +
> +		if (tegra_xudc_queue_trbs(ep, req) > 0)
> +			trbs_queued =3D true;
> +	}
> +
> +	if (trbs_queued)
> +		tegra_xudc_ep_ring_doorbell(ep);
> +}
> +
> +static int
> +__tegra_xudc_ep_queue(struct tegra_xudc_ep *ep, struct tegra_xudc_reques=
t *req)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +	int err;
> +
> +	if (usb_endpoint_xfer_control(ep->desc) && !list_empty(&ep->queue)) {
> +		dev_err(xudc->dev, "control EP has pending transfers\n");
> +		return -EINVAL;
> +	}
> +
> +	if (usb_endpoint_xfer_control(ep->desc)) {
> +		err =3D usb_gadget_map_request(&xudc->gadget, &req->usb_req,
> +					     (xudc->setup_state =3D=3D
> +					      DATA_STAGE_XFER));
> +	} else {
> +		err =3D usb_gadget_map_request(&xudc->gadget, &req->usb_req,
> +					     usb_endpoint_dir_in(ep->desc));
> +	}
> +
> +	if (err < 0) {
> +		dev_err(xudc->dev, "failed to map request: %d\n", err);
> +		return err;
> +	}
> +
> +	req->first_trb =3D NULL;
> +	req->last_trb =3D NULL;
> +	req->buf_queued =3D 0;
> +	req->trbs_queued =3D 0;
> +	req->need_zlp =3D false;
> +	req->trbs_needed =3D DIV_ROUND_UP(req->usb_req.length,
> +					XUDC_TRB_MAX_BUFFER_SIZE);
> +	if (req->usb_req.length =3D=3D 0)
> +		req->trbs_needed++;
> +
> +	if (!usb_endpoint_xfer_isoc(ep->desc) &&
> +	    req->usb_req.zero && req->usb_req.length &&
> +	    ((req->usb_req.length % ep->usb_ep.maxpacket) =3D=3D 0)) {
> +		req->trbs_needed++;
> +		req->need_zlp =3D true;
> +	}
> +
> +	req->usb_req.status =3D -EINPROGRESS;
> +	req->usb_req.actual =3D 0;
> +
> +	list_add_tail(&req->list, &ep->queue);
> +
> +	tegra_xudc_ep_kick_queue(ep);
> +
> +	return 0;
> +}
> +
> +static int
> +tegra_xudc_ep_queue(struct usb_ep *usb_ep, struct usb_request *usb_req,
> +		    gfp_t gfp)
> +{
> +	struct tegra_xudc_request *req;
> +	struct tegra_xudc_ep *ep;
> +	struct tegra_xudc *xudc;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!usb_ep || !usb_req)
> +		return -EINVAL;
> +
> +	ep =3D to_xudc_ep(usb_ep);
> +	req =3D to_xudc_req(usb_req);
> +	xudc =3D ep->xudc;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	if (xudc->powergated || !ep->desc) {
> +		ret =3D -ESHUTDOWN;
> +		goto unlock;
> +	}
> +
> +	ret =3D __tegra_xudc_ep_queue(ep, req);
> +unlock:
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void squeeze_transfer_ring(struct tegra_xudc_ep *ep,
> +				  struct tegra_xudc_request *req)
> +{
> +	struct tegra_xudc_trb *trb =3D req->first_trb;
> +	bool pcs_enq =3D trb_read_cycle(trb);
> +	bool pcs;
> +
> +	/*
> +	 * Clear out all the TRBs part of or after the cancelled request,
> +	 * and must correct trb cycle bit to the last un-enqueued state.
> +	 */
> +	while (trb !=3D &ep->transfer_ring[ep->enq_ptr]) {
> +		pcs =3D trb_read_cycle(trb);
> +		memset(trb, 0, sizeof(*trb));
> +		trb_write_cycle(trb, !pcs);
> +		trb++;
> +
> +		if (trb_read_type(trb) =3D=3D TRB_TYPE_LINK)
> +			trb =3D ep->transfer_ring;
> +	}
> +
> +	/* Requests will be re-queued at the start of the cancelled request. */
> +	ep->enq_ptr =3D req->first_trb - ep->transfer_ring;
> +	/*
> +	 * Retrieve the correct cycle bit state from the first trb of
> +	 * the cancelled request.
> +	 */
> +	ep->pcs =3D pcs_enq;
> +	ep->ring_full =3D false;
> +	list_for_each_entry_continue(req, &ep->queue, list) {
> +		req->usb_req.status =3D -EINPROGRESS;
> +		req->usb_req.actual =3D 0;
> +
> +		req->first_trb =3D NULL;
> +		req->last_trb =3D NULL;
> +		req->buf_queued =3D 0;
> +		req->trbs_queued =3D 0;
> +	}
> +}
> +
> +/*
> + * Determine if the given TRB is in the range [first trb, last trb] for =
the
> + * given request.
> + */
> +static bool trb_in_request(struct tegra_xudc_ep *ep,
> +			   struct tegra_xudc_request *req,
> +			   struct tegra_xudc_trb *trb)
> +{
> +	dev_dbg(ep->xudc->dev, "%s: request %p -> %p; trb %p\n", __func__,
> +		req->first_trb, req->last_trb, trb);
> +
> +	if (trb >=3D req->first_trb && (trb <=3D req->last_trb ||
> +				      req->last_trb < req->first_trb))
> +		return true;
> +
> +	if (trb < req->first_trb && trb <=3D req->last_trb &&
> +	    req->last_trb < req->first_trb)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Determine if the given TRB is in the range [EP enqueue pointer, first=
 TRB)
> + * for the given endpoint and request.
> + */
> +static bool trb_before_request(struct tegra_xudc_ep *ep,
> +			       struct tegra_xudc_request *req,
> +			       struct tegra_xudc_trb *trb)
> +{
> +	struct tegra_xudc_trb *enq_trb =3D &ep->transfer_ring[ep->enq_ptr];
> +
> +	dev_dbg(ep->xudc->dev, "%s: request %p -> %p; enq ptr: %p; trb %p\n",
> +		__func__, req->first_trb, req->last_trb, enq_trb, trb);
> +
> +	if (trb < req->first_trb && (enq_trb <=3D trb ||
> +				     req->first_trb < enq_trb))
> +		return true;
> +
> +	if (trb > req->first_trb && req->first_trb < enq_trb && enq_trb <=3D tr=
b)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int
> +__tegra_xudc_ep_dequeue(struct tegra_xudc_ep *ep,
> +			struct tegra_xudc_request *req)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +	struct tegra_xudc_request *r;
> +	struct tegra_xudc_trb *deq_trb;
> +	bool busy, kick_queue =3D false;
> +	int ret =3D 0;
> +
> +	/* Make sure the request is actually queued to this endpoint. */
> +	list_for_each_entry(r, &ep->queue, list) {
> +		if (r =3D=3D req)
> +			break;
> +	}
> +
> +	if (r !=3D req)
> +		return -EINVAL;
> +
> +	/* Request hasn't been queued in the transfer ring yet. */
> +	if (!req->trbs_queued) {
> +		tegra_xudc_req_done(ep, req, -ECONNRESET);
> +		return 0;
> +	}
> +
> +	/* Halt DMA for this endpiont. */
> +	if (ep_ctx_read_state(ep->context) =3D=3D EP_STATE_RUNNING) {
> +		ep_pause(xudc, ep->index);
> +		ep_wait_for_inactive(xudc, ep->index);
> +	}
> +
> +	deq_trb =3D trb_phys_to_virt(ep, ep_ctx_read_deq_ptr(ep->context));
> +	/* Is the hardware processing the TRB at the dequeue pointer? */
> +	busy =3D (trb_read_cycle(deq_trb) =3D=3D ep_ctx_read_dcs(ep->context));
> +
> +	if (trb_in_request(ep, req, deq_trb) && busy) {
> +		/*
> +		 * Request has been partially completed or it hasn't
> +		 * started processing yet.
> +		 */
> +		dma_addr_t deq_ptr;
> +
> +		squeeze_transfer_ring(ep, req);
> +
> +		req->usb_req.actual =3D ep_ctx_read_edtla(ep->context);
> +		tegra_xudc_req_done(ep, req, -ECONNRESET);
> +		kick_queue =3D true;
> +
> +		/* EDTLA is > 0: request has been partially completed */
> +		if (req->usb_req.actual > 0) {
> +			/*
> +			 * Abort the pending transfer and update the dequeue
> +			 * pointer
> +			 */
> +			ep_ctx_write_edtla(ep->context, 0);
> +			ep_ctx_write_partial_td(ep->context, 0);
> +			ep_ctx_write_data_offset(ep->context, 0);
> +
> +			deq_ptr =3D trb_virt_to_phys(ep,
> +					&ep->transfer_ring[ep->enq_ptr]);
> +
> +			if (dma_mapping_error(xudc->dev, deq_ptr)) {
> +				ret =3D -EINVAL;
> +			} else {
> +				ep_ctx_write_deq_ptr(ep->context, deq_ptr);
> +				ep_ctx_write_dcs(ep->context, ep->pcs);
> +				ep_reload(xudc, ep->index);
> +			}
> +		}
> +	} else if (trb_before_request(ep, req, deq_trb) && busy) {
> +		/* Request hasn't started processing yet. */
> +		squeeze_transfer_ring(ep, req);
> +
> +		tegra_xudc_req_done(ep, req, -ECONNRESET);
> +		kick_queue =3D true;
> +	} else {
> +		/*
> +		 * Request has completed, but we haven't processed the
> +		 * completion event yet.
> +		 */
> +		tegra_xudc_req_done(ep, req, -ECONNRESET);
> +		ret =3D -EINVAL;
> +	}
> +
> +	/* Resume the endpoint. */
> +	ep_unpause(xudc, ep->index);
> +
> +	if (kick_queue)
> +		tegra_xudc_ep_kick_queue(ep);
> +
> +	return ret;
> +}
> +
> +static int
> +tegra_xudc_ep_dequeue(struct usb_ep *usb_ep, struct usb_request *usb_req)
> +{
> +	struct tegra_xudc_request *req;
> +	struct tegra_xudc_ep *ep;
> +	struct tegra_xudc *xudc;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!usb_ep || !usb_req)
> +		return -EINVAL;
> +
> +	ep =3D to_xudc_ep(usb_ep);
> +	req =3D to_xudc_req(usb_req);
> +	xudc =3D ep->xudc;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	if (xudc->powergated || !ep->desc) {
> +		ret =3D -ESHUTDOWN;
> +		goto unlock;
> +	}
> +
> +	ret =3D __tegra_xudc_ep_dequeue(ep, req);
> +unlock:
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int __tegra_xudc_ep_set_halt(struct tegra_xudc_ep *ep, bool halt)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +
> +	if (!ep->desc)
> +		return -EINVAL;
> +
> +	if (usb_endpoint_xfer_isoc(ep->desc)) {
> +		dev_err(xudc->dev, "can't halt isoc EP\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (!!(xudc_readl(xudc, EP_HALT) & BIT(ep->index)) =3D=3D halt) {
> +		dev_dbg(xudc->dev, "EP %u already %s\n", ep->index,
> +			halt ? "halted" : "not halted");
> +		return 0;
> +	}
> +
> +	if (halt) {
> +		ep_halt(xudc, ep->index);
> +	} else {
> +		ep_ctx_write_state(ep->context, EP_STATE_DISABLED);
> +
> +		ep_reload(xudc, ep->index);
> +
> +		ep_ctx_write_state(ep->context, EP_STATE_RUNNING);
> +		ep_ctx_write_seq_num(ep->context, 0);
> +
> +		ep_reload(xudc, ep->index);
> +		ep_unpause(xudc, ep->index);
> +		ep_unhalt(xudc, ep->index);
> +
> +		tegra_xudc_ep_ring_doorbell(ep);
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_xudc_ep_set_halt(struct usb_ep *usb_ep, int value)
> +{
> +	struct tegra_xudc_ep *ep;
> +	struct tegra_xudc *xudc;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!usb_ep)
> +		return -EINVAL;
> +
> +	ep =3D to_xudc_ep(usb_ep);
> +	xudc =3D ep->xudc;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	if (xudc->powergated) {
> +		ret =3D -ESHUTDOWN;
> +		goto unlock;
> +	}
> +
> +	if (value && usb_endpoint_dir_in(ep->desc) &&
> +	    !list_empty(&ep->queue)) {
> +		dev_err(xudc->dev, "can't halt EP with requests pending\n");
> +		ret =3D -EAGAIN;
> +		goto unlock;
> +	}
> +
> +	ret =3D __tegra_xudc_ep_set_halt(ep, value);
> +unlock:
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void tegra_xudc_ep_context_setup(struct tegra_xudc_ep *ep)
> +{
> +	const struct usb_endpoint_descriptor *desc =3D ep->desc;
> +	const struct usb_ss_ep_comp_descriptor *comp_desc =3D ep->comp_desc;
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +	u16 maxpacket, maxburst =3D 0, esit =3D 0;
> +	u32 val;
> +
> +	maxpacket =3D usb_endpoint_maxp(desc) & 0x7ff;
> +	if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER) {
> +		if (!usb_endpoint_xfer_control(desc))
> +			maxburst =3D comp_desc->bMaxBurst;
> +
> +		if (usb_endpoint_xfer_int(desc) || usb_endpoint_xfer_isoc(desc))
> +			esit =3D le16_to_cpu(comp_desc->wBytesPerInterval);
> +	} else if ((xudc->gadget.speed < USB_SPEED_SUPER) &&
> +		   (usb_endpoint_xfer_int(desc) ||
> +		    usb_endpoint_xfer_isoc(desc))) {
> +		if (xudc->gadget.speed =3D=3D USB_SPEED_HIGH) {
> +			maxburst =3D (usb_endpoint_maxp(desc) >> 11) & 0x3;
> +			if (maxburst =3D=3D 0x3) {
> +				dev_warn(xudc->dev,
> +					 "invalid endpoint maxburst\n");
> +				maxburst =3D 0x2;
> +			}
> +		}
> +		esit =3D maxpacket * (maxburst + 1);
> +	}
> +
> +	memset(ep->context, 0, sizeof(*ep->context));
> +
> +	ep_ctx_write_state(ep->context, EP_STATE_RUNNING);
> +	ep_ctx_write_interval(ep->context, desc->bInterval);
> +	if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER) {
> +		if (usb_endpoint_xfer_isoc(desc)) {
> +			ep_ctx_write_mult(ep->context,
> +					  comp_desc->bmAttributes & 0x3);
> +		}
> +
> +		if (usb_endpoint_xfer_bulk(desc)) {
> +			ep_ctx_write_max_pstreams(ep->context,
> +						  comp_desc->bmAttributes &
> +						  0x1f);
> +			ep_ctx_write_lsa(ep->context, 1);
> +		}
> +	}
> +
> +	if (!usb_endpoint_xfer_control(desc) && usb_endpoint_dir_out(desc))
> +		val =3D usb_endpoint_type(desc);
> +	else
> +		val =3D usb_endpoint_type(desc) + EP_TYPE_CONTROL;
> +
> +	ep_ctx_write_type(ep->context, val);
> +	ep_ctx_write_cerr(ep->context, 0x3);
> +	ep_ctx_write_max_packet_size(ep->context, maxpacket);
> +	ep_ctx_write_max_burst_size(ep->context, maxburst);
> +
> +	ep_ctx_write_deq_ptr(ep->context, ep->transfer_ring_phys);
> +	ep_ctx_write_dcs(ep->context, ep->pcs);
> +
> +	/* Select a reasonable average TRB length based on endpoint type. */
> +	switch (usb_endpoint_type(desc)) {
> +	case USB_ENDPOINT_XFER_CONTROL:
> +		val =3D 8;
> +		break;
> +	case USB_ENDPOINT_XFER_INT:
> +		val =3D 1024;
> +		break;
> +	case USB_ENDPOINT_XFER_BULK:
> +	case USB_ENDPOINT_XFER_ISOC:
> +	default:
> +		val =3D 3072;
> +		break;
> +	}
> +
> +	ep_ctx_write_avg_trb_len(ep->context, val);
> +	ep_ctx_write_max_esit_payload(ep->context, esit);
> +
> +	ep_ctx_write_cerrcnt(ep->context, 0x3);
> +}
> +
> +static void setup_link_trb(struct tegra_xudc_ep *ep,
> +			   struct tegra_xudc_trb *trb)
> +{
> +	trb_write_data_ptr(trb, ep->transfer_ring_phys);
> +	trb_write_type(trb, TRB_TYPE_LINK);
> +	trb_write_toggle_cycle(trb, 1);
> +}
> +
> +static int __tegra_xudc_ep_disable(struct tegra_xudc_ep *ep)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +
> +	if (ep_ctx_read_state(ep->context) =3D=3D EP_STATE_DISABLED) {
> +		dev_err(xudc->dev, "endpoint %u already disabled\n",
> +			ep->index);
> +		return -EINVAL;
> +	}
> +
> +	ep_ctx_write_state(ep->context, EP_STATE_DISABLED);
> +
> +	ep_reload(xudc, ep->index);
> +
> +	tegra_xudc_ep_nuke(ep, -ESHUTDOWN);
> +
> +	xudc->nr_enabled_eps--;
> +	if (usb_endpoint_xfer_isoc(ep->desc))
> +		xudc->nr_isoch_eps--;
> +
> +	ep->desc =3D NULL;
> +	ep->comp_desc =3D NULL;
> +
> +	memset(ep->context, 0, sizeof(*ep->context));
> +
> +	ep_unpause(xudc, ep->index);
> +	ep_unhalt(xudc, ep->index);
> +	if (xudc_readl(xudc, EP_STOPPED) & BIT(ep->index))
> +		xudc_writel(xudc, BIT(ep->index), EP_STOPPED);
> +
> +	/*
> +	 * If this is the last endpoint disabled in a de-configure request,
> +	 * switch back to address state.
> +	 */
> +	if ((xudc->device_state =3D=3D USB_STATE_CONFIGURED) &&
> +	    (xudc->nr_enabled_eps =3D=3D 1)) {
> +		u32 val;
> +
> +		xudc->device_state =3D USB_STATE_ADDRESS;
> +		usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +
> +		val =3D xudc_readl(xudc, CTRL);
> +		val &=3D ~CTRL_RUN;
> +		xudc_writel(xudc, val, CTRL);
> +	}
> +
> +	dev_info(xudc->dev, "ep %u disabled\n", ep->index);
> +
> +	return 0;
> +}
> +
> +static int tegra_xudc_ep_disable(struct usb_ep *usb_ep)
> +{
> +	struct tegra_xudc_ep *ep;
> +	struct tegra_xudc *xudc;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!usb_ep)
> +		return -EINVAL;
> +
> +	ep =3D to_xudc_ep(usb_ep);
> +	xudc =3D ep->xudc;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	if (xudc->powergated) {
> +		ret =3D -ESHUTDOWN;
> +		goto unlock;
> +	}
> +
> +	ret =3D __tegra_xudc_ep_disable(ep);
> +unlock:
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int __tegra_xudc_ep_enable(struct tegra_xudc_ep *ep,
> +				  const struct usb_endpoint_descriptor *desc)
> +{
> +	struct tegra_xudc *xudc =3D ep->xudc;
> +	unsigned int i;
> +	u32 val;
> +
> +	if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER &&
> +		!usb_endpoint_xfer_control(desc) && !ep->usb_ep.comp_desc)
> +		return -EINVAL;
> +
> +	/* Disable the EP if it is not disabled */
> +	if (ep_ctx_read_state(ep->context) !=3D EP_STATE_DISABLED)
> +		__tegra_xudc_ep_disable(ep);
> +
> +	ep->desc =3D desc;
> +	ep->comp_desc =3D ep->usb_ep.comp_desc;
> +
> +	if (usb_endpoint_xfer_isoc(desc)) {
> +		if (xudc->nr_isoch_eps > XUDC_MAX_ISOCH_EPS) {
> +			dev_err(xudc->dev, "too many isoch endpoints\n");
> +			return -EBUSY;
> +		}
> +		xudc->nr_isoch_eps++;
> +	}
> +
> +	memset(ep->transfer_ring, 0, XUDC_TRANSFER_RING_SIZE *
> +	       sizeof(*ep->transfer_ring));
> +	setup_link_trb(ep, &ep->transfer_ring[XUDC_TRANSFER_RING_SIZE - 1]);
> +
> +	ep->enq_ptr =3D 0;
> +	ep->deq_ptr =3D 0;
> +	ep->pcs =3D true;
> +	ep->ring_full =3D false;
> +	xudc->nr_enabled_eps++;
> +
> +	tegra_xudc_ep_context_setup(ep);
> +
> +	/*
> +	 * No need to reload and un-halt EP0.  This will be done automatically
> +	 * once a valid SETUP packet is received.
> +	 */
> +	if (usb_endpoint_xfer_control(desc))
> +		goto out;
> +
> +	/*
> +	 * Transition to configured state once the first non-control
> +	 * endpoint is enabled.
> +	 */
> +	if (xudc->device_state =3D=3D USB_STATE_ADDRESS) {
> +		val =3D xudc_readl(xudc, CTRL);
> +		val |=3D CTRL_RUN;
> +		xudc_writel(xudc, val, CTRL);
> +
> +		xudc->device_state =3D USB_STATE_CONFIGURED;
> +		usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +	}
> +
> +	if (usb_endpoint_xfer_isoc(desc)) {
> +		/*
> +		 * Pause all bulk endpoints when enabling an isoch endpoint
> +		 * to ensure the isoch endpoint is allocated enough bandwidth.
> +		 */
> +		for (i =3D 0; i < ARRAY_SIZE(xudc->ep); i++) {
> +			if (xudc->ep[i].desc &&
> +			    usb_endpoint_xfer_bulk(xudc->ep[i].desc))
> +				ep_pause(xudc, i);
> +		}
> +	}
> +
> +	ep_reload(xudc, ep->index);
> +	ep_unpause(xudc, ep->index);
> +	ep_unhalt(xudc, ep->index);
> +
> +	if (usb_endpoint_xfer_isoc(desc)) {
> +		for (i =3D 0; i < ARRAY_SIZE(xudc->ep); i++) {
> +			if (xudc->ep[i].desc &&
> +			    usb_endpoint_xfer_bulk(xudc->ep[i].desc))
> +				ep_unpause(xudc, i);
> +		}
> +	}
> +
> +out:
> +	dev_info(xudc->dev, "EP %u (type: %s, dir: %s) enabled\n", ep->index,
> +		 usb_ep_type_string(usb_endpoint_type(ep->desc)),
> +		 usb_endpoint_dir_in(ep->desc) ? "in" : "out");
> +
> +	return 0;
> +}
> +
> +static int tegra_xudc_ep_enable(struct usb_ep *usb_ep,
> +				const struct usb_endpoint_descriptor *desc)
> +{
> +	struct tegra_xudc_ep *ep;
> +	struct tegra_xudc *xudc;
> +	unsigned long flags;
> +	int ret;
> +
> +	if  (!usb_ep || !desc || (desc->bDescriptorType !=3D USB_DT_ENDPOINT))
> +		return -EINVAL;
> +
> +	ep =3D to_xudc_ep(usb_ep);
> +	xudc =3D ep->xudc;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	if (xudc->powergated) {
> +		ret =3D -ESHUTDOWN;
> +		goto unlock;
> +	}
> +
> +	ret =3D __tegra_xudc_ep_enable(ep, desc);
> +unlock:
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static struct usb_request *
> +tegra_xudc_ep_alloc_request(struct usb_ep *usb_ep, gfp_t gfp)
> +{
> +	struct tegra_xudc_request *req;
> +
> +	req =3D kzalloc(sizeof(*req), gfp);
> +	if (!req)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&req->list);
> +
> +	return &req->usb_req;
> +}
> +
> +static void tegra_xudc_ep_free_request(struct usb_ep *usb_ep,
> +				       struct usb_request *usb_req)
> +{
> +	struct tegra_xudc_request *req =3D to_xudc_req(usb_req);
> +
> +	kfree(req);
> +}
> +
> +static struct usb_ep_ops tegra_xudc_ep_ops =3D {
> +	.enable =3D tegra_xudc_ep_enable,
> +	.disable =3D tegra_xudc_ep_disable,
> +	.alloc_request =3D tegra_xudc_ep_alloc_request,
> +	.free_request =3D tegra_xudc_ep_free_request,
> +	.queue =3D tegra_xudc_ep_queue,
> +	.dequeue =3D tegra_xudc_ep_dequeue,
> +	.set_halt =3D tegra_xudc_ep_set_halt,
> +};
> +
> +static int tegra_xudc_ep0_enable(struct usb_ep *usb_ep,
> +				 const struct usb_endpoint_descriptor *desc)
> +{
> +	return -EBUSY;
> +}
> +
> +static int tegra_xudc_ep0_disable(struct usb_ep *usb_ep)
> +{
> +	return -EBUSY;
> +}
> +
> +static struct usb_ep_ops tegra_xudc_ep0_ops =3D {
> +	.enable =3D tegra_xudc_ep0_enable,
> +	.disable =3D tegra_xudc_ep0_disable,
> +	.alloc_request =3D tegra_xudc_ep_alloc_request,
> +	.free_request =3D tegra_xudc_ep_free_request,
> +	.queue =3D tegra_xudc_ep_queue,
> +	.dequeue =3D tegra_xudc_ep_dequeue,
> +	.set_halt =3D tegra_xudc_ep_set_halt,
> +};
> +
> +static int tegra_xudc_gadget_get_frame(struct usb_gadget *gadget)
> +{
> +	struct tegra_xudc *xudc =3D to_xudc(gadget);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	if (xudc->powergated) {
> +		ret =3D -ESHUTDOWN;
> +		goto unlock;
> +	}
> +
> +	ret =3D (xudc_readl(xudc, MFINDEX) & MFINDEX_FRAME_MASK) >>
> +		MFINDEX_FRAME_SHIFT;
> +unlock:
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void tegra_xudc_resume_device_state(struct tegra_xudc *xudc)
> +{
> +	unsigned int i;
> +	u32 val;
> +
> +	ep_unpause_all(xudc);
> +
> +	/* Direct link to U0. */
> +	val =3D xudc_readl(xudc, PORTSC);
> +	if (((val & PORTSC_PLS_MASK) >> PORTSC_PLS_SHIFT) !=3D PORTSC_PLS_U0) {
> +		val &=3D ~(PORTSC_CHANGE_MASK | PORTSC_PLS_MASK);
> +		val |=3D PORTSC_LWS | PORTSC_PLS(PORTSC_PLS_U0);
> +		xudc_writel(xudc, val, PORTSC);
> +	}
> +
> +	if (xudc->device_state =3D=3D USB_STATE_SUSPENDED) {
> +		xudc->device_state =3D xudc->resume_state;
> +		usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +		xudc->resume_state =3D 0;
> +	}
> +
> +	/*
> +	 * Doorbells may be dropped if they are sent too soon (< ~200ns)
> +	 * after unpausing the endpoint.  Wait for 500ns just to be safe.
> +	 */
> +	ndelay(500);
> +	for (i =3D 0; i < ARRAY_SIZE(xudc->ep); i++)
> +		tegra_xudc_ep_ring_doorbell(&xudc->ep[i]);
> +}
> +
> +static int tegra_xudc_gadget_wakeup(struct usb_gadget *gadget)
> +{
> +	struct tegra_xudc *xudc =3D to_xudc(gadget);
> +	unsigned long flags;
> +	int ret =3D 0;
> +	u32 val;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	if (xudc->powergated) {
> +		ret =3D -ESHUTDOWN;
> +		goto unlock;
> +	}
> +	val =3D xudc_readl(xudc, PORTPM);
> +	dev_dbg(xudc->dev, "%s: PORTPM=3D%#x, speed=3D%x\n", __func__,
> +			val, gadget->speed);
> +
> +	if (((xudc->gadget.speed <=3D USB_SPEED_HIGH) &&
> +	     (val & PORTPM_RWE)) ||
> +	    ((xudc->gadget.speed =3D=3D USB_SPEED_SUPER) &&
> +	     (val & PORTPM_FRWE))) {
> +		tegra_xudc_resume_device_state(xudc);
> +
> +		/* Send Device Notification packet. */
> +		if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER) {
> +			val =3D DEVNOTIF_LO_TYPE(DEVNOTIF_LO_TYPE_FUNCTION_WAKE)
> +					     | DEVNOTIF_LO_TRIG;
> +			xudc_writel(xudc, 0, DEVNOTIF_HI);
> +			xudc_writel(xudc, val, DEVNOTIF_LO);
> +		}
> +	}
> +
> +unlock:
> +	dev_dbg(xudc->dev, "%s: ret value is %d", __func__, ret);
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int tegra_xudc_gadget_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +	struct tegra_xudc *xudc =3D to_xudc(gadget);
> +	unsigned long flags;
> +	u32 val;
> +
> +	pm_runtime_get_sync(xudc->dev);
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	if (is_on !=3D xudc->pullup) {
> +		val =3D xudc_readl(xudc, CTRL);
> +		if (is_on)
> +			val |=3D CTRL_ENABLE;
> +		else
> +			val &=3D ~CTRL_ENABLE;
> +		xudc_writel(xudc, val, CTRL);
> +	}
> +
> +	xudc->pullup =3D is_on;
> +	dev_dbg(xudc->dev, "%s: pullup:%d", __func__, is_on);
> +
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	pm_runtime_put(xudc->dev);
> +
> +	return 0;
> +}
> +
> +static int tegra_xudc_gadget_start(struct usb_gadget *gadget,
> +				   struct usb_gadget_driver *driver)
> +{
> +	struct tegra_xudc *xudc =3D to_xudc(gadget);
> +	unsigned long flags;
> +	u32 val;
> +	int ret;
> +
> +	if (!driver)
> +		return -EINVAL;
> +
> +	pm_runtime_get_sync(xudc->dev);
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	if (xudc->driver) {
> +		ret =3D -EBUSY;
> +		goto unlock;
> +	}
> +
> +	xudc->setup_state =3D WAIT_FOR_SETUP;
> +	xudc->device_state =3D USB_STATE_DEFAULT;
> +	usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +
> +	ret =3D __tegra_xudc_ep_enable(&xudc->ep[0], &tegra_xudc_ep0_desc);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	val =3D xudc_readl(xudc, CTRL);
> +	val |=3D CTRL_IE | CTRL_LSE;
> +	xudc_writel(xudc, val, CTRL);
> +
> +	val =3D xudc_readl(xudc, PORTHALT);
> +	val |=3D PORTHALT_STCHG_INTR_EN;
> +	xudc_writel(xudc, val, PORTHALT);
> +
> +	if (xudc->pullup) {
> +		val =3D xudc_readl(xudc, CTRL);
> +		val |=3D CTRL_ENABLE;
> +		xudc_writel(xudc, val, CTRL);
> +	}
> +
> +	xudc->driver =3D driver;
> +unlock:
> +	dev_dbg(xudc->dev, "%s: ret value is %d", __func__, ret);
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	pm_runtime_put(xudc->dev);
> +
> +	return ret;
> +}
> +
> +static int tegra_xudc_gadget_stop(struct usb_gadget *gadget)
> +{
> +	struct tegra_xudc *xudc =3D to_xudc(gadget);
> +	unsigned long flags;
> +	u32 val;
> +
> +	pm_runtime_get_sync(xudc->dev);
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	val =3D xudc_readl(xudc, CTRL);
> +	val &=3D ~(CTRL_IE | CTRL_ENABLE);
> +	xudc_writel(xudc, val, CTRL);
> +
> +	__tegra_xudc_ep_disable(&xudc->ep[0]);
> +
> +	xudc->driver =3D NULL;
> +	dev_dbg(xudc->dev, "Gadget stopped");
> +
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	pm_runtime_put(xudc->dev);
> +
> +	return 0;
> +}
> +
> +static int tegra_xudc_set_selfpowered(struct usb_gadget *gadget, int is_=
on)
> +{
> +	struct tegra_xudc *xudc =3D to_xudc(gadget);
> +
> +	dev_dbg(xudc->dev, "%s: %d\n", __func__, is_on);
> +	xudc->selfpowered =3D !!is_on;
> +
> +	return 0;
> +}
> +
> +static struct usb_gadget_ops tegra_xudc_gadget_ops =3D {
> +	.get_frame =3D tegra_xudc_gadget_get_frame,
> +	.wakeup =3D tegra_xudc_gadget_wakeup,
> +	.pullup =3D tegra_xudc_gadget_pullup,
> +	.udc_start =3D tegra_xudc_gadget_start,
> +	.udc_stop =3D tegra_xudc_gadget_stop,
> +	.set_selfpowered =3D tegra_xudc_set_selfpowered,
> +};
> +
> +static void no_op_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +}
> +
> +static int
> +tegra_xudc_ep0_queue_status(struct tegra_xudc *xudc,
> +		void (*cmpl)(struct usb_ep *, struct usb_request *))
> +{
> +	xudc->ep0_req->usb_req.buf =3D NULL;
> +	xudc->ep0_req->usb_req.dma =3D 0;
> +	xudc->ep0_req->usb_req.length =3D 0;
> +	xudc->ep0_req->usb_req.complete =3D cmpl;
> +	xudc->ep0_req->usb_req.context =3D xudc;
> +
> +	return __tegra_xudc_ep_queue(&xudc->ep[0], xudc->ep0_req);
> +}
> +
> +static int
> +tegra_xudc_ep0_queue_data(struct tegra_xudc *xudc, void *buf, size_t len,
> +		void (*cmpl)(struct usb_ep *, struct usb_request *))
> +{
> +	xudc->ep0_req->usb_req.buf =3D buf;
> +	xudc->ep0_req->usb_req.length =3D len;
> +	xudc->ep0_req->usb_req.complete =3D cmpl;
> +	xudc->ep0_req->usb_req.context =3D xudc;
> +
> +	return __tegra_xudc_ep_queue(&xudc->ep[0], xudc->ep0_req);
> +}
> +
> +static void tegra_xudc_ep0_req_done(struct tegra_xudc *xudc)
> +{
> +	switch (xudc->setup_state) {
> +	case DATA_STAGE_XFER:
> +		xudc->setup_state =3D STATUS_STAGE_RECV;
> +		tegra_xudc_ep0_queue_status(xudc, no_op_complete);
> +		break;
> +	case DATA_STAGE_RECV:
> +		xudc->setup_state =3D STATUS_STAGE_XFER;
> +		tegra_xudc_ep0_queue_status(xudc, no_op_complete);
> +		break;
> +	default:
> +		xudc->setup_state =3D WAIT_FOR_SETUP;
> +		break;
> +	}
> +}
> +
> +static int tegra_xudc_ep0_delegate_req(struct tegra_xudc *xudc,
> +				       struct usb_ctrlrequest *ctrl)
> +{
> +	int ret;
> +
> +	spin_unlock(&xudc->lock);
> +	ret =3D xudc->driver->setup(&xudc->gadget, ctrl);
> +	spin_lock(&xudc->lock);
> +
> +	return ret;
> +}
> +
> +static void set_feature_complete(struct usb_ep *ep, struct usb_request *=
req)
> +{
> +	struct tegra_xudc *xudc =3D req->context;
> +
> +	if (xudc->test_mode_pattern) {
> +		xudc_writel(xudc, xudc->test_mode_pattern, PORT_TM);
> +		xudc->test_mode_pattern =3D 0;
> +	}
> +}
> +
> +static int tegra_xudc_ep0_set_feature(struct tegra_xudc *xudc,
> +				      struct usb_ctrlrequest *ctrl)
> +{
> +	bool set =3D (ctrl->bRequest =3D=3D USB_REQ_SET_FEATURE);
> +	u32 feature =3D le16_to_cpu(ctrl->wValue);
> +	u32 index =3D le16_to_cpu(ctrl->wIndex);
> +	u32 val, ep;
> +	int ret;
> +
> +	if (le16_to_cpu(ctrl->wLength) !=3D 0)
> +		return -EINVAL;
> +
> +	switch (ctrl->bRequestType & USB_RECIP_MASK) {
> +	case USB_RECIP_DEVICE:
> +		switch (feature) {
> +		case USB_DEVICE_REMOTE_WAKEUP:
> +			if ((xudc->gadget.speed =3D=3D USB_SPEED_SUPER) ||
> +			    (xudc->device_state =3D=3D USB_STATE_DEFAULT))
> +				return -EINVAL;
> +
> +			val =3D xudc_readl(xudc, PORTPM);
> +			if (set)
> +				val |=3D PORTPM_RWE;
> +			else
> +				val &=3D ~PORTPM_RWE;
> +
> +			xudc_writel(xudc, val, PORTPM);
> +			break;
> +		case USB_DEVICE_U1_ENABLE:
> +		case USB_DEVICE_U2_ENABLE:
> +			if ((xudc->device_state !=3D USB_STATE_CONFIGURED) ||
> +			    (xudc->gadget.speed !=3D USB_SPEED_SUPER))
> +				return -EINVAL;
> +
> +			val =3D xudc_readl(xudc, PORTPM);
> +			if ((feature =3D=3D USB_DEVICE_U1_ENABLE) &&
> +			     xudc->soc->u1_enable) {
> +				if (set)
> +					val |=3D PORTPM_U1E;
> +				else
> +					val &=3D ~PORTPM_U1E;
> +			}
> +
> +			if ((feature =3D=3D USB_DEVICE_U2_ENABLE) &&
> +			     xudc->soc->u2_enable) {
> +				if (set)
> +					val |=3D PORTPM_U2E;
> +				else
> +					val &=3D ~PORTPM_U2E;
> +			}
> +
> +			xudc_writel(xudc, val, PORTPM);
> +			break;
> +		case USB_DEVICE_TEST_MODE:
> +			if (xudc->gadget.speed !=3D USB_SPEED_HIGH)
> +				return -EINVAL;
> +
> +			if (!set)
> +				return -EINVAL;
> +
> +			xudc->test_mode_pattern =3D index >> 8;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		if (xudc->device_state !=3D USB_STATE_CONFIGURED)
> +			return -EINVAL;
> +
> +		switch (feature) {
> +		case USB_INTRF_FUNC_SUSPEND:
> +			if (set) {
> +				val =3D xudc_readl(xudc, PORTPM);
> +
> +				if (index & USB_INTRF_FUNC_SUSPEND_RW)
> +					val |=3D PORTPM_FRWE;
> +				else
> +					val &=3D ~PORTPM_FRWE;
> +
> +				xudc_writel(xudc, val, PORTPM);
> +			}
> +
> +			return tegra_xudc_ep0_delegate_req(xudc, ctrl);
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		break;
> +	case USB_RECIP_ENDPOINT:
> +		ep =3D (index & USB_ENDPOINT_NUMBER_MASK) * 2 +
> +			((index & USB_DIR_IN) ? 1 : 0);
> +
> +		if ((xudc->device_state =3D=3D USB_STATE_DEFAULT) ||
> +		    ((xudc->device_state =3D=3D USB_STATE_ADDRESS) &&
> +		     (index !=3D 0)))
> +			return -EINVAL;
> +
> +		ret =3D __tegra_xudc_ep_set_halt(&xudc->ep[ep], set);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return tegra_xudc_ep0_queue_status(xudc, set_feature_complete);
> +}
> +
> +static int tegra_xudc_ep0_get_status(struct tegra_xudc *xudc,
> +				     struct usb_ctrlrequest *ctrl)
> +{
> +	struct tegra_xudc_ep_context *ep_ctx;
> +	u32 val, ep, index =3D le16_to_cpu(ctrl->wIndex);
> +	u16 status =3D 0;
> +
> +	if (!(ctrl->bRequestType & USB_DIR_IN))
> +		return -EINVAL;
> +
> +	if ((le16_to_cpu(ctrl->wValue) !=3D 0) ||
> +	    (le16_to_cpu(ctrl->wLength) !=3D 2))
> +		return -EINVAL;
> +
> +	switch (ctrl->bRequestType & USB_RECIP_MASK) {
> +	case USB_RECIP_DEVICE:
> +		val =3D xudc_readl(xudc, PORTPM);
> +
> +		if (xudc->selfpowered)
> +			status |=3D BIT(USB_DEVICE_SELF_POWERED);
> +
> +		if ((xudc->gadget.speed < USB_SPEED_SUPER) &&
> +		    (val & PORTPM_RWE))
> +			status |=3D BIT(USB_DEVICE_REMOTE_WAKEUP);
> +
> +		if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER) {
> +			if (val & PORTPM_U1E)
> +				status |=3D BIT(USB_DEV_STAT_U1_ENABLED);
> +			if (val & PORTPM_U2E)
> +				status |=3D BIT(USB_DEV_STAT_U2_ENABLED);
> +		}
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER) {
> +			status |=3D USB_INTRF_STAT_FUNC_RW_CAP;
> +			val =3D xudc_readl(xudc, PORTPM);
> +			if (val & PORTPM_FRWE)
> +				status |=3D USB_INTRF_STAT_FUNC_RW;
> +		}
> +		break;
> +	case USB_RECIP_ENDPOINT:
> +		ep =3D (index & USB_ENDPOINT_NUMBER_MASK) * 2 +
> +			((index & USB_DIR_IN) ? 1 : 0);
> +		ep_ctx =3D &xudc->ep_context[ep];
> +
> +		if ((xudc->device_state !=3D USB_STATE_CONFIGURED) &&
> +		    ((xudc->device_state !=3D USB_STATE_ADDRESS) || (ep !=3D 0)))
> +			return -EINVAL;
> +
> +		if (ep_ctx_read_state(ep_ctx) =3D=3D EP_STATE_DISABLED)
> +			return -EINVAL;
> +
> +		if (xudc_readl(xudc, EP_HALT) & BIT(ep))
> +			status |=3D BIT(USB_ENDPOINT_HALT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	xudc->status_buf =3D cpu_to_le16(status);
> +	return tegra_xudc_ep0_queue_data(xudc, &xudc->status_buf,
> +					 sizeof(xudc->status_buf),
> +					 no_op_complete);
> +}
> +
> +static void set_sel_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	/* Nothing to do with SEL values */
> +}
> +
> +static int tegra_xudc_ep0_set_sel(struct tegra_xudc *xudc,
> +				  struct usb_ctrlrequest *ctrl)
> +{
> +	if (ctrl->bRequestType !=3D (USB_DIR_OUT | USB_RECIP_DEVICE |
> +				     USB_TYPE_STANDARD))
> +		return -EINVAL;
> +
> +	if (xudc->device_state =3D=3D USB_STATE_DEFAULT)
> +		return -EINVAL;
> +
> +	if ((le16_to_cpu(ctrl->wIndex) !=3D 0) ||
> +	    (le16_to_cpu(ctrl->wValue) !=3D 0) ||
> +	    (le16_to_cpu(ctrl->wLength) !=3D 6))
> +		return -EINVAL;
> +
> +	return tegra_xudc_ep0_queue_data(xudc, &xudc->sel_timing,
> +					 sizeof(xudc->sel_timing),
> +					 set_sel_complete);
> +}
> +
> +static void set_isoch_delay_complete(struct usb_ep *ep, struct usb_reque=
st *req)
> +{
> +	/* Nothing to do with isoch delay */
> +}
> +
> +static int tegra_xudc_ep0_set_isoch_delay(struct tegra_xudc *xudc,
> +					  struct usb_ctrlrequest *ctrl)
> +{
> +	u32 delay =3D le16_to_cpu(ctrl->wValue);
> +
> +	if (ctrl->bRequestType !=3D (USB_DIR_OUT | USB_RECIP_DEVICE |
> +				   USB_TYPE_STANDARD))
> +		return -EINVAL;
> +
> +	if ((delay > 65535) || (le16_to_cpu(ctrl->wIndex) !=3D 0) ||
> +	    (le16_to_cpu(ctrl->wLength) !=3D 0))
> +		return -EINVAL;
> +
> +	xudc->isoch_delay =3D delay;
> +
> +	return tegra_xudc_ep0_queue_status(xudc, set_isoch_delay_complete);
> +}
> +
> +static void set_address_complete(struct usb_ep *ep, struct usb_request *=
req)
> +{
> +	struct tegra_xudc *xudc =3D req->context;
> +
> +	if ((xudc->device_state =3D=3D USB_STATE_DEFAULT) &&
> +	    (xudc->dev_addr !=3D 0)) {
> +		xudc->device_state =3D USB_STATE_ADDRESS;
> +		usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +	} else if ((xudc->device_state =3D=3D USB_STATE_ADDRESS) &&
> +		   (xudc->dev_addr =3D=3D 0)) {
> +		xudc->device_state =3D USB_STATE_DEFAULT;
> +		usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +	}
> +}
> +
> +static int tegra_xudc_ep0_set_address(struct tegra_xudc *xudc,
> +				      struct usb_ctrlrequest *ctrl)
> +{
> +	struct tegra_xudc_ep *ep0 =3D &xudc->ep[0];
> +	u32 val, addr =3D le16_to_cpu(ctrl->wValue);
> +
> +	if (ctrl->bRequestType !=3D (USB_DIR_OUT | USB_RECIP_DEVICE |
> +				     USB_TYPE_STANDARD))
> +		return -EINVAL;
> +
> +	if ((addr > 127) || (le16_to_cpu(ctrl->wIndex) !=3D 0) ||
> +	    (le16_to_cpu(ctrl->wLength) !=3D 0))
> +		return -EINVAL;
> +
> +	if (xudc->device_state =3D=3D USB_STATE_CONFIGURED)
> +		return -EINVAL;
> +
> +	dev_dbg(xudc->dev, "set address: %u\n", addr);
> +
> +	xudc->dev_addr =3D addr;
> +	val =3D xudc_readl(xudc, CTRL);
> +	val &=3D ~(CTRL_DEVADDR_MASK);
> +	val |=3D CTRL_DEVADDR(addr);
> +	xudc_writel(xudc, val, CTRL);
> +
> +	ep_ctx_write_devaddr(ep0->context, addr);
> +
> +	return tegra_xudc_ep0_queue_status(xudc, set_address_complete);
> +}
> +
> +static int tegra_xudc_ep0_standard_req(struct tegra_xudc *xudc,
> +				      struct usb_ctrlrequest *ctrl)
> +{
> +	int ret;
> +
> +	switch (ctrl->bRequest) {
> +	case USB_REQ_GET_STATUS:
> +		dev_dbg(xudc->dev, "USB_REQ_GET_STATUS\n");
> +		ret =3D tegra_xudc_ep0_get_status(xudc, ctrl);
> +		break;
> +	case USB_REQ_SET_ADDRESS:
> +		dev_dbg(xudc->dev, "USB_REQ_SET_ADDRESS\n");
> +		ret =3D tegra_xudc_ep0_set_address(xudc, ctrl);
> +		break;
> +	case USB_REQ_SET_SEL:
> +		dev_dbg(xudc->dev, "USB_REQ_SET_SEL\n");
> +		ret =3D tegra_xudc_ep0_set_sel(xudc, ctrl);
> +		break;
> +	case USB_REQ_SET_ISOCH_DELAY:
> +		dev_dbg(xudc->dev, "USB_REQ_SET_ISOCH_DELAY\n");
> +		ret =3D tegra_xudc_ep0_set_isoch_delay(xudc, ctrl);
> +		break;
> +	case USB_REQ_CLEAR_FEATURE:
> +	case USB_REQ_SET_FEATURE:
> +		dev_dbg(xudc->dev, "USB_REQ_CLEAR/SET_FEATURE\n");
> +		ret =3D tegra_xudc_ep0_set_feature(xudc, ctrl);
> +		break;
> +	case USB_REQ_SET_CONFIGURATION:
> +		dev_dbg(xudc->dev, "USB_REQ_SET_CONFIGURATION\n");
> +		/*
> +		 * In theory we need to clear RUN bit before status stage of
> +		 * deconfig request sent, but this seems to be causing problems.
> +		 * Clear RUN once all endpoints are disabled instead.
> +		 */
> +		__attribute__ ((fallthrough));
> +	default:
> +		ret =3D tegra_xudc_ep0_delegate_req(xudc, ctrl);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void tegra_xudc_handle_ep0_setup_packet(struct tegra_xudc *xudc,
> +					       struct usb_ctrlrequest *ctrl,
> +					       u16 seq_num)
> +{
> +	int ret;
> +
> +	xudc->setup_seq_num =3D seq_num;
> +
> +	/* Ensure EP0 is unhalted. */
> +	ep_unhalt(xudc, 0);
> +
> +	/*
> +	 * On Tegra210, setup packets with sequence numbers 0xfffe or 0xffff
> +	 * are invalid.  Halt EP0 until we get a valid packet.
> +	 */
> +	if (xudc->soc->invalid_seq_num &&
> +	    (seq_num =3D=3D 0xfffe || seq_num =3D=3D 0xffff)) {
> +		dev_warn(xudc->dev, "invalid sequence number detected\n");
> +		ep_halt(xudc, 0);
> +		return;
> +	}
> +
> +	if (ctrl->wLength)
> +		xudc->setup_state =3D (ctrl->bRequestType & USB_DIR_IN) ?
> +			DATA_STAGE_XFER :  DATA_STAGE_RECV;
> +	else
> +		xudc->setup_state =3D STATUS_STAGE_XFER;
> +
> +	if ((ctrl->bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDARD)
> +		ret =3D tegra_xudc_ep0_standard_req(xudc, ctrl);
> +	else
> +		ret =3D tegra_xudc_ep0_delegate_req(xudc, ctrl);
> +
> +	if (ret < 0) {
> +		dev_warn(xudc->dev, "setup request failed: %d\n", ret);
> +		xudc->setup_state =3D WAIT_FOR_SETUP;
> +		ep_halt(xudc, 0);
> +	}
> +}
> +
> +static void tegra_xudc_handle_ep0_event(struct tegra_xudc *xudc,
> +					struct tegra_xudc_trb *event)
> +{
> +	struct usb_ctrlrequest *ctrl =3D (struct usb_ctrlrequest *)event;
> +	u16 seq_num =3D trb_read_seq_num(event);
> +
> +	if (xudc->setup_state !=3D WAIT_FOR_SETUP) {
> +		/*
> +		 * The controller is in the process of handling another
> +		 * setup request.  Queue subsequent requests and handle
> +		 * the last one once the controller reports a sequence
> +		 * number error.
> +		 */
> +		memcpy(&xudc->setup_packet.ctrl_req, ctrl, sizeof(*ctrl));
> +		xudc->setup_packet.seq_num =3D seq_num;
> +		xudc->queued_setup_packet =3D true;
> +	} else {
> +		tegra_xudc_handle_ep0_setup_packet(xudc, ctrl, seq_num);
> +	}
> +}
> +
> +static struct tegra_xudc_request *
> +trb_to_request(struct tegra_xudc_ep *ep, struct tegra_xudc_trb *trb)
> +{
> +	struct tegra_xudc_request *req;
> +
> +	list_for_each_entry(req, &ep->queue, list) {
> +		if (!req->trbs_queued)
> +			break;
> +
> +		if (trb_in_request(ep, req, trb))
> +			return req;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void tegra_xudc_handle_transfer_completion(struct tegra_xudc *xud=
c,
> +						  struct tegra_xudc_ep *ep,
> +						  struct tegra_xudc_trb *event)
> +{
> +	struct tegra_xudc_request *req;
> +	struct tegra_xudc_trb *trb;
> +	bool short_packet;
> +
> +	short_packet =3D (trb_read_cmpl_code(event) =3D=3D
> +			TRB_CMPL_CODE_SHORT_PACKET);
> +
> +	trb =3D trb_phys_to_virt(ep, trb_read_data_ptr(event));
> +	req =3D trb_to_request(ep, trb);
> +
> +	/*
> +	 * TDs are complete on short packet or when the completed TRB is the
> +	 * last TRB in the TD (the CHAIN bit is unset).
> +	 */
> +	if (req && (short_packet || (!trb_read_chain(trb) &&
> +		(req->trbs_needed =3D=3D req->trbs_queued)))) {
> +		struct tegra_xudc_trb *last =3D req->last_trb;
> +		unsigned int residual;
> +
> +		residual =3D trb_read_transfer_len(event);
> +		req->usb_req.actual =3D req->usb_req.length - residual;
> +
> +		dev_dbg(xudc->dev, "bytes transferred %u / %u\n",
> +			req->usb_req.actual, req->usb_req.length);
> +
> +		tegra_xudc_req_done(ep, req, 0);
> +
> +		if (ep->desc && usb_endpoint_xfer_control(ep->desc))
> +			tegra_xudc_ep0_req_done(xudc);
> +
> +		/*
> +		 * Advance the dequeue pointer past the end of the current TD
> +		 * on short packet completion.
> +		 */
> +		if (short_packet) {
> +			ep->deq_ptr =3D (last - ep->transfer_ring) + 1;
> +			if (ep->deq_ptr =3D=3D XUDC_TRANSFER_RING_SIZE - 1)
> +				ep->deq_ptr =3D 0;
> +		}
> +	} else if (!req) {
> +		dev_warn(xudc->dev, "transfer event on dequeued request\n");
> +	}
> +
> +	if (ep->desc)
> +		tegra_xudc_ep_kick_queue(ep);
> +}
> +
> +static void tegra_xudc_handle_transfer_event(struct tegra_xudc *xudc,
> +					     struct tegra_xudc_trb *event)
> +{
> +	unsigned int ep_index =3D trb_read_endpoint_id(event);
> +	struct tegra_xudc_ep *ep =3D &xudc->ep[ep_index];
> +	struct tegra_xudc_trb *trb;
> +	u16 comp_code;
> +
> +	if (ep_ctx_read_state(ep->context) =3D=3D EP_STATE_DISABLED) {
> +		dev_warn(xudc->dev, "transfer event on disabled EP %u\n",
> +			 ep_index);
> +		return;
> +	}
> +
> +	/* Update transfer ring dequeue pointer. */
> +	trb =3D trb_phys_to_virt(ep, trb_read_data_ptr(event));
> +	comp_code =3D trb_read_cmpl_code(event);
> +	if (comp_code !=3D TRB_CMPL_CODE_BABBLE_DETECTED_ERR) {
> +		ep->deq_ptr =3D (trb - ep->transfer_ring) + 1;
> +
> +		if (ep->deq_ptr =3D=3D XUDC_TRANSFER_RING_SIZE - 1)
> +			ep->deq_ptr =3D 0;
> +		ep->ring_full =3D false;
> +	}
> +
> +	switch (comp_code) {
> +	case TRB_CMPL_CODE_SUCCESS:
> +	case TRB_CMPL_CODE_SHORT_PACKET:
> +		tegra_xudc_handle_transfer_completion(xudc, ep, event);
> +		break;
> +	case TRB_CMPL_CODE_HOST_REJECTED:
> +		dev_info(xudc->dev, "stream rejected on EP %u\n", ep_index);
> +
> +		ep->stream_rejected =3D true;
> +		break;
> +	case TRB_CMPL_CODE_PRIME_PIPE_RECEIVED:
> +		dev_info(xudc->dev, "prime pipe received on EP %u\n", ep_index);
> +
> +		if (ep->stream_rejected) {
> +			ep->stream_rejected =3D false;
> +			/*
> +			 * An EP is stopped when a stream is rejected.  Wait
> +			 * for the EP to report that it is stopped and then
> +			 * un-stop it.
> +			 */
> +			ep_wait_for_stopped(xudc, ep_index);
> +		}
> +		tegra_xudc_ep_ring_doorbell(ep);
> +		break;
> +	case TRB_CMPL_CODE_BABBLE_DETECTED_ERR:
> +		/*
> +		 * Wait for the EP to be stopped so the controller stops
> +		 * processing doorbells.
> +		 */
> +		ep_wait_for_stopped(xudc, ep_index);
> +		ep->enq_ptr =3D ep->deq_ptr;
> +		tegra_xudc_ep_nuke(ep, -EIO);
> +		/* FALLTHROUGH */
> +	case TRB_CMPL_CODE_STREAM_NUMP_ERROR:
> +	case TRB_CMPL_CODE_CTRL_DIR_ERR:
> +	case TRB_CMPL_CODE_INVALID_STREAM_TYPE_ERR:
> +	case TRB_CMPL_CODE_RING_UNDERRUN:
> +	case TRB_CMPL_CODE_RING_OVERRUN:
> +	case TRB_CMPL_CODE_ISOCH_BUFFER_OVERRUN:
> +	case TRB_CMPL_CODE_USB_TRANS_ERR:
> +	case TRB_CMPL_CODE_TRB_ERR:
> +		dev_err(xudc->dev, "completion error %#x on EP %u\n",
> +			comp_code, ep_index);
> +
> +		ep_halt(xudc, ep_index);
> +		break;
> +	case TRB_CMPL_CODE_CTRL_SEQNUM_ERR:
> +		dev_info(xudc->dev, "sequence number error\n");
> +
> +		/*
> +		 * Kill any queued control request and skip to the last
> +		 * setup packet we received.
> +		 */
> +		tegra_xudc_ep_nuke(ep, -EINVAL);
> +		xudc->setup_state =3D WAIT_FOR_SETUP;
> +		if (!xudc->queued_setup_packet)
> +			break;
> +
> +		tegra_xudc_handle_ep0_setup_packet(xudc,
> +						   &xudc->setup_packet.ctrl_req,
> +						   xudc->setup_packet.seq_num);
> +		xudc->queued_setup_packet =3D false;
> +		break;
> +	case TRB_CMPL_CODE_STOPPED:
> +		dev_dbg(xudc->dev, "stop completion code on EP %u\n",
> +			ep_index);
> +
> +		/* Disconnected. */
> +		tegra_xudc_ep_nuke(ep, -ECONNREFUSED);
> +		break;
> +	default:
> +		dev_dbg(xudc->dev, "completion event %#x on EP %u\n",
> +			comp_code, ep_index);
> +		break;
> +	}
> +}
> +
> +static void tegra_xudc_reset(struct tegra_xudc *xudc)
> +{
> +	struct tegra_xudc_ep *ep0 =3D &xudc->ep[0];
> +	dma_addr_t deq_ptr;
> +	unsigned int i;
> +
> +	xudc->setup_state =3D WAIT_FOR_SETUP;
> +	xudc->device_state =3D USB_STATE_DEFAULT;
> +	usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +
> +	ep_unpause_all(xudc);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(xudc->ep); i++)
> +		tegra_xudc_ep_nuke(&xudc->ep[i], -ESHUTDOWN);
> +
> +	/*
> +	 * Reset sequence number and dequeue pointer to flush the transfer
> +	 * ring.
> +	 */
> +	ep0->deq_ptr =3D ep0->enq_ptr;
> +	ep0->ring_full =3D false;
> +
> +	xudc->setup_seq_num =3D 0;
> +	xudc->queued_setup_packet =3D false;
> +
> +	ep_ctx_write_seq_num(ep0->context, xudc->setup_seq_num);
> +
> +	deq_ptr =3D trb_virt_to_phys(ep0, &ep0->transfer_ring[ep0->deq_ptr]);
> +
> +	if (!dma_mapping_error(xudc->dev, deq_ptr)) {
> +		ep_ctx_write_deq_ptr(ep0->context, deq_ptr);
> +		ep_ctx_write_dcs(ep0->context, ep0->pcs);
> +	}
> +
> +	ep_unhalt_all(xudc);
> +	ep_reload(xudc, 0);
> +	ep_unpause(xudc, 0);
> +}
> +
> +static void tegra_xudc_port_connect(struct tegra_xudc *xudc)
> +{
> +	struct tegra_xudc_ep *ep0 =3D &xudc->ep[0];
> +	u16 maxpacket;
> +	u32 val;
> +
> +	val =3D (xudc_readl(xudc, PORTSC) & PORTSC_PS_MASK) >> PORTSC_PS_SHIFT;
> +	switch (val) {
> +	case PORTSC_PS_LS:
> +		xudc->gadget.speed =3D USB_SPEED_LOW;
> +		break;
> +	case PORTSC_PS_FS:
> +		xudc->gadget.speed =3D USB_SPEED_FULL;
> +		break;
> +	case PORTSC_PS_HS:
> +		xudc->gadget.speed =3D USB_SPEED_HIGH;
> +		break;
> +	case PORTSC_PS_SS:
> +		xudc->gadget.speed =3D USB_SPEED_SUPER;
> +		break;
> +	default:
> +		xudc->gadget.speed =3D USB_SPEED_UNKNOWN;
> +		break;
> +	}
> +
> +	xudc->device_state =3D USB_STATE_DEFAULT;
> +	usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +
> +	xudc->setup_state =3D WAIT_FOR_SETUP;
> +
> +	if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER)
> +		maxpacket =3D 512;
> +	else
> +		maxpacket =3D 64;
> +
> +	ep_ctx_write_max_packet_size(ep0->context, maxpacket);
> +	tegra_xudc_ep0_desc.wMaxPacketSize =3D cpu_to_le16(maxpacket);
> +	usb_ep_set_maxpacket_limit(&ep0->usb_ep, maxpacket);
> +
> +	if (!xudc->soc->u1_enable) {
> +		val =3D xudc_readl(xudc, PORTPM);
> +		val &=3D ~(PORTPM_U1TIMEOUT_MASK);
> +		xudc_writel(xudc, val, PORTPM);
> +	}
> +
> +	if (!xudc->soc->u2_enable) {
> +		val =3D xudc_readl(xudc, PORTPM);
> +		val &=3D ~(PORTPM_U2TIMEOUT_MASK);
> +		xudc_writel(xudc, val, PORTPM);
> +	}
> +
> +	if (xudc->gadget.speed <=3D USB_SPEED_HIGH) {
> +		val =3D xudc_readl(xudc, PORTPM);
> +		val &=3D ~(PORTPM_L1S_MASK);
> +		if (xudc->soc->lpm_enable)
> +			val |=3D PORTPM_L1S(PORTPM_L1S_ACCEPT);
> +		else
> +			val |=3D PORTPM_L1S(PORTPM_L1S_NYET);
> +		xudc_writel(xudc, val, PORTPM);
> +	}
> +
> +	val =3D xudc_readl(xudc, ST);
> +	if (val & ST_RC)
> +		xudc_writel(xudc, ST_RC, ST);
> +}
> +
> +static void tegra_xudc_port_disconnect(struct tegra_xudc *xudc)
> +{
> +	tegra_xudc_reset(xudc);
> +
> +	if (xudc->driver && xudc->driver->disconnect) {
> +		spin_unlock(&xudc->lock);
> +		xudc->driver->disconnect(&xudc->gadget);
> +		spin_lock(&xudc->lock);
> +	}
> +
> +	xudc->device_state =3D USB_STATE_NOTATTACHED;
> +	usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +
> +	complete(&xudc->disconnect_complete);
> +}
> +
> +static void tegra_xudc_port_reset(struct tegra_xudc *xudc)
> +{
> +	tegra_xudc_reset(xudc);
> +
> +	if (xudc->driver) {
> +		spin_unlock(&xudc->lock);
> +		usb_gadget_udc_reset(&xudc->gadget, xudc->driver);
> +		spin_lock(&xudc->lock);
> +	}
> +
> +	tegra_xudc_port_connect(xudc);
> +}
> +
> +static void tegra_xudc_port_suspend(struct tegra_xudc *xudc)
> +{
> +	dev_dbg(xudc->dev, "port suspend\n");
> +
> +	xudc->resume_state =3D xudc->device_state;
> +	xudc->device_state =3D USB_STATE_SUSPENDED;
> +	usb_gadget_set_state(&xudc->gadget, xudc->device_state);
> +
> +	if (xudc->driver->suspend) {
> +		spin_unlock(&xudc->lock);
> +		xudc->driver->suspend(&xudc->gadget);
> +		spin_lock(&xudc->lock);
> +	}
> +}
> +
> +static void tegra_xudc_port_resume(struct tegra_xudc *xudc)
> +{
> +	dev_dbg(xudc->dev, "port resume\n");
> +
> +	tegra_xudc_resume_device_state(xudc);
> +
> +	if (xudc->driver->resume) {
> +		spin_unlock(&xudc->lock);
> +		xudc->driver->resume(&xudc->gadget);
> +		spin_lock(&xudc->lock);
> +	}
> +}
> +
> +static inline void clear_port_change(struct tegra_xudc *xudc, u32 flag)
> +{
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, PORTSC);
> +	val &=3D ~PORTSC_CHANGE_MASK;
> +	val |=3D flag;
> +	xudc_writel(xudc, val, PORTSC);
> +}
> +
> +static void __tegra_xudc_handle_port_status(struct tegra_xudc *xudc)
> +{
> +	u32 portsc, porthalt;
> +
> +	porthalt =3D xudc_readl(xudc, PORTHALT);
> +	if ((porthalt & PORTHALT_STCHG_REQ) &&
> +	    (porthalt & PORTHALT_HALT_LTSSM)) {
> +		dev_dbg(xudc->dev, "STCHG_REQ, PORTHALT =3D %#x\n", porthalt);
> +		porthalt &=3D ~PORTHALT_HALT_LTSSM;
> +		xudc_writel(xudc, porthalt, PORTHALT);
> +	}
> +
> +	portsc =3D xudc_readl(xudc, PORTSC);
> +	if ((portsc & PORTSC_PRC) && (portsc & PORTSC_PR)) {
> +		dev_dbg(xudc->dev, "PRC, PR, PORTSC =3D %#x\n", portsc);
> +		clear_port_change(xudc, PORTSC_PRC | PORTSC_PED);
> +#define TOGGLE_VBUS_WAIT_MS 100
> +		if (xudc->soc->port_reset_quirk) {
> +			schedule_delayed_work(&xudc->port_reset_war_work,
> +				msecs_to_jiffies(TOGGLE_VBUS_WAIT_MS));
> +			xudc->wait_for_sec_prc =3D 1;
> +		}
> +	}
> +
> +	if ((portsc & PORTSC_PRC) && !(portsc & PORTSC_PR)) {
> +		dev_dbg(xudc->dev, "PRC, Not PR, PORTSC =3D %#x\n", portsc);
> +		clear_port_change(xudc, PORTSC_PRC | PORTSC_PED);
> +		tegra_xudc_port_reset(xudc);
> +		cancel_delayed_work(&xudc->port_reset_war_work);
> +		xudc->wait_for_sec_prc =3D 0;
> +	}
> +
> +	portsc =3D xudc_readl(xudc, PORTSC);
> +	if (portsc & PORTSC_WRC) {
> +		dev_dbg(xudc->dev, "WRC, PORTSC =3D %#x\n", portsc);
> +		clear_port_change(xudc, PORTSC_WRC | PORTSC_PED);
> +		if (!(xudc_readl(xudc, PORTSC) & PORTSC_WPR))
> +			tegra_xudc_port_reset(xudc);
> +	}
> +
> +	portsc =3D xudc_readl(xudc, PORTSC);
> +	if (portsc & PORTSC_CSC) {
> +		dev_dbg(xudc->dev, "CSC, PORTSC =3D %#x\n", portsc);
> +		clear_port_change(xudc, PORTSC_CSC);
> +
> +		if (portsc & PORTSC_CCS)
> +			tegra_xudc_port_connect(xudc);
> +		else
> +			tegra_xudc_port_disconnect(xudc);
> +
> +		if (xudc->wait_csc) {
> +			cancel_delayed_work(&xudc->plc_reset_work);
> +			xudc->wait_csc =3D false;
> +		}
> +	}
> +
> +	portsc =3D xudc_readl(xudc, PORTSC);
> +	if (portsc & PORTSC_PLC) {
> +		u32 pls =3D (portsc & PORTSC_PLS_MASK) >> PORTSC_PLS_SHIFT;
> +
> +		dev_dbg(xudc->dev, "PLC, PORTSC =3D %#x\n", portsc);
> +		clear_port_change(xudc, PORTSC_PLC);
> +		switch (pls) {
> +		case PORTSC_PLS_U3:
> +			tegra_xudc_port_suspend(xudc);
> +			break;
> +		case PORTSC_PLS_U0:
> +			if (xudc->gadget.speed < USB_SPEED_SUPER)
> +				tegra_xudc_port_resume(xudc);
> +			break;
> +		case PORTSC_PLS_RESUME:
> +			if (xudc->gadget.speed =3D=3D USB_SPEED_SUPER)
> +				tegra_xudc_port_resume(xudc);
> +			break;
> +		case PORTSC_PLS_INACTIVE:
> +			schedule_delayed_work(&xudc->plc_reset_work,
> +					msecs_to_jiffies(TOGGLE_VBUS_WAIT_MS));
> +			xudc->wait_csc =3D true;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (portsc & PORTSC_CEC) {
> +		dev_warn(xudc->dev, "CEC, PORTSC =3D %#x\n", portsc);
> +		clear_port_change(xudc, PORTSC_CEC);
> +	}
> +
> +	dev_dbg(xudc->dev, "PORTSC =3D %#x\n", xudc_readl(xudc, PORTSC));
> +}
> +
> +static void tegra_xudc_handle_port_status(struct tegra_xudc *xudc)
> +{
> +	while ((xudc_readl(xudc, PORTSC) & PORTSC_CHANGE_MASK) ||
> +	       (xudc_readl(xudc, PORTHALT) & PORTHALT_STCHG_REQ))
> +		__tegra_xudc_handle_port_status(xudc);
> +}
> +
> +static void tegra_xudc_handle_event(struct tegra_xudc *xudc,
> +				    struct tegra_xudc_trb *event)
> +{
> +	u32 type =3D trb_read_type(event);
> +
> +	dump_trb(xudc, "EVENT", event);
> +
> +	switch (type) {
> +	case TRB_TYPE_PORT_STATUS_CHANGE_EVENT:
> +		tegra_xudc_handle_port_status(xudc);
> +		break;
> +	case TRB_TYPE_TRANSFER_EVENT:
> +		tegra_xudc_handle_transfer_event(xudc, event);
> +		break;
> +	case TRB_TYPE_SETUP_PACKET_EVENT:
> +		tegra_xudc_handle_ep0_event(xudc, event);
> +		break;
> +	default:
> +		dev_info(xudc->dev, "Unrecognized TRB type =3D %#x\n", type);
> +		break;
> +	}
> +}
> +
> +static void tegra_xudc_process_event_ring(struct tegra_xudc *xudc)
> +{
> +	struct tegra_xudc_trb *event;
> +	dma_addr_t erdp;
> +
> +	while (true) {
> +		event =3D xudc->event_ring[xudc->event_ring_index] +
> +			xudc->event_ring_deq_ptr;
> +
> +		if (trb_read_cycle(event) !=3D xudc->ccs)
> +			break;
> +
> +		tegra_xudc_handle_event(xudc, event);
> +
> +		xudc->event_ring_deq_ptr++;
> +		if (xudc->event_ring_deq_ptr =3D=3D XUDC_EVENT_RING_SIZE) {
> +			xudc->event_ring_deq_ptr =3D 0;
> +			xudc->event_ring_index++;
> +		}
> +
> +		if (xudc->event_ring_index =3D=3D XUDC_NR_EVENT_RINGS) {
> +			xudc->event_ring_index =3D 0;
> +			xudc->ccs =3D !xudc->ccs;
> +		}
> +	}
> +
> +	erdp =3D xudc->event_ring_phys[xudc->event_ring_index] +
> +		xudc->event_ring_deq_ptr * sizeof(*event);
> +
> +	xudc_writel(xudc, upper_32_bits(erdp), ERDPHI);
> +	xudc_writel(xudc, lower_32_bits(erdp) | ERDPLO_EHB, ERDPLO);
> +}
> +
> +static irqreturn_t tegra_xudc_irq(int irq, void *data)
> +{
> +	struct tegra_xudc *xudc =3D data;
> +	unsigned long flags;
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, ST);
> +	if (!(val & ST_IP))
> +		return IRQ_NONE;
> +	xudc_writel(xudc, ST_IP, ST);
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	tegra_xudc_process_event_ring(xudc);
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tegra_xudc_alloc_ep(struct tegra_xudc *xudc, unsigned int ind=
ex)
> +{
> +	struct tegra_xudc_ep *ep =3D &xudc->ep[index];
> +
> +	ep->xudc =3D xudc;
> +	ep->index =3D index;
> +	ep->context =3D &xudc->ep_context[index];
> +	INIT_LIST_HEAD(&ep->queue);
> +
> +	/*
> +	 * EP1 would be the input endpoint corresponding to EP0, but since
> +	 * EP0 is bi-directional, EP1 is unused.
> +	 */
> +	if (index =3D=3D 1)
> +		return 0;
> +
> +	ep->transfer_ring =3D dma_pool_alloc(xudc->transfer_ring_pool,
> +					   GFP_KERNEL,
> +					   &ep->transfer_ring_phys);
> +	if (!ep->transfer_ring)
> +		return -ENOMEM;
> +
> +	if (index) {
> +		snprintf(ep->name, sizeof(ep->name), "ep%u%s", index / 2,
> +			 (index % 2 =3D=3D 0) ? "out" : "in");
> +		ep->usb_ep.name =3D ep->name;
> +		usb_ep_set_maxpacket_limit(&ep->usb_ep, 1024);
> +		ep->usb_ep.max_streams =3D 16;
> +		ep->usb_ep.ops =3D &tegra_xudc_ep_ops;
> +		ep->usb_ep.caps.type_bulk =3D true;
> +		ep->usb_ep.caps.type_int =3D true;
> +		if (index & 1)
> +			ep->usb_ep.caps.dir_in =3D true;
> +		else
> +			ep->usb_ep.caps.dir_out =3D true;
> +		list_add_tail(&ep->usb_ep.ep_list, &xudc->gadget.ep_list);
> +	} else {
> +		strscpy(ep->name, "ep0", 3);
> +		ep->usb_ep.name =3D ep->name;
> +		usb_ep_set_maxpacket_limit(&ep->usb_ep, 512);
> +		ep->usb_ep.ops =3D &tegra_xudc_ep0_ops;
> +		ep->usb_ep.caps.type_control =3D true;
> +		ep->usb_ep.caps.dir_in =3D true;
> +		ep->usb_ep.caps.dir_out =3D true;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tegra_xudc_free_ep(struct tegra_xudc *xudc, unsigned int ind=
ex)
> +{
> +	struct tegra_xudc_ep *ep =3D &xudc->ep[index];
> +
> +	/*
> +	 * EP1 would be the input endpoint corresponding to EP0, but since
> +	 * EP0 is bi-directional, EP1 is unused.
> +	 */
> +	if (index =3D=3D 1)
> +		return;
> +
> +	dma_pool_free(xudc->transfer_ring_pool, ep->transfer_ring,
> +		      ep->transfer_ring_phys);
> +}
> +
> +static int tegra_xudc_alloc_eps(struct tegra_xudc *xudc)
> +{
> +	struct usb_request *req;
> +	unsigned int i;
> +	int err;
> +
> +	xudc->ep_context =3D
> +		dma_alloc_coherent(xudc->dev, XUDC_NR_EPS *
> +				    sizeof(*xudc->ep_context),
> +				    &xudc->ep_context_phys, GFP_KERNEL);
> +	if (!xudc->ep_context)
> +		return -ENOMEM;
> +
> +	xudc->transfer_ring_pool =3D
> +		dmam_pool_create(dev_name(xudc->dev), xudc->dev,
> +				 XUDC_TRANSFER_RING_SIZE *
> +				 sizeof(struct tegra_xudc_trb),
> +				 sizeof(struct tegra_xudc_trb), 0);
> +	if (!xudc->transfer_ring_pool) {
> +		err =3D -ENOMEM;
> +		goto free_ep_context;
> +	}
> +
> +	INIT_LIST_HEAD(&xudc->gadget.ep_list);
> +	for (i =3D 0; i < ARRAY_SIZE(xudc->ep); i++) {
> +		err =3D tegra_xudc_alloc_ep(xudc, i);
> +		if (err < 0)
> +			goto free_eps;
> +	}
> +
> +	req =3D tegra_xudc_ep_alloc_request(&xudc->ep[0].usb_ep, GFP_KERNEL);
> +	if (!req) {
> +		err =3D -ENOMEM;
> +		goto free_eps;
> +	}
> +	xudc->ep0_req =3D to_xudc_req(req);
> +
> +	return 0;
> +
> +free_eps:
> +	for (; i > 0; i--)
> +		tegra_xudc_free_ep(xudc, i - 1);
> +free_ep_context:
> +	dma_free_coherent(xudc->dev, XUDC_NR_EPS * sizeof(*xudc->ep_context),
> +			  xudc->ep_context, xudc->ep_context_phys);
> +	return err;
> +}
> +
> +static void tegra_xudc_init_eps(struct tegra_xudc *xudc)
> +{
> +	xudc_writel(xudc, lower_32_bits(xudc->ep_context_phys), ECPLO);
> +	xudc_writel(xudc, upper_32_bits(xudc->ep_context_phys), ECPHI);
> +}
> +
> +static void tegra_xudc_free_eps(struct tegra_xudc *xudc)
> +{
> +	unsigned int i;
> +
> +	tegra_xudc_ep_free_request(&xudc->ep[0].usb_ep,
> +				   &xudc->ep0_req->usb_req);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(xudc->ep); i++)
> +		tegra_xudc_free_ep(xudc, i);
> +
> +	dma_free_coherent(xudc->dev, XUDC_NR_EPS * sizeof(*xudc->ep_context),
> +			  xudc->ep_context, xudc->ep_context_phys);
> +}
> +
> +static int tegra_xudc_alloc_event_ring(struct tegra_xudc *xudc)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(xudc->event_ring); i++) {
> +		xudc->event_ring[i] =3D
> +			dma_alloc_coherent(xudc->dev, XUDC_EVENT_RING_SIZE *
> +					   sizeof(*xudc->event_ring[i]),
> +					   &xudc->event_ring_phys[i],
> +					   GFP_KERNEL);
> +		if (!xudc->event_ring[i])
> +			goto free_dma;
> +	}
> +
> +	return 0;
> +
> +free_dma:
> +	for (; i > 0; i--) {
> +		dma_free_coherent(xudc->dev, XUDC_EVENT_RING_SIZE *
> +				  sizeof(*xudc->event_ring[i - 1]),
> +				  xudc->event_ring[i - 1],
> +				  xudc->event_ring_phys[i - 1]);
> +	}
> +	return -ENOMEM;
> +}
> +
> +static void tegra_xudc_init_event_ring(struct tegra_xudc *xudc)
> +{
> +	unsigned int i;
> +	u32 val;
> +
> +	val =3D xudc_readl(xudc, SPARAM);
> +	val &=3D ~(SPARAM_ERSTMAX_MASK);
> +	val |=3D SPARAM_ERSTMAX(XUDC_NR_EVENT_RINGS);
> +	xudc_writel(xudc, val, SPARAM);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(xudc->event_ring); i++) {
> +		memset(xudc->event_ring[i], 0, XUDC_EVENT_RING_SIZE *
> +		       sizeof(*xudc->event_ring[i]));
> +
> +		val =3D xudc_readl(xudc, ERSTSZ);
> +		val &=3D ~(ERSTSZ_ERSTXSZ_MASK << ERSTSZ_ERSTXSZ_SHIFT(i));
> +		val |=3D XUDC_EVENT_RING_SIZE << ERSTSZ_ERSTXSZ_SHIFT(i);
> +		xudc_writel(xudc, val, ERSTSZ);
> +
> +		xudc_writel(xudc, lower_32_bits(xudc->event_ring_phys[i]),
> +			    ERSTXBALO(i));
> +		xudc_writel(xudc, upper_32_bits(xudc->event_ring_phys[i]),
> +			    ERSTXBAHI(i));
> +	}
> +
> +	val =3D lower_32_bits(xudc->event_ring_phys[0]);
> +	xudc_writel(xudc, val, ERDPLO);
> +	val |=3D EREPLO_ECS;
> +	xudc_writel(xudc, val, EREPLO);
> +
> +	val =3D upper_32_bits(xudc->event_ring_phys[0]);
> +	xudc_writel(xudc, val, ERDPHI);
> +	xudc_writel(xudc, val, EREPHI);
> +
> +	xudc->ccs =3D true;
> +	xudc->event_ring_index =3D 0;
> +	xudc->event_ring_deq_ptr =3D 0;
> +}
> +
> +static void tegra_xudc_free_event_ring(struct tegra_xudc *xudc)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(xudc->event_ring); i++) {
> +		dma_free_coherent(xudc->dev, XUDC_EVENT_RING_SIZE *
> +				  sizeof(*xudc->event_ring[i]),
> +				  xudc->event_ring[i],
> +				  xudc->event_ring_phys[i]);
> +	}
> +}
> +
> +static void tegra_xudc_fpci_ipfs_init(struct tegra_xudc *xudc)
> +{
> +	u32 val;
> +
> +	if (xudc->soc->has_ipfs) {
> +		val =3D ipfs_readl(xudc, XUSB_DEV_CONFIGURATION_0);
> +		val |=3D XUSB_DEV_CONFIGURATION_0_EN_FPCI;
> +		ipfs_writel(xudc, val, XUSB_DEV_CONFIGURATION_0);
> +		usleep_range(10, 15);
> +	}
> +
> +	/* Enable bus master */
> +	val =3D XUSB_DEV_CFG_1_IO_SPACE_EN | XUSB_DEV_CFG_1_MEMORY_SPACE_EN |
> +		XUSB_DEV_CFG_1_BUS_MASTER_EN;
> +	fpci_writel(xudc, val, XUSB_DEV_CFG_1);
> +
> +	/* Program BAR0 space */
> +	val =3D fpci_readl(xudc, XUSB_DEV_CFG_4);
> +	val &=3D ~(XUSB_DEV_CFG_4_BASE_ADDR_MASK);
> +	val |=3D xudc->phys_base & (XUSB_DEV_CFG_4_BASE_ADDR_MASK);
> +
> +	fpci_writel(xudc, val, XUSB_DEV_CFG_4);
> +	fpci_writel(xudc, upper_32_bits(xudc->phys_base), XUSB_DEV_CFG_5);
> +
> +	usleep_range(100, 200);
> +
> +	if (xudc->soc->has_ipfs) {
> +		/* Enable interrupt assertion */
> +		val =3D ipfs_readl(xudc, XUSB_DEV_INTR_MASK_0);
> +		val |=3D XUSB_DEV_INTR_MASK_0_IP_INT_MASK;
> +		ipfs_writel(xudc, val, XUSB_DEV_INTR_MASK_0);
> +	}
> +}
> +
> +static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
> +{
> +	u32 val, imod;
> +
> +	if (xudc->soc->has_ipfs) {
> +		val =3D xudc_readl(xudc, BLCG);
> +		val |=3D BLCG_ALL;
> +		val &=3D ~(BLCG_DFPCI | BLCG_UFPCI | BLCG_FE |
> +				BLCG_COREPLL_PWRDN);
> +		val |=3D BLCG_IOPLL_0_PWRDN;
> +		val |=3D BLCG_IOPLL_1_PWRDN;
> +		val |=3D BLCG_IOPLL_2_PWRDN;
> +
> +		xudc_writel(xudc, val, BLCG);
> +	}
> +
> +	/* Set a reasonable U3 exit timer value. */
> +	val =3D xudc_readl(xudc, SSPX_CORE_PADCTL4);
> +	val &=3D ~(SSPX_CORE_PADCTL4_RXDAT_VLD_TIMEOUT_U3_MASK);
> +	val |=3D SSPX_CORE_PADCTL4_RXDAT_VLD_TIMEOUT_U3(0x5dc0);
> +	xudc_writel(xudc, val, SSPX_CORE_PADCTL4);
> +
> +	/* Default ping LFPS tBurst is too large. */
> +	val =3D xudc_readl(xudc, SSPX_CORE_CNT0);
> +	val &=3D ~(SSPX_CORE_CNT0_PING_TBURST_MASK);
> +	val |=3D SSPX_CORE_CNT0_PING_TBURST(0xa);
> +	xudc_writel(xudc, val, SSPX_CORE_CNT0);
> +
> +	/* Default tPortConfiguration timeout is too small. */
> +	val =3D xudc_readl(xudc, SSPX_CORE_CNT30);
> +	val &=3D ~(SSPX_CORE_CNT30_LMPITP_TIMER_MASK);
> +	val |=3D SSPX_CORE_CNT30_LMPITP_TIMER(0x978);
> +	xudc_writel(xudc, val, SSPX_CORE_CNT30);
> +
> +	if (xudc->soc->lpm_enable) {
> +		/* Set L1 resume duration to 95 us. */
> +		val =3D xudc_readl(xudc, HSFSPI_COUNT13);
> +		val &=3D ~(HSFSPI_COUNT13_U2_RESUME_K_DURATION_MASK);
> +		val |=3D HSFSPI_COUNT13_U2_RESUME_K_DURATION(0x2c88);
> +		xudc_writel(xudc, val, HSFSPI_COUNT13);
> +	}
> +
> +	/*
> +	 * Compliacne suite appears to be violating polling LFPS tBurst max
> +	 * of 1.4us.  Send 1.45us instead.
> +	 */
> +	val =3D xudc_readl(xudc, SSPX_CORE_CNT32);
> +	val &=3D ~(SSPX_CORE_CNT32_POLL_TBURST_MAX_MASK);
> +	val |=3D SSPX_CORE_CNT32_POLL_TBURST_MAX(0xb0);
> +	xudc_writel(xudc, val, SSPX_CORE_CNT32);
> +
> +	/* Direct HS/FS port instance to RxDetect. */
> +	val =3D xudc_readl(xudc, CFG_DEV_FE);
> +	val &=3D ~(CFG_DEV_FE_PORTREGSEL_MASK);
> +	val |=3D CFG_DEV_FE_PORTREGSEL(CFG_DEV_FE_PORTREGSEL_HSFS_PI);
> +	xudc_writel(xudc, val, CFG_DEV_FE);
> +
> +	val =3D xudc_readl(xudc, PORTSC);
> +	val &=3D ~(PORTSC_CHANGE_MASK | PORTSC_PLS_MASK);
> +	val |=3D PORTSC_LWS | PORTSC_PLS(PORTSC_PLS_RXDETECT);
> +	xudc_writel(xudc, val, PORTSC);
> +
> +	/* Direct SS port instance to RxDetect. */
> +	val =3D xudc_readl(xudc, CFG_DEV_FE);
> +	val &=3D ~(CFG_DEV_FE_PORTREGSEL_MASK);
> +	val |=3D CFG_DEV_FE_PORTREGSEL_SS_PI & CFG_DEV_FE_PORTREGSEL_MASK;
> +	xudc_writel(xudc, val, CFG_DEV_FE);
> +
> +	val =3D xudc_readl(xudc, PORTSC);
> +	val &=3D ~(PORTSC_CHANGE_MASK | PORTSC_PLS_MASK);
> +	val |=3D PORTSC_LWS | PORTSC_PLS(PORTSC_PLS_RXDETECT);
> +	xudc_writel(xudc, val, PORTSC);
> +
> +	/* Restore port instance. */
> +	val =3D xudc_readl(xudc, CFG_DEV_FE);
> +	val &=3D ~(CFG_DEV_FE_PORTREGSEL_MASK);
> +	xudc_writel(xudc, val, CFG_DEV_FE);
> +
> +	/*
> +	 * Enable INFINITE_SS_RETRY to prevent device from entering
> +	 * Disabled.Error when attached to buggy SuperSpeed hubs.
> +	 */
> +	val =3D xudc_readl(xudc, CFG_DEV_FE);
> +	val |=3D CFG_DEV_FE_INFINITE_SS_RETRY;
> +	xudc_writel(xudc, val, CFG_DEV_FE);
> +
> +	/* Set interrupt moderation. */
> +	imod =3D XUDC_INTERRUPT_MODERATION_US * 4;
> +	val =3D xudc_readl(xudc, RT_IMOD);
> +	val &=3D ~((RT_IMOD_IMODI_MASK) | (RT_IMOD_IMODC_MASK));
> +	val |=3D (RT_IMOD_IMODI(imod) | RT_IMOD_IMODC(imod));
> +	xudc_writel(xudc, val, RT_IMOD);
> +
> +	/* increase SSPI transaction timeout from 32us to 512us */
> +	val =3D xudc_readl(xudc, CFG_DEV_SSPI_XFER);
> +	val &=3D ~(CFG_DEV_SSPI_XFER_ACKTIMEOUT_MASK);
> +	val |=3D CFG_DEV_SSPI_XFER_ACKTIMEOUT(0xf000);
> +	xudc_writel(xudc, val, CFG_DEV_SSPI_XFER);
> +}
> +
> +static int tegra_xudc_phy_init(struct tegra_xudc *xudc)
> +{
> +	int err;
> +
> +	err =3D phy_init(xudc->utmi_phy);
> +	if (err < 0) {
> +		dev_err(xudc->dev, "utmi phy init failed: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D phy_init(xudc->usb3_phy);
> +	if (err < 0) {
> +		dev_err(xudc->dev, "usb3 phy init failed: %d\n", err);
> +		goto exit_utmi_phy;
> +	}
> +
> +	return 0;
> +
> +exit_utmi_phy:
> +	phy_exit(xudc->utmi_phy);
> +	return err;
> +}
> +
> +static void tegra_xudc_phy_exit(struct tegra_xudc *xudc)
> +{
> +	phy_exit(xudc->usb3_phy);
> +	phy_exit(xudc->utmi_phy);
> +}
> +
> +static const char * const tegra210_xudc_supply_names[] =3D {
> +	"hvdd-usb",
> +	"avddio-usb",
> +};
> +
> +static const char * const tegra210_xudc_clock_names[] =3D {
> +	"dev",
> +	"ss",
> +	"ss_src",
> +	"hs_src",
> +	"fs_src",
> +};
> +
> +static struct tegra_xudc_soc tegra210_xudc_soc_data =3D {
> +	.supply_names =3D tegra210_xudc_supply_names,
> +	.num_supplies =3D ARRAY_SIZE(tegra210_xudc_supply_names),
> +	.clock_names =3D tegra210_xudc_clock_names,
> +	.num_clks =3D ARRAY_SIZE(tegra210_xudc_clock_names),
> +	.u1_enable =3D false,
> +	.u2_enable =3D true,
> +	.lpm_enable =3D false,
> +	.invalid_seq_num =3D true,
> +	.pls_quirk =3D true,
> +	.port_reset_quirk =3D true,
> +	.has_ipfs =3D true,
> +};
> +
> +static const struct of_device_id tegra_xudc_of_match[] =3D {
> +	{
> +		.compatible =3D "nvidia,tegra210-xudc",
> +		.data =3D &tegra210_xudc_soc_data
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tegra_xudc_of_match);
> +
> +static void tegra_xudc_powerdomain_remove(struct tegra_xudc *xudc)
> +{
> +	if (xudc->genpd_dl_ss)
> +		device_link_del(xudc->genpd_dl_ss);
> +	if (xudc->genpd_dl_device)
> +		device_link_del(xudc->genpd_dl_device);
> +	if (xudc->genpd_dev_ss)
> +		dev_pm_domain_detach(xudc->genpd_dev_ss, true);
> +	if (xudc->genpd_dev_device)
> +		dev_pm_domain_detach(xudc->genpd_dev_device, true);
> +}
> +
> +static int tegra_xudc_powerdomain_init(struct tegra_xudc *xudc)
> +{
> +	struct device *dev =3D xudc->dev;
> +	int err;
> +
> +	xudc->genpd_dev_device =3D dev_pm_domain_attach_by_name(dev,
> +								"dev");
> +	if (IS_ERR(xudc->genpd_dev_device)) {
> +		err =3D PTR_ERR(xudc->genpd_dev_device);
> +		dev_err(dev, "failed to get dev pm-domain: %d\n", err);
> +		return err;
> +	}
> +
> +	xudc->genpd_dev_ss =3D dev_pm_domain_attach_by_name(dev, "ss");
> +	if (IS_ERR(xudc->genpd_dev_ss)) {
> +		err =3D PTR_ERR(xudc->genpd_dev_ss);
> +		dev_err(dev, "failed to get superspeed pm-domain: %d\n", err);
> +		return err;
> +	}
> +
> +	xudc->genpd_dl_device =3D device_link_add(dev, xudc->genpd_dev_device,
> +					       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_STATELESS);
> +	if (!xudc->genpd_dl_device) {
> +		dev_err(dev, "adding usb device device link failed!\n");
> +		return -ENODEV;
> +	}
> +
> +	xudc->genpd_dl_ss =3D device_link_add(dev, xudc->genpd_dev_ss,
> +					     DL_FLAG_PM_RUNTIME |
> +					     DL_FLAG_STATELESS);
> +	if (!xudc->genpd_dl_ss) {
> +		dev_err(dev, "adding superspeed device link failed!\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_xudc_probe(struct platform_device *pdev)
> +{
> +	struct tegra_xudc *xudc;
> +	struct resource *res;
> +	struct usb_role_switch_desc role_sx_desc =3D { 0 };
> +	unsigned int i;
> +	int err;
> +
> +	xudc =3D devm_kzalloc(&pdev->dev, sizeof(*xudc), GFP_ATOMIC);
> +	if (!xudc)
> +		return -ENOMEM;
> +
> +	xudc->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, xudc);
> +
> +	xudc->soc =3D of_device_get_match_data(&pdev->dev);
> +	if (!xudc->soc)
> +		return -ENODEV;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "base");
> +	xudc->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xudc->base))
> +		return PTR_ERR(xudc->base);
> +	xudc->phys_base =3D res->start;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "fpci");
> +	xudc->fpci =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xudc->fpci))
> +		return PTR_ERR(xudc->fpci);
> +
> +	if (xudc->soc->has_ipfs) {
> +		res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "ipfs");
> +		xudc->ipfs =3D devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(xudc->ipfs))
> +			return PTR_ERR(xudc->ipfs);
> +	}
> +
> +	xudc->irq =3D platform_get_irq(pdev, 0);
> +	if (xudc->irq < 0) {
> +		dev_err(xudc->dev, "failed to get IRQ: %d\n",
> +				xudc->irq);
> +		return xudc->irq;
> +	}
> +
> +	err =3D devm_request_irq(&pdev->dev, xudc->irq, tegra_xudc_irq, 0,
> +			       dev_name(&pdev->dev), xudc);
> +	if (err < 0) {
> +		dev_err(xudc->dev, "failed to claim IRQ#%u: %d\n", xudc->irq,
> +			err);
> +		return err;
> +	}
> +
> +	xudc->clks =3D devm_kcalloc(&pdev->dev, xudc->soc->num_clks,
> +				      sizeof(*xudc->clks), GFP_KERNEL);
> +	if (!xudc->clks)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < xudc->soc->num_clks; i++)
> +		xudc->clks[i].id =3D xudc->soc->clock_names[i];
> +
> +	err =3D devm_clk_bulk_get(&pdev->dev, xudc->soc->num_clks,
> +				      xudc->clks);
> +	if (err) {
> +		dev_err(xudc->dev, "failed to request clks %d\n", err);
> +		return err;
> +	}
> +
> +	xudc->supplies =3D devm_kcalloc(&pdev->dev, xudc->soc->num_supplies,
> +				      sizeof(*xudc->supplies), GFP_KERNEL);
> +	if (!xudc->supplies)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < xudc->soc->num_supplies; i++)
> +		xudc->supplies[i].supply =3D xudc->soc->supply_names[i];
> +
> +	err =3D devm_regulator_bulk_get(&pdev->dev, xudc->soc->num_supplies,
> +				      xudc->supplies);
> +	if (err) {
> +		dev_err(xudc->dev, "failed to request regulators %d\n", err);
> +		return err;
> +	}
> +
> +	xudc->padctl =3D tegra_xusb_padctl_get(&pdev->dev);
> +	if (IS_ERR(xudc->padctl))
> +		return PTR_ERR(xudc->padctl);
> +
> +	err =3D regulator_bulk_enable(xudc->soc->num_supplies, xudc->supplies);
> +	if (err) {
> +		dev_err(xudc->dev, "failed to enable regulators %d\n", err);
> +		goto put_padctl;
> +	}
> +
> +	xudc->usb3_phy =3D devm_phy_optional_get(&pdev->dev, "usb3");
> +	if (IS_ERR(xudc->usb3_phy)) {
> +		err =3D PTR_ERR(xudc->usb3_phy);
> +		dev_err(xudc->dev, "failed to get usb3 phy: %d\n", err);
> +		goto disable_regulator;
> +	}
> +
> +	xudc->utmi_phy =3D devm_phy_optional_get(&pdev->dev, "usb2");
> +	if (IS_ERR(xudc->utmi_phy)) {
> +		err =3D PTR_ERR(xudc->utmi_phy);
> +		dev_err(xudc->dev, "failed to get usb2 phy: %d\n", err);
> +		goto disable_regulator;
> +	}
> +
> +	err =3D tegra_xudc_powerdomain_init(xudc);
> +	if (err)
> +		goto put_powerdomains;
> +
> +	err =3D tegra_xudc_phy_init(xudc);
> +	if (err)
> +		goto put_powerdomains;
> +
> +	err =3D tegra_xudc_alloc_event_ring(xudc);
> +	if (err)
> +		goto disable_phy;
> +
> +	err =3D tegra_xudc_alloc_eps(xudc);
> +	if (err)
> +		goto free_event_ring;
> +
> +	spin_lock_init(&xudc->lock);
> +
> +	init_completion(&xudc->disconnect_complete);
> +
> +	INIT_WORK(&xudc->usb_role_sw_work, tegra_xudc_usb_role_sw_work);
> +
> +	INIT_DELAYED_WORK(&xudc->plc_reset_work, tegra_xudc_plc_reset_work);
> +
> +	INIT_DELAYED_WORK(&xudc->port_reset_war_work,
> +				tegra_xudc_port_reset_war_work);
> +
> +	if (of_property_read_bool(xudc->dev->of_node, "usb-role-switch")) {
> +		role_sx_desc.set =3D tegra_xudc_usb_role_sw_set;
> +		role_sx_desc.fwnode =3D dev_fwnode(xudc->dev);
> +
> +		xudc->usb_role_sw =3D usb_role_switch_register(xudc->dev,
> +							&role_sx_desc);
> +		if (IS_ERR(xudc->usb_role_sw)) {
> +			err =3D PTR_ERR(xudc->usb_role_sw);
> +			dev_err(xudc->dev, "Failed to register USB role SW: %d",
> +					   err);
> +			goto free_eps;
> +		}
> +	} else {
> +		/* Set the mode as device mode and this keeps phy always ON */
> +		dev_info(xudc->dev, "Set usb role to device mode always");
> +		schedule_work(&xudc->usb_role_sw_work);
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	xudc->gadget.ops =3D &tegra_xudc_gadget_ops;
> +	xudc->gadget.ep0 =3D &xudc->ep[0].usb_ep;
> +	xudc->gadget.name =3D "tegra-xudc";
> +	xudc->gadget.max_speed =3D USB_SPEED_SUPER;
> +
> +	err =3D usb_add_gadget_udc(&pdev->dev, &xudc->gadget);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to add USB gadget: %d\n", err);
> +		goto free_eps;
> +	}
> +
> +	return 0;
> +
> +free_eps:
> +	tegra_xudc_free_eps(xudc);
> +free_event_ring:
> +	tegra_xudc_free_event_ring(xudc);
> +disable_phy:
> +	tegra_xudc_phy_exit(xudc);
> +put_powerdomains:
> +	tegra_xudc_powerdomain_remove(xudc);
> +disable_regulator:
> +	regulator_bulk_disable(xudc->soc->num_supplies, xudc->supplies);
> +put_padctl:
> +	tegra_xusb_padctl_put(xudc->padctl);
> +
> +	return err;
> +}
> +
> +static int tegra_xudc_remove(struct platform_device *pdev)
> +{
> +	struct tegra_xudc *xudc =3D platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(xudc->dev);
> +
> +	cancel_delayed_work(&xudc->plc_reset_work);
> +
> +	if (xudc->usb_role_sw) {
> +		usb_role_switch_unregister(xudc->usb_role_sw);
> +		cancel_work_sync(&xudc->usb_role_sw_work);
> +	}
> +
> +	usb_del_gadget_udc(&xudc->gadget);
> +
> +	tegra_xudc_free_eps(xudc);
> +	tegra_xudc_free_event_ring(xudc);
> +
> +	tegra_xudc_powerdomain_remove(xudc);
> +
> +	regulator_bulk_disable(xudc->soc->num_supplies, xudc->supplies);
> +
> +	phy_power_off(xudc->utmi_phy);
> +	phy_power_off(xudc->usb3_phy);
> +
> +	tegra_xudc_phy_exit(xudc);
> +
> +	pm_runtime_disable(xudc->dev);
> +	pm_runtime_put(xudc->dev);
> +
> +	tegra_xusb_padctl_put(xudc->padctl);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra_xudc_powergate(struct tegra_xudc *xudc)
> +{
> +	unsigned long flags;
> +
> +	dev_dbg(xudc->dev, "entering ELPG\n");
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +
> +	xudc->powergated =3D true;
> +	xudc->saved_regs.ctrl =3D xudc_readl(xudc, CTRL);
> +	xudc->saved_regs.portpm =3D xudc_readl(xudc, PORTPM);
> +	xudc_writel(xudc, 0, CTRL);
> +
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	clk_bulk_disable_unprepare(xudc->soc->num_clks, xudc->clks);
> +
> +	regulator_bulk_disable(xudc->soc->num_supplies, xudc->supplies);
> +
> +	dev_dbg(xudc->dev, "entering ELPG done\n");
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra_xudc_unpowergate(struct tegra_xudc *xudc)
> +{
> +	unsigned long flags;
> +	int err;
> +
> +	dev_dbg(xudc->dev, "exiting ELPG\n");
> +
> +	err =3D regulator_bulk_enable(xudc->soc->num_supplies,
> +			xudc->supplies);
> +	if (err < 0)
> +		return err;
> +
> +	err =3D clk_bulk_prepare_enable(xudc->soc->num_clks, xudc->clks);
> +	if (err < 0)
> +		return err;
> +
> +	tegra_xudc_fpci_ipfs_init(xudc);
> +
> +	tegra_xudc_device_params_init(xudc);
> +
> +	tegra_xudc_init_event_ring(xudc);
> +
> +	tegra_xudc_init_eps(xudc);
> +
> +	xudc_writel(xudc, xudc->saved_regs.portpm, PORTPM);
> +	xudc_writel(xudc, xudc->saved_regs.ctrl, CTRL);
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	xudc->powergated =3D false;
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	dev_dbg(xudc->dev, "exiting ELPG done\n");
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra_xudc_suspend(struct device *dev)
> +{
> +	struct tegra_xudc *xudc =3D dev_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	xudc->suspended =3D true;
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	flush_work(&xudc->usb_role_sw_work);
> +
> +	/* Forcibly disconnect before powergating. */
> +	tegra_xudc_device_mode_off(xudc);
> +
> +	if (!pm_runtime_status_suspended(dev))
> +		tegra_xudc_powergate(xudc);
> +
> +	pm_runtime_disable(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra_xudc_resume(struct device *dev)
> +{
> +	struct tegra_xudc *xudc =3D dev_get_drvdata(dev);
> +	unsigned long flags;
> +	int err;
> +
> +	err =3D tegra_xudc_unpowergate(xudc);
> +	if (err < 0)
> +		return err;
> +
> +	spin_lock_irqsave(&xudc->lock, flags);
> +	xudc->suspended =3D false;
> +	spin_unlock_irqrestore(&xudc->lock, flags);
> +
> +	schedule_work(&xudc->usb_role_sw_work);
> +
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra_xudc_runtime_suspend(struct device *dev)
> +{
> +	struct tegra_xudc *xudc =3D dev_get_drvdata(dev);
> +
> +	return tegra_xudc_powergate(xudc);
> +}
> +
> +static int __maybe_unused tegra_xudc_runtime_resume(struct device *dev)
> +{
> +	struct tegra_xudc *xudc =3D dev_get_drvdata(dev);
> +
> +	return tegra_xudc_unpowergate(xudc);
> +}
> +
> +static const struct dev_pm_ops tegra_xudc_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(tegra_xudc_suspend, tegra_xudc_resume)
> +	SET_RUNTIME_PM_OPS(tegra_xudc_runtime_suspend,
> +			   tegra_xudc_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver tegra_xudc_driver =3D {
> +	.probe =3D tegra_xudc_probe,
> +	.remove =3D tegra_xudc_remove,
> +	.driver =3D {
> +		.name =3D "tegra-xudc",
> +		.pm =3D &tegra_xudc_pm_ops,
> +		.of_match_table =3D tegra_xudc_of_match,
> +	},
> +};
> +module_platform_driver(tegra_xudc_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA Tegra XUSB Device Controller");
> +MODULE_AUTHOR("Andrew Bresticker <abrestic@chromium.org>");
> +MODULE_AUTHOR("Hui Fu <hfu@nvidia.com>");
> +MODULE_AUTHOR("Nagarjuna Kristam <nkristam@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.7.4
>=20

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2kRRAACgkQ3SOs138+
s6EOYQ/9HMd478g2iOXb1yyyfuRJ9AiHb5WU8CqqfMTwakiDE+c/2H52s+R14cPe
tF6VmsXb+GstUwcrGnnb0zSk9sWKnKCYOQZdeygK2uZO9mdBY/wc2WZUaxtnZCKT
edG1z+Gnh+0PkI24fKW2Jy4AeaXJeJ5+xuFatzuJ/L+myeOBb8UrtXfZErDN8Mvm
rNUNrz7qsROddZnkgDG3l70tK+poLeaPvBOZ/6E6MoXwls1WRsYMbAG4ykN2JZAB
6Z68C3y+WbWFpGcA1cLvh+nQHO28Azbo9/01l/GyQlVmguA7Ro+UDqfbnlHIicD7
T5oSTiQbNjv0lkcbNh7jse4QiGVPcTw76FRnrfuC3SOycpgUHc6v6QWuDoC4GucG
co8omtINGVmD30cZEteDWr0l+Xwtb/ADDvAMCPkkXCv+FE4Pt8RTg2YpNGTErF8+
FCqO/CWY6LN3QgukH/RUXG1V8Nw1P+tWxMGMOuxmiKe63q4udsmzTpgwvgzjDYdv
7POZqZEWFucLz4RWnfAY3m+FB4AKLTfXAm6F28DROqHjAhjgqV1Tfp77WfSynwWg
YhiCwlR+A04TZrPvgpsxMCOolzFENEG5OFsRJDHTjfOk+pJQblCfmIeIWlahezTf
nr1+w2qA7LXc9zR8BYerqfh5lHreQxT4JdncOeCl+iDqNF/T+xU=
=M+v2
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
