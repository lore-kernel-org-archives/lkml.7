Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BADDC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D8A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfFRHX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:23:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44626 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:23:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so20111397edr.11;
        Tue, 18 Jun 2019 00:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCmSq7/dX8Bi0Rr7j3EyPomsJ3SBkWb71qFb9BFHhSE=;
        b=B9qz21nWB/btW1lVC4eiZcXqxFe4OMokumsyvum5S0Ipz+yS32BwMDQXZvpNqNUsCC
         0azEK9UycqgMo9rtn54s0/wstgeMpQ/3jGksWeGPzHB5K1sccq3pc7cahRUVi6UgZQW9
         Pee8AW+WVkKtM2dpvXcXKgcfJfb+CZQ5nnkmoIvKI49zCLl5RxidDQ6shF5VBU6QIoFw
         A1WWBPDDC2P3BYgNwfAV2B/E2xHU62iKsPhbgRT+1IaH0qAvtQKvW/XlxUQtXlGmWiBR
         sF295LerkXho3GF886yV1Ufg3bRx5e6m2L1nqyvOHg/KiBLbtPY/xJ9i/Nv4+kbQAfEr
         43jw==
X-Gm-Message-State: APjAAAUGZ/GqfGqWSsm58ltfFavtF//y8LnjGyO5cIvP5UWTxyhqzfhO
        s+sWHdT5BpahufvcVMk8AAUSqRoqTMk=
X-Google-Smtp-Source: APXvYqz8Lr3h2GkkvEjz6Op9fiq0cVORydxuf+FbIbmToxbrgtGG9LAdaHb0cx/un4PILzSZR79OfQ==
X-Received: by 2002:a50:b7bc:: with SMTP id h57mr123835886ede.77.1560842634181;
        Tue, 18 Jun 2019 00:23:54 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id w35sm1957440edd.32.2019.06.18.00.23.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 00:23:53 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id a15so1962183wmj.5;
        Tue, 18 Jun 2019 00:23:53 -0700 (PDT)
X-Received: by 2002:a1c:f512:: with SMTP id t18mr1991013wmh.47.1560842633421;
 Tue, 18 Jun 2019 00:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <20190617114503.pclqsf6bo3ih47nt@flea>
 <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com> <CAMty3ZA0J+2fSRwX+tS-waJDLMyTOf6UY_1pHjXe0qOk5QuzrQ@mail.gmail.com>
In-Reply-To: <CAMty3ZA0J+2fSRwX+tS-waJDLMyTOf6UY_1pHjXe0qOk5QuzrQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 18 Jun 2019 15:23:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v64htYr+iRUnLx0hKkqCtYa0GbzZJEvb-ViyJFAYzU1sig@mail.gmail.com>
Message-ID: <CAGb2v64htYr+iRUnLx0hKkqCtYa0GbzZJEvb-ViyJFAYzU1sig@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 5/9] drm/sun4i: tcon_top: Register
 clock gates in probe
To:     Jagan Teki <jagan@amarulasolutions.com>
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

On Tue, Jun 18, 2019 at 3:12 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Jun 17, 2019 at 6:31 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Mon, Jun 17, 2019 at 7:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Jun 14, 2019 at 10:13:20PM +0530, Jagan Teki wrote:
> > > > TCON TOP have clock gates for TV0, TV1, dsi and right
> > > > now these are register during bind call.
> > > >
> > > > Of which, dsi clock gate would required during DPHY probe
> > > > but same can miss to get since tcon top is not bound at
> > > > that time.
> > > >
> > > > To solve, this circular dependency move the clock gate
> > > > registration from bind to probe so-that DPHY can get the
> > > > dsi gate clock on time.
> > >
> > > It's not really clear to me what the circular dependency is?
> > >
> > > if you have a chain that is:
> > >
> > > tcon-top +-> DSI
> > >          +-> D-PHY
> > >
> > > There's no loop, right?
> >
> > Looking at how the DTSI patch structures things (without going into
> > whether it is correct or accurate):
> >
> > The D-PHY is not part of the component graph. However it requests
> > the DSI gate clock from the TCON-TOP.
> >
> > The TCON-TOP driver, in its current form, only registers the clocks
> > it provides at component bind time. Thus the D-PHY can't successfully
> > probe until the TCON-TOP has been bound.
> >
> > The DSI interface requires the D-PHY to bind. It will return -EPROBE_DEFER
> > if it cannot request it. This in turn goes into the error path of
> > component_bind_all, which unbinds all previous components.
> >
> > So it's actually
> >
> >     D-PHY -> TCON-TOP -> DSI
> >       ^                   |
> >       |--------------------
> >
> > I've not checked, but I suspect there's no possibility of having other
> > drivers probe (to deal with deferred probing) within component_bind_all.
> > Otherwise we shouldn't run into this weird circular dependency issue.
> >
> > So the question for Jagan is that is this indeed the case? Does this
> > patch solve it, or at least work around it.
>
> Yes, this is what I was mentioned in initial version, since the "dsi"
> gate in tcon top is registering during bind, the dphy of dsi
> controller won't get the associated clock for "mod" so it is keep on
> returning -EPROBE_DEFER. By moving the clock gate registration to
> probe, everything bound as expected.

I believe you failed to mention the DSI block, which is the part that
completes the circular dependency. Don't expect others to have full
awareness of the context. You have to provide it in your commit log.

ChenYu
