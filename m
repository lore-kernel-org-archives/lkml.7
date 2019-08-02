Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64FDC32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B994D20449
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aev3x8A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436841AbfHBSA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:00:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37166 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405231AbfHBSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:00:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so36403699pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=utHlX+HRu3Xm/Uv0ZaCQimVcSWZRaE3J9Mbhdz2oQTw=;
        b=aev3x8A7/02y5wMj+Uys7nYJDsF4Z4bx/90XFHfVj5cP9u5g64fuurmp8ONDGiZQOj
         qQr/bkrLGtCG/Xf1O7Fl+5Lo7enguggsUMw70faxN+HyFWP8r8GCdJPrJfjPwU1aRCsC
         AXSDJFbW8MGdw2rnW0GTKGiaM4ct7YJe7fSLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=utHlX+HRu3Xm/Uv0ZaCQimVcSWZRaE3J9Mbhdz2oQTw=;
        b=UARhQLd1zCMgbjz6MrCSuWXzUnrC2eKsD0Eo4gXVZNW8vpht4YVtaD8bMFxY6NMDH8
         XoEvfnX/PVuVrPontIYC3jqtOdJmpmPojXeT0lB3MDDI8RSl3K6Mc4Pxf5qEfZxGyDzf
         DBKSyVbexRPnH/9k4vEYE9o12KqivzpVtdboFKjg7zXTauP9lNnaF20VQZLAqrL/bl91
         YT0TPCswAJcStk7f5K/e0GifKa+mY7yWbhAzrZS3X0OamW9HM07uKhDYVuD/tRT7J01x
         aQZIPoCha1GxOjqjd8zKXDJVIvIMVJmXwyQVWrBLZHdwPRuWKGs/Sr7WaU5NSAEhXVhg
         siMw==
X-Gm-Message-State: APjAAAXgHQmd050+1euYMLEYIzkWEpskBKsYzatTLALaOcPZygy6ZnRe
        vhZOC4Hbug33GyJM8d+BywW7NjGoCRE=
X-Google-Smtp-Source: APXvYqwP7dR+fv73aVcZ8AUbuou2bjRVUi33FWSny5TXtoCtTZh/W5+0qXeYiD+TMnie0pk3VAmDyw==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr5526332pjb.30.1564768858131;
        Fri, 02 Aug 2019 11:00:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z12sm57738196pfn.29.2019.08.02.11.00.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 11:00:57 -0700 (PDT)
Message-ID: <5d447a59.1c69fb81.bab04.66af@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190801171209.234546-1-sboyd@kernel.org>
References: <20190801171209.234546-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: Fix falling back to legacy parent string matching
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 11:00:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-01 10:12:09)
> Calls to clk_core_get() will return ERR_PTR(-EINVAL) if we've started
> migrating a clk driver to use the DT based style of specifying parents
> but we haven't made any DT updates yet. This happens when we pass a
> non-NULL value as the 'name' argument of of_parse_clkspec(). That
> function returns -EINVAL in such a situation, instead of -ENOENT like we
> expected. The return value comes back up to clk_core_fill_parent_index()
> which proceeds to skip calling clk_core_lookup() because the error
> pointer isn't equal to -ENOENT, it's -EINVAL.
>=20
> Furthermore, we'll blindly overwrite the error pointer returned by
> clk_core_get() with NULL when there isn't a legacy .name member
> specified in the parent map. This isn't too bad right now because we
> don't really care to differentiate NULL from an error, but in the future
> we should only try to do a legacy lookup if we know we might find
> something so that DT lookups that fail don't try to lookup based on
> strings when there isn't any string to match, hiding the error.
>=20
> Fix both these problems so that clk provider drivers can use the new
> style of parent mapping without having to also update their DT at the
> same time. This patch is based on an earlier patch from Taniya Das which
> checked for -EINVAL in addition to -ENOENT return values.
>=20
> Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec inde=
x")
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Reported-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..6587a70c271c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -355,8 +355,9 @@ static struct clk_core *clk_core_lookup(const char *n=
ame)
>   *      };
>   *
>   * Returns: -ENOENT when the provider can't be found or the clk doesn't
> - * exist in the provider. -EINVAL when the name can't be found. NULL whe=
n the
> - * provider knows about the clk but it isn't provided on this system.
> + * exist in the provider or the name can't be found in the DT node or
> + * in a clkdev lookup. NULL when the provider knows about the clk but it
> + * isn't provided on this system.
>   * A valid clk_core pointer when the clk can be found in the provider.
>   */
>  static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
> @@ -374,9 +375,9 @@ static struct clk_core *clk_core_get(struct clk_core =
*core, u8 p_index)
>         /*
>          * If the DT search above couldn't find the provider or the provi=
der
>          * didn't know about this clk, fallback to looking up via clkdev =
based
> -        * clk_lookups
> +        * clk_lookups.
>          */
> -       if (PTR_ERR(hw) =3D=3D -ENOENT && name)
> +       if (IS_ERR(hw) && name)
>                 hw =3D clk_find_hw(dev_id, name);

I thought about this some more. I think we need to call
of_parse_clkspec() in clk_core_get() and only fallback to looking up in
clkdev if we can't parse the DT clock specifier. Otherwise, we'll have a
situation where the DT parsing may fail to find the clock because it
hasn't been registered yet, so it returns -EPROBE_DEFER, but then we'll
overwrite that error value with -ENOENT because clk_find_hw() will be
called.

I'll resend this with a better approach that should still fix the
original problem while making it possible for this scenario to return
errors from the clk provider lookup.

> =20
>         if (IS_ERR(hw))
> @@ -401,7 +402,7 @@ static void clk_core_fill_parent_index(struct clk_cor=
e *core, u8 index)
>                         parent =3D ERR_PTR(-EPROBE_DEFER);
>         } else {
>                 parent =3D clk_core_get(core, index);
> -               if (IS_ERR(parent) && PTR_ERR(parent) =3D=3D -ENOENT)
> +               if (IS_ERR(parent) && entry->name)
>                         parent =3D clk_core_lookup(entry->name);
>         }


