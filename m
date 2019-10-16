Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DBECE59E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4352067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVVE9XDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfJPFXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:23:01 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45143 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJPFXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:23:01 -0400
Received: by mail-ua1-f67.google.com with SMTP id j5so6802293uak.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x84fnYes++VeBDbIo6qHMe1U6I3n9DWg2uJuSL1+ZRo=;
        b=mVVE9XDy13ZeRTLAxh6diSwqxs5+pFC+8NzUM1/Iufrxc92V1mff6IQ2f/lQ+SlJDn
         fwhahz8Fp0dOAM18EHJt+dW4hfdej+c/FrMv/bl+glt1rMaW7kwirXGR8+cTc4ngppJJ
         0NxASLZI6vL0oVsWKPbq4MKeyJZDk3DgC4I9XmM70t2nlAeoWwG6l/1kFVWI8Kn9d62l
         WGBmEd8F40veGIoAv7Rm/nx//5XTO3cI/HK2xVtXcniixv1LkJXgu5BQwuXNoCqzFRFX
         pRgdKV4oNe/IMGQB/OMGwh1dwjKnPXrePkBBF7btoaRH20gL0zeB3Bj0MpSNFwumrv6s
         IDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x84fnYes++VeBDbIo6qHMe1U6I3n9DWg2uJuSL1+ZRo=;
        b=ebnYFexDxxajZ6YxpCZA8ZcfskCV3/s9iYt2IFONFg/XLd97+N3aob9H6vQwE4oslF
         oLp7879Z9U8PPWG61SHtEW17y+3LLfnSW+azrCzB0NEtAOrRS+rGaLKBTU7K352DPWkK
         xeUTICoIcNwiKcP2k44XlhscRUDGRJUVTEUc6zza2blDKzF9dEB/qpUauZfQSNU+8dK0
         jfV3VagzKsvF1mEDy9gqkZLnHj3c3lRVazXKX+CQz0I8iAkL/CGot/EjE7mhuMtaa/YX
         jEc6LK4xjllEUv/wl+Is3Km3VjGa5ER7j6oBzZjLltgqZO4sTQzU97krNQYAm7g0o+Ol
         pKvg==
X-Gm-Message-State: APjAAAWL8ynli9Qjn2cuexl+kx2lm4ukH1lS3lHjAJVaIPU88tB7S1U2
        act2rowL5IUitr+Q2SDqPJTbZFYlIY6vElQScu9G3g==
X-Google-Smtp-Source: APXvYqys7H0IirmGn56W5Al1VbtX5v5sS8hQcM6/P5+54uaG3iq1JZw5FIQ3v0csjEffNlOhceV9HZ7UmmMXVsD17Tk=
X-Received: by 2002:a9f:364c:: with SMTP id s12mr15532433uad.77.1571203379780;
 Tue, 15 Oct 2019 22:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571181041.git.amit.kucheria@linaro.org>
 <1b53ef537203e629328285b4597a09e4a586d688.1571181041.git.amit.kucheria@linaro.org>
 <5da6a33b.1c69fb81.64cc.6834@mx.google.com>
In-Reply-To: <5da6a33b.1c69fb81.64cc.6834@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 16 Oct 2019 10:52:48 +0530
Message-ID: <CAHLCerOe=Cx0+uyLG1S9B297BbUFdqaAFKFCUVrjfy=p+qRuSQ@mail.gmail.com>
Subject: Re: [PATCH] of-thermal: Disable polling when interrupt property is
 found in DT
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:27 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-10-15 16:13:16)
> > Currently, in order to enable interrupt-only mode, one must set
> > polling-delay-passive and polling-delay properties in the DT to 0,
> > otherwise the thermal framework will continue to setup a periodic timers
> > to monitor the thermal zones.
> >
> > Change the behaviour, so that on DT-based systems, we no longer have to
> > set the properties to zero if we find an 'interrupt' property in the
> > sensor.
> >
> > Following data shows the number of times
> > thermal_zone_device_set_polling() is invoked with and without this
> > patch. So the patch achieves the same behaviour as setting the delay
> > properties to 0.
> >
> > Current behaviour (without setting delay properties to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update          302
> >   thermal_zone_device_set_pollin     7911
>
> thermal_zone_device_set_polling?

Yes, the script I was using restricted the width of the fn name while printing.

>
> >
> > Current behaviour (with delay properties set to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update            3
> >   thermal_zone_device_set_pollin        6
> >
> > With this patch (without setting delay properties to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update            3
> >   thermal_zone_device_set_pollin        6
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
