Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7836C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B78720855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="tsHzbEjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDDNGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:06:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34860 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDNGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:06:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so3093485qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4mm242+NcoTu7Kb85rV7/dNDgHZFPpBv+0EOR3M1v0=;
        b=tsHzbEjTOM+8xtRK58vZSG6Eq4tY5RIgirZ2v33ZfMde7VUzAXIy09bk4z/XlslNsF
         znrCMd91JXSAYTlVaPqqa2kduJmQOx5K8WhJQ4S2DhSV+b26i4VXxjDLYL3OiQQDLNko
         7DBdRlMdjXoTFi7s9ZAwqlRR0CP090TWWxgBBmnb53S10Zeza24PpTwaGRdcAGUEr49M
         jGlDO2p5DbhfPT0e7vscNCeLCum3uXWauKVIT2u7XN9FSt/FbO0U+hv1Q40rZ4kF+toj
         7xzwBjygy/TRDkjU+M0q35oz2erzTD67nrq5gu4QXs8q9LxcfsY7VgYAt/3coLtEg6Jh
         7Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4mm242+NcoTu7Kb85rV7/dNDgHZFPpBv+0EOR3M1v0=;
        b=l7GBK78NVcsvKl7lwJ8O79FQvYLfHutw4Ag+yCW6fudi6DxWs1iLQKYjPlcqiTXbOW
         99LtFRMYE6UHhksiNBkU0XC18ykCqfj4HEkFHBfWmZfKnDltflOgZVnAn4cqyMJGHIhk
         7KhlpOp+V3lh+FJxn5l4vTY1ZZjLR+mQllQwTrCyiSTybfhxnQtEQtDfcW7g2YVDWsKb
         1wKmaDfM0Ssh+koFTr4Y7xstyqLRRA4qkO8WqMt3+ZeKXY5ayOmfPeH6O0Zu6gthN8jQ
         rZXzWgLr2xqjTFiG2Rw4ow2xgWDh3/WwkY4AJmtjIYkxCLPnX/BqAJ4GUtkYa+Oh+jLs
         j0yA==
X-Gm-Message-State: APjAAAXk4xxvFU0ikbcqJEAGdnFAy1RqVnWM3FqRPCEtNF4L9lACnVBM
        H4yIshuVr16hSQRwAIgTlk2Ld/lMIE1qJRAG6LCZnw==
X-Google-Smtp-Source: APXvYqwNXFOvAiw9fSbCVBWu3hmv0SRf+sYOjWMiQZlQEceIBb5LaQ93/OemFtyIAcHa9rploOSGyrMLBnRZWdWn5tI=
X-Received: by 2002:ac8:3307:: with SMTP id t7mr5326815qta.153.1554383176897;
 Thu, 04 Apr 2019 06:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
 <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com>
 <20190328123444.GX3622@lahna.fi.intel.com> <CAB4CAwcQTH5BiDDbzfFXTDDuYQ_fuDd_1tKkecf6vwygGQmn5w@mail.gmail.com>
 <20190401074953.GQ3622@lahna.fi.intel.com> <CAB4CAweW_3p4i_8ntscJyU9n55HwdLt3pxyT3Gf6SUSbZAJ8qA@mail.gmail.com>
 <20190401122256.GF9224@smile.fi.intel.com> <CAB4CAwd6+6+Qwb2wDFkVOc_auTNdrEw07tX2ha=XLvxfwFHRXw@mail.gmail.com>
 <20190402115836.GL9224@smile.fi.intel.com> <CAB4CAwe7n5XsRNS-ZoJL1K7dHLpRrwNReBCCMXjDWCtxYaqfdQ@mail.gmail.com>
 <20190403130640.GD9224@smile.fi.intel.com>
In-Reply-To: <20190403130640.GD9224@smile.fi.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 4 Apr 2019 21:06:04 +0800
Message-ID: <CAB4CAweo6uSbn2hY-YbnPqWPBShAYwfGhfOosHL+oL_EE=8L9A@mail.gmail.com>
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

