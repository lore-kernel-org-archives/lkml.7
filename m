Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF7C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14D420896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnbqCKr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbfFKMGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:06:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38750 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfFKMGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:06:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id o13so11353678lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZXirDOut9vTqPwIy2+NlkcxYvoX0FlWKfU61yeOlXc=;
        b=YnbqCKr3jMbW1jUhQ7uQsXIvK/YeDj1P1hgI7tJ+yc2M760ar+rV2fnGcMxMFQx1wT
         FiO54DDsoHx/hhRaCgxZ2iqXcQKCL8fvsP8wrc4ZlWO47rqYOxJV6vilfqgBx9UaGc19
         dusFW2VjVyYmmklpJOfiOsnPGkzLf8G4gxxQDFLdU2qryMV3Dp23bEQWkd06axjVSiXG
         ducOaewG12zHLktAQRNFRqdfSdzNduv62pfY/+nKDqAcU+Ks3v/7V+8z3F6IOcsKN0Kl
         +u7KB2SOYLU957Xzo3/dkqbsKM9+yCMXUHiGWah/opMPIJTsTSPnF4iDDTXkDov3Ulvu
         u+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZXirDOut9vTqPwIy2+NlkcxYvoX0FlWKfU61yeOlXc=;
        b=XtAUbrq4IHJ649FJaP32mJ/PeNQvh9nQyyazf17R0ViEImmbLc47jwE+KfgRBZ4BBg
         rj+n895fCyrc0xe4K4JuKlwCifxNfsiVhEDZxOCuu4tUNp/DfaizyJ9sUOcbWbe7CYEh
         CpIS1pC9Ag6YoBfhVFK7YGEeHG6H6dxTLG9rAF+eD7bZqNfC6jTY0+KvqSG/aeGzapOn
         7bGl9HeYz9yiZM4kinsDrmJ1JJsVuPT8esaw6DjmizAI5SGv6ZGKc2s78PXKj7zUNvfF
         eMGWtrKaYOZ+2p8tOXa06cNI8PnwMlPLUgiAnF6IxWNrB0UFMhw++sthmJyw0PjoM3f1
         /RPg==
X-Gm-Message-State: APjAAAW2BJzpvfPwGDqwpdEVz5wB/VhR7DDhvxCu+NZ34II2+URFFauH
        PTkL1ALWQ805S8sB75rS4PS7oGy35t7Hq0bzfbo=
X-Google-Smtp-Source: APXvYqyNbKW8MLdfiFF2bBbCPn6JlewYUZ4cSvk+vV6vxfgRu10IAU5IRNihSdhfyXPovuQjMfLgF6htx5YUpU9HpCk=
X-Received: by 2002:a2e:a318:: with SMTP id l24mr27777904lje.36.1560254767023;
 Tue, 11 Jun 2019 05:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190610175234.196844-1-dianders@chromium.org> <CAMavQKLRm8uYu3O=co5Ui7YjkK0hKHAd=+TA0oExfqnLc+TLFA@mail.gmail.com>
In-Reply-To: <CAMavQKLRm8uYu3O=co5Ui7YjkK0hKHAd=+TA0oExfqnLc+TLFA@mail.gmail.com>
From:   Erico Nunes <nunes.erico@gmail.com>
Date:   Tue, 11 Jun 2019 14:05:55 +0200
Message-ID: <CAK4VdL0jph-LzkRai=6nLahgrvG0cFNt5N3GNGjKAE-G0jc38A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: Fix unwedge crash when no
 pinctrl entries
To:     Sean Paul <sean@poorly.run>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:51 PM Sean Paul <sean@poorly.run> wrote:
>
> On Mon, Jun 10, 2019 at 1:52 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In commit 50f9495efe30 ("drm/bridge/synopsys: dw-hdmi: Add "unwedge"
> > for ddc bus") I stupidly used IS_ERR() to check for whether we have an
> > "unwedge" pinctrl state even though on most flows through the driver
> > the unwedge state will just be NULL.
> >
> > Fix it so that we consistently use NULL for no unwedge state.
> >
> > Fixes: 50f9495efe30 ("drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus")
> > Reported-by: Erico Nunes <nunes.erico@gmail.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks Erico for the report, and Doug for fixing this up quickly, I've applied
> the patch to drm-misc-next

It does fix the issue. Thank you for the quick fix.

Erico
