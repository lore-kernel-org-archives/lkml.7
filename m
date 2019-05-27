Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6BC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D35020859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tSvoWWkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfE0SPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:15:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45973 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfE0SPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:15:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id t24so15492692otl.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZXI0Vn72E/kvqUVtGm0iU9miuWChUM3kAYpzpVGfLI=;
        b=tSvoWWkLsY1P3+leYGrD5X5mo8Xnvw2PuTio2xXbcEWt1z6dDw9GiJpKsm1oJTF99b
         fua5Ifgyz51Rodgs5JkfzurKlGPoPYJdBuLN1m7OIvMoRemkDDdZ/DrNo7Tj6AT3/O+g
         hvuX/BVFs+41JDZY87oxiQcURLyGoACEjyGRe+Kj/42h4Bjc2ddBpQwWxY3FuKhkUjw7
         CzbYIRM24oxp75+WPr1CAzTjmoXRl74YS99VRGYTXjtF4u7pDRKaokdXGFuQ+/oZrbu4
         7wfs10chpRgTZsdocsWxitwrK2bByBfUSMB3bpm/RC9AtGRaRTl9LGvp2Hu3xyfRyxEd
         zQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZXI0Vn72E/kvqUVtGm0iU9miuWChUM3kAYpzpVGfLI=;
        b=IsB1bKHWLPwg3PY7xq8PuuVx1KSH0rzwRC83cqD7AFynEkC+iS7rAa7GNSUztRxHOQ
         u8OqFvcT63jCiERbxrJVM0zdj3K7gfBAbzMjZVagH4u2+2631QxZJQuc7slRvAJQl+Iz
         LwHWkP8Kn6vmziHqoK0Pb3EZZjVRH9fLrJRlNLER0tFbexQzcIPXjUimDXVOJx0V8GZy
         doWcUrB3HInPxFmY5+BzpdHC38lKuel7lNqqB2ANLQC+AamFcavI/o5bzmsMKDZ0xxAE
         zTY0NnJBJ+8b52UEfBFn8tGhS6zVIY5I7vKrwhtaNuWon6BJmaWU5gwf0mmuTXErp2NM
         7uPA==
X-Gm-Message-State: APjAAAXsYuvaphG6dZjfE1tHHfhjGPH1ybAU2yhrEazjQnHD/blEuJbk
        zVDlKBiQw4Pbt3Lkg1ERrZdWSya0AQqtdIxjP3g=
X-Google-Smtp-Source: APXvYqytYrC2eskykBQx9xuR6VQWqrtmKRbQrCEpy1SQnswhueDhG3nDNwT5nAwRtA3pcFaY0y+7otf8sm0gM0iP2V0=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr71839920otb.42.1558980938237;
 Mon, 27 May 2019 11:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-4-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:15:27 +0200
Message-ID: <CAFBinCBJwVT0uMx--NPuuAYS7k2Zx-X-Ew+qNmRQiPV+Cmv=KA@mail.gmail.com>
Subject: Re: [PATCH 03/10] arm64: dts: meson-gxbb-wetek: enable SARADC
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Enable SARADC on Wetek Boards.
as far I as remember there's a story behind this (and it would be nice
to have it documented here):
some of the SCPI firmware revisions don't enable the SAR ADC clock
when reading the SoCs temperature.
if the SAR ADC is disabled in Linux then the common clock framework
will disable the SAR ADC clock.
now, when the SCPI firmware uses the SAR ADC to read the SoC
temperature we only get garbage.

enabling the SAR ADC in Linux "fixes" this issue

> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
