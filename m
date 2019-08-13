Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D343C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEB320843
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565731966;
	bh=ocGtIgTgq9tRn05MEA2AseiewpPV58nDV6Bz5EJeVWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yu4e5dR8CjcQZV9kqf2OFjAb70rtJnUbZZEkWJ1y2JQJ5bpauNdZ3BEbccUE2cAZU
	 QLXfYbuuxchrcYL11FBWbUob9OnzADayfKKhDbfDdxf6hk9WqkxvJj6SFIyO8auC0z
	 P3DhOMygvFk3CN4CApPQGtAhrWvkEYAmPkFavq1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfHMVcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfHMVco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:32:44 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E24320874;
        Tue, 13 Aug 2019 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565731963;
        bh=ocGtIgTgq9tRn05MEA2AseiewpPV58nDV6Bz5EJeVWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ryp35nFyB4LnjvwmcCk+mgcBlhlO9BoGGEbJqCuysxgMYE3QrXhMpNU3pFzcephid
         2eNvhTsz6fl6tXCc9h5oWhr8XJ2JVTIdVMNyhKFCFQNvMRXbeO3LBh7o0ekIv+8Jvk
         RiHcWeAQT0plw55xtzmZyqe1cwYGYxCeQwnApwjo=
Received: by mail-qt1-f178.google.com with SMTP id z4so108023057qtc.3;
        Tue, 13 Aug 2019 14:32:43 -0700 (PDT)
X-Gm-Message-State: APjAAAX8a7WihbC08SvvG/YBZisgrmqmBVGbcRu4RecmfWD96/PT5jEh
        qHtxKQwPkFywDxZHSGXBvkq2tYhn7+iy/oDh3w==
X-Google-Smtp-Source: APXvYqx48HpN2WmRdaQx2jqeMfSS99pR9DuL4bLmyJdzDJvvyzz7a7PeTjZtWFPiQUCpm5ztHYxh1a0HIsggmFI0ZZU=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr35482240qtc.143.1565731962734;
 Tue, 13 Aug 2019 14:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190813124744.32614-1-mripard@kernel.org> <20190813124744.32614-3-mripard@kernel.org>
In-Reply-To: <20190813124744.32614-3-mripard@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 15:32:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5v1nd85FuuU1aHDDvojnWqs-4aDZAUDm0iCR0akhF9g@mail.gmail.com>
Message-ID: <CAL_JsqL5v1nd85FuuU1aHDDvojnWqs-4aDZAUDm0iCR0akhF9g@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: sun4i: Add the watchdog interrupts
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 6:47 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The Allwinner watchdog has an interrupt, either shared or dedicated
> depending on the SoC, that has been described in some DT, but not all of
> them.
>
> The binding is also completely missing that description. Let's add that
> property to be consistent.

I'm fine with fixing errors like this in the conversion patch.

> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)

Either way:

Reviewed-by: Rob Herring <robh@kernel.org>
