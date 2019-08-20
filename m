Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D9320656
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tj0pYCCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfHTU3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:29:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44783 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:29:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id k22so5154844oiw.11;
        Tue, 20 Aug 2019 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6E1lyHDsgDU8DiTt3vegXCDVprFaiy8n8sbPdFHGho=;
        b=tj0pYCCsetgnZSZRPyv4P8EZfHeUJz7Oq8sYze0pLvO5MNR/8KfKlfjvm9LnjZtdMm
         0RMWONs9gPFVr72LH7qMEQaEahe0nxLAEmcZK4hT7DbaqF3ExCtLpAUcIPePe4dsVL08
         InHaq+2NNvkD1PvM3BFhNrUF6owR6q7I8EHUsxO1iMoFI0OzCfCT7MX5tOM6rtC/eaNy
         yflsKa6NMo2TrgHCdqfo6WkirtzOMWWRGc/OqEEAcfE1T1skJEklkJlH+x9BBsYITb6N
         +vj1lFUy2wLbIMeXdS3Rvx9h1lDOX20owB9/qpH7wPO6FuWYUhsE2muoOAF1Ea+xnyjd
         7HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6E1lyHDsgDU8DiTt3vegXCDVprFaiy8n8sbPdFHGho=;
        b=Ap3ImWEOAIHo8E8PdUAIdXtqc2pkzv/eB0OFl6wez3fVPSMgNk92VfC0US6OtKVbUz
         KmNOlAdPXg7GXXu9JJuOlqzSyNGkM2W0goQDRNb7SSkM85mjWWBLPsNq0cYBhVGc4GwE
         yDYHDz/aq0hxQbkor54Mt2KKhj4nDGWJ1aQQi6aQSHq257XYDI76SEdFBBzkxPXzBGc9
         dQXioKm0P+LwreZyEFwbWgfOBE2r7115RZFK2Y19mZg089gBJEbx9pdUMNOvUNs8Ed+O
         jZKGACaAqm5o+C8R+/8VS0/40v958XN9a7RvYDkr4WvLyELbKeX0CLstoQTruJOxSyu9
         M0Uw==
X-Gm-Message-State: APjAAAWU+IKxGsrQYkLZjWQ8CNCtohDIVnrbqO2BkaFLPapxTfufSu1S
        pOaEWjvwpzxloix5ODMB14HmnHv9aEaPdrZIfToknNBC
X-Google-Smtp-Source: APXvYqw0L67k2dTpl+TcYZzMhdPd+8VdAypm5lktacA1LHAmxmKNHY2j19AbzoOhGAoriRZFeI/NEDh66fA5zXBXjEM=
X-Received: by 2002:aca:4f17:: with SMTP id d23mr1354353oib.154.1566332943483;
 Tue, 20 Aug 2019 13:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-3-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:28:52 +0200
Message-ID: <CAFBinCBQwsoO1dGKzzkE4Jh9VeqDhiy__m96X=CZBKSDRrHDOw@mail.gmail.com>
Subject: Re: [PATCH 02/14] arm64: dts: meson-gx: drop the vpu dmc memory cell
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:31 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxl-s805x-libretech-ac.dt.yaml: vpu@d0100000: reg-names: Additional items are not allowed ('dmc' was unexpected)
> meson-gxl-s805x-libretech-ac.dt.yaml: vpu@d0100000: reg-names: ['vpu', 'hhi', 'dmc'] is too long
if you have to re-send it for whatever reason I would add:
"
The 'dmc' register area was replaced by the amlogic,canvas property
which was introduced in commit f1726043426c73 ("arm64: dts: meson-gx:
add dmcbus and canvas nodes.") and commit cf34287986d0b6 ("arm64: dts:
meson-gx: Add canvas provider node to the vpu")
"

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
