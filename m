Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02479CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CCB20679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5CNyEH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440730AbfJYP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:27:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51713 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440654AbfJYP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:27:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id q70so2595255wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCss/7sQ1HSQl3wdXs28HsmigxCT/sGmn1VxblcDWXM=;
        b=M5CNyEH1B6nmtZ81nmXhqnFcgegp3RnjyMLBute0xecp1fqzIGe5xWc+z4IZbSy/3J
         SW3Zj0eyCAkNFX5wwIBb+bEz5SxYHgr6L5c+QVnMRz9i1c9itrLlDiE1hB6NynVIWsaU
         KX3SEaUtdVk7ALfufiNqFlxTUkDixKyxhuTBzyj+at8wdAh2h/AmJuwoQfEefOp8MgLf
         wxwzcXDnW53J6OE17VC8knXIJ67SI4GHDbXMk4alKysghqdTvC7yiMJYjuujWfPT/hEJ
         zoqSTwzpQYt6PK58CYh4u6+OsNlZBE7GLYZasDw1OJrMJ2bPmusiGbTUXe1CJCfICzZZ
         BkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCss/7sQ1HSQl3wdXs28HsmigxCT/sGmn1VxblcDWXM=;
        b=tecND9dfqD4hjnT5MOIy76H7pJu80yoPZWUHUmBbUP1mpXqr9P0Isl+Bq/GxFyDqQ7
         8Rk62I+wG+pSdSnarkU57iEg62dU1ULGB1q6Zp2tq3hr6IYq1FTH3AM7df2VcqIfipRa
         tOoGEbQFyzVXJ1K8VBua+1IWAZgmRGkDZCkVsa/3d8EifIUWICxsAr2KX6w3JISQSaeD
         GS3TB0b2ozmhdrpB8l6FwtF7h9a1J9mbCKjT3bpGMU9j6dPsO/5a4OtLcxcB1rsTVQRI
         f6fX9c9A/x55X3EitQGr4u3lVsu2kXz7sPLAP3iEuAyXTMUq7NLg5ju9zFUVqEt05M2w
         Goog==
X-Gm-Message-State: APjAAAU2hSzqHg68T8O/L61uIW2WGem3diZZOp/JSURve+u6VpFA86fo
        i3YUa44trwj5ycX56c4L1L4S6qxTCP3PjB3Ajto=
X-Google-Smtp-Source: APXvYqwoGUe7u+dXsWJItWQDokq3RCnotk8ohfPs7jL3je17F27nCi8iQK7nc7QplUsoLhf+L4T5gPMcWdapR+l/NWM=
X-Received: by 2002:a1c:1d53:: with SMTP id d80mr3135648wmd.88.1572017227113;
 Fri, 25 Oct 2019 08:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com> <20191025121737.GC4568@sirena.org.uk>
In-Reply-To: <20191025121737.GC4568@sirena.org.uk>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 17:26:56 +0200
Message-ID: <CAHtQpK60d_GT4JMBBwGc2q1FqVT7NNhK5T7rSY0GL288ukUc1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something went wrong (mainly with me pressing wrong buttons), so I
managed to pull the conversation off the list. I'd duplicate my
answers here with comments from Mark, first being:

