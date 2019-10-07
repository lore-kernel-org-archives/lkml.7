Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFF0C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CBA206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzYyitCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfJGSYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:24:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35329 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:24:33 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so30857356iop.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gxl1Sj3jOISFNXt8eiWogFvzI6Qdi8w9AgTcI10++HU=;
        b=WzYyitCce82001FPDRYIc6CxCv1XsXC4hELJkeLagGQhr5Ldg+pgTwXv4jxA1uKRrI
         s0WaSm4mfSNFQpeaf50AND3gD8U5t2gUXSb0BSM2z7BCxu87q+KeJ7WhlSxGEF4OaGOj
         LUh+G8Aar3ZVPZHqbMddaQwgOcLSkgtEoPMm/sFLGMIG+5vAZrlxakvY5/Oh7RPph1Ic
         wszlr7sgybXpIE6hJs+cXALL4v0Sjt+NrQ5f2PmpHmRAFGUsBqdYjpH/nsgLllJnroOn
         523SZ8EVFUz06YFeOkMkatRdwafe43q/3Eu0nMUys9VSiHHqj+w7+kcLy31pS0gm7EG+
         7TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gxl1Sj3jOISFNXt8eiWogFvzI6Qdi8w9AgTcI10++HU=;
        b=h4oxZAJNr6EPNrSLWI3Qmvr6/wAMG9dQh/SPal9YoSwteBd7wzrMFGISpVNLufv0+L
         J2oF6X2vqCDP1vaFwIosBo+BNXWYv9ZCmZLUjsOfNJ5UW5ckdQtGOiE73nNTbbt/CkbO
         DWvdbAF+7yvUvPGmtj9YuK/n6Rpprrzpku3UhrTZKIht6lrZw+eDE/TA798s/jMf+BaI
         OXQ/wTMkVfUrFL6qU1hFZxUcV4u0tWYjz4kJm01oBaTTBpifqIF9S6L0q27j4DBzFOJZ
         3NBU8ONt9qzBv06P3cd1ayJFaP+BtH7TFac3Pf8lpnjIyZcZ8WgSNIuJiHk1Thf3/eEm
         bL0g==
X-Gm-Message-State: APjAAAUXOiuPLx4XIT6ugja3l5HElreG2sQwXB4hDxCyvKyszXAEI6Rl
        x9+2M8S2xthyQnbHPgPRMmqkgu5Dcp4oKBCkNQg=
X-Google-Smtp-Source: APXvYqxoJXtkMpM8iu5pDtkVyH4QPn19p8irHOb1FvoM14Z/S8BYayGh+Bz6mI5oahvo+0PKCdlBZBhxCTpRuBzgfwI=
X-Received: by 2002:a92:3546:: with SMTP id c67mr31832449ila.292.1570472665991;
 Mon, 07 Oct 2019 11:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:a04a:0:0:0:0:0 with HTTP; Mon, 7 Oct 2019 11:24:25 -0700 (PDT)
In-Reply-To: <20191004133324.GE18429@dell>
References: <1569338741-2784-1-git-send-email-gene.chen.richtek@gmail.com> <20191004133324.GE18429@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 8 Oct 2019 02:24:25 +0800
Message-ID: <CAE+NS37bQyWknxy+bXYZqyHH_3RbhTQJc5fVd=ibjV6QMz_rew@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: mt6360: add pmic mt6360 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: multipart/mixed; boundary="00000000000062f1960594562929"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000062f1960594562929
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jones,

Thanks for review, we will fix some comment which your suggestion in next p=
atch

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2019=E5=B9=B410=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Wolfram,
>
> Would you be kind enough to grep for your name below?
>
> On Tue, 24 Sep 2019, Gene Chen wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add mfd driver for mt6360 pmic chip include
> > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com
> > ---
> >  drivers/mfd/Kconfig                |  12 +
> >  drivers/mfd/Makefile               |   1 +
> >  drivers/mfd/mt6360-core.c          | 463 +++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
> >  include/linux/mfd/mt6360.h         |  33 +++
> >  5 files changed, 788 insertions(+)
> >  create mode 100644 drivers/mfd/mt6360-core.c
> >  create mode 100644 include/linux/mfd/mt6360-private.h
> >  create mode 100644 include/linux/mfd/mt6360.h
> >
> > changelogs between v1 & v2
> > - include missing header file
> >
> > changelogs between v2 & v3
> > - add changelogs
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index f129f96..a422c76 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -862,6 +862,18 @@ config MFD_MAX8998
> >         additional drivers must be enabled in order to use the function=
ality
> >         of the device.
> >
> > +config MFD_MT6360
> > +     tristate "Mediatek MT6360 SubPMIC"
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     select REGMAP_IRQ
> > +     depends on I2C
> > +     help
> > +       Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> > +       PMU part include charger, flashlight, rgb led
> > +       PMIC part include 2-channel BUCKs and 2-channel LDOs
> > +       LDO part include 4-channel LDOs
>
>           PMU part includes Charger, Flashlight, RGB and LED
>           PMIC part includes 2-channel BUCKs and 2-channel LDOs
>           LDO part includes 4-channel LDOs
>

ACK. RGB LED is one of indicator light, only single feature

