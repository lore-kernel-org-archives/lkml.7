Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAD3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23FB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9vPofbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfEOSgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:36:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38824 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEOSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:36:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id v9so594394vse.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xAR9pN5InwiER09ljeYKEHWdfzCaHDHyTua6zX9tIs=;
        b=E9vPofboNKcy0FTkvpv3g/b9WDCcxyg+n3xLdnsOiOs2BDOldqtgH7ArPscDExXX0n
         GrzaTXoe/AzxIS0mIgOsDEk7BkbsJL2kuG0lJaj7BHIjjo2Zun1ez1IN4k8qlwFeoNqA
         k8fVPBfuKl9HBnvUOH+lzUb1Yjr12oKGw78uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xAR9pN5InwiER09ljeYKEHWdfzCaHDHyTua6zX9tIs=;
        b=pFnZn/n1+RNIW/X/owvXAQVXX1sUF3V/WutWh+s+WBYYBcyWUMHTuY2Nm1BYsr03/S
         Iajy3J58hf7KwLXr+rYmOWvOigBJF0bo5Uw3iJnG7/klmAHi0zRaHH5ZCkF10OAGHH5k
         LeKS+3ZZG03+7dNcBw5q51ImdzaU+Bu4IhLeagGhMZzZPz4HGRer5WbBI/gQl9JdSovH
         iYHC0E57lHWKLXBJVT4bKIaGWLr2DiFz9m8UztmQ7XMGZXJDwptqPWdzLw1t/ckcJj+V
         9EahJ+NstDLEMnqA9RrCg2VamjO3CYr75tg/c7MbdBxfHb15r1xroXHDFjGQT5SCWJWr
         z8ag==
X-Gm-Message-State: APjAAAXJIld8qCerqPmNTsImpLHtlAtLSwDh8yY4EKs77K8lWMC13Eva
        Z9nLC3DP4W0V2G2LS02+nMGfIrbN04k=
X-Google-Smtp-Source: APXvYqwylLGYciv9eRLhdPgD0JIahz6vV0w4o7kDMO5KNBgilqphEMsXoJ0BCNzOPrmnqng2WuVHiQ==
X-Received: by 2002:a67:f547:: with SMTP id z7mr13862122vsn.72.1557945407795;
        Wed, 15 May 2019 11:36:47 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id n23sm1605956vsj.27.2019.05.15.11.36.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:36:46 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id j184so566378vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:36:46 -0700 (PDT)
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr14360313vsk.149.1557945406002;
 Wed, 15 May 2019 11:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190502225336.206885-1-dianders@chromium.org>
 <20190502225336.206885-2-dianders@chromium.org> <20190515182038.GV17077@art_vandelay>
In-Reply-To: <20190515182038.GV17077@art_vandelay>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 11:36:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WP-rFDAR28oZg+9DcrXbaYPjFCAD-dV1VR3-3_XDs-3A@mail.gmail.com>
Message-ID: <CAD=FV=WP-rFDAR28oZg+9DcrXbaYPjFCAD-dV1VR3-3_XDs-3A@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus
To:     Sean Paul <sean@poorly.run>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 15, 2019 at 11:20 AM Sean Paul <sean@poorly.run> wrote:

> > +                     if (IS_ERR(hdmi->default_state) &&
> > +                         !IS_ERR(hdmi->unwedge_state)) {
> > +                             dev_warn(dev,
> > +                                      "Unwedge requires default pinctrl\n");
>
> Can you downgrade this message to info or dbg? Given how rare this issue is, we
> probably don't want to spam everyone who is happily using dw-hdmi.

I don't think it will spam anyone, will it?  It will only spam if you
_do_ specify an unwedge state and you _don't_ specify a default state.
This seems like something you'd want a pretty serious warning about
because it meant that you wanted to use unwedge but you didn't specify
it properly.


> Reviewed-by: Sean Paul <sean@poorly.run>

Thanks!

-Doug
