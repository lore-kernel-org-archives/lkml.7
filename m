Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73896C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4436B2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ung3RKmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGLQht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:37:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44211 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:37:48 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so21582792iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uamx4VkpAz7OTzGeRs+kr2OaHae670D3WH4tTrkzLk=;
        b=Ung3RKmkytToVTSIaF1K1EPHzaSzlQCF3R2XbQcAJRyz7bl1mtx5b1PJhTJ9UiIz+u
         nuYp5Vid428d8OLD/ZRfdS8NudBt+rNJ6fSN+7yt3pimr+f/ITICt1z3eTLFIAnaH+jm
         f7weMJmRsYu3sNIeBe88h9k5/qQOslWZNh+IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uamx4VkpAz7OTzGeRs+kr2OaHae670D3WH4tTrkzLk=;
        b=Tn8boxozZPjL9dQ78r9rPuEXUkKPh0CLn8CoFdxTjLm2dxjuJwJQ7EDrk/j0PQnlFy
         Ihv5C5F9TJOWTo5LeEPQ7z0CDVgOZRfNaHhkXinskTd96n34uMLUFlj2MVEpHwtQFoih
         CSf32k1t71xRImVokT39VHSDCnlDsnZ+6nxM9smfVCJYM7qs1i9vRxVM1xLvFCE9RFEJ
         afmrjQP2aUiOGKJudawUJbu9tmzG8qxX20L9Ny/A5Xdjspe87Xif33PbpcsH1OrM5V5w
         v13L6QytdrN03g0LCneMVThY90H7pLRBAsRx7l8npwc5Z/ryhJ7Bq9zsyO7no0Iwavpx
         qJkg==
X-Gm-Message-State: APjAAAUtPj0k8ilG1gYOJX+mY/Y7TpDHRbz7/rRjjpqn/ffuqrVQc/D9
        iS8r4E6LK//gMGiPhlizRnSSh7Dxd0A=
X-Google-Smtp-Source: APXvYqyjXtsBW1Lglrh9EW503iHne02LY0v/uuQhu3/sApNnJ2rdJBmAJxr4nISU6lDYBX3MfUo/mQ==
X-Received: by 2002:a5d:9416:: with SMTP id v22mr12231155ion.4.1562949467834;
        Fri, 12 Jul 2019 09:37:47 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id t133sm14972203iof.21.2019.07.12.09.37.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 09:37:46 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id q22so21660531iog.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 09:37:46 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr11787238iol.269.1562949466057;
 Fri, 12 Jul 2019 09:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190711203455.125667-1-dianders@chromium.org> <20190712060737.GA9569@ravnborg.org>
In-Reply-To: <20190712060737.GA9569@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 12 Jul 2019 09:37:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WG7SbdFu+-Kpr9JDQpNhQW+nA6tbfT2inwgTYF0mgdpQ@mail.gmail.com>
Message-ID: <CAD=FV=WG7SbdFu+-Kpr9JDQpNhQW+nA6tbfT2inwgTYF0mgdpQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] drm/panel: simple: Add mode support to devicetree
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 11, 2019 at 11:07 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Doug.
>
> On Thu, Jul 11, 2019 at 01:34:52PM -0700, Douglas Anderson wrote:
> > I'm reviving Sean Paul's old patchset to get mode support in device
> > tree.  The cover letter for his v3 is at:
> > https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html
> >
> > v6 of this patch is just a repost of the 3 DRM patches in v5 rebased
> > atop drm-misc.  A few notes:
> > - I've dropped the bindings patch.  Commit 821a1f7171ae ("dt-bindings:
> >   display: Convert common panel bindings to DT schema") has landed and
> >   Rob H said [1] that when that landed the bindings were implicitly
> >   supported.
> > - Since the bindings patch was dropped I am assuming that Heiko
> >   can just pick up the .dts patches from the v5 series.  I
> >   double-checked with him and he confirmed this is fine.  Thus I
> >   have left the device tree patches out of this version.
> >
> > There were some coding style discussions on v5 of the path but it's
> > been agreed that we can land this series as-is and after it lands we
> > can address the minor style issues.
> >
> > [1] https://lkml.kernel.org/r/CAL_JsqJGtUTpJL+SDEKi09aDT4yDzY4x9KwYmz08NaZcn=nHfA@mail.gmail.com
> >
> > Changes in v6:
> > - Rebased to drm-misc next
> > - Added tags
> ...
>
> Thanks for your patience with this.
> Applied to drm-misc-next and pushed out.

As promised, posted the follow-up patch addressing the style concerns
/ suggestions.  I didn't CC every last person here, but it's on LKML
and I'm happy for anyone to review it that is interested:

https://lkml.kernel.org/r/20190712163333.231884-1-dianders@chromium.org

-Doug
