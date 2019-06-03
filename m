Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0118C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A7025ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YI3bF1wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFCVpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:45:11 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36531 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:45:11 -0400
Received: by mail-ua1-f65.google.com with SMTP id 94so7065131uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abYS+Uz7A281R7NvC6O8zM/sshSHcswm8DbDdd1frRg=;
        b=YI3bF1wxRrFFyQe1fOOz0HEeP24BXNJUB5WaMcuJQiiEXYicZaZjP+RDPlt4vZZTFG
         eXNqIAopT3I9G6yVvErYwCBjRHaou0mmLJA3k221pf03KQ0A+QkDPr4pbAevxP3HQjos
         ANB17tDD0zu4EM4sRMHhzs02e9QgRsbY7hTmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abYS+Uz7A281R7NvC6O8zM/sshSHcswm8DbDdd1frRg=;
        b=HkD5E4jbJNGvpJ9wy+Ea9vWhoGQT3xU2yvhPFSnsc5ZMqDUxMxWasrKHXF5bBpCw8a
         BzGTLb4PvIFYi89Qtrzu7FD2s1N04UyXYJtErt5h/jClbGnU4x8XcWFrhc0hkoAUuuqB
         QUHtrUL7r46NBHYyI9X+tLg+qGSxlVEDNaAoaWf6zX1oBLUiCET/0Ki7c7pDp6xOXvqL
         Bc/lNnJiVFuemohS7YdmimDouysIUQLQpwfWiNydX+fgFLPajs6qZk/MCr91uZlJaup0
         WHmykM0FSWAU12cWVZ+GviSbWA/xuKWFfYnVGcjoYrScFTQx3OyksIAt5Krk4uXFkt3M
         Z3Wg==
X-Gm-Message-State: APjAAAWIc2lc1lyYPO9AO4Su77+I2QHpOaHXxJLDAFoe8BrItaR7qYg6
        jRMSbQkrTMbIn0R176aupjuzdjrFgoM=
X-Google-Smtp-Source: APXvYqz7gHf82JbZ7jJUpsU8XARYof6sZHonHDJEUVfIy7qAFR4gg7BwIKBWAF4vQbt1SjOUJ41Yfg==
X-Received: by 2002:ab0:1849:: with SMTP id j9mr7768803uag.75.1559597841541;
        Mon, 03 Jun 2019 14:37:21 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id s24sm5494835vsj.26.2019.06.03.14.37.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 14:37:20 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id 7so7061191uah.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 14:37:19 -0700 (PDT)
X-Received: by 2002:ab0:670c:: with SMTP id q12mr13608918uam.106.1559597839129;
 Mon, 03 Jun 2019 14:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190516214022.65220-1-dianders@chromium.org>
In-Reply-To: <20190516214022.65220-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Jun 2019 14:37:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ukt+Y=CNDR2uRLx5JhwyBK36UH4fCaY00a3FoMm-0VCA@mail.gmail.com>
Message-ID: <CAD=FV=Ukt+Y=CNDR2uRLx5JhwyBK36UH4fCaY00a3FoMm-0VCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: bridge: dw-hdmi: Add hook for resume
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent,

On Thu, May 16, 2019 at 2:40 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
>
> 1. You lose the ability to detect an HDMI device being plugged in.
>
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
>
> Let's add a hook to the core dw-hdmi driver so that we can call it in
> dw_hdmi-rockchip in the next commit.
>
> NOTE: the exact set of steps I've done here in resume come from
> looking at the normal dw_hdmi init sequence in upstream Linux plus the
> sequence that we did in downstream Chrome OS 3.14.  Testing show that
> it seems to work, but if an extra step is needed or something here is
> not needed we could improve it.
>
> As part of this change we'll refactor the hardware init bits of
> dw-hdmi to happen all in one function and all at the same time.  Since
> we need to init the interrupt mutes before we request the IRQ, this
> means moving the hardware init earlier in the function, but there
> should be no problems with that.  Also as part of this we now
> unconditionally init the "i2c" parts of dw-hdmi, but again that ought
> to be fine.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - No empty stub for suspend (Laurent)
> - Refactor to use the same code in probe and resume (Laurent)
> - Unconditionally init i2c (seems OK + needed before hdmi->i2c init)
> - Combine "init" of i2c and "setup" of i2c (no reason to split)

Are you happy with this now?  Even if you feel like you don't want to
give it a full Reviewed-by, it'd good if you could confirm that I
handled your suggestions properly.

Thanks!  :-)

-Doug
