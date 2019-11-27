Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57682C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CB52075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZLPCoWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK0QbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:31:07 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:39393 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK0QbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:31:06 -0500
Received: by mail-qk1-f177.google.com with SMTP id d124so4850306qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 08:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BW8Iv3F/t56rMQHhfpUtEUowOT8/SKG2l+YOWV4ch3Q=;
        b=DZLPCoWWf9i/wY3MVP1zzdkriDFBGt6cV8bQnsF+Ln3QBVp1IbVekkQm8L9+zFtkEW
         o4qxi+keC9Zj/naaZlTlxv41GMTcEbr4c0G2Yw8BC73boBIr5mGPfij0xc7zy2x/b6Yq
         TofhfxOi84OqqmAaK+XbdfgBfkhRGEkQpHi3Y6CydRTaMYbdZvo4A/X3Grcoat5DuzOi
         +0sGaBUgWV1EnHawe3Nf+HZFTnl0zLFQq/q4bbvdb2wb5KZkNr9ydFffZsVxwE/bXxnT
         eJbYQqkAJoeRbaDeOsJJDLwBnt+n/YNg0hYZBv9/IcyW6Aegaxgu1GXv4g0qKt+qyT5y
         Qd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BW8Iv3F/t56rMQHhfpUtEUowOT8/SKG2l+YOWV4ch3Q=;
        b=VW+C12HVPS0xVpYwOLw/zSMwOeaj9xRoPq/I8W6IGFDfEE7FX6GlHLPTFn3bTwA8fl
         dzNAFNwclupycV2z7pmONqwDwVab0Ov7UQORAMUHNCPv4j1IIt6qpFjsRPGTT2XiptV4
         4fKhJdlr8EX5B8Vuk34gsZklxrHZUt+i5XocfK/oeNiXW23RFxLzrqE5OYDMKQ+dYL48
         CqB+WVgntSIqrSoLtYXOgou/4JQLJ0qWYEO5G8f4zdw15IbiGEYxmSwHlsza/RNVXOzf
         t0tg4kCipKe7R3co6pVCr5vFSXrAR/OJXFwsaqlPkBYwUTX9i3tfAVcRo9i2pbYU/fwj
         cBuA==
X-Gm-Message-State: APjAAAUTj0JwS/3U1cig4OAMe9H+bcI6bJdlcT3wMttIBEORzTHWXytt
        1/kt4qiLiIMycwcUunCLTCgYTWgQdoPzirUivXE4tg==
X-Google-Smtp-Source: APXvYqwdJ1XE2muy3vyx4R8AKGSK9LqACjb+OkAbWKhSS1EzFIwSHnHXkEHGgdc4XKpW8iSqXpPRgCxd+W7JrLtsQVY=
X-Received: by 2002:a37:7f45:: with SMTP id a66mr4762213qkd.427.1574872265669;
 Wed, 27 Nov 2019 08:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-29-mihail.atanassov@arm.com> <20191126193740.GC2044@ravnborg.org>
 <2161383.jsAorMfJJG@e123338-lin> <20191127161907.GA17176@ravnborg.org>
In-Reply-To: <20191127161907.GA17176@ravnborg.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 27 Nov 2019 17:30:54 +0100
Message-ID: <CA+M3ks43CrCqXiQzs=Y2hd6_Z7TK36h98tGHSOGi3BPoWMX9WQ@mail.gmail.com>
Subject: Re: [PATCH 28/30] drm/sti: sti_vdo: Use drm_bridge_init()
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 27 nov. 2019 =C3=A0 17:19, Sam Ravnborg <sam@ravnborg.org> a =C3=A9=
crit :
>
> Hi Mihail.
>
> > >
> > > I can see from grepping that bridge.driver_private is used
> > > in a couple of other files in sti/
> > >
> > > Like sti_hdmi.c:
> > >         bridge->driver_private =3D hdmi;
> > >         bridge->funcs =3D &sti_hdmi_bridge_funcs;
> > >         drm_bridge_attach(encoder, bridge, NULL);
> > >
> > >
> > > I wonder if a drm_bridge_init() should be added there.
> > > I did not look closely - but it looked suspisiously.
> >
> > My goal with drm_bridge_init() was to get devlinks sorted out for
> > cross-module uses of a drm_bridge (via of_drm_find_bridge()), so I only
> > considered locations where drm_bridge_add/remove() were used.
> >
> > Would you be okay with a promise to push a cleanup of this one and the
> > one in sti_hda.c after patch 1/30 lands in some form? I'd rather not
> > make this series much longer, it's already pushing it at 30 :).
>
> Absolutely - my drive-by comment was more out of concern if this
> was missing. A clean-up later souns good.

Or you can just do the changes for sti_hdmi and sti_hda in this patch too.

Benjamin

>
>         Sam
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
