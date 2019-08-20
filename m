Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC5DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E7A20656
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OGAbSMzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfHTUXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:23:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45008 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:23:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so6277330ote.11;
        Tue, 20 Aug 2019 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbUoCPU7dhXf7N3yPBPfTHh406LSiW+lJWVrE8Nq7yk=;
        b=OGAbSMzOjAbjHAbArYLwGOOBuIe1MwU/DH+/1Vbsw4e+kllSEenQzS2cZArmeVohAE
         CU43oYPAQ6BjsZPPrI5mxNcdRN6bJT2HT00jCo72QgokrkYVLHZXX0drcM0HnFroIqPm
         dVo7kCSPcC9nuz6R37G4BkMXvX+yZQ5ipvGeDGq/ZWgMzS0AO+kB/5L+w9pwkSGoXYVU
         iP5f/26eR4VdKNiy+RYYC4TRb1WEGQctHFo1XNgq+lmdGHpVk6GacSHraqOmXDoJfNt/
         8tFFTOVt+ZjLWTUuvpU78i1Pq3LUVFn6MgX6sLYfkl3UrA93+GahMO5w81QOQ7VjwPJc
         X+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbUoCPU7dhXf7N3yPBPfTHh406LSiW+lJWVrE8Nq7yk=;
        b=O1d5ej9+5mPY3EIgXB5S0puhDc8d2USfVK7C4D4uH/1a0FSkntjsxpxMm9gpcvZQ/b
         d0F3QmdbksdWBoKiR54QCVfAt2PuNvHWlO1l3HV3L8ZUNViMpljVa3ortFdZwnGHCJsF
         GozPYtL6HUcn0bw5rUqoGEHtgykQFWHZZ4yrv52jeSrBYDuaGSkbil7xxzFs5ir+e20Y
         SrbG+lmQ+cBfZWvk1PyCbGzlANNDEtmeKlZliqzLIh0+kgdI3x99QwV/6FHY1oRnN6dR
         kJNzr2PtZxwHaf4SEcSlGqphCYCSyAPsbNDKCW+2ec1LpBT8FfA0a2nL9DDvwLcwYTaS
         2rDA==
X-Gm-Message-State: APjAAAVzQC42rZ+IsDHuqu64Esv4Cvsm3cIOtGj7r2eJE3kNNQwrzYCe
        WUYa41Hhzn6jV/J4bjGyhwkGB6lLIy7d/bvHdHArbUkP
X-Google-Smtp-Source: APXvYqwlEZEWByUwf102QXdWmV49xzyNpn8RmWiw+ptTx1FS1uGyVOZLkcZ3upU00U++IgKBTHK9rcUxJIz24/UHbNM=
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr22570884otq.6.1566332625047;
 Tue, 20 Aug 2019 13:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-14-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-14-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:23:34 +0200
Message-ID: <CAFBinCBPebpiKtMv3KuKRHsp3puZqAUeR0+V6d3k6gAX2ZNO5Q@mail.gmail.com>
Subject: Re: [PATCH 13/14] arm64: dts: meson-gxbb-p201: fix snps,
 reset-delays-us format
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
> meson-gxbb-p201.dt.yaml: ethernet@c9410000: snps,reset-delays-us: [[0, 10000, 1000000]] is too short
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
