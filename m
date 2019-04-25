Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063C0C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017F8206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/9crnaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfDYUEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:04:54 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35861 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:04:54 -0400
Received: by mail-ua1-f67.google.com with SMTP id k32so418515uae.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iwN7Z7FCvjRO1zWepxXWRLEDswXrQAlZY84YrkKRyk=;
        b=G/9crnaExz4j3NUZrA1xwUhpt8QUCnwHzOkmKV8ElWAiiYe0eua9gA/8IX3aJQeDtf
         aI+0qGisF0X1Sukvr/Z77t5NN9wi5HLTQ4m5PHknalRy4FrrZSIL2N79D1ELF+7y5Dks
         criecb8jD7mHKbvky3N2NvcPGXtP5nGyekU5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iwN7Z7FCvjRO1zWepxXWRLEDswXrQAlZY84YrkKRyk=;
        b=GG3W6uXgpmqeYvlFHKu7xa7dzCnOV4eo5ZgWrZ1C9dneWteVN4Jc5N99tgrLY7/Z53
         X7RNKPEx7mWDWcIC2TKvlGUqR+Z3qEa9UMxTv46UYP/fmbqVuoA0NdERL7RJsIMaAPnv
         8AkuYRU0g3ftyCv3ZgMALPYkUERSKIzBwDlPPZL87DkpVNR9ToLiNCOePV3L5QxkClBO
         vp0qWf/C7SjSJu1A5BcBZ1YD74IwpX4W9cvojjL21Oo+iwgR+ILOdP+Mp1m7mwvlA7lF
         KXMKcOgzyOr5gXcSXYls304nQslD608nNnn9beYms/qIPItQ8oc62RUTacU7Y+dZ+ACR
         ONxw==
X-Gm-Message-State: APjAAAVJ7vSOM44Y7Bzj4v3IHxwuZs/KZsOYGuDfPGlyf1Dpy6uS5baH
        WQUxYE83CmTaXQ6DsTbdTSJB0wOKlCk=
X-Google-Smtp-Source: APXvYqxkq7fRg/4fFLvudvUu9RKUoVWq/AjKjMVMFnp0xWubbEsmpx/TKLDR0BJrrrGyOZnvngLGZg==
X-Received: by 2002:ab0:15e7:: with SMTP id j36mr21721144uae.115.1556222692524;
        Thu, 25 Apr 2019 13:04:52 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id y72sm6561801vky.29.2019.04.25.13.04.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 13:04:52 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id x84so270969vkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:04:52 -0700 (PDT)
X-Received: by 2002:a1f:9991:: with SMTP id b139mr21625257vke.73.1556222301650;
 Thu, 25 Apr 2019 12:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-4-dianders@chromium.org> <87pnpas1fx.fsf@linux.intel.com>
 <CAD=FV=V=6dUkXAsX0+XR2y=688VcyDa8aPvD8JkKHTFZrs=YDg@mail.gmail.com>
