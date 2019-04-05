Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0AFC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E502171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVLFF2Kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfDESYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:24:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53143 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDESYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:24:36 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so658141itf.2;
        Fri, 05 Apr 2019 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBH+SM2bujZl+JdQv/2UTLvGpSmzd0ZUmsO/Su9EDfI=;
        b=oVLFF2Kz0l8a9o/Px6t0HdrWGCx1wkhpgOC3B6bnGthmBvU2Z7kK6xmFwP3hAPjclG
         qBvpcX5WG0VjJEl4/iF4ZjBfQPg241h2Of196TMuMEdM2uOdWXfEtPYkFsSbdypsgccW
         kw1Hk0EY9Yzfdno33uxPhwaEc1dIV3apQF89Ky/Wy/zMPOLRdwXkriOzyv9EogSr/ZPT
         7AaC2J037moznM07kAvS5QQzP2oWgHxNRCN4a5aQAiAB1vnhC2EkNyAPosm72Slj+BOG
         0JWvm2Ct/K/W1SSDdZp6654xJ9MAiFPIYbG2iish9vqeR1288VQpPxz6yatmzW7edORu
         zaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBH+SM2bujZl+JdQv/2UTLvGpSmzd0ZUmsO/Su9EDfI=;
        b=VaFl1rskBySY6mBHFTbwJV5C/8DRedOHSI+gHD2ZtP3QC786rvR05vBkv8HVp6Ke62
         I8TGgmDP/d8+u52I0/H/dRXamMf8uQhd82okG4KryL33iBAldFM6qulp85ose4V3XCES
         802Oighev2uY+8eBxqEVsuA2boCyd6ksfmHqz7B7LA7Xk48w+3f9T29772sQFrgwEcBl
         5JMV49CMN0p+29p1J6k+xH9uyU+IcCEZg7twVJWZ3Hf5a0Kcir925VkFl0FwJeNm1bn8
         UNvqmP4PiOyQ21lz7PKr6LltvD5Y5Eaq9/HyCOuGFJ14fmQ7pW5l2mPKhqF1K3Un6Xzd
         usOw==
X-Gm-Message-State: APjAAAVBmI+mBMSxGKca77KLHB4grE/rUJlPhvQ69N3M97PjX7DsENLO
        vrCq3RXvUrGXs+SRBI91zegjVLF/xOjUTGjS+SU=
X-Google-Smtp-Source: APXvYqw7TJRCJBKcVNv44BjfkyvqRYVu62NdtcJcwHNfMeAZESTZ0Dfc5shrPxJXanjn1ubL06hH2bj1hlc7eiFDYI4=
X-Received: by 2002:a24:4702:: with SMTP id t2mr10063693itb.105.1554488674894;
 Fri, 05 Apr 2019 11:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-10-andrew.smirnov@gmail.com> <52c33c26-47fa-04d2-0808-65a53fd2c804@linaro.org>
