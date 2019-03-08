Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD47221019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsNHKAWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfCHNQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:16:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34210 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfCHNQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:16:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id l5so17358113lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5jV9GyZGM4487bBJ5f4Q8s5y0m68G7H19Fqvj1DWl8=;
        b=EsNHKAWvSYL9x+iDRomGyyXP/NJgA0GYG5QDSrRTs6TRqUlCy5yP/WglmbrGjR+LZ6
         ltN6tHP6E6arXLPdT3dE0k05yDgLu4FoMLvUAVx2bkO/ByzJoRc4lTSOKMyE507yXlkq
         cyXTtdA4EfM7PXmzKyc3gk4cHTt6TRQeMeV8OH+zqTxb4Ifv3p/AjYdLdhNLTwYRpx/0
         dzoOzP5rtO6xc9nxlGGv2sR9+nMh66WyqLWJhCUdzo30uDuO89aU5VtSl9IJwU09fq6k
         vswGPRkbCDWRwhv5HuEMUrKOs2TCiEN7jcRhNjcMaX4fWJ3rSLEE0jRErQTuPAR6oGyD
         RQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5jV9GyZGM4487bBJ5f4Q8s5y0m68G7H19Fqvj1DWl8=;
        b=GfHKBSo9ntFr043uphQOlO6HoeD75B5v8zZ6OlQ5bXw8TTDzCEKDQUgqsL3EO95GNZ
         e7rsIIoGeZa56uyn4fIyrYRlDCsxz3CFWDpjZFVj1zvPypDcmxBi43MdmkDvzYPm1ymR
         eSm05MiVA38AMwSSCo146GxAt3mOLKmC56C1BYu6I1b5TqKBbEZH4jf5LbpHUe8sfMnl
         Cig7uoUyrpmNhOAQtkDFZCIcyo8cYcZEEVKRhAccy6BB7JRAL7XK5EXkQcXWsIY/0xWx
         H1YW0R7sPUex01gYQb3cnDFkVyiOF17H3s/56lBwp1h09La0jkvcgUrQeGAoM7LFah+h
         VcrQ==
X-Gm-Message-State: APjAAAV8oxHdVIU9/z4WDHJdDDwfMdJK4WqqHhnUgpziHotALVOnUrgM
        ybWwPdDk5tYDfrJvz5wKkOvKtK4sCN1FKni/Bf9tUg==
X-Google-Smtp-Source: APXvYqzddqaZ/cRrqtw5DJs7KH3qMQRrGhQarFNsh8dbIdE+3XXFKhtAE+X47O2c38xQoewtcl/gn1OtEnrusTYOTVQ=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr9682837ljk.105.1552051003873;
 Fri, 08 Mar 2019 05:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20190307135356.15736-1-axel.lin@ingics.com>
In-Reply-To: <20190307135356.15736-1-axel.lin@ingics.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 14:16:32 +0100
Message-ID: <CACRpkdZd6mvOfPa1Z12TZow6NustU0hAFpaJLZt-d0QVn1G5fQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: ab3100: Remove ab3100_regulators_remove function
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:54 PM Axel Lin <axel.lin@ingics.com> wrote:

> Current code is using devm_regulator_register() so it is not necessary
> to save reg->rdev for clean up. Remove *rdev from struct ab3100_regulator,
> then ab3100_regulators_remove() can be removed as well.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
