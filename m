Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F24C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CDC208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfFNDfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:35:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35026 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNDfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:35:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so1391895edr.2;
        Thu, 13 Jun 2019 20:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5X0bylW7cnZXlc8waXhJ/q/kNkLK/1K8QN94+coOFM=;
        b=HoMLm1sI+abrc9ngyGIkfX93s2SC7q9Z7m7/LUtI19TypMcL0hSQPNeWuWnhzj64SM
         yQgqp/9o/r/bBBsQJ/8N+XpYJsy+P3kLfVccrrWGIEKUs9qJdVbhgjHDxNYpzOysGoy/
         mDsgQD91sueog8ixD/eRdpD3DoNJc4Fe4ST1dvQkrf80xqk+F/FkFboGYszuIk7+FNLs
         u8L28QoDnWuunSjHkUMsJRd4UM4QXhiR3mK61cFBb2uLGHCpq5BLOALtHPuh+PEs7yfi
         L9cQ7cvu7sGiJGf4MGnAt4kY8DEcYyR/JdZq7eVNz5QYoYWwVKAdDdzY9aI1dR2RwXT2
         gWUQ==
X-Gm-Message-State: APjAAAUKQPJS2u7ow2irz4UYL+gxNkmSI+dcKi7p7mrzZVE38GM4rC5E
        kbhZin01S8HWn5BqoDntMq9Cm/xapy4=
X-Google-Smtp-Source: APXvYqwuCiURIA/FEBO8t18uh8Wp15E+xhYHlpu+1sQMUUU9bAbIsMjVfOpuBC5Qow3Uw24Epu2z2w==
X-Received: by 2002:a17:906:3e8d:: with SMTP id a13mr15385478ejj.71.1560483310227;
        Thu, 13 Jun 2019 20:35:10 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id r14sm485940edd.0.2019.06.13.20.35.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 20:35:09 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id d18so901674wrs.5;
        Thu, 13 Jun 2019 20:35:09 -0700 (PDT)
X-Received: by 2002:adf:fc85:: with SMTP id g5mr62068736wrr.324.1560483309487;
 Thu, 13 Jun 2019 20:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
 <20190613185241.22800-3-jagan@amarulasolutions.com> <CAGb2v65xuXc4C1jOyM1GbEFVDam5P-6NN0ZhtzwzA7qU5F3nJQ@mail.gmail.com>
In-Reply-To: <CAGb2v65xuXc4C1jOyM1GbEFVDam5P-6NN0ZhtzwzA7qU5F3nJQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 11:34:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v67DY534hXrx2H4jnZXA7jJS7sq2UwYCqw1iAgyLKdNzgA@mail.gmail.com>
Message-ID: <CAGb2v67DY534hXrx2H4jnZXA7jJS7sq2UwYCqw1iAgyLKdNzgA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/9] drm/sun4i: tcon: Add TCON LCD support
 for R40
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
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:19 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Jun 14, 2019 at 2:53 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > TCON LCD0, LCD1 in allwinner R40, are used for managing
> > LCD interfaces like RGB, LVDS and DSI.
> >
> > Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> > tcon top.
> >
> > Add support for it, in tcon driver.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

I take that back.

The TCON output muxing (which selects whether TCON LCD or TCON TV
outputs to the GPIO pins)
is not supported yet. Please at least add TODO notes, or ideally,
block RGB output from
being used.

ChenYu
