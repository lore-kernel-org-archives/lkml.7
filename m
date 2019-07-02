Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C51C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD59A218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YWDFyFRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGCAnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:43:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38562 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCAnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:43:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so580144oie.5;
        Tue, 02 Jul 2019 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WW5toOARIQ7duYOFcBhdjxTG2zu+PE3OJ8IsJFKcDaY=;
        b=YWDFyFReOw5A20APKlPQm/STRGBj1lG8LHOh65917g5mJ3CVlnwLCbF3t8dJye81lq
         oBJDlbCvbynivEGV4PL+f6H1f+PwDRR2RC/aizii/HSO9X3qXEQC6DPoDrUfkBwl7Fop
         KmwDaeMAHWqt98M95ZV8rrFrjSD+TKIEmZefdO31XSn3yR15GT7keP1JvWMCx22492B6
         FYUCfHIAxRzKnEFDA3X37E4vpLk2rp4sNL3+/JIE41uTisDieiRtHKV3CGYtQrRlDNEc
         Y3WJl3IN0GHOQ2mesZlcHEbpaiy3jLjvP+baLuRY0ouxYEb0aUDLd/4e/1DBL/UVmzci
         swfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WW5toOARIQ7duYOFcBhdjxTG2zu+PE3OJ8IsJFKcDaY=;
        b=X9DpjZboItSmzeTr7VjHIftPeXGGK+kXJ2IgHrduyYqEwcheh74CJbZ466bhjyXS2M
         qSrPx61CXRPzG21MUSwmrolxFil2ZwTjgCk1APfnUcqJWk6IFwIL4uJl95k6HB8QDbzy
         C84v2QVPhYMT0K9mwV84YJQWenTuSb89Wu1GzAlfJlbIFMkiuDdXlc9+RLtk2PgI/U5U
         Da5PsOJ5M2xfv5uDB2eMUiVV8hVAEPTRbOlwDRT1vUdaD76ZFFlu0cnnHOIhgRnf8JbA
         u9RauEWUzZERAbmDjQ+lKTEW70k/aYaYK9mRz5gW0s9qHeZtg7um9w5ablW1gS6WjrWY
         DhBA==
X-Gm-Message-State: APjAAAXnoy+Es9sNwMWwysUmR142Fhdzlj44gTX6qubAYSgnjPpQB2lJ
        jTPG4F5iYyIn79OovR7ZdH0B/9lsDBdCNkV/PYdBp56V
X-Google-Smtp-Source: APXvYqxlJf85RIzJ3+TzKp9rzx1O65T6vzrzCJARARCucN2vc1cY/g5Vzo1gF94okc60g5IoCN8PVau32fspA3+GGy0=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr1435225oib.15.1562108742686;
 Tue, 02 Jul 2019 16:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-3-narmstrong@baylibre.com>
In-Reply-To: <20190701091258.3870-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:05:31 +0200
Message-ID: <CAFBinCCVCd1OT1AUCRtm2FB=ZzjuD3Gfs0vcQYLWd=gFqTHugQ@mail.gmail.com>
Subject: Re: [RFC/RFT v3 02/14] clk: core: introduce clk_hw_set_parent()
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 11:13 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Introduce the clk_hw_set_parent() provider call to change parent of
> a clock by using the clk_hw pointers.
>
> This eases the clock reparenting from clock rate notifiers and
> implementing DVFS with simpler code avoiding the boilerplates
> functions as __clk_lookup(clk_hw_get_name()) then clk_set_parent().
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
for the same reason this is handy for the meson8b clock driver as well, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
