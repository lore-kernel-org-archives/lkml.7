Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F62FC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FF02085A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CuI2IgTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGCA7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:59:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37699 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfGCA7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:59:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so608769oih.4;
        Tue, 02 Jul 2019 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCrBHpvs2bjlY0tZQ78kB/teoCTIaxox5gIgv2Zg7MM=;
        b=CuI2IgTXX842IlAyxReyqFM1sRgD7KsYh/dPgH6QAHgmHFKOPh7/a3W6pU8NOrWD0i
         r0HgT9QAhB3P0L/SWdmy2QahcMIkNdOT9sM4bcNQi4Ow67paIGHcnPZqpW4yB3lDIPYr
         3LvXJK+WTzqu0K9DtXHI7rFi97IFGrcgRoSResKlOVMBTEYfPmMfxpIT9k+/4uJ1yP8z
         HPI5nCrJ5EzIiMBe7xemYcyUYwvaQdSLLELy1yUsDPMaZfgnz3HGUWHwT8mgyNVshEBb
         ruxaz1jL4/BjMVUXqdAUlRklzGjyHeKoZ/I+J8ZcWABIvPw0KHcl3yLKYqpM3asVZDIp
         CZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCrBHpvs2bjlY0tZQ78kB/teoCTIaxox5gIgv2Zg7MM=;
        b=GtqPsYVqQG1GIEcfbhyCT37s4m+muGPBuAoyKX1PSDtJ6bN2ikU4lVR8UXCm+ykZaP
         2QzN9ej9gcxfUsr04h9DxVk7qDVdyEZp6SWDu6q9HUjr7CRhF3R+ggO1coEn1beSEZlR
         AHV1+2yA64iG9GqRVSDrYryTsMH0OqCEMVrpzUQ/zYOEPzaE1fmb/6UAwIbw3gV9KWoe
         qZodJN1i/BoLSxwX2Y4KUNyeRz8JhbY/2voj/76Bv9ne2xKpPeu1ia0zprr/OEFKj+pd
         yFHDrnpWJsNB3btb4Gixb1af99K9nZfyspv+bJM75XOPxcBbPdbVFdjqC6mieSWXGsMw
         NY5g==
X-Gm-Message-State: APjAAAVheCBvlaZjxSL0ddNQFfeRDe9ZW0lzpNCnxhNxzJIhyzPkElGH
        KgLQPuIdzm1ttGagJeYVVVHttDYCsLp/BO3uFf+ymcX5
X-Google-Smtp-Source: APXvYqwmd7VMNZTet4EgIbGsgiX7YKyruChF5ByKLBpLAB5R3TkByx3a5jpZ7+k3zDWzGsAg0iUnSr7TbRx2PMhG4lo=
X-Received: by 2002:aca:4306:: with SMTP id q6mr4696022oia.39.1562109386381;
 Tue, 02 Jul 2019 16:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-5-narmstrong@baylibre.com>
In-Reply-To: <20190701091258.3870-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:16:15 +0200
Message-ID: <CAFBinCA1gUUbEj=++1rGcFQ1RdyxSheofAo=TKw3-UaenFAcug@mail.gmail.com>
Subject: Re: [RFC/RFT v3 04/14] clk: meson: eeclk: add setup callback
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        amergnat@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Alexandre Mergnat

On Mon, Jul 1, 2019 at 11:13 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add a setup() callback in the eeclk structure, to call an optional
> call() function at end of eeclk probe to setup clocks.
>
> It's used for the G12A clock controller to setup the CPU clock notifiers.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
this will probably work fine, but I want do double check first

are we planning to get rid of meson-eeclk (mid-term)?
Alex has some patches to get rid of all these IN_PREFIX logic.
I'm asking because if we want to get rid of meson-eeclk it may be the
time to do so now to have less logic to migrate later on


Martin
