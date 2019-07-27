Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E955C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AFD2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="trJ4em4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfG0Sdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:33:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36369 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0Sdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 14:33:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so58604079oti.3;
        Sat, 27 Jul 2019 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zykk+16i/VaVO7vGCiEbOdwpwXy1foVL2dprzKW3VcY=;
        b=trJ4em4+Up9wf1cWi1zJIcTeKiL7VU8V9eR5/totF/SJ0sOa2b18vWkoRsYUxxjzXZ
         bpbUjXFrViU1uLaFI1bFyaXG3jXnsd/VptCVzoGhYHUtyPKCfE7qY3mRHhnJjQUQgps5
         QH1MDSQ6e6BO3L7fA174okRYNj8wrkebTPaGzABuPmG1O06GVUYNkIk5gwhb7aobsEL4
         bJtYvldv5e5lbou3rE9WXAJiexTIhjSPu6N+jbiglnMbX4vli9Yss52Y+bh0jzdDlZ+q
         HeyajiZSxZuhogSB1u+OMqPLkh3JkyBsJxjA/RweVlQm6ry5uxMMhzqMmYv0EUkUfY+d
         h0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zykk+16i/VaVO7vGCiEbOdwpwXy1foVL2dprzKW3VcY=;
        b=X2MrJyO0Qo70Fvun1uNFG7Smnm9RU1SuL11OrMdYxrpu2re73D2GUUE2GKAignIVVP
         eVoT8WlY7pe1A+or+/CeeJ5rCiZOuSaRxQvKcyz1Cm3MEU6F9UY1onD/o7MRZGM+aPal
         JM82Uj1PXYL/gDwdF5GFmPG+txVwKo5VLf9hiwy0M/GtzqZgTKj8wtaMqr50kg2ldQ8m
         sf7djX7DLby904CcTQLSH/YxRI8ugwosmoN29N+x528XLsAnP09iYpbzzurhq+vOeqT/
         AHRJVuDSGXtdjzvsOXhO6o2E4EuCq8DY2arhGEDHcfBIq/CCWHKnSt115RTn5arh5p/O
         hO5g==
X-Gm-Message-State: APjAAAW4+qzoGuwIxJfeKtlSA+x5AuQzUe/VjPItyqkJk8PmQR3SKEdl
        Y8Q/FkHKkGqMTX/BkWcn4bSCGDOdOvmk9aatR4w=
X-Google-Smtp-Source: APXvYqyXx94WA5EdJdcpHMg/R/oEWO8JMmb/K2pzFqcu3/J8K/4V0sX76FoWK0bUo/XsHICC0CqCHvBxvgMmF7RF9t8=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr11080912otb.81.1564252433247;
 Sat, 27 Jul 2019 11:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190725164238.27991-1-amergnat@baylibre.com> <20190725164238.27991-6-amergnat@baylibre.com>
In-Reply-To: <20190725164238.27991-6-amergnat@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Jul 2019 20:33:42 +0200
Message-ID: <CAFBinCC3D87AxTJ_SpATWM8BcKAtLPKjc22mF5GPS+=-u0HC0w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] clk: meson: meson8b: migrate to the new parent
 description method
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        sboyd@kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, baylibre-upstreaming@groups.io,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Jul 25, 2019 at 6:47 PM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
> This clock controller use the string comparison method to describe parent
> relation between the clocks, which is not optimized.
>
> Migrate to the new way by using .parent_hws where possible (ie. when
> all clocks are local to the controller) and use .parent_data otherwise.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
thank you for working on this - everything looks fine to me, so feel
free to add:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

and on my Odroid-C1+:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

(I compared the output of /sys/kernel/debug/clk/clk_summary before and
after this patch and it's identical. CPU frequency scaling also still
works)


Martin
