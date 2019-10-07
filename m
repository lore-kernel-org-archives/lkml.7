Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FCF205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFDyTPz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfJGQJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:09:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45741 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfJGQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:09:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so15952815wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqJ0vbvGAeolZd2vSOe/7rP/jwOR0aoF9Fh0aImNAAY=;
        b=fFDyTPz/c3ABifR0uGkkFfA3T4wZKNjifQ194u3nCRCSJY4LsrTNWUeX1jcPlWprOT
         1MbCxB6ZLCVa430OOIZ454NIJujssKIzCSNwDei2E588Ha11s/YCWG6fqB/iW/sg7IDn
         EKihD2BfJp/c+a2C1d7MMJtVJ0AtgOI+Dqmo6gh7UYAKDQPfvGhnHsJ09EYKGzM+OY0M
         /2mwRPdsmLRIdWqNOFGBQOZoTlAvdt7s/xNAeCGCodT/fTDwgYd2cJsc0kUPShUL3xo6
         OpkBqoyI2EUTaQZdGRJmaAHyw7l5AOFFufhTCbCHLQj94lPqsNlBoE3sPz6oMdFbfna0
         KNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqJ0vbvGAeolZd2vSOe/7rP/jwOR0aoF9Fh0aImNAAY=;
        b=SHEkk9lPiNwFExq5rBpJYg9lsQ0MDoDBKwPyGEQ5RcFMVpEiAzMjPRb9V35uR2+ph8
         AaJpaWf6BmIUaE43JGl1pjxySvCB5dPAO/PCeS0PoLs2YFDuAdErOIvD/eVKj/0bvbmD
         /IhzaMb+e7NUvvcZI2GlOnoLPRKxEpl14G2Wd5O8Xgu+nnGgoCthPDN5TJ9mUI6ojvXG
         zCWvYQZBGW4b5kWH7N2oPfgQG/GrRKL9Jrf0sOj0VIVl6svpMxgzrgxGKxBliBHCwZ+D
         z1VVUo0v2WyNWtJQe+w518P48e7c3n+Hike2SgZxmPnwyWlGBhP4rboO7HGdCxsZxXb0
         ua8w==
X-Gm-Message-State: APjAAAXfbqlTxEErrj0iWOsKfbllPV8OMIXCmKaZMeVs2uSJczDTkVNm
        D/7ND5K/Z6ZSZwidrXYfcZjZpbBC2BIOyLezexQ=
X-Google-Smtp-Source: APXvYqxgHqJZNgIWzKRUTN0lTc9yubZcuhBGUiP8kclFNKByTkdixaX3OZuWxl98eB2sTzFDMiLudNl4WXyL54+19BU=
X-Received: by 2002:adf:e951:: with SMTP id m17mr22737714wrn.154.1570464592558;
 Mon, 07 Oct 2019 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191004144549.3567-1-krzk@kernel.org> <87sgo4hjii.fsf@intel.com>
In-Reply-To: <87sgo4hjii.fsf@intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Oct 2019 12:09:40 -0400
Message-ID: <CADnq5_MqGehpWwOAxYg0T2x3qXisqmae2uGG5dijQX+Aa4NsoQ@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL v2] gpu: Fix Kconfig indentation
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 7:39 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Fri, 04 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >  drivers/gpu/drm/i915/Kconfig             |  12 +-
> >  drivers/gpu/drm/i915/Kconfig.debug       | 144 +++++++++++------------
>
> Please split these out to a separate patch. Can't speak for others, but
> the patch looks like it'll be conflicts galore and a problem to manage
> if merged in one big lump.

Yes, it would be nice to have the amd patch separate as well.

Alex

>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