In-Reply-To: <CAD=FV=V=6dUkXAsX0+XR2y=688VcyDa8aPvD8JkKHTFZrs=YDg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Apr 2019 12:58:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WA07+gUkVvsikN=iDHZLUJQtzjkKtiBHAEDw4gLNWY7w@mail.gmail.com>
Message-ID: <CAD=FV=WA07+gUkVvsikN=iDHZLUJQtzjkKtiBHAEDw4gLNWY7w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Documentation: dt-bindings: Add
 snps,need-phy-for-wake for dwc2 USB
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Julius Werner <jwerner@chromium.org>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 25, 2019 at 11:09 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 25, 2019 at 5:40 AM Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
> >
> > Douglas Anderson <dianders@chromium.org> writes:
> >
> > > Some SoCs with a dwc2 USB controller may need to keep the PHY on to
> > > support remote wakeup.  Allow specifying this as a device tree
> > > property.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > For relevant prior discussion on this patch, see:
> > >
> > > https://lkml.kernel.org/r/1435017144-2971-3-git-send-email-dianders@chromium.org
> > >
> > > I didn't make any changes from the prior version since I never found
> > > out what Rob thought of my previous arguments.  If folks want a
> > > change, perhaps they could choose from these options:
> > >
> > > 1. Assume that all dwc2 hosts would like to keep their PHY on for
> > >    suspend if there's a USB wakeup enabled, thus we totally drop this
> > >    binding.  This doesn't seem super great to me since I'd bet that
> > >    many devices that use dwc2 weren't designed for USB wakeup (they
> > >    may not keep enough clocks or rails on) so we might be wasting
> > >    power for nothing.
> > > 2. Rename this property to "snps,wakeup-from-suspend-with-phy" to make
> > >    it more obvious that this property is intended both to document
> > >    that wakeup from suspend is possible and that we need the PHY for
> > >    said wakeup.
> > > 3. Rename this property to "snps,can-wakeup-from-suspend" and assume
> > >    it's implicit that if we can wakeup from suspend that we need to
> > >    keep the PHY on.  If/when someone shows that a device exists using
> > >    dwc2 where we can wakeup from suspend without the PHY they can add
> > >    a new property.
> > >
> > > Changes in v2: None
> > >
> > >  Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > checking file Documentation/devicetree/bindings/usb/dwc2.txt
> > Hunk #1 FAILED at 37.
> > Hunk #2 succeeded at 52 (offset -1 lines).
> > 1 out of 2 hunks FAILED
>
> Yeah, as Minas pointed out in the cover letter [1] my series conflicts
> with Artur's.  I have it on my list to try out his series and see if,
> perhaps, it allows me to enable the partial power down and also just
> generally rebase.  It's fairly high on my list to do that--hopefully
> in the next week.
>
> [1] https://lkml.kernel.org/r/e4b3cd69-1c91-dfbe-bea7-bbca89ca1348@synopsys.com

Oh, it looks like you didn't apply Artur's patches, though.
Presumably you applied mine first and they won the race and thus I
guess it's up to Artur to rebase his patches atop mine.  This probably
explains why you told him the patches didn't apply.  I'll reply to
that thread.

...so it turns out that when I try now my patches apply fine [2].  I'm
guessing that you perhaps tried to apply these patches before my
"rk3288's remote wake quirk" which would indeed cause conflicts.  I
mentioned the dependency in my cover letter [1] but totally understand
that it's easy to miss stuff like that.  :-)

I'm going to assume you can just go-ahead and try applying patches 3,
4, and 5 in this series again.  If you want me to repost them then
please let me know.

Thanks, and sorry for the hassle.

[1] https://lkml.kernel.org/r/20190418001356.124334-1-dianders@chromium.org

[2] Showing that patches currently apply:

dianders@tictac2:v4.19 ((2e3cfcbbb140...))$ git checkout
linux_usb_balbi/testing/next
HEAD is now at 2e3cfcbbb140 dwc2: gadget: Fix completed transfer size
calculation in DDMA

dianders@tictac2:v4.19 ((2e3cfcbbb140...))$ curl -L
https://lore.kernel.org/patchwork/patch/1063477/mbox | git am
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  7273  100  7273    0     0  35827      0 --:--:-- --:--:-- --:--:-- 35827
Applying: Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB

dianders@tictac2:v4.19 ((84c34d7b9647...))$ curl -L
https://lore.kernel.org/patchwork/patch/1063478/mbox | git am
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  9587  100  9587    0     0  46538      0 --:--:-- --:--:-- --:--:-- 46538
Applying: USB: dwc2: Don't turn off the usbphy in suspend if wakeup is enabled

dianders@tictac2:v4.19 ((ff5ab1cb16ab...))$ curl -L
https://lore.kernel.org/patchwork/patch/1063479/mbox | git am
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  6045  100  6045    0     0  29778      0 --:--:-- --:--:-- --:--:-- 29778
Applying: ARM: dts: rockchip: Allow wakeup from rk3288-veyron's dwc2 USB ports

-Doug
