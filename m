Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA13C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B012077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwsVzige"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfHPV1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:27:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45643 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfHPV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:27:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so3725797pfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+ZQXsiG4dFvJZO/CtCADlk+/s2HQcVxge7ZEsZ75MA=;
        b=JwsVzigeqeonkzmA6qGereNHoD3N+KunzR2inoTOrf+8mfyhAQmFS/WPodBY/Zr/Zx
         ZifH3DBLqLFUHgYIveyE0T8rvkv5PM/vc8Rs8Xj+bDUdLC7EKLj9a6ZqNbJdcPFbVrfC
         DYUG7UXtae/wvzcFeipGvQq7qgjrrSNA4OMtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+ZQXsiG4dFvJZO/CtCADlk+/s2HQcVxge7ZEsZ75MA=;
        b=dyxcEE/P7THomWBqdNODiPAEG/3aOdhke2BK7eBgcNLtJeKbXjfy2gw6QQwl0FZXMM
         4MhfVcAyLBc/YZFZz4TMi/9ZGNthp/fPlrkxp5SYhTrwaZ7hIJigKg8lwH3Wm0kmUV4n
         143sTehCtf4thTVzryhsrKsWTKkUzwjjXBm1tqucZlJA1EWMha8CT5GqaqjvrBCV7082
         K1wo1+VC/tdksapL/lkB048rYPd//a6u/TrKeyUkBs5UYaw0AYh/t3LZnCtAhdxllsqC
         gC5Yq1YzBl0VVw/tr249pxYOJRZjClPudO20kxb9PIaRYVzLnhJsac8ksyvbUE4Jkfae
         F5gg==
X-Gm-Message-State: APjAAAWtWgQXHLr8U39IVnu66yDSDayVPD19U0AkOX8sQ5Z4K814ieCo
        H+E1v7Segoq3NvjWbe3Bm6sOqw==
X-Google-Smtp-Source: APXvYqzbeuEjhrZHzS2dfMcNDL91d/TEzw4enwa88Gi11sQXjvhfKaU/LEFoIDh62jfymEIREP68+g==
X-Received: by 2002:a63:6904:: with SMTP id e4mr9352982pgc.321.1565990852019;
        Fri, 16 Aug 2019 14:27:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 136sm10761162pfz.123.2019.08.16.14.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 14:27:30 -0700 (PDT)
Date:   Fri, 16 Aug 2019 14:27:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 4/4] net: phy: realtek: Add LED configuration support
 for RTL8211E
Message-ID: <20190816212728.GW250418@google.com>
References: <20190813191147.19936-1-mka@chromium.org>
 <20190813191147.19936-5-mka@chromium.org>
 <20190816201342.GB1646@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816201342.GB1646@bug>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:13:42PM +0200, Pavel Machek wrote:
> On Tue 2019-08-13 12:11:47, Matthias Kaehlcke wrote:
> > Add a .config_led hook which is called by the PHY core when
> > configuration data for a PHY LED is available. Each LED can be
> > configured to be solid 'off, solid 'on' for certain (or all)
> > link speeds or to blink on RX/TX activity.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> THis really needs to go through the LED subsystem,

Sorry, I used what get_maintainers.pl threw at me, I should have
manually cc-ed the LED list.

> and use the same userland interfaces as the rest of the system.

With the PHY maintainers we discussed to define a binding that is
compatible with that of the LED one, to have the option to integrate
it with the LED subsystem later. The integration itself is beyond the
scope of this patchset.

The PHY LED configuration is a low priority for the project I'm
working on. I wanted to make an attempt to upstream it and spent
already significantly more time on it than planned, if integration
with the LED framework now is a requirement please consider this
series abandonded.
