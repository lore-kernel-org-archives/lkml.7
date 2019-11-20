Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721F5C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481B820872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6z3K/E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKTUUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:20:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39169 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKTUUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:20:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id f18so601065lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaeubB9oup5HPqMiD5Vl71T+HPv8UFVWjeFHFcqOIRg=;
        b=g6z3K/E68Ogd7jMI6ZONW7+DAdhxqpPKHIDEaoNSMtYue8XTJ/HvPPAXCzSxcQ9Myu
         tKo0KxfliQKm/v2eXdO7SoooMtGHZNBg9sJGfWmqJRszcUhYyJ6q2zAw7qkYAuUbJ/1z
         nz8h5YA2W7XQOvrRod7zoL9FoSiIkybl2X0BzoPlSs7mQ96rO/e38Tum1oHxvHjbNKrF
         kVMHz8sS4IlV7PVQho2QUBLFlE7pzSZ4+U0bxv8vYB3yc3OdSHmATUEej2S7CEHwwQNb
         Iz1SCfMdz8IB+vFT3qsYCb2SF3h6aOuTdCajPLIzmSlJ/7SC+Rlc4H90C3eNj/O1F6H0
         QupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaeubB9oup5HPqMiD5Vl71T+HPv8UFVWjeFHFcqOIRg=;
        b=RK+zAfjp+Y9A5MUfL6vxoAz9Qz/JSiin3HlPk8Nlmofz7/4u6esHYBP0huICZJNTdt
         gEHwufnZ/chzazk7josvXVIqbU6OGv+JX/rMscZ+TYaR/UbvbanVg3G3MglbGO+ooLZR
         ywKRbDKwezFNYPbDQBoSRIPPpL3u52faCO3u2CQ1tc/XvzULTZQxWImW87DuRxZGRhfc
         RlsKmjLLul/ZnCpL11OPYI+VrnihbiNydUSmBPBjF26sxqkvbDGe4w0Tpy2HbDN/2CfQ
         4G55gu+L41W7h97aCFv74vCSeCgsrA6xcOHxDLtgEdD2B8GvvIVDd3NG+GXbUz+iv2zv
         64fw==
X-Gm-Message-State: APjAAAXqWJa0Unkrx52McfBlGVagz6oj6VDH5X2Ngm9MBTVVgcWxlAyX
        fjbGMRmg6eVjlpqrBGKhoGPPZtkg51CpcVM0a5PpPgu5fgg=
X-Google-Smtp-Source: APXvYqxhbKk0D/bHbd56rMIcDb7oudDKdTswz6YCWF2G7ykBMmGOeVyKBHsxVMNvRMkkTI0Q37OuJ+n8wDj2M9zOHLU=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr4212581lfi.93.1574281247289;
 Wed, 20 Nov 2019 12:20:47 -0800 (PST)
MIME-Version: 1.0
References: <20191120181857.97174-1-stephan@gerhold.net> <20191120181857.97174-2-stephan@gerhold.net>
In-Reply-To: <20191120181857.97174-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Nov 2019 21:20:35 +0100
Message-ID: <CACRpkda2UJB=dA+1ydBqSu_0D_+xoRX7jCCYEZDE-LPv67WxrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: vendor-prefixes: Deprecate "ste" and "st-ericsson"
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 7:19 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Until now, device tree bindings for ST-Ericsson have been added
> inconsistently with one of 3 possible vendor prefixes.
>
> "stericsson" is the most commonly used vendor prefix,
> so deprecate "ste" and "st-ericsson".
>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

FWIW this is the byproduct of Ux500 being used as guinea pig
and shooting practice target in the early days of Arm Device Tree
support. I still think we got out pretty clean :D

Yours,
Linus Walleij
