Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483A420896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="IdQBL1wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDAKmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:42:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40735 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfDAKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:42:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id w20so5245082qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avix0l/4HnhJqGdPmgVFLMwJx5CoLVwVrAQP99HCOK4=;
        b=IdQBL1wIvWO8LpI+5V9URYpVJ9HUj2Y0qtusZkSFca7O6RzeRbHB2zpWeq8M1lwlS9
         vD0aoeQk4eqaXPMAhVt806a2wzSYo9yReI1PT+cAFAlU8EZB25KjFQCDfxwLzXMpnJ8X
         CDV/U0+TuKyPk3k9hBtwqlGtY9sEhZQ48HHgfgbgw4IKG+Xn4VInQ/qQ5szMRhJc/Cr7
         mba8FXrgiB0eNHhf7T2Jddy19P6TXC2QADkFdXwsI4wm0kloyHdDm1drxisxEobCzUGn
         FAunLPALrWJgQDD+VejfNTLzM31kCl+H6XDs00yVvrZIWGsM8hFZ0RDn0LcEYFJ+0PDN
         ROQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avix0l/4HnhJqGdPmgVFLMwJx5CoLVwVrAQP99HCOK4=;
        b=k+V4T0EQireeOIwQPQ6aiQwt4tmTWOlfJsw9ACoPtK1UM2E913eEIsV5Mf/qdXGDM6
         GO3Aa32h7r/v8xgku0UdrR/A8KcSP4q50J5beq1FtFixjo3y+OJZU+xwg76Z83sz4i8l
         QH/WwwucpXXhVDb3Sq2cH2FGjG8xjT5jrOcBQzKZAWFib/Zg9I3PVFIoELVf0jo39uk/
         VERNYki1Lmu7lUeT6YwP1sgOJZZgZWb0lb/Y6A5KydjjFPD0JQV3DN8KDv3QKC5W32yd
         mSGNLv7SF6DvP2D2/eahTdigloKgVFao4jcI/1gzt4Y+blXJImN+QTWgMT0tCHqPAKWV
         kWgw==
X-Gm-Message-State: APjAAAVi/QpgBSxfgZ/v9nSPh5506TdALEaaNCY83gvAzF774Ifexo8c
        AFRMaxJXTJvebH6u6e6pVLf/N+Elhx8j5YqKvYtvPw==
X-Google-Smtp-Source: APXvYqyp+b7qPzotOUPV0EqsIpVeJvtVn6qDuExt2PKy9xWra9XDRB2FDAeaC5GM7GNeW6MG1j2vB6aB8R0LMApxHc4=
X-Received: by 2002:a37:451:: with SMTP id 78mr23292207qke.315.1554115329015;
 Mon, 01 Apr 2019 03:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20171121105205.GP22431@lahna.fi.intel.com> <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com> <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
 <20190327172940.GR3622@lahna.fi.intel.com> <20190328091729.GV9224@smile.fi.intel.com>
 <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
 <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com>
 <20190328123444.GX3622@lahna.fi.intel.com> <CAB4CAwcQTH5BiDDbzfFXTDDuYQ_fuDd_1tKkecf6vwygGQmn5w@mail.gmail.com>
 <20190401074953.GQ3622@lahna.fi.intel.com>
In-Reply-To: <20190401074953.GQ3622@lahna.fi.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 1 Apr 2019 18:41:57 +0800
Message-ID: <CAB4CAweW_3p4i_8ntscJyU9n55HwdLt3pxyT3Gf6SUSbZAJ8qA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over suspend/resume
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
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

On Mon, Apr 1, 2019 at 3:49 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, Mar 29, 2019 at 04:38:20PM +0800, Chris Chiu wrote:
> > On Thu, Mar 28, 2019 at 8:34 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Thu, Mar 28, 2019 at 08:19:59PM +0800, Chris Chiu wrote:
> > > > On Thu, Mar 28, 2019 at 5:38 PM Daniel Drake <drake@endlessm.com> wrote:
> > > > >
> > > > > On Thu, Mar 28, 2019 at 5:17 PM Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > > Hmm... Can you confirm that laptop you declared as a fixed case and the
> > > > > > mentioned here is the same one?
> > > > >
> > > > > They are definitely not the same exact unit - originally we had a
> > > > > pre-production sample, and now we briefly diagnosed a real production
> > > > > unit that was sold to a customer. There could be subtle motherboard
> > > > > variations as you mention.
> > > > >
> > > > > > If it's the case, I recommend to ping Asus again and make them check and fix.
> > > > >
> > > > > We'll keep an eye open for any opportunities to go deeper here.
> > > > > However further investigation on both our side and theirs is blocked
> > > > > by not having any of the affected hardware (since the models are now
> > > > > so old), so I'm not very optimistic that we'll be able to make
> > > > > progress there.
> > > > >
> > > > > > Meanwhile, Mika's proposal sounds feasible and not so intrusive. We may
> > > > > > implement this later on.
> > > > >
> > > > > Chris will work on implementing this for your consideration.
> > > > >
> > > > > Thanks for the quick feedback!
> > > > > Daniel
> > > >
> > > > What if I modify the patch as follows? It doesn't save HOSTSW_OWN register.
> > > > It just toggles the bit specifically for the IRQ GPIO pin after resume when DMI
> > > > matches.
> > >
> > > I don't really like having quirks like this if we can avoid it and in
> > > this case I think we can. Just always save HOSTSW_OWN and then restore
> > > it if there is a GPIO requested and the value differs (and log a warning
> > > or something like that).
> >
> > You mean save the content of hostsw_own register on padgroup based ex.
> >     communities[i].hostown[gpp] = readl(base + gpp * 4);
> >
> > And then check the hostown bit for the GPIO requested pin in
> > intel_pinctrl_resume(),
> > differs the hostsw_own bit on pin base (like padcfg), then restore the
> > hostsw_own
> > value of the padgroug which the GPIO pin is belonging to?
>
> Yes.
>
> > I think what you mean should be a much more straightforward solution
> > for this. Could
> > you implement this in your way and we can try to help verification. Thanks.
>
> Sure I can but it probably does not happen until end of the week because
> I'm currently busy with something else.