On Fri, Oct 25, 2019 at 4:43 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 25, 2019 at 03:55:17PM +0200, Andrey Zhizhikin wrote:
> > On Fri, Oct 25, 2019 at 2:17 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
>
> Please don't take things off-list unless there is a really strong reason
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.  (From some of the things
> in your mail I think this might've been unintentional.)
>

Sorry for mess, sometimes it happens but I try not to create it...

On Fri, Oct 25, 2019 at 2:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
>
> > +       Only select this regulator driver if the MFD part is selected
> > +       in the Kernel configuration, it is meant to be operable as a cell.
>
> This i what Kconfig dependencies are for.

True, would re-phrase to description.

>
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * intel-cht-wc-regulator.c - CherryTrail regulator driver
> > + *
>
> Please use C++ style for the entire comment so things look more
> consistent.

This is what I'm puzzled about - which style to use for the file
header since the introduction of SPDX and a rule that it should be
"C++ style" commented for source files and "C style" for header files.
After this introduction, should the more-or-less standard header be
also done in C++ style? I saw different source files are doing
different things... But all-in-all I would follow you advise here with
converting entire block to C++.

[Mark]: The only thing SPDX cares about is the first line, the making
the rest of the block a C++ one is mostly a preference I have.

Got it, would be done!

>
> > +#define CHT_WC_VPROG1A_VRANGE        53
> > +#define CHT_WC_VPROG1B_VRANGE        53
> > +#define CHT_WC_VPROG1F_VRANGE        53
> > +#define CHT_WC_V1P8SX_VRANGE 53
> > +#define CHT_WC_V1P2SX_VRANGE 53
> > +#define CHT_WC_V1P2A_VRANGE  53
> > +#define CHT_WC_VSDIO_VRANGE  53
> > +#define CHT_WC_V2P8SX_VRANGE 53
> > +#define CHT_WC_V3P3SD_VRANGE 53
> > +#define CHT_WC_VPROG2D_VRANGE        53
> > +#define CHT_WC_VPROG3A_VRANGE        53
> > +#define CHT_WC_VPROG3B_VRANGE        53
> > +#define CHT_WC_VPROG4A_VRANGE        53
> > +#define CHT_WC_VPROG4B_VRANGE        53
> > +#define CHT_WC_VPROG4C_VRANGE        53
> > +#define CHT_WC_VPROG4D_VRANGE        53
> > +#define CHT_WC_VPROG5A_VRANGE        53
> > +#define CHT_WC_VPROG5B_VRANGE        53
> > +#define CHT_WC_VPROG6A_VRANGE        53
> > +#define CHT_WC_VPROG6B_VRANGE        53
>
> These appear to be identical - is this not just a bunch of
> instantiations of the same IPs

That was done for "macro convenience". I would definitely re-work this part.

>
> > +/* voltage tables */
> > +static unsigned int CHT_WC_V3P3A_VSEL_TABLE[CHT_WC_V3P3A_VRANGE],
> > +                 CHT_WC_V1P8A_VSEL_TABLE[CHT_WC_V1P8A_VRANGE],
> > +                 CHT_WC_V1P05A_VSEL_TABLE[CHT_WC_V1P05A_VRANGE],
> > +                 CHT_WC_VDDQ_VSEL_TABLE[CHT_WC_VDDQ_VRANGE],
> > +                 CHT_WC_V1P8SX_VSEL_TABLE[CHT_WC_V1P8SX_VRANGE],
> > +                 CHT_WC_V1P2SX_VSEL_TABLE[CHT_WC_V1P2SX_VRANGE],
> > +                 CHT_WC_V1P2A_VSEL_TABLE[CHT_WC_V1P2A_VRANGE],
> > +                 CHT_WC_V2P8SX_VSEL_TABLE[CHT_WC_V2P8SX_VRANGE],
> > +                 CHT_WC_V3P3SD_VSEL_TABLE[CHT_WC_V3P3SD_VRANGE],
> > +                 CHT_WC_VPROG1A_VSEL_TABLE[CHT_WC_VPROG1A_VRANGE],
> > +                 CHT_WC_VPROG1B_VSEL_TABLE[CHT_WC_VPROG1B_VRANGE],
> > +                 CHT_WC_VPROG1F_VSEL_TABLE[CHT_WC_VPROG1F_VRANGE],
> > +                 CHT_WC_VPROG2D_VSEL_TABLE[CHT_WC_VPROG2D_VRANGE],
> > +                 CHT_WC_VPROG3A_VSEL_TABLE[CHT_WC_VPROG3A_VRANGE],
> > +                 CHT_WC_VPROG3B_VSEL_TABLE[CHT_WC_VPROG3B_VRANGE],
> > +                 CHT_WC_VPROG4A_VSEL_TABLE[CHT_WC_VPROG4A_VRANGE],
> > +                 CHT_WC_VPROG4B_VSEL_TABLE[CHT_WC_VPROG4B_VRANGE],
> > +                 CHT_WC_VPROG4C_VSEL_TABLE[CHT_WC_VPROG4C_VRANGE],
> > +                 CHT_WC_VPROG4D_VSEL_TABLE[CHT_WC_VPROG4D_VRANGE],
> > +                 CHT_WC_VPROG5A_VSEL_TABLE[CHT_WC_VPROG5A_VRANGE],
> > +                 CHT_WC_VPROG5B_VSEL_TABLE[CHT_WC_VPROG5B_VRANGE],
> > +                 CHT_WC_VPROG6A_VSEL_TABLE[CHT_WC_VPROG6A_VRANGE],
> > +                 CHT_WC_VPROG6B_VSEL_TABLE[CHT_WC_VPROG6B_VRANGE];
>
> Please write a series of individual variable declarations, the
> above way of writing things is very unusual and hence confusing
> to read.  Though like I say it looks like the tables are mostly
> identical so you probably only need a much smaller number of
> tables, one per IP.

Agreed, would be re-worked as well.

>
> > +/*
> > + * The VSDIO regulator should only support 1.8V and 3.3V. All other
> > + * voltages are invalid for sd card, so disable them here.
> > + */
> > +static unsigned int CHT_WC_VSDIO_VSEL_TABLE[CHT_WC_VSDIO_VRANGE] = {
> > +     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > +     0, 0, 0, 0, 0, 0, 0, 0, 1800000, 0, 0, 0,
> > +     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > +     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > +     0, 0, 3300000, 0, 0
> > +};
>
> Is this really a limitation of the *regulator* or is it a
> limitation of the consumer?  The combination of the way this is
> written and the register layout makes it look like it's a
> consumer limitation in which case leave it up to the consumer to
> figure out what constraints it has.

This is a tricky point. Since there is no datasheet available from
Intel on this IP - I went with a safe option of taking this part from
original Intel patch, which they did for Aero board as the range was
described there in exactly this way. I am totally unsure if the
regulator does not provide all voltages, or this limit is purely
artificial here. Nevertheless, according to SD specification this
regulator should only operate with only those two voltage levels: 1v8
and 3v3 and consumers (mmc) should be well aware of this.

[Mark]: There's always the possibility that someone builds a board
with something else attached to the regulator if they don't want to
use SD cards for example.

I would re-work this to map all voltage ranges here properly, so there
would be no further confusions.

[Mark]: OK

>
> > +/* List the SD card interface as a consumer of vqmmc voltage source from VSDIO
> > + * regulator. This is the only interface that requires this source on Cherry
> > + * Trail to operate with UHS-I cards.
> > + */
> > +static struct regulator_consumer_supply cht_wc_vqmmc_supply_consumer[] = {
> > +     REGULATOR_SUPPLY("vqmmc", "80860F14:02"),
> > +};
>
> This looks like board specific configuration so should be defined
> in the board.
>
> > +static struct regulator_init_data vqmmc_init_data = {
> > +     .constraints = {
> > +             .min_uV                 = 1800000,
> > +             .max_uV                 = 3300000,
> > +             .valid_ops_mask         = REGULATOR_CHANGE_VOLTAGE |
> > +                                     REGULATOR_CHANGE_STATUS,
> > +             .valid_modes_mask       = REGULATOR_MODE_NORMAL,
> > +             .settling_time          = 20000,
> > +     },
> > +     .num_consumer_supplies  = ARRAY_SIZE(cht_wc_vqmmc_supply_consumer),
> > +     .consumer_supplies      = cht_wc_vqmmc_supply_consumer,
> > +};
>
> This *definitely* appears to be board specific configuration and
> should be defined for the board.

Above those two points above: I totally agree this is not the
regulator configuration but rather a specific board one. The only
thing I was not able to locate is a correct board file to put this
into.

Maybe you or Hans can guide me here on where to have this code as best?

[Mark]: I *think* drivers/platform/x86 might be what you're looking
for but I'm not super familiar with x86.  There's also
arch/x86/platform but I think they're also trying to push things out
of arch/.

>
> > +static int cht_wc_regulator_enable(struct regulator_dev *rdev)
> > +{
> > +     struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
>
> regulator_enable_regmap()

Agreed, would re-work this.

>
> > +static int cht_wc_regulator_disable(struct regulator_dev *rdev)
> > +{
> > +     struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
>
> regulator_disable_regmap()

... and this as well.

>
> > +static int cht_wc_regulator_is_enabled(struct regulator_dev *rdev)
> > +{
> > +     struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
> > +     int rval;
>
> This looks like it's a get_status() operation (reading back the
> actual staus of the regulator rather than if we asked for it to
> be enabled or disabled).

Yes, this is actually a get_status. Would re-work it.

>
> > +static int cht_wc_regulator_read_voltage_sel(struct regulator_dev *rdev)
> > +{
>
> regulator_get_voltage_sel_regmap()
>
> > +static int cht_wc_regulator_set_voltage_sel(struct regulator_dev *rdev,
> > +             unsigned int selector)
>
> regulator_set_voltage_sel_regmap()

I'd revise the whole regulator core API usage from comments above, as
I see now the driver code could be simplified dramatically.

>
> > +static void initialize_vtable(struct ch_wc_regulator_info *reg_info)
> > +{
> > +     unsigned int i, volt;
> > +
> > +     if (reg_info->runtime_table == true) {
> > +             for (i = 0; i < reg_info->nvolts; i++) {
> > +                     volt = reg_info->min_mV + (i * reg_info->scale);
> > +                     if (volt < reg_info->min_mV)
> > +                             volt = reg_info->min_mV;
> > +                     if (volt > reg_info->max_mV)
> > +                             volt = reg_info->max_mV;
> > +                     /* set value in uV */
> > +                     reg_info->vtable[i] = volt*1000;
> > +             }
> > +     }
> > +     reg_info->desc.volt_table = reg_info->vtable;
> > +     reg_info->desc.n_voltages = reg_info->nvolts;
> > +}
>
> This looks like you've got a linear range so you should be using
> regulator_map_voltage_linear and regulator_list_voltage_linear.

Yes, you're absolutely right, I've missed this one out. Would use a
proper API here as well.

>
> > +     regulator->rdev = regulator_register(&reg_info->desc, &config);
>
> devm_regulator_register()

Yeap, and consecutively devm_regulator_unregister() in
cht_wc_regulator_remove call.

[Mark]: With devm_ you don't even need to explicitly unregister so the
entire remove function can go.

>
> > +static int __init cht_wc_regulator_init(void)
> > +{
> > +     return platform_driver_register(&cht_wc_regulator_driver);
> > +}
> > +subsys_initcall_sync(cht_wc_regulator_init);
>
> Why subsys_initcall() and not just module_platform_driver?
> Deferred probe should work fine for regulators.

Got it, would correct this as well.

Overall, I would definitely work on a v2 here for both the regulator
and mfd cell part. If anyone has additional comment - please share
them here so I would gladly take them in!

Thanks a lot to all of you for reviewing this set!

--
Regards,
Andrey.
