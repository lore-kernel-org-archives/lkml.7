Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3549220840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Dbmg1bV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDBGQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:16:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46057 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbfDBGQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:16:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so13647857qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acqOcFwgrJ1SAcN/jNUV88PxCIESsoGFAYAa1b22QyE=;
        b=Dbmg1bV40IoP9vv258ghrRtTxtTi3IXTtQ1doi05ezmq+vEl//GKAFPEC4duHX/yMN
         pMWCG5apKeY0h7X1C0Z7V/tdzI0ikJtnrmFrOgTBeG1Ds1FKx7nn+OzAlRw9yFva1arL
         IGK/8Q9JGfhXtlx+R98z5hWHwO7EQTWfWKro18lxgYxfHFKUNRm+Cfha7rCw2VI0HFVO
         FJ+Q1CHGP7qlVadJK0lZxj82nUylmpMyMj6wTPv4VeDUTr1NpAwPsirNW0edqME0SLXY
         ZtOLU/6LTzx9zT02TmvPQkpbjPtZAKWvzPmMDTjOpFYXW9DodojvymJG77TuahOaIZq1
         TVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acqOcFwgrJ1SAcN/jNUV88PxCIESsoGFAYAa1b22QyE=;
        b=POR8ZsVRZ1ENTEji3k/JSj3zPZJXH97AvsNIknZlHCCz4xfvm22d2tPnf9Ld9CeuCu
         LirTCuqC8VQwic4ALP4clCgMYKzyDXLxVdWMpmxGyMoLpx81mOdblDpPUHnq+RQ5FNm9
         XvK9gfZW4Wsr0Nf5WLgsPVPo6WWjL+ePycYeJVObdqlfmqFLVg5PEmmXdAlWB8xX2moj
         G1KU3lh8rCpb8EoL2VR3arTsvTS4Ux8wuRrpHt+zyMj0arTzwwf59HvpTGaJ9ghNyWpv
         C9VCKI+7CiMCPqteg2+vV0KyOJrK7+6mZA4CG53OC/T5BtthzmmapHvgF4uCa+s5unG8
         m1cw==
X-Gm-Message-State: APjAAAUFEh6j2+gV5mkmcRzuc7aI3BICu/yzX7FcWzim4nPwocUhGQOe
        rlhGQguQ7UJzzvrLqVP2Sv+rfZkR/7nJGXA0VEXqRQ==
X-Google-Smtp-Source: APXvYqwhCa6eLRt4HIAkeWTbr7HXES9ZEq+HcLW3L9tQGjK4bJRDXFSkpF9MqzD9VQ5wiV4hAN4ODxHwRwKlMgEpv6k=
X-Received: by 2002:ac8:1a34:: with SMTP id v49mr57046152qtj.236.1554185792114;
 Mon, 01 Apr 2019 23:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20171121120422.GR22431@lahna.fi.intel.com> <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
 <20190327172940.GR3622@lahna.fi.intel.com> <20190328091729.GV9224@smile.fi.intel.com>
 <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
 <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com>
 <20190328123444.GX3622@lahna.fi.intel.com> <CAB4CAwcQTH5BiDDbzfFXTDDuYQ_fuDd_1tKkecf6vwygGQmn5w@mail.gmail.com>
 <20190401074953.GQ3622@lahna.fi.intel.com> <CAB4CAweW_3p4i_8ntscJyU9n55HwdLt3pxyT3Gf6SUSbZAJ8qA@mail.gmail.com>
 <20190401122256.GF9224@smile.fi.intel.com>
In-Reply-To: <20190401122256.GF9224@smile.fi.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 2 Apr 2019 14:16:19 +0800
Message-ID: <CAB4CAwd6+6+Qwb2wDFkVOc_auTNdrEw07tX2ha=XLvxfwFHRXw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over suspend/resume
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 8:23 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Apr 01, 2019 at 06:41:57PM +0800, Chris Chiu wrote:
>
> Thanks for the patch.
> My comments below.
>
> > diff --git a/drivers/pinctrl/intel/pinctrl-intel.c
> > b/drivers/pinctrl/intel/pinctrl-intel.c
> > index 8cda7b535b02..d1cfa5adef9b 100644
> > --- a/drivers/pinctrl/intel/pinctrl-intel.c
> > +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> > @@ -77,6 +77,7 @@ struct intel_pad_context {
> >         u32 padcfg0;
> >         u32 padcfg1;
> >         u32 padcfg2;
>
> > +       u32 hostown;
>
> This is wrong. We have one register per entire (*) group of pins to keep host
> ownership. Basically it's a mask.
>
> *) if it's <= 32, otherwise there are more registers. But in any case it's 1
> bit per pin, and not 32 bits.
>
> >         for (i = 0; i < pctrl->soc->npins; i++)
>
> Thus, the actual actions should mimic what we do for interrupt mask.
>
> --
> With Best Regards,
> Andy Shevchenko
>

