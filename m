Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F11CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B75621871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CdlQZ3us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfCOVJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:09:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39627 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfCOVJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:09:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id b4so8475838oif.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kui9b3hFWnE2uUTU7SbYrqlPmXB13fsLEaAm0fowE0M=;
        b=CdlQZ3usPgNg7Y3hMH38BgbfDizrmuaaTzQk/NaAcUQXDfIrW/rRcHVceUbqYTC2Yi
         Tbd8ThAyc5DmxVuncU/kjWZC0FXaIoi3Mc4yjDqLjSVh/uPkVLyTKB/TfSlWiLXJsFHo
         U0LNGnD5/yBTtuLAOTJ/FHRL5b++ffqpmA0XE4jIbNZNQk4XxOL1g+R8GsFcWxeX/xZd
         3BCy0OHrfnFO+yk6pLYIbnwhLDAhVUrxGYJHDn/pfKmoH9zXfl5zqdL2N2LHb7jQVrbA
         Tq9dOZbqASBz9AF+5VvFZx4g87se630mbkYF6o6tanseA4ej/5YgA9AxLlWCjKs5CT7E
         H6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kui9b3hFWnE2uUTU7SbYrqlPmXB13fsLEaAm0fowE0M=;
        b=du8+dioqw3d7/+ggGPZHkXRekJmkTM1hvHEXPqERu5HF/WT7ghaNlbaG2HW2Qbiz4i
         B/Ip9c8fmqQBa579JO87hRha5odMoU39x988zpue6lDf1mIt4KoZvzbEIO7p2d4AV4/O
         Qd7Lrol0DzelisowLZY297roh29Gxr3uCXueKVJjggz+bHLAPz5w+A6GSIX0xOamBv0w
         +3seHcUAXgVFXUMF3sKMZGjHzU/SvEXBGEH/EEynzIgtHm6GUsgJVZGHH/tAtZEShDfy
         dpvSR/pZ5CphLbBXgPyk/FrMOt7iF4wdDGmoHV7KRsc3/pjFMnropPkpf1B5H6pE++Nr
         QIOw==
X-Gm-Message-State: APjAAAUZ8qhaRxn0BdYNlBWh0seZL9eLc+PiHbhThK9aNrd3DqZXy9qK
        hWs5PKASmsRXM/g09PPISoEtKFSkjJHecPvr1TM=
X-Google-Smtp-Source: APXvYqx5F4qCzzgRpIH1kHEn7fyeri/ssXbZsMy/pFhTtFxsXHPnPMQewQu8QbAdWVe8tPNRFtF8YPpckIJVDbDx22U=
X-Received: by 2002:a54:4e02:: with SMTP id a2mr2987252oiy.140.1552684178774;
 Fri, 15 Mar 2019 14:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-3-narmstrong@baylibre.com>
In-Reply-To: <20190307151342.7381-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:09:27 +0100
Message-ID: <CAFBinCAp6xVk_wmVB+Fo+WPs4k0TzTdaF5zGC-QvjgrUEXo7Zw@mail.gmail.com>
Subject: Re: [PATCH 2/9] arm64: dts: meson: g12a: Add AO Secure node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds the Always-On ao-secure system control registers node,
> which is used by the meson-gx-socinfo driver to detect the SoC IDs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
