Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B09C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B861520678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dh0Q3XCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgAIF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:58:06 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35301 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgAIF6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:58:04 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so2075573ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 21:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DjPx1eV8QPqDcx/sjKIxavtaGi+2Rmdyzg645rvwrI=;
        b=Dh0Q3XCsP8JwuJIY/YsgboRS+BQfU1j6Z3n8g/IjRVnL+ysomvfZeFLXAT/kwIjKnY
         O9+XWiunCbvfaklvqvMDu+wOpsVlnAIeVGR6lAnUXSulFNCxc8kk5p4QWd7cvUmtp68v
         eNBWjB+XmNZfoVvnvpBg5rEMLgvomBmINlHg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DjPx1eV8QPqDcx/sjKIxavtaGi+2Rmdyzg645rvwrI=;
        b=HRlhre8ZWFXTFGY6NnYLB4oCCqMyVgNXEELdsWl3X0fKjiZG02iBi3asESHsIZkyvE
         AQiJjHfy0GHGX+/O80BjAAl4c5f/2bygG65rnW94pbqjI78aoVEMiBDYbRBikf9G7P/N
         ZK45LNSy+WKtFcPgLDImjaAtnMV52PeMv2GRLi5z25Cs4DfH/BQ3ERZuscLjfMBkyw6x
         KZJPSH49QxWRskhwzjj/1MlRihC0WsC5RK9FwqZC8ZjWr3lD+EdaZMNtJKhhx5KEAvEs
         ovS+BUTP6lI10i6VHTS57SItrlekS5NQhUGh3vE5uZjCT8wMzDOSf8cR7l29k8qHNKyl
         +MBQ==
X-Gm-Message-State: APjAAAWZy6tSzawPGpRyxLe6VrU8wF20UPT9SyteszFHzPiwcKCi5ULb
        LAPo3OIGsCkZhmO/FY+6UkpZOkwNX9Y=
X-Google-Smtp-Source: APXvYqypgYTgEZ7qz3lWQ+tdpP7lLIGXVWyKGu/defP7xP9H9rIn+o9oXG/SvmtprjQol6/JuPS8fw==
X-Received: by 2002:a9f:24c1:: with SMTP id 59mr6085985uar.75.1578549483595;
        Wed, 08 Jan 2020 21:58:03 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id x9sm1470732vsf.7.2020.01.08.21.58.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 21:58:02 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id o42so2053110uad.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 21:58:02 -0800 (PST)
X-Received: by 2002:ab0:724c:: with SMTP id d12mr5861475uap.0.1578549482261;
 Wed, 08 Jan 2020 21:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
In-Reply-To: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jan 2020 21:57:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XREb0zf=BxwKF7jGO7fwtwQaO+vR1giodsW+RkHZe_XQ@mail.gmail.com>
Message-ID: <CAD=FV=XREb0zf=BxwKF7jGO7fwtwQaO+vR1giodsW+RkHZe_XQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-qcom-qspi: Use device managed memory for clk_bulk_data
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 8, 2020 at 1:40 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Currrently the memory for the clk_bulk_data of the QSPI controller
> is allocated with spi_alloc_master(). The bulk data pointer is passed
> to devm_clk_bulk_get() which saves it in clk_bulk_devres->clks. When
> the device is removed later devm_clk_bulk_release() is called and
> uses the bulk data referenced by the pointer to release the clocks.
> For this driver this results in accessing memory that has already
> been freed, since the memory allocated with spi_alloc_master() is
> released by spi_controller_release(), which is called before the
> managed resources are released.
>
> Use device managed memory for the clock bulk data to fix the issue
> described above.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/spi/spi-qcom-qspi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

It's a little ugly, but it seems somewhat same.  Basically we're
saying that the caller of devm_clk_bulk_get() is in charge of keeping
the list of clocks readable for the devm free function.  Maybe we
should also fix devm_clk_bulk_get() to always make a copy of the
clocks so we can relax this limitation (though that's a lot of extra
copying for the uncommon case), but even if we do change that your
change would still be OK.

...so from my point of view:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
