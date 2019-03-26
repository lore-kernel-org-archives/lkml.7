Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE29C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079EC2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfCZDLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:11:10 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27114 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727394AbfCZDLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:11:10 -0400
X-UUID: 1acf4bcf862b45fa9f12a2f9a9d880b9-20190326
X-UUID: 1acf4bcf862b45fa9f12a2f9a9d880b9-20190326
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 284292820; Tue, 26 Mar 2019 11:10:56 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 26 Mar
 2019 11:10:53 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Mar 2019 11:10:53 +0800
Message-ID: <1553569852.21970.13.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] pinctrl: add drive for I2C related pins on MT8183
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <hui.liu@mediatek.com>, "Eddie Huang" <eddie.huang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <biao.huang@mediatek.com>,
        <hongzhou.yang@mediatek.com>, Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Date:   Tue, 26 Mar 2019 11:10:52 +0800
In-Reply-To: <CANMq1KBwjNxi2fMLFna5r0ak56+8paMq1YbLWHEScTzzLqf+Bw@mail.gmail.com>
References: <20190325122302.5483-1-zhiyong.tao@mediatek.com>
         <20190325122302.5483-5-zhiyong.tao@mediatek.com>
         <CANMq1KBwjNxi2fMLFna5r0ak56+8paMq1YbLWHEScTzzLqf+Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 11:25 -0700, Nicolas Boichat wrote:
> On Mon, Mar 25, 2019 at 5:23 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> >
> > This patch provides the advanced drive for I2C used pins on MT8183.
> > The detail strength specification description of the I2C pin:
> > When E1=0/E0=0, the strength is 0.125mA.
> > When E1=0/E0=1, the strength is 0.25mA.
> > When E1=1/E0=0, the strength is 0.5mA.
> > When E1=1/E0=1, the strength is 1mA.
> > For I2C pins, there are existing generic driving setup and the above
> > specific driving setup. I2C pins can only support 2/4/6/8/10/12/14/16mA
> > driving adjustment in generic driving setup. But in specific driving
> > setup, they can support 0.125/0.25/0.5/1mA adjustment.
> > If we enable specific driving setup for I2C pins,
> > the existing generic driving setup will be disabled.
> > For some special features, we need the I2C pins specific driving setup.
> > The specific driving setup is controlled by E1E0EN.
> > So we need add extra vendor driving preperty instead of the generic
> > driving property. We can add "mediatek,drive-strength-adv = <XXX>;"
> > to describe the specific driving setup property.
> > "XXX" means the value of E1E0EN. So the valid arguments of
> > "mediatek,drive-strength-adv" are from 0 to 7.
> >
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 47 ++++++++++++++++++++++
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 11 ++++++
> >  drivers/pinctrl/mediatek/pinctrl-paris.c         | 12 ++++++
> >  4 files changed, 120 insertions(+)
> >
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > index 6262fd3678ea..2c7409ed16fa 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > @@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
> >         PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
> >  };
> >
> > +static const struct mtk_pin_field_calc mt8183_pin_e1e0en_range[] = {
> > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 20, 1),
> > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 15, 1),
> > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 12, 1),
> > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 7, 1),
> > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 12, 1),
> > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 9, 1),
> > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 19, 1),
> > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 22, 1),
> > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 24, 1),
> > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 14, 1),
> > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 27, 1),
> > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 17, 1),
> > +};
> > +
> > +static const struct mtk_pin_field_calc mt8183_pin_e0_range[] = {
> > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 21, 1),
> > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 16, 1),
> > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 13, 1),
> > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 8, 1),
> > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 13, 1),
> > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 10, 1),
> > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 20, 1),
> > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 23, 1),
> > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 25, 1),
> > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 15, 1),
> > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 28, 1),
> > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 18, 1),
> > +};
> > +
> > +static const struct mtk_pin_field_calc mt8183_pin_e1_range[] = {
> > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 22, 1),
> > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 17, 1),
> > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 14, 1),
> > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 9, 1),
> > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 14, 1),
> > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 11, 1),
> > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 21, 1),
> > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 24, 1),
> > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 26, 1),
> > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 16, 1),
> > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 29, 1),
> > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 19, 1),
> > +};
> > +
> >  static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
> >         [PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
> >         [PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
> > @@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
> >         [PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
> >         [PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
> >         [PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
> > +       [PINCTRL_PIN_REG_DRV_EN] = MTK_RANGE(mt8183_pin_e1e0en_range),
> > +       [PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_e0_range),
> > +       [PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_e1_range),
> >  };
> >
> >  static const char * const mt8183_pinctrl_register_base_names[] = {
> > @@ -517,6 +565,8 @@ static const struct mtk_pin_soc mt8183_data = {
> >         .drive_get = mtk_pinconf_drive_get_rev1,
> >         .adv_pull_get = mtk_pinconf_adv_pull_get,
> >         .adv_pull_set = mtk_pinconf_adv_pull_set,
> > +       .adv_drive_get = mtk_pinconf_adv_drive_get,
> > +       .adv_drive_set = mtk_pinconf_adv_drive_set,
> >  };
> >
> >  static const struct of_device_id mt8183_pinctrl_of_match[] = {
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > index b1c368455d30..ef8732e8966b 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > @@ -674,3 +674,50 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
> >
> >         return 0;
> >  }
> > +
> > +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, u32 arg)
> > +{
> > +       int err;
> > +
> > +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN, arg & 1);
> 
> Should 1, 2, 4 masks be defined as masks somewhere above in this file?
> 
> > +       if (err)
> > +               return err;
> > +
> > +       if (arg & 1) {
> 
> It's the second time you use arg & 1.
> 
> Maybe define:
> int en = arg & 1;
> int e0 = !!(arg & 2);
> int e1 = !!(arg & 4);
> 
> Also, I feel that the code looks a little cleaner if you just return early here:
> if (!(arg & 1))
>    return err;

Thanks for your suggestion, we will change it in v4.
> 
> > +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0,
> > +                                      !!(arg & 2));
> > +               if (err)
> > +                       return err;
> > +
> > +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
> > +                                      !!(arg & 4));
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, u32 *val)
> 
> Is there any user for this function? If not, why do we even define it?
I should add it in the function "mtk_pinconf_get". It will use it.
We will add it in v4. Thanks for your suggestion.
> 
> > +{
> > +       u32 en, e0, e1;
> > +       int err;
> > +
> > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN, &en);
> > +       if (err)
> > +               return err;
> > +
> > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, &e0);
> > +       if (err)
> > +               return err;
> > +
> > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, &e1);
> > +       if (err)
> > +               return err;
> > +
> > +       *val = (e0 | e1 << 1 | en << 2) & 0x7;
> 
> I'm confused. Here, e0 is bit 0, e1 is bit 1, end is bit 2. But above
> in mtk_pinconf_adv_drive_set, it seems to be in this order: en, e0,
> e1?

