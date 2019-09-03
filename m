Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C64C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EF921897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l9nH8yA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfICTAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:00:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42898 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfICTAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:00:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so6532783otd.9;
        Tue, 03 Sep 2019 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vf/VvldevLv/HCFkjZrV94cfSMaqLzordyoxKpG1uYw=;
        b=l9nH8yA8dk2cWypmwNTEl29wItA0r60ykvssWEIu6OfsaVT2LG924XNrdoQDJaVKKU
         KhPae1R/bxhgZCuawZ3GLUgDARpEyLUCJLwt+bbgA+t3TCw/v/vYXhnDEaNCyyUAh6uu
         05lpyL573U5gYnRbeV1fiUF4xYkpLr1e4fQy1H85nmpLdQ5zsmZseMt9ue+FH9rGrXYD
         KzfQy5vzo0LDOdRHOVGJDXQhSpqA8N+tL6uEpQBo0Stkpdu0V/+5gw8x8IQwYK+x/700
         UhaY89UU7vsCnJd0AwtNFsC/YOU6IWAMJv/bI4vcFwVsNKlZaX5Ktm0I+xjVRWUOpSvw
         SfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vf/VvldevLv/HCFkjZrV94cfSMaqLzordyoxKpG1uYw=;
        b=TU1FxjFtrN4YvWjitE/WugJOlaPhYQzDb21/72Zt/eY33D2yZiAx7XbJDQ6krirWpx
         saex60x8B6P1c2v0cjaUvnKbTFSTXFxLE8/YkEeyLMUl8U+cXG+ZwcS7cF29BvYAV0D6
         NlksmfpuFJfQbhazRLMly9jtdYT8ZzBHBWS3T3MrIUT9vEC/yjggmis8U6kV1IlRIgF4
         GxyDKsUK8ULyims02X/BpdYv0HCZtTWuXh83RkuzrDPhwrqoH9S/yBznL5t6/Xq0k0DO
         OgFvmgaJvfBAfI+OwD5URD9/M+shY32W7qOgxJhFgghdn1MA+W17XjP6SOlIk9JWauFq
         BpOg==
X-Gm-Message-State: APjAAAUS7XLInuZdTNUxUnSdH5TmEG+xW9s1BD+WqBaDHUOV0DP2csML
        lfaM+0GLKk1fcyVV0od+xjB6ML11qwssM8QKLmg=
X-Google-Smtp-Source: APXvYqybrQKStl3+FVCJwwcMnm906TDSMh+2UBslvDCPsH/wUJ0nK8jlZLTIL9bXUyNxcp7IBfZAAKplrBI9qBuchqs=
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr18894833otq.6.1567537217247;
 Tue, 03 Sep 2019 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190902085821.1263-1-linux.amoon@gmail.com> <20190902085821.1263-4-linux.amoon@gmail.com>
In-Reply-To: <20190902085821.1263-4-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Sep 2019 21:00:06 +0200
Message-ID: <CAFBinCCkdaCQim4EZtpoo1J0FyCEUNP8djXnF1dK=2cpX5Vizw@mail.gmail.com>
Subject: Re: [PATCHv2-next 3/3] arm64: dts: meson: odroid-c2: Add missing
 regulator linked to HDMI supply
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 10:58 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per schematics HDMI_P5V0 is supplied by P5V0 so add missing link.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
