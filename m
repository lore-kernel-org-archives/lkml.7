Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF733C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A557221851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPSevJy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfGYQxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:53:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45656 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfGYQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:53:38 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so98668892ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kolA9oGTMt2kJuYg8zC6oRG5UHIMOnhc3kiBOYsRrZA=;
        b=IPSevJy2liwkLBHgCIP++Od2vm8pxaK7qAFqKLBz212Z655uA/9ROOg+s5IaImVzfs
         mp32U3H4iTgV7TrIOZ+ToG924T9y/qluKpRZOuijot3YOobPniwSFgN0j+k3iBv5Ur+V
         vqSmZD4y6I1UTcz6Rz2aS0nGWj9Ge5ijQbM4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kolA9oGTMt2kJuYg8zC6oRG5UHIMOnhc3kiBOYsRrZA=;
        b=PRJTqCOn7jk2msRlPGQnJBs/Rj+PDa4LjtFfMyO0ehyELUpuln0BRNkjRNKiyyXC4k
         OOycQSn2AKXWG+dyCOqWpBzg2GuaWcBsIWmKCOzqzNkntJvqcQtVqLPIp2DfACYDUmeQ
         j9iuF3SaqM0dSN5vugHZ19rp4Cy3EBcZr+qF2OHTElPzKGYL4D0yIoUZFB5Tbtumzerc
         R8FpzJhy+8Mf+no/LMLd06ZxBt+o5dqppy1Xo33GhTOK/afAh1QLbU7za7jRjC9xF3Yh
         dQ9C4NYfu8oKJVV1hkUe9W5MEmnFMsZXdsOtUAK8UKtSDP/aqJM6IKZ8JpDfgtANrcps
         r4XA==
X-Gm-Message-State: APjAAAVJTHCXnUVMLBmCb6PMV7WA8TQPcE+q+k2G5hHzrkh2RGMl4Cls
        XP2XSH2KxClOc/UkSUPcm19k3BuT+EQ=
X-Google-Smtp-Source: APXvYqxaShSLAt4ormEWtgbFebRI8U4c/SNZJjL4Ts+VlwGJAGd3k56cbD2uVUzfF3D4lszRRPsukA==
X-Received: by 2002:a05:6602:104:: with SMTP id s4mr80700922iot.200.1564073616787;
        Thu, 25 Jul 2019 09:53:36 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id j23sm40217836ioo.6.2019.07.25.09.53.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:53:36 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id e20so68301358iob.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:53:35 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr77963588iop.58.1564073615649;
 Thu, 25 Jul 2019 09:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190725162642.250709-1-mka@chromium.org> <20190725162642.250709-4-mka@chromium.org>
In-Reply-To: <20190725162642.250709-4-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Jul 2019 09:53:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZur9gPvUnRtdwieqkjMxx1nOabaRXjMsQ7hZwgNVE5Q@mail.gmail.com>
Message-ID: <CAD=FV=VZur9gPvUnRtdwieqkjMxx1nOabaRXjMsQ7hZwgNVE5Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-{fievel,tiger}
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 25, 2019 at 9:27 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Fievel is a Chromebox and Tiger a Chromebase with a 10" display and
> touchscreen. Tiger and Fievel are based on the same board.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - patch added to the series
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