> >  config MFD_MT6397
> >       tristate "MediaTek MT6397 PMIC Support"
> >       select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index f026ada..77a8f0b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -241,6 +241,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)      +=3D intel-soc-pm=
ic.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)   +=3D intel_soc_pmic_bxtwc.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)   +=3D intel_soc_pmic_chtwc.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)        +=3D intel_soc_pmic_chtdc=
_ti.o
> > +obj-$(CONFIG_MFD_MT6360)     +=3D mt6360-core.o
> >  obj-$(CONFIG_MFD_MT6397)     +=3D mt6397-core.o
> >
> >  obj-$(CONFIG_MFD_ALTERA_A10SR)       +=3D altera-a10sr.o
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > new file mode 100644
> > index 0000000..d3580618
> > --- /dev/null
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -0,0 +1,463 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019 MediaTek Inc.
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/version.h>
> > +
> > +#include <linux/mfd/mt6360.h>
> > +#include <linux/mfd/mt6360-private.h>
> > +
> > +/* reg 0 -> 0 ~ 7 */
> > +#define MT6360_CHG_TREG_EVT          (4)
> > +#define MT6360_CHG_AICR_EVT          (5)
> > +#define MT6360_CHG_MIVR_EVT          (6)
> > +#define MT6360_PWR_RDY_EVT           (7)
> > +/* REG 1 -> 8 ~ 15 */
> > +#define MT6360_CHG_BATSYSUV_EVT              (9)
> > +#define MT6360_FLED_CHG_VINOVP_EVT   (11)
> > +#define MT6360_CHG_VSYSUV_EVT                (12)
> > +#define MT6360_CHG_VSYSOV_EVT                (13)
> > +#define MT6360_CHG_VBATOV_EVT                (14)
> > +#define MT6360_CHG_VBUSOV_EVT                (15)
> > +/* REG 2 -> 16 ~ 23 */
> > +/* REG 3 -> 24 ~ 31 */
> > +#define MT6360_WD_PMU_DET            (25)
> > +#define MT6360_WD_PMU_DONE           (26)
> > +#define MT6360_CHG_TMRI                      (27)
> > +#define MT6360_CHG_ADPBADI           (29)
> > +#define MT6360_CHG_RVPI                      (30)
> > +#define MT6360_OTPI                  (31)
> > +/* REG 4 -> 32 ~ 39 */
> > +#define MT6360_CHG_AICCMEASL         (32)
> > +#define MT6360_CHGDET_DONEI          (34)
> > +#define MT6360_WDTMRI                        (35)
> > +#define MT6360_SSFINISHI             (36)
> > +#define MT6360_CHG_RECHGI            (37)
> > +#define MT6360_CHG_TERMI             (38)
> > +#define MT6360_CHG_IEOCI             (39)
> > +/* REG 5 -> 40 ~ 47 */
> > +#define MT6360_PUMPX_DONEI           (40)
> > +#define MT6360_BAT_OVP_ADC_EVT               (41)
> > +#define MT6360_TYPEC_OTP_EVT         (42)
> > +#define MT6360_ADC_WAKEUP_EVT                (43)
> > +#define MT6360_ADC_DONEI             (44)
> > +#define MT6360_BST_BATUVI            (45)
> > +#define MT6360_BST_VBUSOVI           (46)
> > +#define MT6360_BST_OLPI                      (47)
> > +/* REG 6 -> 48 ~ 55 */
> > +#define MT6360_ATTACH_I                      (48)
> > +#define MT6360_DETACH_I                      (49)
> > +#define MT6360_QC30_STPDONE          (51)
> > +#define MT6360_QC_VBUSDET_DONE               (52)
> > +#define MT6360_HVDCP_DET             (53)
> > +#define MT6360_CHGDETI                       (54)
> > +#define MT6360_DCDTI                 (55)
> > +/* REG 7 -> 56 ~ 63 */
> > +#define MT6360_FOD_DONE_EVT          (56)
> > +#define MT6360_FOD_OV_EVT            (57)
> > +#define MT6360_CHRDET_UVP_EVT                (58)
> > +#define MT6360_CHRDET_OVP_EVT                (59)
> > +#define MT6360_CHRDET_EXT_EVT                (60)
> > +#define MT6360_FOD_LR_EVT            (61)
> > +#define MT6360_FOD_HR_EVT            (62)
> > +#define MT6360_FOD_DISCHG_FAIL_EVT   (63)
> > +/* REG 8 -> 64 ~ 71 */
> > +#define MT6360_USBID_EVT             (64)
> > +#define MT6360_APWDTRST_EVT          (65)
> > +#define MT6360_EN_EVT                        (66)
> > +#define MT6360_QONB_RST_EVT          (67)
> > +#define MT6360_MRSTB_EVT             (68)
> > +#define MT6360_OTP_EVT                       (69)
> > +#define MT6360_VDDAOV_EVT            (70)
> > +#define MT6360_SYSUV_EVT             (71)
> > +/* REG 9 -> 72 ~ 79 */
> > +#define MT6360_FLED_STRBPIN_EVT              (72)
> > +#define MT6360_FLED_TORPIN_EVT               (73)
> > +#define MT6360_FLED_TX_EVT           (74)
> > +#define MT6360_FLED_LVF_EVT          (75)
> > +#define MT6360_FLED2_SHORT_EVT               (78)
> > +#define MT6360_FLED1_SHORT_EVT               (79)
> > +/* REG 10 -> 80 ~ 87 */
> > +#define MT6360_FLED2_STRB_EVT                (80)
> > +#define MT6360_FLED1_STRB_EVT                (81)
> > +#define MT6360_FLED2_STRB_TO_EVT     (82)
> > +#define MT6360_FLED1_STRB_TO_EVT     (83)
> > +#define MT6360_FLED2_TOR_EVT         (84)
> > +#define MT6360_FLED1_TOR_EVT         (85)
> > +/* REG 11 -> 88 ~ 95 */
> > +/* REG 12 -> 96 ~ 103 */
> > +#define MT6360_BUCK1_PGB_EVT         (96)
> > +#define MT6360_BUCK1_OC_EVT          (100)
> > +#define MT6360_BUCK1_OV_EVT          (101)
> > +#define MT6360_BUCK1_UV_EVT          (102)
> > +/* REG 13 -> 104 ~ 111 */
> > +#define MT6360_BUCK2_PGB_EVT         (104)
> > +#define MT6360_BUCK2_OC_EVT          (108)
> > +#define MT6360_BUCK2_OV_EVT          (109)
> > +#define MT6360_BUCK2_UV_EVT          (110)
> > +/* REG 14 -> 112 ~ 119 */
> > +#define MT6360_LDO1_OC_EVT           (113)
> > +#define MT6360_LDO2_OC_EVT           (114)
> > +#define MT6360_LDO3_OC_EVT           (115)
> > +#define MT6360_LDO5_OC_EVT           (117)
> > +#define MT6360_LDO6_OC_EVT           (118)
> > +#define MT6360_LDO7_OC_EVT           (119)
> > +/* REG 15 -> 120 ~ 127 */
> > +#define MT6360_LDO1_PGB_EVT          (121)
> > +#define MT6360_LDO2_PGB_EVT          (122)
> > +#define MT6360_LDO3_PGB_EVT          (123)
> > +#define MT6360_LDO5_PGB_EVT          (125)
> > +#define MT6360_LDO6_PGB_EVT          (126)
> > +#define MT6360_LDO7_PGB_EVT          (127)
> > +
> > +#define MT6360_REGMAP_IRQ_REG(_irq_evt)              \
> > +     REGMAP_IRQ_REG(_irq_evt, (_irq_evt) / 8, BIT((_irq_evt) % 8))
> > +
> > +#define MT6360_MFD_CELL(_name)                                       \
> > +     {                                                       \
> > +             .name =3D #_name,                                 \
> > +             .of_compatible =3D "mediatek," #_name,            \
> > +             .num_resources =3D ARRAY_SIZE(_name##_resources), \
> > +             .resources =3D _name##_resources,                 \
> > +     }
>
> Please do not roll your own MACROS like this.  If they are helpful for
> you, they are likely to be helpful for others.  However, this is your
> lucky day, as we've been here before.  Please rebase onto the MFD tree
> where you will find some pre-authored macros which aren't too
> dissimilar to this one.  Please use one of those instead.
>

ACK

> > +static const struct regmap_irq mt6360_pmu_irqs[] =3D  {
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TREG_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_AICR_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_MIVR_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_PWR_RDY_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_BATSYSUV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_CHG_VINOVP_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VSYSUV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VSYSOV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VBATOV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VBUSOV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_WD_PMU_DET),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_WD_PMU_DONE),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TMRI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_ADPBADI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_RVPI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_OTPI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_AICCMEASL),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHGDET_DONEI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_WDTMRI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_SSFINISHI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_RECHGI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TERMI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_IEOCI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_PUMPX_DONEI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TREG_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BAT_OVP_ADC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_TYPEC_OTP_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_ADC_WAKEUP_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_ADC_DONEI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BST_BATUVI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BST_VBUSOVI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BST_OLPI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_ATTACH_I),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_DETACH_I),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_QC30_STPDONE),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_QC_VBUSDET_DONE),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_HVDCP_DET),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHGDETI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_DCDTI),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_DONE_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_OV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHRDET_UVP_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHRDET_OVP_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHRDET_EXT_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_LR_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_HR_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_DISCHG_FAIL_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_USBID_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_APWDTRST_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_EN_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_QONB_RST_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_MRSTB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_OTP_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_VDDAOV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_SYSUV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_STRBPIN_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_TORPIN_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_TX_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_LVF_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_SHORT_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_SHORT_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_STRB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_STRB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_STRB_TO_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_STRB_TO_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_TOR_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_TOR_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_PGB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_OV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_UV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_PGB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_OV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_UV_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO1_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO2_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO3_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO5_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO6_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO7_OC_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO1_PGB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO2_PGB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO3_PGB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO5_PGB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO6_PGB_EVT),
> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO7_PGB_EVT),
> > +};
> > +
> > +static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
> > +{
> > +     struct mt6360_pmu_info *mpi =3D irq_drv_data;
> > +
> > +     return regmap_update_bits(mpi->regmap,
> > +             MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG)=
;
> > +}
> > +
> > +static const struct regmap_irq_chip mt6360_pmu_irq_chip =3D {
> > +     .irqs =3D mt6360_pmu_irqs,
> > +     .num_irqs =3D ARRAY_SIZE(mt6360_pmu_irqs),
> > +     .num_regs =3D MT6360_PMU_IRQ_REGNUM,
> > +     .mask_base =3D MT6360_PMU_CHG_MASK1,
> > +     .status_base =3D MT6360_PMU_CHG_IRQ1,
> > +     .ack_base =3D MT6360_PMU_CHG_IRQ1,
> > +     .init_ack_masked =3D true,
> > +     .use_ack =3D true,
> > +     .handle_post_irq =3D mt6360_pmu_handle_post_irq,
> > +};
> > +
> > +static const struct regmap_config mt6360_pmu_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D MT6360_PMU_MAXREG,
> > +};
> > +
> > +static const struct resource mt6360_adc_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
> > +};
> > +
> > +static const struct resource mt6360_chg_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_TREG_EVT, "chg_treg_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_PWR_RDY_EVT, "pwr_rdy_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_BATSYSUV_EVT, "chg_batsysuv_evt")=
,
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VSYSUV_EVT, "chg_vsysuv_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VSYSOV_EVT, "chg_vsysov_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VBATOV_EVT, "chg_vbatov_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VBUSOV_EVT, "chg_vbusov_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_AICCMEASL, "chg_aiccmeasl"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_WDTMRI, "wdtmri"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_RECHGI, "chg_rechgi"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_TERMI, "chg_termi"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_IEOCI, "chg_ieoci"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_PUMPX_DONEI, "pumpx_donei"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_ATTACH_I, "attach_i"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHRDET_EXT_EVT, "chrdet_ext_evt"),
> > +};
> > +
> > +static const struct resource mt6360_led_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED_CHG_VINOVP_EVT, "fled_chg_vinovp=
_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED_LVF_EVT, "fled_lvf_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED2_SHORT_EVT, "fled2_short_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED1_SHORT_EVT, "fled1_short_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED2_STRB_TO_EVT, "fled2_strb_to_evt=
"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt=
"),
> > +};
> > +
> > +static const struct resource mt6360_pmic_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_UV_EVT, "buck1_uv_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_PGB_EVT, "buck2_pgb_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_OC_EVT, "buck2_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_OV_EVT, "buck2_ov_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_UV_EVT, "buck2_uv_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO6_OC_EVT, "ldo6_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > +};
> > +
> > +static const struct resource mt6360_ldo_resources[] =3D {
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO5_OC_EVT, "ldo5_oc_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO1_PGB_EVT, "ldo1_pgb_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO2_PGB_EVT, "ldo2_pgb_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO3_PGB_EVT, "ldo3_pgb_evt"),
> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO5_PGB_EVT, "ldo5_pgb_evt"),
> > +};
> > +
> > +static const struct mfd_cell mt6360_devs[] =3D {
> > +     MT6360_MFD_CELL(mt6360_adc),
> > +     MT6360_MFD_CELL(mt6360_chg),
> > +     MT6360_MFD_CELL(mt6360_led),
> > +     MT6360_MFD_CELL(mt6360_pmic),
> > +     MT6360_MFD_CELL(mt6360_ldo),
> > +     /* tcpc dev */
> > +     {
> > +             .name =3D "mt6360_tcpc",
> > +             .of_compatible =3D "mediatek,mt6360_tcpc",
>
> There is a macro for this too (OF_MFD_CELL())
>

ACK

> > +     },
> > +};
> > +
> > +static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =3D {
> > +     MT6360_PMU_SLAVEID,
> > +     MT6360_PMIC_SLAVEID,
> > +     MT6360_LDO_SLAVEID,
> > +     MT6360_TCPC_SLAVEID,
> > +};
> > +
> > +static int mt6360_pmu_probe(struct i2c_client *client,
> > +                         const struct i2c_device_id *id)
>
> If you use .probe_new (see below) you can omit the 'id' param.
>

