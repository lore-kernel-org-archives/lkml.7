Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD651C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9344B2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AobIyWBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfKHCGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:06:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35625 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKHCGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:06:30 -0500
Received: by mail-io1-f68.google.com with SMTP id x21so4639454iol.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 18:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSgW3A7RWyhsJj378/fhZw4bo/3lSZywb10x/TiQ6js=;
        b=AobIyWBWp8Z6LpdtKuyma3ufS/KNGQ+bmCTeW6cvoDC7nZ3SHSDceDgHKbyNh1AIwM
         CxX6yLM6gyuEKDxu8eYrOCBPuL58TvXko5kWxjv1YVWCJzzqo9G0qLEny5lAwy2u80JN
         +uoc4wzs5+DZjg+oVIZUomGzqkbJXUsZoz2/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSgW3A7RWyhsJj378/fhZw4bo/3lSZywb10x/TiQ6js=;
        b=VOpkD0/S6wUaQJRTxjMGVHWUW4OMu8ic6eUKurAfyEUKqEff7VgdOvh6UBWvyU1GIs
         9ObfetN3ZLy1IusxeZOax8DODsAELBcNw+770O42pXP2kVPzTYx2L86ceLYiVyH1/GWQ
         B5vJ57ZW2fS7J2uKmHgQWFsBlgk8ptsajDMuvwutBF58DE4mHetqE6QESdCveU3x0FGP
         2uTQBYnWYzOMLsWTXkhJJwwoUjXF+B1fiL7f4alZMsQWmURDhS4EhIfHJLj73uXQq97w
         nhwITNlIeKqvqIdmKBSK2wRRnKjiy5Jjsgt6kYQm62KehS/EMatZfgMIcgniFNBpj/WH
         3qRQ==
X-Gm-Message-State: APjAAAXXh7db5GBJeK74Numtt1rbEpqAu6QacgYZbTXDEnImkeYOQphE
        dJC/+Lpvzc9SswRP/1fyDbgBNJtbF4GUiUXRCyEfMA==
X-Google-Smtp-Source: APXvYqyn0DsKqg8rSWqcfoMm6d8Fl2Z6dgUSaiBlmZgGR04MFVjbMr+p8KLgwaxrK5kbeIdRnkzz/m2YgeK0W6B0DHA=
X-Received: by 2002:a02:58c8:: with SMTP id f191mr7652985jab.94.1573178789631;
 Thu, 07 Nov 2019 18:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20191014102308.27441-1-tdas@codeaurora.org> <20191014102308.27441-6-tdas@codeaurora.org>
 <20191029175941.GA27773@google.com> <fa17b97d-bfc4-4e9c-78b5-c225e5b38946@codeaurora.org>
 <20191031174149.GD27773@google.com> <20191107210606.E536F21D79@mail.kernel.org>
In-Reply-To: <20191107210606.E536F21D79@mail.kernel.org>
From:   Rob Clark <robdclark@chromium.org>
Date:   Thu, 7 Nov 2019 18:06:19 -0800
Message-ID: <CAJs_Fx60uEdGFjJXAjvVy5LLBXXmergRi8diWxhgGqde1wiXXQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] clk: qcom: Add Global Clock controller (GCC)
 driver for SC7180
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 1:06 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Matthias Kaehlcke (2019-10-31 10:41:49)
> > Hi Taniya,
> >
> > On Thu, Oct 31, 2019 at 04:59:26PM +0530, Taniya Das wrote:
> > > Hi Matthias,
> > >
> > > Thanks for your comments.
> > >
> > > On 10/29/2019 11:29 PM, Matthias Kaehlcke wrote:
> > > > Hi Taniya,
> > > >
> > > > On Mon, Oct 14, 2019 at 03:53:08PM +0530, Taniya Das wrote:
> > > > > Add support for the global clock controller found on SC7180
> > > > > based devices. This should allow most non-multimedia device
> > > > > drivers to probe and control their clocks.
> > > > >
> > > > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > >
> > > >
> > > > v3 also had
> > > >
> > > > +   [GCC_DISP_AHB_CLK] = &gcc_disp_ahb_clk.clkr,
> > > >
> > > > Removing it makes the dpu_mdss driver unhappy:
> > > >
> > > > [    2.999855] dpu_mdss_enable+0x2c/0x58->msm_dss_enable_clk: 'iface' is not available
> > > >
> > > > because:
> > > >
> > > >          mdss: mdss@ae00000 {
> > > >                     ...
> > > >
> > > >   =>             clocks = <&gcc GCC_DISP_AHB_CLK>,
> > > >                           <&gcc GCC_DISP_HF_AXI_CLK>,
> > > >                           <&dispcc DISP_CC_MDSS_MDP_CLK>;
> > > >                  clock-names = "iface", "gcc_bus", "core";
> > > >     };
> > > >
> > >
> > > The basic idea as you mentioned below was to move the CRITICAL clocks to
> > > probe. The clock provider to return NULL in case the clocks are not
> > > registered.
> > > This was discussed with Stephen on v3. Thus I submitted the below patch.
> > > clk: qcom: common: Return NULL from clk_hw OF provider.
> >
> > I see. My assumption was that the entire clock hierarchy should be registered,
> > but Stephen almost certainly knows better :)
> >
> > > Yes it would throw these warnings, but no functional issue is observed from
> > > display. I have tested it on the cheza board.
> >
> > The driver considers it an error (uses DEV_ERR to log the message) and doesn't
> > handle other clocks when one is found missing. I'm not really famililar with
> > the dpu_mdss driver, but I imagine this can have some side effects. Added some
> > of the authors/contributors to cc.
>
> NULL is a valid clk pointer returned by clk_get(). What is the display
> driver doing that makes it consider NULL an error?
>

do we not have an iface clk?  I think the driver assumes we should
have one, rather than it being an optional thing.. we could ofc change
that

BR,
-R