==>the correct order is e1e0en, e1 is bit 2, e0 is bit 1, en is bit 0.
we will change it as "*val = (en | e0 << 1 | e1 << 2) & 0x7;" in v4.
> 
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > index 6d24522739d9..1b7da42aa1d5 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > @@ -63,6 +63,9 @@ enum {
> >         PINCTRL_PIN_REG_IES,
> >         PINCTRL_PIN_REG_PULLEN,
> >         PINCTRL_PIN_REG_PULLSEL,
> > +       PINCTRL_PIN_REG_DRV_EN,
> > +       PINCTRL_PIN_REG_DRV_E0,
> > +       PINCTRL_PIN_REG_DRV_E1,
> >         PINCTRL_PIN_REG_MAX,
> >  };
> >
> > @@ -224,6 +227,10 @@ struct mtk_pin_soc {
> >         int (*adv_pull_get)(struct mtk_pinctrl *hw,
> >                             const struct mtk_pin_desc *desc, bool pullup,
> >                             u32 *val);
> > +       int (*adv_drive_set)(struct mtk_pinctrl *hw,
> > +                            const struct mtk_pin_desc *desc, u32 arg);
> > +       int (*adv_drive_get)(struct mtk_pinctrl *hw,
> > +                            const struct mtk_pin_desc *desc, u32 *val);
> >
> >         /* Specific driver data */
> >         void                            *driver_data;
> > @@ -287,5 +294,9 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
> >  int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
> >                              const struct mtk_pin_desc *desc, bool pullup,
> >                              u32 *val);
> > +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, u32 arg);
> > +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, u32 *val);
> >
> >  #endif /* __PINCTRL_MTK_COMMON_V2_H */
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > index b59e10852bfb..dcd295f0eb4b 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > @@ -20,12 +20,14 @@
> >  #define MTK_PIN_CONFIG_RDSEL   (PIN_CONFIG_END + 2)
> >  #define MTK_PIN_CONFIG_PU_ADV  (PIN_CONFIG_END + 3)
> >  #define MTK_PIN_CONFIG_PD_ADV  (PIN_CONFIG_END + 4)
> > +#define MTK_PIN_CONFIG_DRV_ADV (PIN_CONFIG_END + 5)
> >
> >  static const struct pinconf_generic_params mtk_custom_bindings[] = {
> >         {"mediatek,tdsel",      MTK_PIN_CONFIG_TDSEL,           0},
> >         {"mediatek,rdsel",      MTK_PIN_CONFIG_RDSEL,           0},
> >         {"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,         1},
> >         {"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,       1},
> > +       {"mediatek,drive-strength-adv", MTK_PIN_CONFIG_DRV_ADV, 2},
> >  };
> >
> >  #ifdef CONFIG_DEBUG_FS
> > @@ -34,6 +36,7 @@ static const struct pin_config_item mtk_conf_items[] = {
> >         PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
> >         PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
> >         PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
> > +       PCONFDUMP(MTK_PIN_CONFIG_DRV_ADV, "drive-strengt-adv", NULL, true),
> 
> drive-strength-adv
> 
> >  };
> >  #endif
> >
> > @@ -311,6 +314,15 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> >                         return -ENOTSUPP;
> >                 }
> >                 break;
> > +       case MTK_PIN_CONFIG_DRV_ADV:
> > +               if (hw->soc->adv_drive_set) {
> > +                       err = hw->soc->adv_drive_set(hw, desc, arg);
> > +                       if (err)
> > +                               return err;
> > +               } else {
> > +                       return -ENOTSUPP;
> > +               }
> > +               break;
> >         default:
> >                 err = -ENOTSUPP;
> >         }
> > --
> > 2.12.5
> >


