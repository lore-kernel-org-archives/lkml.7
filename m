Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5966EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395F82089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfFQNBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:01:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40705 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQNBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:01:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so16052978eds.7;
        Mon, 17 Jun 2019 06:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T87ic57rQt3UfwYy1X9DryRi6OUhzyqVbWtm9GM976Y=;
        b=dHsueJQcDZtuv/eD+7UUJr9neQWrZAW4Hkedfz7gwd/0fJBQtSDXo3Twp2nrKdj+py
         KJUl5z9VJ5Amf8T6RRYihnEI5eOeXRXs826/WVr2ggv0OvJCDweRTkmYy/SGVpHuRfKl
         PFaZ5w0zTaFMdHYer9MrgXpRVwHgX6UlGcA19ctUnpNAOUec73yoe6coAFCED9PDxmQk
         u9FEhXuGiz0Sthiz0V6ArBqO1EAd4+vjUdHtB2TG87gZsKMdD3ipDTmBMMf3MuZ4/zxA
         ibN4eIIQgPNZtP23vOQktMa01yVRcSquILQmyY1f/Ox8BKl2Mg1giKOsGrk7pkDdIDGK
         2IiA==
X-Gm-Message-State: APjAAAXePZZ6AS54zp7S+hjQJFbURddSsBHGqL1lNDrwl5woc0FBwtKQ
        4I8JTAwDa61Pi7jCFsKGICYn4HxMy5c=
X-Google-Smtp-Source: APXvYqwAP0NtwmM3ET/jTI7jrWo8Uw0zRjTGoXmLzbyyKSuRNm2UV3i2mlX6S7Sq7ErI9W8wRY8N8A==
X-Received: by 2002:a50:ad2c:: with SMTP id y41mr95836414edc.300.1560776507871;
        Mon, 17 Jun 2019 06:01:47 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id v3sm1342180ejk.77.2019.06.17.06.01.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 06:01:47 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id w9so4484776wmd.1;
        Mon, 17 Jun 2019 06:01:47 -0700 (PDT)
X-Received: by 2002:a1c:c545:: with SMTP id v66mr19389774wmf.51.1560776506243;
 Mon, 17 Jun 2019 06:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <20190617114503.pclqsf6bo3ih47nt@flea>
In-Reply-To: <20190617114503.pclqsf6bo3ih47nt@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Jun 2019 21:01:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com>
Message-ID: <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 5/9] drm/sun4i: tcon_top: Register
 clock gates in probe
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
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

On Mon, Jun 17, 2019 at 7:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Jun 14, 2019 at 10:13:20PM +0530, Jagan Teki wrote:
> > TCON TOP have clock gates for TV0, TV1, dsi and right
> > now these are register during bind call.
> >
> > Of which, dsi clock gate would required during DPHY probe
> > but same can miss to get since tcon top is not bound at
> > that time.
> >
> > To solve, this circular dependency move the clock gate
> > registration from bind to probe so-that DPHY can get the
> > dsi gate clock on time.
>
> It's not really clear to me what the circular dependency is?
>
> if you have a chain that is:
>
> tcon-top +-> DSI
>          +-> D-PHY
>
> There's no loop, right?

Looking at how the DTSI patch structures things (without going into
whether it is correct or accurate):

The D-PHY is not part of the component graph. However it requests
the DSI gate clock from the TCON-TOP.

The TCON-TOP driver, in its current form, only registers the clocks
it provides at component bind time. Thus the D-PHY can't successfully
probe until the TCON-TOP has been bound.

The DSI interface requires the D-PHY to bind. It will return -EPROBE_DEFER
if it cannot request it. This in turn goes into the error path of
component_bind_all, which unbinds all previous components.

So it's actually

    D-PHY -> TCON-TOP -> DSI
      ^                   |
      |--------------------

I've not checked, but I suspect there's no possibility of having other
drivers probe (to deal with deferred probing) within component_bind_all.
Otherwise we shouldn't run into this weird circular dependency issue.

So the question for Jagan is that is this indeed the case? Does this
patch solve it, or at least work around it.

ChenYu
