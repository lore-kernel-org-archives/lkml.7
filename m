Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10346C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EB62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A0HkQWrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfEOVsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:48:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36277 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfEOVsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:48:01 -0400
Received: by mail-io1-f65.google.com with SMTP id e19so879041iob.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sWbpZHBe6YpRVe1pQMe2dJ3Y9vgwQ34ZV5GLEWuVB0U=;
        b=A0HkQWrQJKaLnNmrfgjL/E9/qPkQ5KNszllhY23b3Pf7LUv30duqOeqydt2saWLPj2
         5cmD3znaPpqshHiIWvtIn+5m9v5HZsPoVO5T0FXibljEZ1/7Us+Pd+VZQF1Rzjzdu4iu
         uUBiTlXqo+RQIYOCi+GZNkubLOExpLqSVQ5hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sWbpZHBe6YpRVe1pQMe2dJ3Y9vgwQ34ZV5GLEWuVB0U=;
        b=tj2uWsLIO62TJk9K5dyYpXNCMeEZeCSJuR1O3Sqi1YePnzQSxZ/v7PPBiVuy6qTSTs
         y3jAR9e43yVZnhtzV1p4Q72RRnYGqXc4F/8h5mJTcuM+7JuRKAib5VJXLEKgwwJsRXOI
         bwFcupGl68wY17sTqO693CiypHPSrEudW5tgpPxTv7+w8Tu+RsdjUOTz4PMC4RW37Bsg
         6nV8/gAxuwEbunACc1w0iqIK+Qt0Qy5Bto9jtq5zb7RVjpPH+Lbp8VpLijzjEEWnsEY8
         ujVsoUZs62zCF/XRYJCQAfY8WXbc5jsNnuGOzmBazvqr85/fJ4GeXOkpApVBQCP0GBhW
         4eWA==
X-Gm-Message-State: APjAAAVRjKYsRT2Qzuazjy5M+cY9aQ+xldNXfGHwopjpkX/49BEfut9K
        69TEvBF4EwW/HocUEGPN0UxvNMkbLZE=
X-Google-Smtp-Source: APXvYqy6zgaN1FSUR13WOZV+36r1jayIO6EfLBjhuM3DJf4NRj+SG1E4CLAkVBleShYTPo7hLzcRmQ==
X-Received: by 2002:a6b:e20d:: with SMTP id z13mr24726706ioc.92.1557956880412;
        Wed, 15 May 2019 14:48:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 1sm702105ity.9.2019.05.15.14.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 14:47:59 -0700 (PDT)
Date:   Wed, 15 May 2019 14:47:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: raise GPU trip point temperature for
 speedy to 80 degC
Message-ID: <20190515214759.GF40515@google.com>
References: <20190515153127.24626-1-mka@chromium.org>
 <20190515153127.24626-2-mka@chromium.org>
 <CAD=FV=XgoG5hiT=vAhNtUF4iVj1-Lmj7S5tvk86ehxB1uUZyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XgoG5hiT=vAhNtUF4iVj1-Lmj7S5tvk86ehxB1uUZyxw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:30:12AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 15, 2019 at 8:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Raise the temperature of the GPU thermal trip point for speedy
> > to 80°C. This is the value used by the downstream Chrome OS 3.14
> > kernel, the 'official' kernel for speedy.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> > index 2ac8748a3a0c..394a9648faee 100644
> > --- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> > +++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> > @@ -64,6 +64,10 @@
> >         temperature = <70000>;
> >  };
> >
> > +&gpu_alert0 {
> > +       temperature = <80000>;
> > +};
> > +
> >  &edp {
> 
> Similar comments to patch set #1 about sort ordering.

ack

> ...I'll also notice that if we do end up setting the "critical" to 100
> C for most of veyron then I guess we'll have to switch it back to 90 C
> here for speedy to match downstream?

yes

> Maybe that's an argument for doing it in this patchset so we don't
> forget?

sounds good to me

> I'm somewhat amazed that downstream has only 10 C between "alert"
> and 'critical" for GPU for speedy, but I guess it's OK?

In tests on other veyron devices I observed gradual temperature
in response to CPU or GPU load, so unless there's a sudden spike in
the ambient temperature I think the 10°C delta should be fine with the
current polling interval of 100ms.