On Wed, Apr 3, 2019 at 9:06 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 03, 2019 at 03:06:43PM +0800, Chris Chiu wrote:
> > On Tue, Apr 2, 2019 at 7:58 PM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
>
> > > Instead you may need to loop over each pin in the part of the group related to
> > > one 32-bit HOSTSW_OWN register (i.e. 8, see PADOWN_*() macros in the driver),
> > > check if it's requested and break a loop. If loop index is off-by-one a limit,
> > > nothing to do, otherwise restore hostown register.
> > >
> > > More pedantic approach is to collect the mask inside the loop and apply it.
> > >
> > > The check function name is gpiochip_is_requested().
> > >
> > > (One of Intel's drivers which is using that at ->resume() is
> > >  drivers/gpio/gpio-lynxpoint.c)
> > >
> > > P.S. I prefer pedantic approach. The simplification one is showed in order to
> > > give you an idea.
>
> > Thanks for your great comment. I remove the useless hostown save function
> > and make the following change in ->resume() to detect and restore the abnormal
> > HOSTSW_OWN. Please help comment if there're still problems. Thanks.
>
>
> This better to make as a separate helper function
>
> static u32 intel_gpio_is_requested(chip, base, size)
> {
>         u32 requested = 0;
>         unsigned int i;
>
>         for () {
>                 if ()
>                         requested |= BIT();
>         }
>         return requested;
> }
>
> (Note u32 as a type)
>

Thanks. I made a minor modification for the check function. I think to
pass a padgroup
as the argument would be better instead of base, size which I may need
to check if
the size > 32 (of course it shouldn't happen) or not.

+intel_padgroup_has_gpio_requested(struct gpio_chip *chip,  const
struct intel_padgroup *gpp)
+{
+       u32 requested = 0;
+       int i;
+
+       if (gpp == NULL)
+               return 0;
+
+       if (gpp->gpio_base < 0)
+               return 0;
+
+       for (i = 0; i < gpp->size; i++)
+               if (gpiochip_is_requested(chip, gpp->gpio_base + i))
+                       requested |= BIT(i);
+
+       return requested;
+}
+
 int intel_pinctrl_resume(struct device *dev)
 {
        struct platform_device *pdev = to_platform_device(dev);

> > +                       if (requested) {
> > +                               if (communities[i].hostown[gpp] !=
> > readl(base + gpp * 4)) {
> > +
> > writel(communities[i].hostown[gpp], base + gpp * 4);
>
> The idea here not to check this at all, but rather apply a mask.
>
> u32 value;
>
> ...
> value = readl();
> value = (value & ~requested) | (hostown[gpp] & requested);
> writel(value);
>

I made the following per your suggestion. So basically I don't need to show a
warning for the abnormal HOSTSW_OWN value change? I will submit a formal
patch for review if there's no big problem for these code logic. Please advise
if any. Thanks.

@@ -1588,6 +1619,22 @@ int intel_pinctrl_resume(struct device *dev)
                        dev_dbg(dev, "restored mask %d/%u %#08x\n", i, gpp,
                                readl(base + gpp * 4));
                }
+
+               base = community->regs + community->hostown_offset;
+               for (gpp = 0; gpp < community->ngpps; gpp++) {
+                       const struct intel_padgroup *padgrp =
&community->gpps[i];
+                       u32 requested =
intel_padgroup_has_gpio_requested(&pctrl->chip, padgrp);
+
+                       if (requested) {
+                               u32 value = readl(base + gpp * 4);
+                               u32 saved = communities[i].hostown[gpp];
+
+                               value = (value & ~requested) | (saved
& requested);
+                               writel(value, base + gpp * 4);
+                               dev_dbg(dev, "restored hostown %d/%u
%#08x\n", i, gpp,
+                                       readl(base + gpp * 4));
+                       }
+               }