ACK

> > +{
> > +     struct mt6360_pmu_info *mpi;
>
> We normally call this ddata.
>

ACK

> > +     unsigned int reg_data =3D 0;
> > +     int i, ret;
> > +
> > +     mpi =3D devm_kzalloc(&client->dev, sizeof(*mpi), GFP_KERNEL);
> > +     if (!mpi)
> > +             return -ENOMEM;
>
> '\n' here.
>

ACK

> > +     mpi->dev =3D &client->dev;
> > +     i2c_set_clientdata(client, mpi);
> > +
> > +     /* regmap regiser */
>
> This comment is spelt incorrectly and doesn't really add anything.
>

ACK

> > +     mpi->regmap =3D devm_regmap_init_i2c(client, &mt6360_pmu_regmap_c=
onfig);
> > +     if (IS_ERR(mpi->regmap)) {
> > +             dev_err(&client->dev, "regmap register fail\n");
>
> "Failed to register regmap"
>

ACK

> > +             return PTR_ERR(mpi->regmap);
> > +     }
>
> '\n' here.
>

ACK

> > +     /* chip id check */
>
> Again, the code is pretty obvious.
>

ACK

> > +     ret =3D regmap_read(mpi->regmap, MT6360_PMU_DEV_INFO, &reg_data);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "device not found\n");
>
> "Device not found"
>

ACK

> > +             return ret;
> > +     }
>
> '\n' here.
>

ACK

> > +     if ((reg_data & CHIP_VEN_MASK) !=3D CHIP_VEN_MT6360) {
> > +             dev_err(&client->dev, "not mt6360 chip\n");
>
> "Device not supported"
>

ACK

> > +             return -ENODEV;
> > +     }
>
> '\n' here.
>

ACK

> > +     mpi->chip_rev =3D reg_data & CHIP_REV_MASK;
>
> Do this above the check, then do
>
>   (mpi->chip_rev !=3D CHIP_VEN_MT6360)
>
> ... above.
>

ACK

> > +     /* irq register */
>
> Please remove all of these comments.
>

ACK

> > +     memcpy(&mpi->irq_chip, &mt6360_pmu_irq_chip, sizeof(mpi->irq_chip=
));
>
> Why do we need to make a copy of it?
>

consider of using mutiple mt6360 chips, we can seperate diff i2c
irq_chip.name by device_name originally
but we can't find silimar case by overview other mfd driver
we will delete this

> > +     mpi->irq_chip.name =3D dev_name(&client->dev);
>
> We already know the name.  Why do we need to do this dynamically?
>

same as above

> > +     mpi->irq_chip.irq_drv_data =3D mpi;
>
> We already saved ddata.  Why do we need to save it here as well?
>

we implement ops ".handle_post_irq" for irq retrigger when irq stuck keep l=
ow

> > +     ret =3D devm_regmap_add_irq_chip(&client->dev, mpi->regmap, clien=
t->irq,
> > +                                    IRQF_TRIGGER_FALLING, 0, &mpi->irq=
_chip,
> > +                                    &mpi->irq_data);
> > +     if (ret < 0) {
>
> Is (ret > 0) valid?
>

we consider mt6360 driver need add irq_chip for full functionality

> > +             dev_err(&client->dev, "regmap irq chip add fail\n");
>
> "Failed to add Regmap IRQ Chip"
>

ACK

> > +             return ret;
> > +     }
>
> '\n' here.
>

ACK

> > +     /* new i2c slave device */
> > +     for (i =3D 0; i < MT6360_SLAVE_MAX; i++) {
> > +             if (mt6360_slave_addr[i] =3D=3D client->addr) {
> > +                     mpi->i2c[i] =3D client;
> > +                     continue;
> > +             }
> > +             mpi->i2c[i] =3D i2c_new_dummy(client->adapter,
> > +                                         mt6360_slave_addr[i]);
> > +             if (!mpi->i2c[i]) {
> > +                     dev_err(&client->dev, "new i2c dev [%d] fail\n", =
i);
> > +                     ret =3D -ENODEV;
> > +                     goto out;
> > +             }
> > +             i2c_set_clientdata(mpi->i2c[i], mpi);
> > +     }
>
> This doesn't look right to me.
>
> Wolfram, would you be kind enough to take a look?
>
> '\n' here.
>

