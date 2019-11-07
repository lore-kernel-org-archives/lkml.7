Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B2C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3E207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycnoBW5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKGHvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:51:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36946 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfKGHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:51:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id l20so1139720lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=On936mGMEelMd4C65roIL0BcdaQ2T5GwNPLPLhFxgbM=;
        b=ycnoBW5a/P0R/fCCa1IlkCCEhbx0j4Dkmsc9IYPN+5xzYVE93lYWmGh/9Y79V+nf0r
         fQHkXQwJVnE5zh1VewSgjbSX5yZ0yqSmaBzHY+em48BBX9gA81wKUNh4C6xoO8zJZaDP
         5umnrsvAeLcFjLuoFUBv9zhc3Ibmt1EPQZzglqJZAyAE0GPBHkz0skLD3cW65mPEQppG
         jfVTyRM2Sq1nLiX9AzsB5CfFEIcxDVY9/giK59bDXPl660Sdi54avlVVHBHE1mQsY2kJ
         stI25GL+ROmqEgPfmLKy5HJeNusz3MJ89txqIqGOTO1fc/0ux/acDfG3WrGBiSD5b1H5
         Bd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=On936mGMEelMd4C65roIL0BcdaQ2T5GwNPLPLhFxgbM=;
        b=eJg1U8wYxsb5DNLz3O/DxMEq0kbAiS4zTh98IhDqSST5IguwCO8haHk1PHLQZ5jNKS
         QT2uwgN3rh54HpakDa5pB3lXkDIQCzcTzHUUhCdwlMVOaaXCY95ZPEimdA0Nnh4zg3H5
         jfMzuNAgWj5+kwmGOogd6ebPErPl3BT0iBdGPzfQ8u64jTOgRW25DAI9oG20Dux7Zm7A
         guvhu728dEJhDuSPCAPUm+LIGt5xMCRNyR7znDaoLDtZaQIY8xdeAwhs7htvmSnDOVBg
         tuDqt33INen3STgC/X74wwRtOh9OlY7xDyv5wTHbqNDyXrSQA5dP7U6+QGvndHWsh8FQ
         pQgg==
X-Gm-Message-State: APjAAAX/yscFq740UWuJ2rETciG0M4d6BQlgImxxFWSNiRtKWw8Vmaon
        a1KHgfoyEZ0eqVfhb9xa533epmpws5E9cKCeKwu9aO/EvPQ=
X-Google-Smtp-Source: APXvYqyXT/frTnZn4f4aOBZNaxsFsBf/960HFLpqrUgIF5vLWRguxul1CehVQt9McUmhGmaLJKFSkOKbC21v3CDFF0c=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr1229482ljj.233.1573113110820;
 Wed, 06 Nov 2019 23:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20191106060301.17408-1-joel@jms.id.au> <20191106060301.17408-5-joel@jms.id.au>
In-Reply-To: <20191106060301.17408-5-joel@jms.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 08:51:39 +0100
Message-ID: <CACRpkdbtrsgawbSoZj=Sma87iePvGjgSm_ASnJNmRoUpx5GpnQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: fttmr010: Add ast2600 compatible
To:     Joel Stanley <joel@jms.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 7:03 AM Joel Stanley <joel@jms.id.au> wrote:

> The ast2600 contains a fttmr010 derivative.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
