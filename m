Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80252C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1ED2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iaB9nIVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfFRHMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:12:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40989 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRHMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:12:36 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so27321540ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmL++hI8lQoZaDbMBXIiWF1lw21O/uzMRwn2y/O0Xwk=;
        b=iaB9nIVlWH6LV1DMIrnPdNE4Ys6DzvdzS2TdZXtSSCE+E+q//N61iRLXcbqzVqDJaM
         QqF1qJCQwPEafzabEz0t6xWOChZQsyc3weFjZWETylgOH5RD2KFWKbMKG4bLlXxFg9OX
         dq6AUnd4hFcU4o+A0TnJag+k3HkoKHdrN5hKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmL++hI8lQoZaDbMBXIiWF1lw21O/uzMRwn2y/O0Xwk=;
        b=dmWner3g8YfnCm9sXkB5gq6SwUpFsVf7zoU94jzjqBp1bd6ifXrz9bPOEUW52HGe6V
         VXvvmSzKGvSQMFvc4TzaNndC+jad0ayF2vWapd+UrYcZPKfT5dbz/Xsqzw7jS0I84Rqh
         yQvYTa1usv6jEBrLaB35b+eYar4y1sqtiYLuxKYqOi56BPp7whWEBUVxVwp/FXlzxlE0
         iD8F5sZES3xkwkXLYPmpCOmlw3Bf+Rr0/PwSO/wS30vLI+KBQ+BAk8DPVWpMKZzlMpP6
         rzpacFHucJlPKGEivyc6bxXmWXAQlKkGynDNXVb1AbcsWm8tz5sK9wj3KV1PDzHm3bTY
         3Yqg==
X-Gm-Message-State: APjAAAVeZ3fUG7dCQTu6wjZXJPn7YhQbXyh5XFaD20arFlUxjqMchFvx
        PBGbs7OeDvKZ/ErisX1dBizLMVbUc0VFmGwQLckHsg==
X-Google-Smtp-Source: APXvYqzNRlDJxCxF6O+3RbQgMZ8Vz5JWFmeOF5YnAqT2HmdW9eHgtOSbGNu6hfDOSRSNCnLlinOQTSXbS6Nte7phh2s=
X-Received: by 2002:a6b:6b14:: with SMTP id g20mr6191396ioc.28.1560841955317;
 Tue, 18 Jun 2019 00:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <20190617114503.pclqsf6bo3ih47nt@flea>
 <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com>
In-Reply-To: <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 18 Jun 2019 12:42:23 +0530
Message-ID: <CAMty3ZA0J+2fSRwX+tS-waJDLMyTOf6UY_1pHjXe0qOk5QuzrQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 5/9] drm/sun4i: tcon_top: Register
 clock gates in probe
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:31 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Jun 17, 2019 at 7:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Jun 14, 2019 at 10:13:20PM +0530, Jagan Teki wrote:
> > > TCON TOP have clock gates for TV0, TV1, dsi and right
> > > now these are register during bind call.
> > >
> > > Of which, dsi clock gate would required during DPHY probe
> > > but same can miss to get since tcon top is not bound at
> > > that time.
> > >
> > > To solve, this circular dependency move the clock gate
> > > registration from bind to probe so-that DPHY can get the
> > > dsi gate clock on time.
> >
> > It's not really clear to me what the circular dependency is?
> >
> > if you have a chain that is:
> >
> > tcon-top +-> DSI
> >          +-> D-PHY
> >
> > There's no loop, right?
>
> Looking at how the DTSI patch structures things (without going into
> whether it is correct or accurate):
>
> The D-PHY is not part of the component graph. However it requests
> the DSI gate clock from the TCON-TOP.
>
> The TCON-TOP driver, in its current form, only registers the clocks
> it provides at component bind time. Thus the D-PHY can't successfully
> probe until the TCON-TOP has been bound.
>
> The DSI interface requires the D-PHY to bind. It will return -EPROBE_DEFER
> if it cannot request it. This in turn goes into the error path of
> component_bind_all, which unbinds all previous components.
>
> So it's actually
>
>     D-PHY -> TCON-TOP -> DSI
>       ^                   |
>       |--------------------
>
> I've not checked, but I suspect there's no possibility of having other
> drivers probe (to deal with deferred probing) within component_bind_all.
> Otherwise we shouldn't run into this weird circular dependency issue.
>
> So the question for Jagan is that is this indeed the case? Does this
> patch solve it, or at least work around it.

Yes, this is what I was mentioned in initial version, since the "dsi"
gate in tcon top is registering during bind, the dphy of dsi
controller won't get the associated clock for "mod" so it is keep on
returning -EPROBE_DEFER. By moving the clock gate registration to
probe, everything bound as expected.
