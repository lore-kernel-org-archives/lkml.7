Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2CCC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCA82075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ck+wpiOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3F35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:29:57 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33763 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfD3F3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:29:53 -0400
Received: by mail-vk1-f196.google.com with SMTP id x194so2840295vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oI6/mbFrFRIlv6U0u6swyj6hDvHAkiQ0dv4jYaZhLCk=;
        b=ck+wpiOtoHFncK/l3p2502NKVY3mfQ215NIogmFrEWBa6w1fEQdMgG1MU88zbsZqih
         m9bKZLCFITPnSS3fJ0EsRU0OIV7/QON22ZmROKou6SXtgBzULdEg5LGSeko8kTvukeI3
         p+qusiDWOsdxykgPSZpQiwM5hGHYA5olAXU30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oI6/mbFrFRIlv6U0u6swyj6hDvHAkiQ0dv4jYaZhLCk=;
        b=aYPCDgjvxIT8s6LRKkWRMgmkFYOxI9SrF0wiDxOgyhK34woQe/yjRnVyt/rzF/nAzH
         m+aftEOg1k3jXVkd2mN1CVL0qkWwVT0qF07NdOBtk8gSuhZmPbvandWEor1ujlAerGvn
         gUPNurvM78bAOpq8bd39dFZPJniNS9dbfrX6xhaqffZTfzpfpMj2rH8MU6ln0M5aC81c
         Z+EUlqJMKwLRHWPrDDI2KuhWwW3RF1gDVclDeDC7nzrnWlQsPuI8TdOP5zr+LFu0W2UI
         cfj4TkB3nzzuLjhKUce1xyhblkw6ffoK5Tni9YrDGjE+rPHMcaSBLW5NLokXsA0RWPYo
         jWmg==
X-Gm-Message-State: APjAAAVEOPlIurCLrH2Xv8rI0skn/D0csBFkpnzP3h/OnlE06pdGBYJi
        fAfYsWlvWD5xnq9mx15/oRr4MP+g7hI=
X-Google-Smtp-Source: APXvYqxDTTMCpL0N35QINeo0XCPg8L57kWdgqVI9kBUtf3Z6rYjmE5KsDoSzarQjjX9NjpTtcnGV1w==
X-Received: by 2002:a1f:2fc7:: with SMTP id v190mr33815551vkv.84.1556602192042;
        Mon, 29 Apr 2019 22:29:52 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id v22sm9130040vkv.35.2019.04.29.22.29.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 22:29:48 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id k32so4346248uae.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:29:48 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr1729807uao.106.1556602187963;
 Mon, 29 Apr 2019 22:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190416215351.242246-1-dianders@chromium.org>
 <20190416215351.242246-2-dianders@chromium.org> <20190430005357.GA13695@bogus>
In-Reply-To: <20190430005357.GA13695@bogus>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Apr 2019 22:29:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3_NcBHdg5A8LvGMoVd_eLN0q=pXo_3f2GCdi5u2GP-Q@mail.gmail.com>
Message-ID: <CAD=FV=V3_NcBHdg5A8LvGMoVd_eLN0q=pXo_3f2GCdi5u2GP-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: dwc2: Document quirk to reset
 PHY upon wakeup
To:     Rob Herring <robh@kernel.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 29, 2019 at 5:54 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 16, 2019 at 02:53:48PM -0700, Douglas Anderson wrote:
> > On Rockchip rk3288 there's a hardware quirk where we need to assert
> > the reset signal to the PHY when we get a remote wakeup on one of the
> > two ports.  Document this quirk in the bindings.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> > Changes in v2: None
> >
> >  Documentation/devicetree/bindings/usb/dwc2.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> > index 6dc3c4a34483..f70f3aee4bfc 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> > +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> > @@ -37,6 +37,8 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
> >  - g-rx-fifo-size: size of rx fifo size in gadget mode.
> >  - g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
> >  - g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
> > +- snps,reset-phy-on-wake: If present indicates that we need to reset the PHY when
> > +                          we detect a wakeup.  This is due to a hardware errata.
>
> Synopsys or Rockchip errata?
>
> Ideally, this should be implied by the controller or phy compatible.

I have no idea.  The errata was described to me by Rockchip but I
don't know if it's common to more than one board.

You're right that we could do it on the controller compatible, but we
have to be careful.  The two ports on rk3288 currently have the same
compatible string but the errata only applies to one of them.  ...so
I'd have to cue on not just the compatible string but also detect
whether we're on the "OTG" port of the "host only" port.  That's not
too hard, though since it is probe-able.

I'm happy to spin this but I'll wait to hear from Felipe.  This is
already in his testing tree, so presumably I should do a follow-up
patch.  ...but if he wants me to re-post I can do that too.


-Doug
