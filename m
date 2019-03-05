Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5402082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j1x8CTF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfCEVKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:10:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43311 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCEVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:10:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id i8so8032955oib.10;
        Tue, 05 Mar 2019 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eK7b1ysZ5RYfu11FRazX4UI1S6Ih8JesHu0IF5iHaA8=;
        b=j1x8CTF89Qs41ZyHYjesb8CIgIIirRbLLbb74rWFRAebVHldQBlD5QT67h0Mm9Z240
         KVz22+PcxuhvZOwORvRobXSh8gSNmMp6Vnfugst5/J856M6jIxk8j8+oK2GrD2h8kDzN
         csbWJ8ZN2qxzvT8N8v6CLuxR6iE33EsdeX5I/QZ2B6FCbJyBCfRYt/jIQGipH9MSk95o
         QUknPxRMrdFmREuHUd6CaGmuP6jc2SyaFj1DsLv+x063A6viqMOWqKzdK11PrDM1MkFu
         u8cGl5dMijZQdfd6inLK9WSYtVKn4B+rec1VT8BSMDsINYoWTieh7cMaAhgF8XdsqYvs
         vSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eK7b1ysZ5RYfu11FRazX4UI1S6Ih8JesHu0IF5iHaA8=;
        b=Ch4B3IPLqdNtrILmFLjpR6wzVemwcofD2jlFHzvFafJfCEwTScFZyYVcAyGXgXlHyW
         k9WX2jqvVIStjAX8wFz7iVQXYLvWVTvbAUrfoxvZ1O2aipKyPCoD2cA4zPYOV7tCqd76
         iurhMhzuVFZhS82PdgWNVEU+oHIkrKljHgG3mknssIJ8IYtXNoGFZdBDHYsUH7XamP7s
         OHun8heqAXUBALhkWoOdRKrRk6nIQja7rWtyX3WjsRnHE7PtR0gC8t3Cdq0kh97gNnGL
         ublgWRGfUowycIhObIASYWeBVoV5liAWR3aDq4cQAobIX5f4orzs1qtV+iof7ft8SZiC
         /dbg==
X-Gm-Message-State: APjAAAX1Nn8HJiRoAEnnm5CQUUqe5WtjAl2hvlax4kdQ0D+O7ItY2IJJ
        6WtHycQYL28Yvsksjx8g9a6TZW3mtj8si/FwOYk=
X-Google-Smtp-Source: APXvYqzNLUVc4KWV8pZ6sWH20srMIwANXU8OP6BAlUdcDbU5dWTNHrF5O5cGb48Aw1nFP7347/B/cSjSO2p09s+kWkw=
X-Received: by 2002:aca:4205:: with SMTP id p5mr309442oia.15.1551820219243;
 Tue, 05 Mar 2019 13:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20190304131129.7762-1-narmstrong@baylibre.com> <20190304131129.7762-3-narmstrong@baylibre.com>
In-Reply-To: <20190304131129.7762-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Mar 2019 22:10:08 +0100
Message-ID: <CAFBinCAax7=dbLxTNtSrJJthuFb02+7YMyGwpie28F1bnr0qRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: meson: g12a: add cpu clocks
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 2:12 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic G12A Family CPU Clock tree in read/only for now.
>
> The CPU clock can either use the SYS_PLL for > 1GHz frequencies or
> use a couple of div+mux from 1GHz/667MHz/24MHz source with 2 non-glitch
> muxes.
>
> Proper DVFS support will come in a second time.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

in my previous review I criticized that the post-dividers are not
mentioned in the description.
it's not part of v2 but after having a closer look again I think it's
not a big issue:
these CPU post-dividers are all marked as read-only and have a comment
that "ROM monitor code" manages them.

disclaimer for my "reviewed-by":
- I don't have access to the datasheet so I can't verify if the clock
tree from this patch is correct
- the latest buildroot code with G12A support
(buildroot_openlinux_kernel_4.9_fbdev_20180706) doesn't have proper
names for all clocks
- this review is based on my experience with Meson8* (where Linux also
manages the CPU clock, unlike on the GX SoCs where it's managed in
firmware)


Regards
Martin
