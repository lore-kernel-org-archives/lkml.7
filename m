Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079E7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B7F2087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEpf7s4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfHEKQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:16:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36938 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfHEKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:16:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so57425099lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrbJD1vEfE60HVKjYoBmFtGgNGgrOIdfFoPt4X6Q+2M=;
        b=CEpf7s4k5oxGDjJNaYqs3rNyMc08fXeAZr7+86sI4zxQ09hLwEgCj/ZTWv270igZUA
         MBnuxP52z+gVvbpCqKNyoY/rVW2zFwZ1dBho3naVESdTps3/PYebbyvptTrbEy0FoD7u
         F4b61y3FBnom8OagnIdGxalPnqdxXn5wtX6dhu+iFbx9p5RuFlAOt1/5Dn1HlQ5JbGZX
         wzDRVmOCjoF2gyOlZKWNfNvoPKyFRyB6X0Y9s5eEwSfcCLRLwT7DijoYst5XrAvrcFIR
         yXzqQ28Y9KXDIGGjcy93VHBgEtefP/zmwNeshyNooHMfGTh4M2r2ormcG94/UfhxaQsF
         pHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrbJD1vEfE60HVKjYoBmFtGgNGgrOIdfFoPt4X6Q+2M=;
        b=GUN6xVHvDbTKFgK5f2P1vFRoc7DGjeYm+fZbITRFTtp/6Fv+HqIfKCAfPFpZO+3MgV
         1HtSfGBEqA07gBtt4Xw5zZAQ0x+p8QBsUJfBwE9QZw1xNOzvsSwbYHeqxWn89IHqbLGl
         F64ogwizAIpdJHiNjWG7NldgnZsY6ZZDaWb+LJb7rosNyeBN4ovSpLkxEbbsX8VA1hhD
         JTEM5uWPjs4DERUuddSmUXD83zelQVQlMfEw7NMEQm6Z7fIHMYwC+ICSO8ZilgwM2l7z
         Yk+BMVeYnsQwryWVDGOz1z84dt04IJYiIj77P6D/1X+IBv+w80NrvZhtnPMwCKCZbvsl
         +FHg==
X-Gm-Message-State: APjAAAVAvqMst30Jk1ASu1bJtaOWbUiqUFBSexc3VmhrQn74zsLtuFV6
        N/5KYZ7Nzqfxy00L58V1pJIVDDYJEkuVq2UiuXvfYA==
X-Google-Smtp-Source: APXvYqyOosV8sv/TZHhVjwj5Q16nJaAbVg2+Q5BdPmAvWKsycRacpctNaCXuf4VkQIw648gtA3ql91UGmSXtMQwMmXU=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr68773554lfh.92.1565000196094;
 Mon, 05 Aug 2019 03:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190725142419.29892-1-yuehaibing@huawei.com>
In-Reply-To: <20190725142419.29892-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:16:24 +0200
Message-ID: <CACRpkdZ+fBDKB3i8D=YKK-iVUeBN23b=2YdhnOY-dwR1tyQnYQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: oxnas: remove set but not used variable 'arg'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-oxnas@groups.io,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 4:24 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/pinctrl/pinctrl-oxnas.c: In function oxnas_ox810se_pinconf_set:
> drivers/pinctrl/pinctrl-oxnas.c:905:6: warning: variable arg set but not used [-Wunused-but-set-variable]
> drivers/pinctrl/pinctrl-oxnas.c: In function oxnas_ox820_pinconf_set:
> drivers/pinctrl/pinctrl-oxnas.c:944:6: warning: variable arg set but not used [-Wunused-but-set-variable]
>
> It is never used since commit 4b0c0c25fa79 ("pinctrl:
> oxnas: Add support for OX820"), so can be removed.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
