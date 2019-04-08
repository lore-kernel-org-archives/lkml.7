Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86F7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904B120870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+Lrvgj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDHKco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:32:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:32:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so106993wrn.11;
        Mon, 08 Apr 2019 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bR/j8CIhN2J5U5z8XuHQYaVZXbAdpwDETs3sfEMMhNY=;
        b=m+Lrvgj6w53FbKkUYMeWEeTt/8jOqGbeIlCO0RUlGbx0rVPtWd1RdQaEorOho5UNbY
         uf+LFYsGLmrZEpK/OpYi1q5htV5ovsGIXkNULduh4vULAvNH9sLV0c8O8QIhm6UTiOAH
         gP8GAQXstGvOMgBowkCpYgehXe5vayzWJ031/OnQm00+cer4nBB24haVec5DJSejyW3j
         nn64MiwXQvRODebVNlDjsIFBUIiEBtsB+p0CJTQCbM1sWYtYKymZVnDd1LlkqKie1Xdo
         tWQUE91OtVVWO2qpDqInO/S+2YqSjPP/HynuMBLBwPP5wwpJfjq9io3GChTxQxtO6Tb+
         l6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bR/j8CIhN2J5U5z8XuHQYaVZXbAdpwDETs3sfEMMhNY=;
        b=qLHVTVXLLf8uLAf5QNkaRHFByz0adDWMFsZ3DxkEBVriTzwswlTrM2WkXbTw1nldRF
         DlmBdKgAoo641naqYhNir2I/S2KjIYpuEvIS6CwGrN+gNr2PbqfExrxEbdeMyDTqTbbR
         bbIFaqMzopDYKczHfK3+oWSjvLGSy9h2YRkDCvgDvruLaqhVMsq7M1gYUIgdGOZa4dWI
         7txjmUr6UFV3IDYaJXY2DbIGGlcuvRuRzlEB1PCGykunUpJY9lXwGFNhp0Dg9UWjnppF
         DFcqYk80KxUpdk1ktgIQUjIfgzErXJeHsKPgrPJhrdhqJxN9fuXuTaDNbjxyLyPEdypq
         XQVA==
X-Gm-Message-State: APjAAAWPQVM+Uw5Q/B08yRekTmi+khbYAdk5MzOBCtC6YTWMn47U8Wsn
        YvF62ojrRz8b+BFAds7sxGg=
X-Google-Smtp-Source: APXvYqzlUqV4F2ptKXTuXPmXsQRWICrNnmbRM3teRtOHxbXrMOwTgenDIeMaJdlF/r2hRrMW7ASDbQ==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr18075630wrw.156.1554719561671;
        Mon, 08 Apr 2019 03:32:41 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id q3sm38635414wrr.75.2019.04.08.03.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 03:32:40 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:32:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric =?utf-8?B?QmFsbGV0YsOy?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v5 1/7] dt-bindings: Add panel-timing subnode to
 simple-panel
Message-ID: <20190408103240.GF6644@ulmo>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <20190401171724.215780-2-dianders@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:17:18AM -0700, Douglas Anderson wrote:
> From: Sean Paul <seanpaul@chromium.org>
>=20
> This patch adds a new subnode to simple-panel allowing us to override
> the typical timing expressed in the panel's display_timing.
>=20
> Changes in v2:
>  - Split out the binding into a new patch (Rob)
>  - display-timings is a new section (Rob)
>  - Use the full display-timings subnode instead of picking the timing
>    out (Rob/Thierry)
> Changes in v3:
>  - Go back to using the timing subnode directly, but rename to
>    panel-timing (Rob)
> Changes in v4:
>  - Simplify desc. for when override should be used (Thierry/Laurent)
>  - Removed Rob H review since it's been a year and wording changed
> Changes in v5:
>  - Removed bit about OS may ignore (Rob/Ezequiel)
>=20
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
>  .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel=
=2Etxt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> index b2b872c710f2..93882268c0b9 100644
> --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> @@ -15,6 +15,16 @@ Optional properties:
>    (hot plug detect) signal, but the signal isn't hooked up so we should
>    hardcode the max delay from the panel spec when powering up the panel.
> =20
> +panel-timing subnode

Is there any reason why we need the panel- prefix? This is already part
of a panel definition, so it's completely redundant. Why not just name
the subnode "timing"?

Thierry

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrI0cACgkQ3SOs138+
s6EmNw/6Av1wNN5Roa8hoku4c8OavdcswUnRwEzieyEcc6eYFZLYSNb26xrVN1Ln
rbyIjZVK6CSnIxrjaEN8kYzUcyUMnr0ovP9enJ9TCCyZoTBid+E5czhmpUHjsv/R
V3yRVqTzfwrZ3lRwk+ZOnD7VrxithhIiiLiV62TsNGytGWMn02V1aTSp0+2tSrQE
aUhKgWtc5DU1wXfR6ZHp3hhuUSJKqcOECuNyJ1tRqmuTtaKiEbrRPWxX32TZhKsv
JFClYZ8CS+Lq2ybtl0tT+33dofVFSLvEsxEAxaxFixWrgcbXW0uwQxmE795WfaoC
o15jXzQJa5qbZ+hLcvPY5nVdLeMH0I1/V0vTQf3Zd1vVRKG3kT3GRMNAi2HUK5mU
ITPJdnxpGVoAEO0hGtlZGBTocb+nnWhdV9H5z1iN5bUkV2H41JoqyRT7HX+V1tjp
+c9l2kk4+K9tyZsLj0Igw9v2YvD1Hmtlvb7S2ptDD/IPHKzfgk2LetcXzcCi4leG
CtrFBFKvNWrwr1YAtDgqiSa4XRNnWyUkkA5PSdfZvtgLNsb3AEKK82mhsohMWnZB
ARHTqUYo5PFtrd1vtHB6hsEbZxZbJ913UOFFztph7OgMwPTOobUdxzP+/EJwxlD7
UvxmywqatQoLvv2RSQFrO6PzPYgfSOtf8F2sQJV0nK7DKb6pfCA=
=B+cu
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
