Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB4827C75
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xunThd3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfFCNsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:48:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39159 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfFCNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:48:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id n2so2874517vso.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOabyvE8wzavVfwd8vYkmNcYm1mrgFpt3KC1yUBwYIM=;
        b=xunThd3DuF5c0doe6up7dw7RyoPvzYQdwp4DlebjoaDzotYGIOP6YBpBZAy/Wl4/3h
         thdQ3GnBxH+6mjUGJmIBMArkWJgIk1GiwV/wynEpW1CLGnmycbm4IZQQDpnjh8a4cE95
         qnPazDgy/3ylDayIr4IsiaQE7cxIx1BKV6XNF7N1CYh4RhH6vX02jGinigcg4jp5H0vK
         g+Ge1I8Q+/6cHwn7Y+CjCrglnUyM5NOrjoI9iWZT1ontQuEOmO5XqknfyERSn5jU9LO1
         ZLgGHt/ZgdihIf/F9KMnZevGeyR2OlerQpjEDDgnbIcZD4c7VVZwuQ0F/YeSWks6YgTw
         jXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOabyvE8wzavVfwd8vYkmNcYm1mrgFpt3KC1yUBwYIM=;
        b=rneDY9QNs9gc05lkGvgJBHCXJUXRtw6LzBc1M02yOmGZcXW4kWEgPdR7uUc21a8W/Z
         0ZL6JyMxjTOuMqYU3rRVYxWpTj9XMubM42h7Zk21xHoUgEnsmXuv/LYPI/4gx5FPND9y
         Ho+d1DTlvL34ljES+KrDcyS1q7PDBkEa304McsJVxx+6ca86wknWmDl5E3r6E6uAEVr8
         ZTQLKBAUFb5vMKZ37kpWfRaEu8p/1/SfWXu8Aai83WvGFLC4D0Gt7oi39SnBobRCoyRr
         XUjRXeD/fI22VVdUlkgSkaQDDrSbNH4rI7PXqwN+Mx1wShO2vUWOo2g7q8/kCA68Mpba
         S+4Q==
X-Gm-Message-State: APjAAAU//oF8GsdVex5A6w37ZnTad4kfcIm4s28iS3wElDzhxmGGu9mJ
        zlLKpsOb7C+Ijqmxx/4m8LPxmiKfJY27P5pbNONixg==
X-Google-Smtp-Source: APXvYqzEdPvWzQjjFpSHEuQm9FZr2NPQCyBaUvjtIxWRVkyS2WCtDm+HemdQFraj4sAa09wSbtwUDA6u+vbbyoDTdag=
X-Received: by 2002:a67:f485:: with SMTP id o5mr12809869vsn.165.1559569731068;
 Mon, 03 Jun 2019 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190528095928.26452-1-faiz_abbas@ti.com>
In-Reply-To: <20190528095928.26452-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Jun 2019 15:48:14 +0200
Message-ID: <CAPDyKFr8LUqpdHGKDj2fK_XXHCSwJWS2=-G4EUhK3nqsDSeW+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix issues with phy configurations in am65x MMC driver
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 at 11:59, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following patches fix issues with phy configurations for
> sdhci_am654 driver.
>
> v3:
> Changed order of patches so that the first one can be applied easily to
> stable tree.
>
> v2:
> 1. Split patch 1 into 2 separate patches.
> 2. Improved patch descriptions.
>
> Faiz Abbas (3):
>   mmc: sdhci_am654: Fix SLOTTYPE write
>   mmc: sdhci_am654: Improve whitespace utilisation with regmap_*() calls
>   mmc: sdhci_am654: Print error message if the DLL fails to lock
>
>  drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>

Patch 1 applied for fixes and by adding a fixes tag. Patch 2+3 applied
for next, thanks!

Kind regards
Uffe
