Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC95CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FCF20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="F/Aj8STx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDCHG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:06:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36588 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:06:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so18341861qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjbZMKXgAkdSlge+ASD14WXdRNud7GTh1PKUiN3JN6Y=;
        b=F/Aj8STxbp41locJ8fSKoQP/l88GD0v32XVhyHS9RvIrybtmvuNWpvJ6vZ9AOOd5R9
         C5yCE1m4PNIsArWcwCFS/gGZjqAoQKM6IRUCo7BNyso3lGCY6uus4Zy3Lxv4Z8lwuQFn
         ARR33o5Librlj5a5MZDMxWsgqWA7P76J6uGpT8ehxuseUjLiZomvxzX1645K3SdMSzZQ
         HvVJCe37payY/7vCA8rKjcLTe9n4wAwomXlyUIvtgiX3Jqed1M+SG03dOPHn9DBjJQuE
         5Nc4+IJWKWA1ZljCJaznkh7HcpPbhmLNNb2OKsHpYDQVebiyjOAlZOHKE3w7u3KVsE9O
         pp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjbZMKXgAkdSlge+ASD14WXdRNud7GTh1PKUiN3JN6Y=;
        b=IEweuq91gFyUpK7qztTlz2DHC7uZDUJ/jTYkxBZ5JStSPA+3IOq703noVsemG6VrxH
         JgzGlmfInVNJ2PfL0+M+9fGFQz403WhxzYryCmWei56yTZcRUhIdui8o9HriruHR4OZU
         voOcGE0n3SJuDlChFggnXPF9Dm30PpEXQGTPKHYaVef1PWulvrjnS4DKHO9lSBRfklcE
         O3oNqw6rWq/Y8B7VYFdIbrtB/sL9LZVHaQZg1Z9HnBt9jl/KQ1kTbVz7OEbSFrc4RKOc
         XvJMM2m7eh5FVqKnj8sqxaiBGa9j5C58fgnLhHGAMaBAnuRjL/+teyNdcMXqzck+ZNmk
         TygQ==
X-Gm-Message-State: APjAAAV0sbNhwYw6ngwJ25L58NdH+5WFBP9TolV6XUqUbxQAKqGdoGPa
        zpl4CT8lDGGWP1OK6eR6F507PTWM7N6vD1LUEj0qxA==
X-Google-Smtp-Source: APXvYqxP4Rl/CqvJ2Vfi0NdlfvvYiDAUt/kmNWQAAdIK6u/Oe8QVuA3XTlxjEq91W64FO1Ln+Kp0MLQW/ZWFJR9VXIs=
X-Received: by 2002:ac8:1a34:: with SMTP id v49mr62641198qtj.236.1554275214438;
 Wed, 03 Apr 2019 00:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190327172940.GR3622@lahna.fi.intel.com> <20190328091729.GV9224@smile.fi.intel.com>
 <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
 <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com>
 <20190328123444.GX3622@lahna.fi.intel.com> <CAB4CAwcQTH5BiDDbzfFXTDDuYQ_fuDd_1tKkecf6vwygGQmn5w@mail.gmail.com>
 <20190401074953.GQ3622@lahna.fi.intel.com> <CAB4CAweW_3p4i_8ntscJyU9n55HwdLt3pxyT3Gf6SUSbZAJ8qA@mail.gmail.com>
 <20190401122256.GF9224@smile.fi.intel.com> <CAB4CAwd6+6+Qwb2wDFkVOc_auTNdrEw07tX2ha=XLvxfwFHRXw@mail.gmail.com>
 <20190402115836.GL9224@smile.fi.intel.com>
In-Reply-To: <20190402115836.GL9224@smile.fi.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 3 Apr 2019 15:06:43 +0800
Message-ID: <CAB4CAwe7n5XsRNS-ZoJL1K7dHLpRrwNReBCCMXjDWCtxYaqfdQ@mail.gmail.com>
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

On Tue, Apr 2, 2019 at 7:58 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > +               base = community->regs + community->hostown_offset;
> > +               for (gpp = 0; gpp < community->ngpps; gpp++) {
> > +                       if (communities[i].hostown[gpp] &&
> > +                           communities[i].hostown[gpp] != readl(base
> > + gpp * 4)) {
> > +                               writel(communities[i].hostown[gpp],
> > base + gpp * 4);
> > +                               dev_warn(dev, "hostown changed after resume\n");
> > +                               dev_dbg(dev, "restored hostown %d/%u
> > %#08x\n", i, gpp,
> > +                                       readl(base + gpp * 4));
> > +                       }
> > +               }
>
> Instead you may need to loop over each pin in the part of the group related to
> one 32-bit HOSTSW_OWN register (i.e. 8, see PADOWN_*() macros in the driver),
> check if it's requested and break a loop. If loop index is off-by-one a limit,
> nothing to do, otherwise restore hostown register.
>
> More pedantic approach is to collect the mask inside the loop and apply it.
>
> The check function name is gpiochip_is_requested().
>
> (One of Intel's drivers which is using that at ->resume() is
>  drivers/gpio/gpio-lynxpoint.c)
>
> P.S. I prefer pedantic approach. The simplification one is showed in order to
> give you an idea.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks for your great comment. I remove the useless hostown save function
and make the following change in ->resume() to detect and restore the abnormal
HOSTSW_OWN. Please help comment if there're still problems. Thanks.

@@ -1588,6 +1600,29 @@ int intel_pinctrl_resume(struct device *dev)
                        dev_dbg(dev, "restored mask %d/%u %#08x\n", i, gpp,
                                readl(base + gpp * 4));
                }
+
+               base = community->regs + community->hostown_offset;
+               for (gpp = 0; gpp < community->ngpps; gpp++) {
+                       const struct intel_padgroup *padgrp =
&community->gpps[i];
+                       unsigned int requested = 0;
+                       int j;
+
+                       if (padgrp->gpio_base < 0)
+                               continue;
+
+                       for (j = 0; j < padgrp->size; j++)
+                               if
(gpiochip_is_requested(&pctrl->chip, padgrp->gpio_base + j))
+                                       requested |= BIT(j);
+
+                       if (requested) {
+                               if (communities[i].hostown[gpp] !=
readl(base + gpp * 4)) {
+
writel(communities[i].hostown[gpp], base + gpp * 4);
+                                       dev_warn(dev, "hostown been
changed during resume\n");
+                                       dev_dbg(dev, "restored hostown
%d/%u %#08x\n", i, gpp,
+                                               readl(base + gpp * 4));
+                               }
+                       }
+               }
        }

        return 0;
