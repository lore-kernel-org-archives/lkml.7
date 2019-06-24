Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E62C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3B220663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mDON5sJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfFXUDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:03:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34451 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbfFXUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:03:53 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so1822183iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MODC0ogg5YjkQPNkOGskIKtf6/ZXAORt86to46yuFlo=;
        b=mDON5sJTCH+vmc//kOAbSHoxD8EtwXQ6+vuQPeBBhNsMTrLo/I/oEiAaPrFWCRuY6s
         ucBjK3P6JnSVNSVjGZ++u+kSgkjIOYZt2ClKfKnxD5GySnrg+Otjy1+pkblkmRhJR9UM
         OpsEFGn9pSmHlkpUUiqT+l1a9UmKWbf8YDGRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MODC0ogg5YjkQPNkOGskIKtf6/ZXAORt86to46yuFlo=;
        b=YEYFIjJyqBqZlfbpdPtOeABCTUVkpEB/4QbSTVsuTdA65AKieA3P8PaGQVs6mradxz
         24JwBjHiR2tZnLdKsQTCMEEEKuqsfPRtmXFOoUVfCJ7KRnhDu26RNNkej9rfvItLtE8Q
         VvZwoAOrg0KgtDQL/EFBPprpIh4ir9nlIEtIAPzolnUlp/2gMdIpA3OwPWb77Cbhx3Md
         tzra6rYMpT9MCAkDKVNjdtkKJMBCqoiHdnKEHcaFOvqK3awe8BEycqTWiL3PefM30UxT
         C6a3MjsuKtJl0AWMOcSbvOI5/85NaCNHE4vnwRuFDZlJtVXnJWSxT/TBvJcyXrty8Hx3
         IbYw==
X-Gm-Message-State: APjAAAUfRmooByrNcH2efVsHiW0qZKNSefzJzBpoBp4KYdphEXfvIRz0
        Y3+E/pMddf3MG2fV3wzN/BKWPBJnP3Y=
X-Google-Smtp-Source: APXvYqwZrj5tc6xOZGBmdazy88Jq94idULrIYBUSlBt062/KmmbxEn9k9jxvDlehc3EUCtZo2PXvkA==
X-Received: by 2002:a5e:8913:: with SMTP id k19mr22632335ioj.155.1561406632512;
        Mon, 24 Jun 2019 13:03:52 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id s2sm9515658ioj.8.2019.06.24.13.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:03:50 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id k8so1821849iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:03:49 -0700 (PDT)
X-Received: by 2002:a02:a48f:: with SMTP id d15mr14797429jam.12.1561406629525;
 Mon, 24 Jun 2019 13:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190621211346.1324-1-ezequiel@collabora.com> <20190621211346.1324-4-ezequiel@collabora.com>
In-Reply-To: <20190621211346.1324-4-ezequiel@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jun 2019 13:03:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDswMa9X2QxRX9gRnY9=Y2ELMNOZvGZCz4g6fi2c6oEg@mail.gmail.com>
Message-ID: <CAD=FV=UDswMa9X2QxRX9gRnY9=Y2ELMNOZvGZCz4g6fi2c6oEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: rockchip: Add RK3288 VOP gamma LUT address
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 21, 2019 at 2:14 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> RK3288 SoC VOPs have optional support Gamma LUT setting,
> which requires specifying the Gamma LUT address in the devicetree.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from v1:
> * Drop reg-names, as suggested by Doug.
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