Thanks for your attention. I don't want to distract you so I'll try to
refine the
patch. It would be a great help if you can help review and give comments.

Don't know whether if the following patch still get the wrong idea about
your thought.  It saves the hostsw_own when GPIO requested, check
if the value differs in resume() and restore if necessary. Please kindly
correct me if any. Thanks

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c
b/drivers/pinctrl/intel/pinctrl-intel.c
index 8cda7b535b02..d1cfa5adef9b 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -77,6 +77,7 @@ struct intel_pad_context {
        u32 padcfg0;
        u32 padcfg1;
        u32 padcfg2;
+       u32 hostown;
 };

 struct intel_community_context {
@@ -219,6 +220,24 @@ static bool intel_pad_acpi_mode(struct
intel_pinctrl *pctrl, unsigned int pin)
        return !(readl(hostown) & BIT(gpp_offset));
 }

+static void __iomem *intel_get_hostown(struct intel_pinctrl *pctrl,
unsigned int pin)
+{
+       const struct intel_community *community;
+       const struct intel_padgroup *padgrp;
+
+       community = intel_get_community(pctrl, pin);
+       if (!community)
+               return NULL;
+       if (!community->hostown_offset)
+               return NULL;
+
+       padgrp = intel_community_get_padgroup(community, pin);
+       if (!padgrp)
+               return NULL;
+
+       return community->regs + community->hostown_offset +
padgrp->reg_num * 4;
+}
+
 static bool intel_pad_locked(struct intel_pinctrl *pctrl, unsigned int pin)
 {
        struct intel_community *community;
@@ -442,7 +461,7 @@ static int intel_gpio_request_enable(struct
pinctrl_dev *pctldev,
                                     unsigned int pin)
 {
        struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-       void __iomem *padcfg0;
+       void __iomem *padcfg0, *hostown;
        unsigned long flags;

        raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -457,6 +476,10 @@ static int intel_gpio_request_enable(struct
pinctrl_dev *pctldev,
        /* Disable TX buffer and enable RX (this will be input) */
        __intel_gpio_set_direction(padcfg0, true);

+       /* Save HOSTSW_OWN */
+       hostown = intel_get_hostown(pctrl, pin);
+       if (!pctrl->context.pads[pin].hostown)
+               pctrl->context.pads[pin].hostown = readl(hostown);
        raw_spin_unlock_irqrestore(&pctrl->lock, flags);

        return 0;
@@ -1543,12 +1566,22 @@ int intel_pinctrl_resume(struct device *dev)
        pads = pctrl->context.pads;
        for (i = 0; i < pctrl->soc->npins; i++) {
                const struct pinctrl_pin_desc *desc = &pctrl->soc->pins[i];
-               void __iomem *padcfg;
+               void __iomem *padcfg, *hostown;
                u32 val;

                if (!intel_pinctrl_should_save(pctrl, desc->number))
                        continue;

+               hostown = intel_get_hostown(pctrl, desc->number);
+               val = readl(hostown);
+               if (!pads[i].hostown && val != pads[i].hostown) {
+                       writel(pads[i].hostown, hostown);
+                       dev_warn(dev, "pin %u not owned by host\n",
+                               desc->number);
+                       dev_dbg(dev, "restored pin %u hostsw_own %#08x\n",
+                               desc->number, readl(hostown));
+               }
+
                padcfg = intel_get_padcfg(pctrl, desc->number, PADCFG0);
                val = readl(padcfg) & ~PADCFG0_GPIORXSTATE;
                if (val != pads[i].padcfg0) {