Thanks for the comment. My first version did mimic the logic of the interrupt
mask restore but it was based on the DMI quirk. It saves HOSTSW_OWN
for each padgroup and restores them all after resume if DMI info matched.

What really confused me is how to do this specifically for a requested GPIO
pin. So here's my new proposed patch. Please suggests if there's any better
idea. Thanks.

--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -81,6 +81,7 @@ struct intel_pad_context {

 struct intel_community_context {
        u32 *intmask;
+       u32 *hostown;
 };

 struct intel_pinctrl_context {
@@ -117,6 +118,10 @@ struct intel_pinctrl {
 #define pin_to_padno(c, p)     ((p) - (c)->pin_base)
 #define padgroup_offset(g, p)  ((p) - (g)->base)

+#ifdef CONFIG_PM_SLEEP
+static void intel_save_hostown(struct intel_pinctrl *pctrl, unsigned int pin);
+#endif
+
 static struct intel_community *intel_get_community(struct intel_pinctrl *pctrl,
                                                   unsigned int pin)
 {
@@ -456,7 +461,9 @@ static int intel_gpio_request_enable(struct
pinctrl_dev *pctldev,
        intel_gpio_set_gpio_mode(padcfg0);
        /* Disable TX buffer and enable RX (this will be input) */
        __intel_gpio_set_direction(padcfg0, true);
+#ifdef CONFIG_PM_SLEEP
+       intel_save_hostown(pctrl, pin);
+#endif
        raw_spin_unlock_irqrestore(&pctrl->lock, flags);

        return 0;
@@ -1284,7 +1291,7 @@ static int intel_pinctrl_pm_init(struct
intel_pinctrl *pctrl)

        for (i = 0; i < pctrl->ncommunities; i++) {
                struct intel_community *community = &pctrl->communities[i];
-               u32 *intmask;
+               u32 *intmask, *hostown;

                intmask = devm_kcalloc(pctrl->dev, community->ngpps,
                                       sizeof(*intmask), GFP_KERNEL);
@@ -1292,6 +1299,13 @@ static int intel_pinctrl_pm_init(struct
intel_pinctrl *pctrl)
                        return -ENOMEM;

                communities[i].intmask = intmask;
+
+               hostown = devm_kcalloc(pctrl->dev, community->ngpps,
+                                      sizeof(*hostown), GFP_KERNEL);
+               if (!hostown)
+                       return -ENOMEM;
+
+               communities[i].hostown= hostown;
        }

        pctrl->context.pads = pads;
@@ -1447,6 +1461,43 @@ int intel_pinctrl_probe_by_uid(struct
platform_device *pdev)
 EXPORT_SYMBOL_GPL(intel_pinctrl_probe_by_uid);

 #ifdef CONFIG_PM_SLEEP
+static void intel_save_hostown(struct intel_pinctrl *pctrl, unsigned int pin)
+{
+       const struct intel_community *community;
+       const struct intel_padgroup *padgrp;
+       int i;
+
+       community = intel_get_community(pctrl, pin);
+       if (!community)
+               return;
+       if (!community->hostown_offset)
+               return;
+
+       padgrp = intel_community_get_padgroup(community, pin);
+       if (!padgrp)
+               return;
+
+       for (i = 0; i < pctrl->ncommunities; i++) {
+               const struct intel_community *comm = &pctrl->communities[i];
+               int j;
+
+               for (j = 0; j < comm->ngpps; j++) {
+                       const struct intel_padgroup *pgrp = &comm->gpps[j];
+
+                       if (padgrp == pgrp) {
+                               struct intel_community_context *communities;
+                               void __iomem *base;
+
+                               communities = pctrl->context.communities;
+                               base = community->regs +
community->hostown_offset;
+                               communities[i].hostown[j] = readl(base + j * 4);
+                               break;
+                       }
+               }
+       }
+       return;
+}
+
 static bool intel_pinctrl_should_save(struct intel_pinctrl *pctrl,
unsigned int pin)
 {
        const struct pin_desc *pd = pin_desc_get(pctrl->pctldev, pin);
@@ -1588,6 +1639,17 @@ int intel_pinctrl_resume(struct device *dev)
                        dev_dbg(dev, "restored mask %d/%u %#08x\n", i, gpp,
                                readl(base + gpp * 4));
                }
+
+               base = community->regs + community->hostown_offset;
+               for (gpp = 0; gpp < community->ngpps; gpp++) {
+                       if (communities[i].hostown[gpp] &&
+                           communities[i].hostown[gpp] != readl(base
+ gpp * 4)) {
+                               writel(communities[i].hostown[gpp],
base + gpp * 4);
+                               dev_warn(dev, "hostown changed after resume\n");
+                               dev_dbg(dev, "restored hostown %d/%u
%#08x\n", i, gpp,
+                                       readl(base + gpp * 4));
+                       }
+               }
        }

        return 0;
