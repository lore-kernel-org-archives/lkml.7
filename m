Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C6CC3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009FE20656
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fBkJ88s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfHTUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:25:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40578 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbfHTUZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:25:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id h21so5157888oie.7;
        Tue, 20 Aug 2019 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fc34abKerT0nPG4qWNGEOV2EVuAycG0riw7i2ox9yUk=;
        b=fBkJ88s3Sl7hR+LtD4mnyE9oZ8hFiNp+F82w7KlKpL+WVEQI7PbprE1o1IdqxF20DD
         9ethXaUt++4J/MSknm0LfoFpFz6ohOgVu5OGErdkm7ebnwY0iiKNiVRaJd+62Xb+4wKw
         h4Vp3dbaJzV61BQ1eyVK7tP8IPCzVBCg/kjrdfmcEj/1wM7wO6syhJFsabY1J7g8MaRY
         ulLhBPFe68b3qtaiGHwDPtd7eAv8ofxLidTnefTEit8njByNJyC2pl5Tgxrk+YobaC9h
         ghA9JjzIJnMpQjLai2jhM0RZK6Tt86viJDXCb4hDOEObm8oW6UpjQ5dJSW/KZ2sk+ZGA
         gBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc34abKerT0nPG4qWNGEOV2EVuAycG0riw7i2ox9yUk=;
        b=njhsjsmB3B7tN0ZZMGyAH0i5v20hQn6Zc82UNTXet0hceIZDcKNzeMHYaRt3zQ0jXl
         ASA/H58NjgeOZxh0d/fhwiVveqzGN878FPMoENoGbgfd4K4nLnpCg2fIt/jWdP8bvdV8
         9c86aehOWJVIMTVZo4uo+BFjpd9myMpcuI4vrzrdcHGW6fn7/5Ia4bP+KQr4DHE6pBM7
         rZ5duUyCx29TDgZTYdB4/QhY3RveOhen1Xyrh35cW6OuqWwR59Bj29UjAGzYO8sPYR4A
         2aNSjGiI4+Q1JW4GvUOpQjY+61+TYxhjBl2HRpl1o/Hmcr2da6nAM6stiUgsiq26Ac2V
         xpsQ==
X-Gm-Message-State: APjAAAWm0WkD205I/8iFpyifFm6jPyt66AJEVflfUpUBD7hfXbrzkp49
        1B8F9QgkK8JlxUfNHRbusIHw2gJlUuK1g40dXqlWs0VG
X-Google-Smtp-Source: APXvYqxo1sZ3HBbbN4X+uoYcquUBFmZBWM+y+N7/M8IBj5mi9mXhFK+scq1wTO0nilDocSU6lZHQGQnDlc1YSx2p0MI=
X-Received: by 2002:aca:d650:: with SMTP id n77mr1406061oig.129.1566332732940;
 Tue, 20 Aug 2019 13:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-13-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-13-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:25:22 +0200
Message-ID: <CAFBinCCJPm+FjMTK+-Qik4x-UtLibH3FTozHG8gMet0e5Rf9bg@mail.gmail.com>
Subject: Re: [PATCH 12/14] arm64: dts: meson-gxbb-nanopi-k2: add missing model
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxbb-nanopi-k2.dt.yaml: /: 'model' is a required property
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> index c34c1c90ccb6..1a36d2bd2d21 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> @@ -10,6 +10,7 @@
>
>  / {
>         compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
> +       model = "Nanopi K2";
this should be "FriendlyARM NanoPi K2" to be consistent with other
boards (for example meson-gxbb-odroidc2.dts)
