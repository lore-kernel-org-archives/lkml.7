Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D899FC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15EC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfHZI5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:57:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35661 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfHZI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:57:17 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i2AoN-0003gN-GM; Mon, 26 Aug 2019 10:57:15 +0200
Message-ID: <1566809829.3842.4.camel@pengutronix.de>
Subject: Re: [RESEND PATCHv4 1/1] drivers/amba: add reset control to amba
 bus probe
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 26 Aug 2019 10:57:09 +0200
In-Reply-To: <e7e986a2-762e-674b-608b-5ee5b013935b@kernel.org>
References: <20190820145834.7301-1-dinguyen@kernel.org>
         <20190820145834.7301-2-dinguyen@kernel.org>
         <CACRpkdasbXuqUkO3NjMGBU_ePEBT23BS1eP-bigB0_g494LgvQ@mail.gmail.com>
         <e7e986a2-762e-674b-608b-5ee5b013935b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh, Linus,

On Fri, 2019-08-23 at 10:42 -0500, Dinh Nguyen wrote:
> 
> On 8/23/19 4:19 AM, Linus Walleij wrote:
> > On Tue, Aug 20, 2019 at 4:58 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> > 
> > > @@ -401,6 +402,26 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> > >         ret = amba_get_enable_pclk(dev);
> > >         if (ret == 0) {
> > >                 u32 pid, cid;
> > > +               int count;
> > > +               struct reset_control *rstc;
> > > +
> > > +               /*
> > > +                * Find reset control(s) of the amba bus and de-assert them.
> > > +                */
> > > +               count = reset_control_get_count(&dev->dev);

The reset_control_get_count() inline stub returns -ENOENT, so the
compiler can throw away the complete loop.

> > > +               while (count > 0) {
> > > +                       rstc = of_reset_control_get_shared_by_index(dev->dev.of_node, count - 1);

Since resets are looked up with of_reset_control_get, I'd use
of_reset_control_get_count() above for consistency. But see below:

> > > +                       if (IS_ERR(rstc)) {
> > > +                               if (PTR_ERR(rstc) == -EPROBE_DEFER)
> > > +                                       ret = -EPROBE_DEFER;
> > > +                               else
> > > +                                       dev_err(&dev->dev, "Can't get amba reset!\n");
> > > +                               break;
> > > +                       }
> > > +                       reset_control_deassert(rstc);
> > > +                       reset_control_put(rstc);
> > > +                       count--;
> > > +               }

It looks like the order of deassertions is irrelevant. If so,
You can use of_reset_control_array_get() to simplify this:

+		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
+		if (IS_ERR(rstc)) {
+			if (PTR_ERR(rstc) != -EPROBE_DEFER)
+				dev_err(&dev->dev, "Can't get amba reset!\n");
+			return PTR_ERR(rstc);
+		}
+		reset_control_deassert(rstc);
+		reset_control_put(rstc);

> > I'm not normally a footprint person, but the looks of the stubs in
> > <linux/reset.h> makes me suspicious whether this will have zero impact
> > in size on platforms without reset controllers.
> > 
> > Can you just ls -al on the kernel without CONFIG_RESET_CONTROLLER
> > before and after this patch and ascertain that it has zero footprint effect?
> 
> Thanks for the review. I checked it, and indeed, it does have a zero
> footprint effect.
> 
> > 
> > If it doesn't I'd sure like to break this into its own function and
> > stick a if (!IS_ENABLED(CONFIG_RESET_CONTROLLER)) return 0;
> > in there to make sure the compiler drops it.
> > 
> > Also it'd be nice to get Philipp's ACK on the semantics, though they
> > look correct to me.

regards
Philipp