ACK

> > +     /* mfd cell register */
> > +     ret =3D devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> > +                                mt6360_devs, ARRAY_SIZE(mt6360_devs), =
NULL,
> > +                                0, regmap_irq_get_domain(mpi->irq_data=
));
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "mfd add cells fail\n");
> > +             goto out;
> > +     }
>
> '\n' here.
>

ACK

> > +     dev_info(&client->dev, "Successfully probed\n");
>
> Please remove this line.  It doesn't provide anything.
>

ACK

> > +     return 0;
> > +out:
> > +     while (--i >=3D 0) {
> > +             if (mpi->i2c[i]->addr =3D=3D client->addr)
> > +                     continue;
> > +             i2c_unregister_device(mpi->i2c[i]);
> > +     }
>
> '\n' here.
>

ACK

> > +     return ret;
> > +}
> > +
> > +static int mt6360_pmu_remove(struct i2c_client *client)
> > +{
> > +     struct mt6360_pmu_info *mpi =3D i2c_get_clientdata(client);
> > +     int i;
> > +
> > +     for (i =3D 0; i < MT6360_SLAVE_MAX; i++) {
> > +             if (mpi->i2c[i]->addr =3D=3D client->addr)
> > +                     continue;
> > +             i2c_unregister_device(mpi->i2c[i]);
> > +     }
>
> '\n' here.
>

ACK

> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
> > +{
> > +     struct i2c_client *i2c =3D to_i2c_client(dev);
> > +
> > +     if (device_may_wakeup(dev))
> > +             enable_irq_wake(i2c->irq);
>
> '\n' here.
>

ACK

> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused mt6360_pmu_resume(struct device *dev)
> > +{
> > +
> > +     struct i2c_client *i2c =3D to_i2c_client(dev);
> > +
> > +     if (device_may_wakeup(dev))
> > +             disable_irq_wake(i2c->irq);
>
> '\n' here.
>

ACK

> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(mt6360_pmu_pm_ops,
> > +                      mt6360_pmu_suspend, mt6360_pmu_resume);
> > +
> > +static const struct of_device_id __maybe_unused mt6360_pmu_of_id[] =3D=
 {
> > +     { .compatible =3D "mediatek,mt6360_pmu", },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
> > +
> > +static const struct i2c_device_id mt6360_pmu_id[] =3D {
> > +     { "mt6360_pmu", 0 },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mt6360_pmu_id);
>
> If you use .probe_new (see below, you can remove this table.
>

ACK

> > +static struct i2c_driver mt6360_pmu_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "mt6360_pmu",
> > +             .owner =3D THIS_MODULE,
>
> This is no longer required.
>

ACK

> > +             .pm =3D &mt6360_pmu_pm_ops,
> > +             .of_match_table =3D of_match_ptr(mt6360_pmu_of_id),
> > +     },
> > +     .probe =3D mt6360_pmu_probe,
>
> Use .probe_new here.
>

ACK

> > +     .remove =3D mt6360_pmu_remove,
> > +     .id_table =3D mt6360_pmu_id,
> > +};
> > +module_i2c_driver(mt6360_pmu_driver);
> > +
> > +MODULE_AUTHOR("CY_Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("MT6360 PMU I2C Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_VERSION("1.0.0");
> > diff --git a/include/linux/mfd/mt6360-private.h b/include/linux/mfd/mt6=
360-private.h
> > new file mode 100644
> > index 0000000..b07b3d9
> > --- /dev/null
> > +++ b/include/linux/mfd/mt6360-private.h
>
> Why do you need 2 header files?
>

According to our architecture as attachment,
mt6360 have 4 i2c slave address for different parts
so we set whole register table in mt6360-private.h, it will be
included by other modules
we will delete it next patch
and we will add until we use it

> > @@ -0,0 +1,279 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2019 MediaTek Inc.
> > + */
> > +
> > +#ifndef __MT6360_PRIVATE_H__
> > +#define __MT6360_PRIVATE_H__
>
> __MFD_MT6360_H__
>
> > +#include <linux/interrupt.h>
> > +
> > +/* PMU register defininition */
> > +#define MT6360_PMU_DEV_INFO                  (0x00)
> > +#define MT6360_PMU_CORE_CTRL1                        (0x01)
> > +#define MT6360_PMU_RST1                              (0x02)
> > +#define MT6360_PMU_CRCEN                     (0x03)
> > +#define MT6360_PMU_RST_PAS_CODE1             (0x04)
> > +#define MT6360_PMU_RST_PAS_CODE2             (0x05)
> > +#define MT6360_PMU_CORE_CTRL2                        (0x06)
> > +#define MT6360_PMU_TM_PAS_CODE1                      (0x07)
> > +#define MT6360_PMU_TM_PAS_CODE2                      (0x08)
> > +#define MT6360_PMU_TM_PAS_CODE3                      (0x09)
> > +#define MT6360_PMU_TM_PAS_CODE4                      (0x0A)
> > +#define MT6360_PMU_IRQ_IND                   (0x0B)
> > +#define MT6360_PMU_IRQ_MASK                  (0x0C)
> > +#define MT6360_PMU_IRQ_SET                   (0x0D)
> > +#define MT6360_PMU_SHDN_CTRL                 (0x0E)
> > +#define MT6360_PMU_TM_INF                    (0x0F)
> > +#define MT6360_PMU_I2C_CTRL                  (0x10)
> > +#define MT6360_PMU_CHG_CTRL1                 (0x11)
> > +#define MT6360_PMU_CHG_CTRL2                 (0x12)
> > +#define MT6360_PMU_CHG_CTRL3                 (0x13)
> > +#define MT6360_PMU_CHG_CTRL4                 (0x14)
> > +#define MT6360_PMU_CHG_CTRL5                 (0x15)
> > +#define MT6360_PMU_CHG_CTRL6                 (0x16)
> > +#define MT6360_PMU_CHG_CTRL7                 (0x17)
> > +#define MT6360_PMU_CHG_CTRL8                 (0x18)
> > +#define MT6360_PMU_CHG_CTRL9                 (0x19)
> > +#define MT6360_PMU_CHG_CTRL10                        (0x1A)
> > +#define MT6360_PMU_CHG_CTRL11                        (0x1B)
> > +#define MT6360_PMU_CHG_CTRL12                        (0x1C)
> > +#define MT6360_PMU_CHG_CTRL13                        (0x1D)
> > +#define MT6360_PMU_CHG_CTRL14                        (0x1E)
> > +#define MT6360_PMU_CHG_CTRL15                        (0x1F)
> > +#define MT6360_PMU_CHG_CTRL16                        (0x20)
> > +#define MT6360_PMU_CHG_AICC_RESULT           (0x21)
> > +#define MT6360_PMU_DEVICE_TYPE                       (0x22)
> > +#define MT6360_PMU_QC_CONTROL1                       (0x23)
> > +#define MT6360_PMU_QC_CONTROL2                       (0x24)
> > +#define MT6360_PMU_QC30_CONTROL1             (0x25)
> > +#define MT6360_PMU_QC30_CONTROL2             (0x26)
> > +#define MT6360_PMU_USB_STATUS1                       (0x27)
> > +#define MT6360_PMU_QC_STATUS1                        (0x28)
> > +#define MT6360_PMU_QC_STATUS2                        (0x29)
> > +#define MT6360_PMU_CHG_PUMP                  (0x2A)
> > +#define MT6360_PMU_CHG_CTRL17                        (0x2B)
> > +#define MT6360_PMU_CHG_CTRL18                        (0x2C)
> > +#define MT6360_PMU_CHRDET_CTRL1                      (0x2D)
> > +#define MT6360_PMU_CHRDET_CTRL2                      (0x2E)
> > +#define MT6360_PMU_DPDN_CTRL                 (0x2F)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL1          (0x30)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL2          (0x31)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL3          (0x32)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL4          (0x33)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL5          (0x34)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL6          (0x35)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL7          (0x36)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL8          (0x37)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL9          (0x38)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL10         (0x39)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL11         (0x3A)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL12         (0x3B)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL13         (0x3C)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL14         (0x3D)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL15         (0x3E)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL16         (0x3F)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL17         (0x40)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL18         (0x41)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL19         (0x42)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL20         (0x43)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL21         (0x44)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL22         (0x45)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL23         (0x46)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL24         (0x47)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL25         (0x48)
> > +#define MT6360_PMU_BC12_CTRL                 (0x49)
> > +#define MT6360_PMU_CHG_STAT                  (0x4A)
> > +#define MT6360_PMU_RESV1                     (0x4B)
> > +#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEH    (0x4E)
> > +#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEL    (0x4F)
> > +#define MT6360_PMU_TYPEC_OTP_HYST_TH         (0x50)
> > +#define MT6360_PMU_TYPEC_OTP_CTRL            (0x51)
> > +#define MT6360_PMU_ADC_BAT_DATA_H            (0x52)
> > +#define MT6360_PMU_ADC_BAT_DATA_L            (0x53)
> > +#define MT6360_PMU_IMID_BACKBST_ON           (0x54)
> > +#define MT6360_PMU_IMID_BACKBST_OFF          (0x55)
> > +#define MT6360_PMU_ADC_CONFIG                        (0x56)
> > +#define MT6360_PMU_ADC_EN2                   (0x57)
> > +#define MT6360_PMU_ADC_IDLE_T                        (0x58)
> > +#define MT6360_PMU_ADC_RPT_1                 (0x5A)
> > +#define MT6360_PMU_ADC_RPT_2                 (0x5B)
> > +#define MT6360_PMU_ADC_RPT_3                 (0x5C)
> > +#define MT6360_PMU_ADC_RPT_ORG1                      (0x5D)
> > +#define MT6360_PMU_ADC_RPT_ORG2                      (0x5E)
> > +#define MT6360_PMU_BAT_OVP_TH_SEL_CODEH              (0x5F)
> > +#define MT6360_PMU_BAT_OVP_TH_SEL_CODEL              (0x60)
> > +#define MT6360_PMU_CHG_CTRL19                        (0x61)
> > +#define MT6360_PMU_VDDASUPPLY                        (0x62)
> > +#define MT6360_PMU_BC12_MANUAL                       (0x63)
> > +#define MT6360_PMU_CHGDET_FUNC                       (0x64)
> > +#define MT6360_PMU_FOD_CTRL                  (0x65)
> > +#define MT6360_PMU_CHG_CTRL20                        (0x66)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL26         (0x67)
> > +#define MT6360_PMU_CHG_HIDDEN_CTRL27         (0x68)
> > +#define MT6360_PMU_RESV2                     (0x69)
> > +#define MT6360_PMU_USBID_CTRL1                       (0x6D)
> > +#define MT6360_PMU_USBID_CTRL2                       (0x6E)
> > +#define MT6360_PMU_USBID_CTRL3                       (0x6F)
> > +#define MT6360_PMU_FLED_CFG                  (0x70)
> > +#define MT6360_PMU_RESV3                     (0x71)
> > +#define MT6360_PMU_FLED1_CTRL                        (0x72)
> > +#define MT6360_PMU_FLED_STRB_CTRL            (0x73)
> > +#define MT6360_PMU_FLED1_STRB_CTRL2          (0x74)
> > +#define MT6360_PMU_FLED1_TOR_CTRL            (0x75)
> > +#define MT6360_PMU_FLED2_CTRL                        (0x76)
> > +#define MT6360_PMU_RESV4                     (0x77)
> > +#define MT6360_PMU_FLED2_STRB_CTRL2          (0x78)
> > +#define MT6360_PMU_FLED2_TOR_CTRL            (0x79)
> > +#define MT6360_PMU_FLED_VMIDTRK_CTRL1                (0x7A)
> > +#define MT6360_PMU_FLED_VMID_RTM             (0x7B)
> > +#define MT6360_PMU_FLED_VMIDTRK_CTRL2                (0x7C)
> > +#define MT6360_PMU_FLED_PWSEL                        (0x7D)
> > +#define MT6360_PMU_FLED_EN                   (0x7E)
> > +#define MT6360_PMU_FLED_Hidden1                      (0x7F)
> > +#define MT6360_PMU_RGB_EN                    (0x80)
> > +#define MT6360_PMU_RGB1_ISNK                 (0x81)
> > +#define MT6360_PMU_RGB2_ISNK                 (0x82)
> > +#define MT6360_PMU_RGB3_ISNK                 (0x83)
> > +#define MT6360_PMU_RGB_ML_ISNK                       (0x84)
> > +#define MT6360_PMU_RGB1_DIM                  (0x85)
> > +#define MT6360_PMU_RGB2_DIM                  (0x86)
> > +#define MT6360_PMU_RGB3_DIM                  (0x87)
> > +#define MT6360_PMU_RESV5                     (0x88)
> > +#define MT6360_PMU_RGB12_Freq                        (0x89)
> > +#define MT6360_PMU_RGB34_Freq                        (0x8A)
> > +#define MT6360_PMU_RGB1_Tr                   (0x8B)
> > +#define MT6360_PMU_RGB1_Tf                   (0x8C)
> > +#define MT6360_PMU_RGB1_TON_TOFF             (0x8D)
> > +#define MT6360_PMU_RGB2_Tr                   (0x8E)
> > +#define MT6360_PMU_RGB2_Tf                   (0x8F)
> > +#define MT6360_PMU_RGB2_TON_TOFF             (0x90)
> > +#define MT6360_PMU_RGB3_Tr                   (0x91)
> > +#define MT6360_PMU_RGB3_Tf                   (0x92)
> > +#define MT6360_PMU_RGB3_TON_TOFF             (0x93)
> > +#define MT6360_PMU_RGB_Hidden_CTRL1          (0x94)
> > +#define MT6360_PMU_RGB_Hidden_CTRL2          (0x95)
> > +#define MT6360_PMU_RESV6                     (0x97)
> > +#define MT6360_PMU_SPARE1                    (0x9A)
> > +#define MT6360_PMU_SPARE2                    (0xA0)
> > +#define MT6360_PMU_SPARE3                    (0xB0)
> > +#define MT6360_PMU_SPARE4                    (0xC0)
> > +#define MT6360_PMU_CHG_IRQ1                  (0xD0)
> > +#define MT6360_PMU_CHG_IRQ2                  (0xD1)
> > +#define MT6360_PMU_CHG_IRQ3                  (0xD2)
> > +#define MT6360_PMU_CHG_IRQ4                  (0xD3)
> > +#define MT6360_PMU_CHG_IRQ5                  (0xD4)
> > +#define MT6360_PMU_CHG_IRQ6                  (0xD5)
> > +#define MT6360_PMU_QC_IRQ                    (0xD6)
> > +#define MT6360_PMU_FOD_IRQ                   (0xD7)
> > +#define MT6360_PMU_BASE_IRQ                  (0xD8)
> > +#define MT6360_PMU_FLED_IRQ1                 (0xD9)
> > +#define MT6360_PMU_FLED_IRQ2                 (0xDA)
> > +#define MT6360_PMU_RGB_IRQ                   (0xDB)
> > +#define MT6360_PMU_BUCK1_IRQ                 (0xDC)
> > +#define MT6360_PMU_BUCK2_IRQ                 (0xDD)
> > +#define MT6360_PMU_LDO_IRQ1                  (0xDE)
> > +#define MT6360_PMU_LDO_IRQ2                  (0xDF)
> > +#define MT6360_PMU_CHG_STAT1                 (0xE0)
> > +#define MT6360_PMU_CHG_STAT2                 (0xE1)
> > +#define MT6360_PMU_CHG_STAT3                 (0xE2)
> > +#define MT6360_PMU_CHG_STAT4                 (0xE3)
> > +#define MT6360_PMU_CHG_STAT5                 (0xE4)
> > +#define MT6360_PMU_CHG_STAT6                 (0xE5)
> > +#define MT6360_PMU_QC_STAT                   (0xE6)
> > +#define MT6360_PMU_FOD_STAT                  (0xE7)
> > +#define MT6360_PMU_BASE_STAT                 (0xE8)
> > +#define MT6360_PMU_FLED_STAT1                        (0xE9)
> > +#define MT6360_PMU_FLED_STAT2                        (0xEA)
> > +#define MT6360_PMU_RGB_STAT                  (0xEB)
> > +#define MT6360_PMU_BUCK1_STAT                        (0xEC)
> > +#define MT6360_PMU_BUCK2_STAT                        (0xED)
> > +#define MT6360_PMU_LDO_STAT1                 (0xEE)
> > +#define MT6360_PMU_LDO_STAT2                 (0xEF)
> > +#define MT6360_PMU_CHG_MASK1                 (0xF0)
> > +#define MT6360_PMU_CHG_MASK2                 (0xF1)
> > +#define MT6360_PMU_CHG_MASK3                 (0xF2)
> > +#define MT6360_PMU_CHG_MASK4                 (0xF3)
> > +#define MT6360_PMU_CHG_MASK5                 (0xF4)
> > +#define MT6360_PMU_CHG_MASK6                 (0xF5)
> > +#define MT6360_PMU_QC_MASK                   (0xF6)
> > +#define MT6360_PMU_FOD_MASK                  (0xF7)
> > +#define MT6360_PMU_BASE_MASK                 (0xF8)
> > +#define MT6360_PMU_FLED_MASK1                        (0xF9)
> > +#define MT6360_PMU_FLED_MASK2                        (0xFA)
> > +#define MT6360_PMU_FAULTB_MASK                       (0xFB)
> > +#define MT6360_PMU_BUCK1_MASK                        (0xFC)
> > +#define MT6360_PMU_BUCK2_MASK                        (0xFD)
> > +#define MT6360_PMU_LDO_MASK1                 (0xFE)
> > +#define MT6360_PMU_LDO_MASK2                 (0xFF)
> > +#define MT6360_PMU_MAXREG                    (MT6360_PMU_LDO_MASK2)
> > +
> > +
> > +/* MT6360_PMU_IRQ_SET */
> > +#define MT6360_PMU_IRQ_REGNUM        (MT6360_PMU_LDO_IRQ2 - MT6360_PMU=
_CHG_IRQ1 + 1)
> > +#define MT6360_IRQ_RETRIG    BIT(2)
> > +
> > +#define CHIP_VEN_MASK                                (0xF0)
> > +#define CHIP_VEN_MT6360                              (0x50)
> > +#define CHIP_REV_MASK                                (0x0F)
> > +
> > +/* IRQ definitions */
>
> Remove this please.
>
> > +struct mt6360_pmu_irq_desc {
> > +     const char *name;
> > +     irq_handler_t irq_handler;
> > +};
>
> Where is this used?
>
> > +#define  MT6360_DT_VALPROP(name, type) \
> > +                     {#name, offsetof(type, name)}
>
> Where is this used?
>
> > +struct mt6360_val_prop {
> > +     const char *name;
> > +     size_t offset;
> > +};
> > +
> > +static inline void mt6360_dt_parser_helper(struct device_node *np, voi=
d *data,
> > +                                        const struct mt6360_val_prop *=
props,
> > +                                        int prop_cnt)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < prop_cnt; i++) {
> > +             if (unlikely(!props[i].name))
> > +                     continue;
> > +             of_property_read_u32(np, props[i].name, data + props[i].o=
ffset);
> > +     }
> > +}
>
> What are you using this for?  Why is the standard API not sufficient?
>
> > +#define MT6360_PDATA_VALPROP(name, type, reg, shift, mask, func, base)=
 \
> > +                     {offsetof(type, name), reg, shift, mask, func, ba=
se}
>
> Where is this used?
>
> > +struct mt6360_pdata_prop {
> > +     size_t offset;
> > +     u8 reg;
> > +     u8 shift;
> > +     u8 mask;
> > +     u32 (*transform)(u32 val);
> > +     u8 base;
> > +};
> > +
> > +static inline int mt6360_pdata_apply_helper(void *context, void *pdata=
,
> > +                                        const struct mt6360_pdata_prop=
 *prop,
> > +                                        int prop_cnt)
> > +{
> > +     int i, ret;
> > +     u32 val;
> > +
> > +     for (i =3D 0; i < prop_cnt; i++) {
> > +             val =3D *(u32 *)(pdata + prop[i].offset);
> > +             if (prop[i].transform)
> > +                     val =3D prop[i].transform(val);
> > +             val +=3D prop[i].base;
> > +             ret =3D regmap_update_bits(context,
> > +                          prop[i].reg, prop[i].mask, val << prop[i].sh=
ift);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
>
> Where is this used?  What does it do?
>
> > +#endif /* __MT6360_PRIVATE_H__ */
> > diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> > new file mode 100644
> > index 0000000..ba2e80a
> > --- /dev/null
> > +++ b/include/linux/mfd/mt6360.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2019 MediaTek Inc.
> > + */
> > +
> > +#ifndef __MT6360_H__
> > +#define __MT6360_H__
> > +
> > +#include <linux/regmap.h>
> > +
> > +enum {
> > +     MT6360_SLAVE_PMU =3D 0,
> > +     MT6360_SLAVE_PMIC,
> > +     MT6360_SLAVE_LDO,
> > +     MT6360_SLAVE_TCPC,
> > +     MT6360_SLAVE_MAX,
> > +};
> > +
> > +#define MT6360_PMU_SLAVEID   (0x34)
> > +#define MT6360_PMIC_SLAVEID  (0x1A)
> > +#define MT6360_LDO_SLAVEID   (0x64)
> > +#define MT6360_TCPC_SLAVEID  (0x4E)
>
> What kind of slave ID?  I2C address?
>
> > +struct mt6360_pmu_info {
> > +     struct i2c_client *i2c[MT6360_SLAVE_MAX];
> > +     struct device *dev;
>
> > +     struct regmap *regmap;
> > +     struct regmap_irq_chip_data *irq_data;
> > +     struct regmap_irq_chip irq_chip;
> > +     unsigned int chip_rev;
>
> Why are you saving these?
>
> Where do you reuse them?
>
> > +};
> > +
> > +#endif /* __MT6360_H__ */
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--00000000000062f1960594562929
Content-Type: application/vnd.oasis.opendocument.presentation; 
	name="MT6360_ARCHITECTURE.odp"
Content-Disposition: attachment; filename="MT6360_ARCHITECTURE.odp"
Content-Transfer-Encoding: base64
X-Attachment-Id: file1

UEsDBBQAAAgAAO6OR08zJqyoLwAAAC8AAAAIAAAAbWltZXR5cGVhcHBsaWNhdGlvbi92bmQub2Fz
aXMub3BlbmRvY3VtZW50LnByZXNlbnRhdGlvblBLAwQUAAAIAADujkdP5FrQyWlrAABpawAAGAAA
AFRodW1ibmFpbHMvdGh1bWJuYWlsLnBuZ4lQTkcNChoKAAAADUlIRFIAAAEAAAAAwAgCAAAAZI8q
MQAAazBJREFUeJzsfQdgHMW58MzW60069d5ly7ZcccFgbNMxNRAcXkiAkISW8kgjJHmk56XxpxGS
QEIJEBI6PDrY2LiAe7dcZFu26kk6Xb+t88/M3p3u1CwXIET3GaTV7uw3M99+fRqHEAJZyMJEBe6j
bkAWsvBRQlYAsjChISsAWZjQkBWALExoyApAFiY0ZAUgCxMasgKQhQkNWQHIwoSG4wsAQghCaFwY
1xiM4bPhFwak/5n+eupd8tS4O3gf0FfSLxJvZSCkV2CUBiRRjtD+sZuXbBV+NDKqdCT00Wi1ZeFj
BuOyAMbX1nUdMwACOsMwgDILS1mAcIaua3qSwyDgGBYXxg8Y/BZCLGQwDh3pEDAsZSNcmIGAoKMI
MDpNI69jxPiCsD9ALMvgdzT8Fq6IYTRaAUaI7+OSpDG49WyiInYUZkww7vGaR5qk6cZzjJ/eTGf3
jJ8Gliz3/2fA8QUg9alZlh1UhPSuhrmGMhZ+xHFM6ikGzLIGx+ELABH+x7FcyobwicKMoXQJw7EM
1f0YVZpqZyAPOcMM4CoM42BgMBpDX2QBlQfcFshgsUq0jTxiIBYnUoCUhym0w5sHCH7GsD74RaNr
FC1icAkI6Z+QNhW/gnUBYjnWsFVZUfhYw7hcIOOr//HhJ59ds99qd/74zs8c2bah35J/3dlNmFUw
h8mR4D2/e2J7Z2RKRa7gzPv+jRf8vz8+4miYfePZ5Xf87Ilv3HFDqS3+ubvvv3DZpVfNrd63e9eP
Hls9ozLvrS0tVrM4ENd+8N+fbnl//cMrW75581VH925/bMXOxYvOvPu/Fh9sabnnz887iqt/99Ur
fvX7h1bs9//wq9fPqszFrfr5fQ+LxY1fvmzO3x97Xiyrv3phg2EfALUp+JqocJCQKzkSGqN5X7/t
+jIn/+Dfn3l8xY4FZ877znWLWto6p9SUEzlhYbrIvfvW2w+uOfa3712PLZZhA7PM/3GHcbpA5Ocr
b68757LrvD1bb//hg584ozTuMO/ds/eR17c01Fbs3LDm/U72t1+7eseWLf/76Io7rln01wf+mb+Y
WVKovrp69y++zQA59tLzbxyOOrEAvPra248+9Nannvt1jkW/64/vPH7/N9a/8fozW3t+/KXlNR5T
60H7r7+2/KYv/2JKVcFDD/+j+cyzb7ls/vNPP/fMVt/yucW3ff/B9Q99E3Pdtk1bn/zbulsvm7N3
y3Ze9YCFVb/+64tz580xxfzAnZfHxjYdi5zXXPLMO7uvv3j+Xx96bMX+6J+//cntmzcPad4rq3b9
7tv83o3v/uDhlY/+6styPP7Pp1/8xp/f/MOP7rAogQ0Hej5x4dkNxfbHnn49JLhdof5IOHaso+OV
DYduvmzBYNSShY8tnEAWyOqwbd2xxxToWbBgnh46+u72Na+8qTXkCj96bdNPv7rs2XufWr2357ar
l/3zjU1/euK13Np6kx585JUNs+dNNwEQiyoNU+sGejs7+wMtnaHSydXFpcXNufGfP7/vrMmlj97f
Egzxv/zzv778+euuXTz9Z3/5l7O20aT6tx3oUk2b79e16IFDS86Z++VPTv3ryz84HEKVduguLVuE
Bn768Jvm3DxBRF/57m9396lPvbmxLNdWVN1QqLTft7r33s/P/dvzu7AATGlq6Hjh6dV7u28d3rz5
M3DX8opLPRb9Hyt23Pflyx/c/r4minYT03Kwa+3ajSu2H1vW5HrgtR3LL12EYxhdidz+4wfPvXgZ
fgtHK0yW+z/mcGJpUJNJLDPldLX77CZdURROMDnd7vlnF1517tlzastuuvv3uw63Lztz0q33/uMH
d94cPbrnV0+t+dUPvoJfVFXFkZfX4M279y/PuIvLa31qVFJ0lYbVALT3BW659c4Zyr6v/faJZ37+
+dKi/D3dR1Zv2OMuq3jhN1//zBe/vfFI8PoZCwGNNwyO8w2Eb/rsVateenWvL36BN3/99oMVU5tx
+DBrxqS3Vr/f482bV2P/6SMrrl7+CVx4wdnnrK2qvuFbv9l5aHjzvooLuArK1z72k+/+4i/zb/nN
j5c3z54Rx2L54ivvFBfltxzpff6dw1/50uc/d3bte6tXffGeP5136ZW3XdSMYw6GYbLq/+MOJyAA
0WC4uri4EaDXXt7vqbZNqizftGbNE205T/+/r65ft6FLM587o+rNI913fGa2cuDomfNn96/rCBzy
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
+hkAAMvDAQBQSwMEFAAACAAA7o5HTxh35WmBCQAAgQkAAC0AAABQaWN0dXJlcy8xMDAwMDIwMDAw
MDAwMEI3MDAwMDAwMkUwODk3QjBBMi5wbmeJUE5HDQoaCgAAAA1JSERSAAAAtwAAAC4IAwAAASre
SLAAAAABc1JHQgCuzhzpAAAABGdBTUEAALGPC/xhBQAAAtxQTFRF/////OTE97xp9KIw85oe9ag9
++C7/vfs97hi9KIv/vbq9ag+9KEu///+9rVb+MiF+9629KMy/vnx//v39Kc6+tio+c2P9a9N//79
/vPk854n85sg/OnN98By/OXG85of9KAr/vXp//389axG+dGY+tSg9alA//36/vft++K/+MN5/ezU
85sh850k/fDf9rJU9a1I/fHf/OjL9rNW+MiE/OPC/vXo+cuM+c2O/fLi/OrQ+9mr971s975v+9yx
854o9q9N+tKa/OjN/fLj9rJT+c6U+cyN+c+T+c2Q+cqI+9uw+cmG9rdf/vPj/vfu/fHh9a9M+MR8
/OfJ+c6R9rNV858o/vTn//789a1J97tn//z4/OK/+ten+tSf9apD/vr09KQ19KU29KU39KMz/vnz
/ObI+MR9/vjv9KY49KY5+tem9KMx/vrz9apC/OPA+cqJ+9uv850l/fLh9ak/+tel85wh+tWh9rBP
97lk+taj+92z9rBQ9rRX/e3X+c+S9KAs+MV++MaA9rFQ9atD9rhh850m9rFT//7+/fHg9a5L85sf
/vjw//77975t+tmr85wj/fDd/evS97lj+MV89ag8+MeC++G8+MaB+MeD+MJ4+9qr+9+4/OjO+MV9
/OK++9qt+dCW85wi+MF1/e/b++K99rVa9KEt9a9O9bJS/vTl9rFR/vTm9rZb979w9KAq9rde++C6
9J8p+cyO/OjM97xq9a5K+tmq/ezW+9+3+dCX++G99apB/ezV9KY69axF//37975u/ObJ9ac7//z5
/OXE+MBz/vny+9+5+tKb9J8q97to/OnP+tin/vbs/OTD+c6T+MmH98B0/evT854m/vLj9rBO//v2
+MN7/e3Y9atE+tOc/erR+MJ3+92y/e7Z97pm+MR7/e3W9rFS/vbr/vv2/e/c9rRY+tGZ+9619rZd
+tal+c+U9a1K858p/OfK971t+tak9rhg9KEvAAAA66HZsQAAAPR0Uk5T////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
ABjg9xcAAAAJcEhZcwAAIdUAACHVAQSctJ0AAAUuSURBVFhHzZkxjus4DIZV6ASpcwRdxEdwYyAX
2BOk9gWmSzkH2HIBl6lSGUja7Y0AKXOC/X+SkuXEfvE8aB/8ZZJIFEVTskTRGUf8Owtiyr3f4xsv
f+fXycSoB+nifOPdxT9YWbYyJ39S7tzBqjkQ11bMobp+siCf93Rd1ryjUe9vvkvq7yyLDRN8IvxI
2+yjIP1k9pw/UCJvf7l5/+jM3E2UdbahijeU5C0vqqP2eLBMAySwuALVnpv3OVTbwFpYw1+qfbHq
J1TbRv4Z1f7ZaHWaUMGE7+7O9TKJrrdGvJ6ibYtStHXSsfArtvv9zflzzX5SFVS7tyLeKNyvesvw
elHnLaMaRcEN2rtDf1womLqsDB2cNLuWxRWotvn1md/RXqtuszph7XJbyd9mVjBZKRozK5isFFh6
icFkpcinvTKZLOETPxBNmqahB/82NSpooQKVQ9sO7t6Gb+egcoDKyR+n7lEtEm9lw+3TO0wXbaGh
Rk9eWAW8NoqonxnNL+6K9b/DSfG4TiODWlXirr6Kg9wVtBWI71wVcDHxvIWlqXHRebjO17nnalWJ
tuVbK9KJSElF8glSVRRURURGa2YFk5XiYWbJypi7mnyZfJmsFGZ2hrnz/LdBEB/BQigJl13CZKXI
bccdWgozK5ioFIgLCUSQophZUvhGxuNWMFExzCyRJI2g7CvnjrbDGLtI4790D6Pc2gpgBAYXyOS8
kf7GTpoUE/mBZbxrrPxWwjhDNQ4TJIpntDPCt02LkNTyEpWp8J3HrDxkxQ0pHu0p+I5hWa6LOP8l
ttnOJMSk+NDvq7QmqBYxEWRylg6u/nIXXjxZOYrfvTtObUPFQj67R/JDMw6ndmfafvauTscJe6Hr
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
AENvbmZpZ3VyYXRpb25zMi90b29sYmFyL1BLAwQUAAAIAADujkdPAAAAAAAAAAAAAAAAGAAAAENv
bmZpZ3VyYXRpb25zMi9tZW51YmFyL1BLAwQUAAAIAADujkdPAAAAAAAAAAAAAAAAGAAAAENvbmZp
Z3VyYXRpb25zMi9mbG9hdGVyL1BLAwQUAAgICADujkdPAAAAAAAAAAAAAAAAJwAAAENvbmZpZ3Vy
YXRpb25zMi9hY2NlbGVyYXRvci9jdXJyZW50LnhtbAMAUEsHCAAAAAACAAAAAAAAAFBLAwQUAAAI
AADujkdPAAAAAAAAAAAAAAAAGgAAAENvbmZpZ3VyYXRpb25zMi90b29scGFuZWwvUEsDBBQAAAgA
AO6OR08AAAAAAAAAAAAAAAAcAAAAQ29uZmlndXJhdGlvbnMyL3Byb2dyZXNzYmFyL1BLAwQUAAAI
AADujkdPAAAAAAAAAAAAAAAAHwAAAENvbmZpZ3VyYXRpb25zMi9pbWFnZXMvQml0bWFwcy9QSwME
FAAICAgA7o5HTwAAAAAAAAAAAAAAABUAAABNRVRBLUlORi9tYW5pZmVzdC54bWytVE1vwyAMvfdX
RNwDaS7toqbVOm3nHbofwIibIoGJwFTtvx/J1o9p6rRq4WKM7feebGCxOliT7cEH7bBmU16wDFC5
RmNbs7fNSz5nq+VkYSXqLQSqTpss1WE4uzWLHisngw4VSguhIlW5DrBxKlpAqr7nVwPT2bsSULLl
JLvwbbWBPNX74yV7G43JO0m7molbIJdjC42WOR07qJnsOqOVpJQm9tjwQTC/1sk7DyHZIYeJe7Rs
dtG+o9QmCDpteYftDS3ayhZEH7+LxQJJnpp5A5XgQKIP3wUagChNPIwOrBxS39WxcV+1opgmJaZF
WmXxtdazT1s+F/OH2bp4LMcfQKCjgfE79eRwq9voh4sXSiGVAgPJdV6o6P3vXfwf1x9fS4jYS+BR
c3WN0JMvxI8vYvkBUEsHCDBwcqIzAQAAXQQAAFBLAQIUABQAAAgAAO6OR08zJqyoLwAAAC8AAAAI
AAAAAAAAAAAAAAAAAAAAAABtaW1ldHlwZVBLAQIUABQAAAgAAO6OR0/kWtDJaWsAAGlrAAAYAAAA
AAAAAAAAAAAAAFUAAABUaHVtYm5haWxzL3RodW1ibmFpbC5wbmdQSwECFAAUAAgICADujkdPtrg9
ibgBAAAnBAAACAAAAAAAAAAAAAAAAAD0awAAbWV0YS54bWxQSwECFAAUAAgICADujkdPKYH96DkG
AADoJQAADAAAAAAAAAAAAAAAAADibQAAc2V0dGluZ3MueG1sUEsBAhQAFAAICAgA7o5HT05K+h/6
GQAAy8MBAAsAAAAAAAAAAAAAAAAAVXQAAGNvbnRlbnQueG1sUEsBAhQAFAAACAAA7o5HTxh35WmB
CQAAgQkAAC0AAAAAAAAAAAAAAAAAiI4AAFBpY3R1cmVzLzEwMDAwMjAwMDAwMDAwQjcwMDAwMDAy
RTA4OTdCMEEyLnBuZ1BLAQIUABQACAgIAO6OR0/CKwcoBxkAAPVfAQAKAAAAAAAAAAAAAAAAAFSY
AABzdHlsZXMueG1sUEsBAhQAFAAACAAA7o5HTwAAAAAAAAAAAAAAABoAAAAAAAAAAAAAAAAAk7EA
AENvbmZpZ3VyYXRpb25zMi9wb3B1cG1lbnUvUEsBAhQAFAAACAAA7o5HTwAAAAAAAAAAAAAAABoA
AAAAAAAAAAAAAAAAy7EAAENvbmZpZ3VyYXRpb25zMi9zdGF0dXNiYXIvUEsBAhQAFAAACAAA7o5H
TwAAAAAAAAAAAAAAABgAAAAAAAAAAAAAAAAAA7IAAENvbmZpZ3VyYXRpb25zMi90b29sYmFyL1BL
AQIUABQAAAgAAO6OR08AAAAAAAAAAAAAAAAYAAAAAAAAAAAAAAAAADmyAABDb25maWd1cmF0aW9u
czIvbWVudWJhci9QSwECFAAUAAAIAADujkdPAAAAAAAAAAAAAAAAGAAAAAAAAAAAAAAAAABvsgAA
Q29uZmlndXJhdGlvbnMyL2Zsb2F0ZXIvUEsBAhQAFAAICAgA7o5HTwAAAAACAAAAAAAAACcAAAAA
AAAAAAAAAAAApbIAAENvbmZpZ3VyYXRpb25zMi9hY2NlbGVyYXRvci9jdXJyZW50LnhtbFBLAQIU
ABQAAAgAAO6OR08AAAAAAAAAAAAAAAAaAAAAAAAAAAAAAAAAAPyyAABDb25maWd1cmF0aW9uczIv
dG9vbHBhbmVsL1BLAQIUABQAAAgAAO6OR08AAAAAAAAAAAAAAAAcAAAAAAAAAAAAAAAAADSzAABD
b25maWd1cmF0aW9uczIvcHJvZ3Jlc3NiYXIvUEsBAhQAFAAACAAA7o5HTwAAAAAAAAAAAAAAAB8A
AAAAAAAAAAAAAAAAbrMAAENvbmZpZ3VyYXRpb25zMi9pbWFnZXMvQml0bWFwcy9QSwECFAAUAAgI
CADujkdPMHByojMBAABdBAAAFQAAAAAAAAAAAAAAAACrswAATUVUQS1JTkYvbWFuaWZlc3QueG1s
UEsFBgAAAAARABEAkQQAACG1AAAAAA==
--00000000000062f1960594562929--
