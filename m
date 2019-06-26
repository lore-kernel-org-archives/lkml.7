Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B4C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E38216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOdIhYXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfFZOsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:48:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45116 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfFZOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:48:20 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so5551782ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgyZrV/0GXyIl5zMpVdez37+pt0NN6PZa+e8Yh9Hijw=;
        b=dOdIhYXTF+no3YlbD2CeiKg6dat5l5CZOYD1xXFNvcNIBlAs26LBlatTYEcR2hhgI7
         H9zsMLsH3VQ22LOEebISJz7Gu5FaNqEkZLSey44RurxttEJ7oggMzJFFrJxCMhUlqrk1
         Z9EaitNaYGsRLgbaGEakPUC+tbKPTUuNIqIRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgyZrV/0GXyIl5zMpVdez37+pt0NN6PZa+e8Yh9Hijw=;
        b=udBGIdplMEeamVlnShebmWgwfAVFvnZAerNbNG1QtX/uqtNf628BXHttYRP0ojLpyu
         KoX8R/MZlV+Z/kx2jGlwEbD5Wkhh+OMZwB1QdEkp7sobEyE/ZCagqmcc2SH6Du8sKneo
         H4woqtIVdpagzHKzbkdtQCvzRtxIfOuUuXNXOGH1vTCOO+D1IoBqyZR/fpRQclBduQmG
         JyL9akTdtbq/+U5zEh/nLpOay3fLps8fU67En9hnk7yi2JpE9Scds6Avw01t4bVqlFWw
         EHC798UpJLN2rimHJks3grtBeNSLFQmBOAd0tbp3JqKtY2wFqZl52QVHi+EYSoiEdRTJ
         R91A==
X-Gm-Message-State: APjAAAUevUotAinwowucdv4qNV0YNLINBsfyraJo8mzSGGD6o9F4cl27
        LzMQvOp67zRn/OcCxY7gPNzNRe/KNJ8=
X-Google-Smtp-Source: APXvYqzPYPe/3VQOu4/ziMa9y5ZTOaWsOhw2n/NqWDo8qlRsecYsVJNshQ4/yOUZL0+TD/gHSZo+8w==
X-Received: by 2002:a6b:4e08:: with SMTP id c8mr5132563iob.217.1561560500075;
        Wed, 26 Jun 2019 07:48:20 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id u187sm34588394iod.37.2019.06.26.07.48.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:48:19 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id h6so3964785ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:48:19 -0700 (PDT)
X-Received: by 2002:a02:aa1d:: with SMTP id r29mr5324399jam.127.1561560097502;
 Wed, 26 Jun 2019 07:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org> <20190626130007.GE23428@ravnborg.org>
In-Reply-To: <20190626130007.GE23428@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Jun 2019 07:41:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4UU8q+CS76uuuGUP=EVnE6+BTUf8U=j7uwfczNgkrZw@mail.gmail.com>
Message-ID: <CAD=FV=U4UU8q+CS76uuuGUP=EVnE6+BTUf8U=j7uwfczNgkrZw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 26, 2019 at 6:00 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas.
>
> On Mon, Apr 01, 2019 at 10:17:17AM -0700, Douglas Anderson wrote:
> > I'm reviving Sean Paul's old patchset to get mode support in device
> > tree.  The cover letter for his v3 is at:
> > https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html
> >
> > No code is different between v4 and v5, just commit messages and text
> > in the bindings.
> >
> > I've pulled together the patches that didn't land in v3, addressed
> > outstanding feedback, and reposted.  Atop them I've added patches for
> > rk3288-veyron-chromebook (used for jaq, jerry, mighty, speedy) and
> > rk3288-veryon-minnie.
> >
> > Please let me know how they look.
> >
> > In general I have added people to the whole series who I think would
> > like the whole series and then let get_maintainer pick extra people it
> > thinks are relevant to each individual patch.  If I see you respond to
> > any of the patches in the series, though, I'll add you to the whole
> > series Cc list next time.
> >
> > Changes in v5:
> > - Removed bit about OS may ignore (Rob/Ezequiel)
> > - Added Heiko's Tested-by
> > - It's not just jerry, it's most rk3288 Chromebooks (Heiko)
>
> What are the plans to move forward with this?
> Or did you drop the whole idea again?

At the moment I'm blocked on Thierry responding, either taking the
patch or telling me what I need to do to fix it.  I saw Sean Paul ping
Thierry on IRC on June 3rd and as far as I could tell there was no
response.

https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2019-06-03&show_html=true

...and as you can see Heiko pinged this thread on June 14th.

Thierry: can you help give us some direction?  Are you uninterested in
reviewing them and would prefer that I find someone to land them in
drm-misc directly?


-Doug
