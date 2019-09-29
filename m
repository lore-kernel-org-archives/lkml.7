Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C4C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B2421655
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnmerIoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfI2Cap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 22:30:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44532 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfI2Cap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 22:30:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id q11so4528514lfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHfWk4Fc9pqqFh5OQThTlBISVYvAJcJHKQm6hgGJ2VY=;
        b=XnmerIoDgijfuJu0AOpP3vFrMgdB2DBhGwUijTSZUiAohK+TKkle8ccyMiaPMuf5ms
         ies+m32foAoRZ/q5pGzoZlL/piOvUCyjKewwYQ+FlLgzhiegF4NpXkjg2K8DJcZJDJR2
         pUMwTrrNxFA723iicF0RKsxyC+9+/CdHQ0ulvHzq6Q5+URpUqcRGr/E34aF+2VDvWb8d
         iI81ee/dyEOSPIx+wz+/PwOqv5OGV0S0TDiToOdurd7vjY7EhllOA/EHJiObS48vkk6j
         KM7axANjcU4McSxDfU906gS3WWbqk6znCiEWWDmlX10yFqgMgp+bI1bU/xdVRHS1Mjc2
         qzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHfWk4Fc9pqqFh5OQThTlBISVYvAJcJHKQm6hgGJ2VY=;
        b=X4ML+VxqH7FB8aZD4LdUVRUOU2l3hUFcNUd/GFmdmDnAITtv/Npo5Xic+025RmK+yP
         y7mxwKU8VAek/ES7VCGrM7xazSOSZhd2ylCVZYL69gcYKP6pHtEJ8KiKukLAT1qHThhT
         G4cHvR4HOuhcu8JTc9CkyTveM7OXyc368ajQZbK+iKmwh5NaJnXEwzECcddxvlBLsVMh
         aLIQnAlLTKwwRGDp6w4qrNbBQl/SqUWGSAOK3jd1pm/ePz082+8pTzinXik+vf8uBaXr
         /eoPmJaB8hWbSy5nZaCpnnoDBJy8g5pwjOLuncleWHNH8/E7TM8aip5wRRPVoZ8A9iuy
         KNdw==
X-Gm-Message-State: APjAAAWr918TpG4QmnobPNjyYFk4tKKuybZ22wyKfbhQ6lpRamnXdUUQ
        pCcSXQ1m4WQ8xMibzc2XJDYqKGGI1YJihOJdpM8qQNy5Sd7N5A==
X-Google-Smtp-Source: APXvYqzjVF17xXbkBKdA0vEwrBT74f5HosJc0hp6iVwXm7nHNeS5q/af5gnC30h8e8/Brxr81+tqoxRN08O8YtZaLOs=
X-Received: by 2002:ac2:4424:: with SMTP id w4mr7120662lfl.65.1569724243059;
 Sat, 28 Sep 2019 19:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
 <20190927184548.312AA20872@mail.kernel.org>
In-Reply-To: <20190927184548.312AA20872@mail.kernel.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sun, 29 Sep 2019 10:30:31 +0800
Message-ID: <CAMz4kuJ6S4NfhGk=jQiha+xbuke441Lp5FBSjsgO=2GY=6S5eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: sprd: Use IS_ERR() to validate the return value
 of syscon_regmap_lookup_by_phandle()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sat, 28 Sep 2019 at 02:45, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Baolin Wang (2019-09-26 20:50:53)
> > The syscon_regmap_lookup_by_phandle() will never return NULL, thus use
> > IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/clk/sprd/common.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Fixes tag?

Yes, the fixes tag should be:
Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")

Do I need to resend this patch with adding the fixes tag?

-- 
Baolin Wang
Best Regards