In-Reply-To: <52c33c26-47fa-04d2-0808-65a53fd2c804@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 11:24:23 -0700
Message-ID: <CAHQ1cqGbBXdQBagcKH211N0GkBzQzsutbu6=FMLLxZoL8pL8bA@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] thermal: qoriq: Convert driver to use regmap API
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:47 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Convert driver to use regmap API, drop custom LE/BE IO helpers and
> > simplify bit manipulation using regmap_update_bits(). This also allows
> > us to convert some register initialization to use loops and adds
> > convenient debug access to TMU registers via debugfs.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 159 +++++++++++++++-----------------
> >  1 file changed, 74 insertions(+), 85 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 4f9a2543f9c3..a909acee4354 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > +#include <linux/regmap.h>
> >  #include <linux/thermal.h>
> >
> >  #include "thermal_core.h"
> > @@ -17,48 +18,27 @@
> >  /*
> >   * QorIQ TMU Registers
> >   */
> > -struct qoriq_tmu_site_regs {
> > -     u32 tritsr;             /* Immediate Temperature Site Register */
> > -     u32 tratsr;             /* Average Temperature Site Register */
> > -     u8 res0[0x8];
> > -};
> >
> > -struct qoriq_tmu_regs {
> > -     u32 tmr;                /* Mode Register */
> > +#define REGS_TMR     0x000   /* Mode Register */
> >  #define TMR_DISABLE  0x0
> >  #define TMR_ME               0x80000000
> >  #define TMR_ALPF     0x0c000000
> > -     u32 tsr;                /* Status Register */
> > -     u32 tmtmir;             /* Temperature measurement interval Register */
> > +
> > +#define REGS_TMTMIR  0x008   /* Temperature measurement interval Register */
> >  #define TMTMIR_DEFAULT       0x0000000f
> > -     u8 res0[0x14];
> > -     u32 tier;               /* Interrupt Enable Register */
> > +
> > +#define REGS_TIER    0x020   /* Interrupt Enable Register */
> >  #define TIER_DISABLE 0x0
> > -     u32 tidr;               /* Interrupt Detect Register */
> > -     u32 tiscr;              /* Interrupt Site Capture Register */
> > -     u32 ticscr;             /* Interrupt Critical Site Capture Register */
> > -     u8 res1[0x10];
> > -     u32 tmhtcrh;            /* High Temperature Capture Register */
> > -     u32 tmhtcrl;            /* Low Temperature Capture Register */
> > -     u8 res2[0x8];
> > -     u32 tmhtitr;            /* High Temperature Immediate Threshold */
> > -     u32 tmhtatr;            /* High Temperature Average Threshold */
> > -     u32 tmhtactr;   /* High Temperature Average Crit Threshold */
> > -     u8 res3[0x24];
> > -     u32 ttcfgr;             /* Temperature Configuration Register */
> > -     u32 tscfgr;             /* Sensor Configuration Register */
> > -     u8 res4[0x78];
> > -     struct qoriq_tmu_site_regs site[SITES_MAX];
> > -     u8 res5[0x9f8];
> > -     u32 ipbrr0;             /* IP Block Revision Register 0 */
> > -     u32 ipbrr1;             /* IP Block Revision Register 1 */
> > -     u8 res6[0x310];
> > -     u32 ttr0cr;             /* Temperature Range 0 Control Register */
> > -     u32 ttr1cr;             /* Temperature Range 1 Control Register */
> > -     u32 ttr2cr;             /* Temperature Range 2 Control Register */
> > -     u32 ttr3cr;             /* Temperature Range 3 Control Register */
> > -};
> >
> > +#define REGS_TTCFGR  0x080   /* Temperature Configuration Register */
> > +#define REGS_TSCFGR  0x084   /* Sensor Configuration Register */
> > +
> > +#define REGS_TRITSR(n)       (0x100 + 16 * (n)) /* Immediate Temperature
> > +                                         * Site Register
> > +                                         */
> > +#define REGS_TTRnCR(n)       (0xf10 + 4 * (n)) /* Temperature Range n
> > +                                        * Control Register
> > +                                        */
> >  /*
> >   * Thermal zone data
> >   */
> > @@ -67,8 +47,7 @@ struct qoriq_sensor {
> >  };
> >
> >  struct qoriq_tmu_data {
> > -     struct qoriq_tmu_regs __iomem *regs;
> > -     bool little_endian;
> > +     struct regmap *regmap;
> >       struct qoriq_sensor     sensor[SITES_MAX];
> >  };
> >
> > @@ -77,29 +56,13 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
> >       return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
> >  }
> >
> > -static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
> > -{
> > -     if (p->little_endian)
> > -             iowrite32(val, addr);
> > -     else
> > -             iowrite32be(val, addr);
> > -}
> > -
> > -static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
> > -{
> > -     if (p->little_endian)
> > -             return ioread32(addr);
> > -     else
> > -             return ioread32be(addr);
> > -}
> > -
> >  static int tmu_get_temp(void *p, int *temp)
> >  {
> >       struct qoriq_sensor *qsensor = p;
> >       struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
> >       u32 val;
> >
> > -     val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
> > +     regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
> >       *temp = (val & 0xff) * 1000;
> >
> >       return 0;
> > @@ -134,7 +97,8 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >
> >       /* Enable monitoring */
> >       if (sites != 0)
> > -             tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
> > +             regmap_write(qdata->regmap, REGS_TMR,
> > +                          sites | TMR_ME | TMR_ALPF);
> >
> >       return 0;
> >  }
> > @@ -153,10 +117,8 @@ static int qoriq_tmu_calibration(struct device *dev,
> >       }
> >
> >       /* Init temperature range registers */
> > -     tmu_write(data, range[0], &data->regs->ttr0cr);
> > -     tmu_write(data, range[1], &data->regs->ttr1cr);
> > -     tmu_write(data, range[2], &data->regs->ttr2cr);
> > -     tmu_write(data, range[3], &data->regs->ttr3cr);
> > +     for (i = 0; i < ARRAY_SIZE(range); i++)
> > +             regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
> >
> >       calibration = of_get_property(np, "fsl,tmu-calibration", &len);
> >       if (calibration == NULL || len % 8) {
> > @@ -166,9 +128,9 @@ static int qoriq_tmu_calibration(struct device *dev,
> >
> >       for (i = 0; i < len; i += 8, calibration += 2) {
> >               val = of_read_number(calibration, 1);
> > -             tmu_write(data, val, &data->regs->ttcfgr);
> > +             regmap_write(data->regmap, REGS_TTCFGR, val);
> >               val = of_read_number(calibration + 1, 1);
> > -             tmu_write(data, val, &data->regs->tscfgr);
> > +             regmap_write(data->regmap, REGS_TSCFGR, val);
> >       }
> >
> >       return 0;
> > @@ -177,15 +139,32 @@ static int qoriq_tmu_calibration(struct device *dev,
> >  static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
> >  {
> >       /* Disable interrupt, using polling instead */
> > -     tmu_write(data, TIER_DISABLE, &data->regs->tier);
> > +     regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
> >
> >       /* Set update_interval */
> > -     tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
> > +     regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
> >
> >       /* Disable monitoring */
> > -     tmu_write(data, TMR_DISABLE, &data->regs->tmr);
> > +     regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
> >  }
> >
> > +static const struct regmap_range qiriq_yes_ranges[] = {
> > +     regmap_reg_range(REGS_TMR, REGS_TSCFGR),
> > +     regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
> > +     /* Read only registers below */
> > +     regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
> > +};
> > +
> > +static const struct regmap_access_table qiriq_wr_table = {
> > +     .yes_ranges     = qiriq_yes_ranges,
> > +     .n_yes_ranges   = ARRAY_SIZE(qiriq_yes_ranges) - 1,
> > +};
> > +
> > +static const struct regmap_access_table qiriq_rd_table = {
> > +     .yes_ranges     = qiriq_yes_ranges,
> > +     .n_yes_ranges   = ARRAY_SIZE(qiriq_yes_ranges),
> > +};
>
> As the table are the same, it would make sense to fold both structure to
> a single one (and s/qiriq/qoriq/ ?)
>

Writable registers are a subset of readable registers and n_yes_ranges
is different between the two. Not sure how I could fold the two into a
single struct. Will definitely fix the typo.

Thanks,
Andrey Smirnov
