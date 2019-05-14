Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DF7216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557853627;
	bh=ynl8AFpFEpjI9vrYRvobxmIYCbtOF48tRyFqccv//zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PXJaKpi7/3O9qTD6mzSai0XJPpr6aBZLO6gJci4ZkMR1CZRMDLQ/pgT4Ym6B1aoTx
	 9pWxRtFwBcCTFLck1zuMug8d6w0DLKUP7amtuxuy/2lH3d/u3g6z+ERoiqH0lr1fXP
	 v0LYdkJaD2pvczQZjtiiEK6fGeALu68gxPiKvPYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfENRHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENRHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:07:06 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE35216FD;
        Tue, 14 May 2019 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557853624;
        bh=ynl8AFpFEpjI9vrYRvobxmIYCbtOF48tRyFqccv//zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0jC7UTr5HM4px+Sfy1o8XrnmDRQhV3GR3xyqaUtsZiWD1U9yFi/kfCt5cODPnixjC
         Y18nLsql0XLr3UClDjWX8gLmjpdL2joxJLgYLllFC5Kj2PfDbKt62fUR9YaIxEsvXz
         IZv7apDW+MobPpB1TJiFPar0xjIJi4A0ZnyFe2SI=
Received: by mail-qk1-f178.google.com with SMTP id n68so8171207qka.1;
        Tue, 14 May 2019 10:07:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVy39DKyQt7OQ3qTQTGBBhWcivq7rGr2XfDFvpGc+r1L5eZLlUU
        tdBqbDycm+xKIn+zINwcxGLfWusTBDY/pkCedA==
X-Google-Smtp-Source: APXvYqwkA2Dj1JJRXoqUmMjMw7gyMeOiQDb1TW0TDwg4hnLqAMxtTj6eK8LmAKdsaY3cW79uDKEIDb8mWuXgzckCYIE=
X-Received: by 2002:a37:7982:: with SMTP id u124mr29199541qkc.79.1557853624097;
 Tue, 14 May 2019 10:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190509215538.93346-1-swboyd@chromium.org>
In-Reply-To: <20190509215538.93346-1-swboyd@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 May 2019 12:06:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKS5KgNpVvunhax+M4+NceP9uy_V=2cYk54kg5eOfxXwA@mail.gmail.com>
Message-ID: <CAL_JsqKS5KgNpVvunhax+M4+NceP9uy_V=2cYk54kg5eOfxXwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] of/fdt: Remove dead code and mark functions with __init
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 4:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some functions in here are never called, and others are only called
> during __init. Remove the dead code and some dead exports for functions
> that don't exist (I'm looking at you of_fdt_get_string!). Mark some
> functions with __init so we can throw them away after we boot up and
> poke at the FDT blob too.

Some of these aren't called, but there are cases where they could be
used instead of accessing initial_boot_params directly. The question
is what direction do we want to go. Make initial_boot_params private
or do away with the wrapper api and expect users to use libfdt api
only. I guess I lean toward the latter because that aligns with my
goal to move all the code in drivers/of/ somewhere else so I have
nothing to maintain. :)

>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/common-properties.txt |  4 +-
>  drivers/of/fdt.c                              | 37 +++----------------
>  include/linux/of_fdt.h                        | 11 ------
>  3 files changed, 7 insertions(+), 45 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
> index a3448bfa1c82..1c50d8700ab5 100644
> --- a/Documentation/devicetree/bindings/common-properties.txt
> +++ b/Documentation/devicetree/bindings/common-properties.txt
> @@ -25,8 +25,8 @@ Optional properties:
>  If a binding supports these properties, then the binding should also
>  specify the default behavior if none of these properties are present.
>  In such cases, little-endian is the preferred default, but it is not
> -a requirement.  The of_device_is_big_endian() and of_fdt_is_big_endian()
> -helper functions do assume that little-endian is the default, because
> +a requirement.  The of_device_is_big_endian()

Hum, we shouldn't have kernel functions in binding docs. Can you
reword to remove both functions.

> +helper function assumes that little-endian is the default, because
>  most existing (PCI-based) drivers implicitly default to LE by using
>  readl/writel for MMIO accesses.
>
