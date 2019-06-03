Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD82C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6653127C7B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYWK0MbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfFCNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:49:05 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43589 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfFCNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:49:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id d128so11228769vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVPjgUEfaRYGNEU+1OBxoG2swQn44QuLIgwlXfuk4Mc=;
        b=aYWK0MbZzIOtT3h65I4XJFM1XyeTSum8bGZutJ6oGT+Ni7GT9hHM/wfxqLCtoUDEmz
         01VmV7kH08fTkH/cC2Xum0TjARU7c22W3r0YBbrRz1rhtm3fLf2/vAbxYU3Zua/OoGfj
         vU6SQZ+elZ9/4lQ5MHacYqRAEYs40n3qWu3ZYETOrZw+JLU0voeoEKN6uZbfo0wTkKpO
         PRQ3FfocXTArfHf8OjD3THxG4uZEZp7IwmNGMDJllryNwqtntIuespOEotcJqLAgxgjz
         Ze6HbmK06EGye6vofym0sxQCcv12KR23LE7BH4/DR8cUKos02+qELuBK/nrQqVYRb+rJ
         r5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVPjgUEfaRYGNEU+1OBxoG2swQn44QuLIgwlXfuk4Mc=;
        b=IC0CgIopiM1v93IFhblaoLbT6ud9zgK6/b7+NDLAMBPPFYhJtjMyluGogICqcZMBkn
         b3qFMXzoB+MxXwZqeCQ37bmoa6/utWgrawqpNHHLikQ0znkOvf1sT9C4Nota59A1YtGg
         wgYEzZGgEKVy/5KBA6Ct1HWIkO7LUhRkv7IuDWDdd+foQP2F3lRWMVe0vcm7JFbwEFeb
         VL/PyqTKTLrsJ5pY9bUmBTm6N08xQr7WR5wP1LJjPw4gwDd58f9nhjujOZjtdKZMSLG/
         zVaMo6Q/gtY4Qec5r0Z9uNoDls91Cr2efnq+lG+cwgNqTIq/GTd3TPXb6zddRHlbvk/z
         YXtg==
X-Gm-Message-State: APjAAAXhXL5tOgcZ+Oa0IWvLJ1Yaqoa0a6BUh7FsekrWwVyjgOGRn4TP
        DsxR2mH5LD8SWzoyffHawPzZZppIs5yexVnfN7QwEw==
X-Google-Smtp-Source: APXvYqwrBwar0BuKF5o1OAxMoU7hB62hCGOT7bVzjxmLgWUwoYSGq7w6IIfkKGw71lrHf/DcoAW/9/0VqOWM+hiU24A=
X-Received: by 2002:a67:f542:: with SMTP id z2mr5609156vsn.200.1559569744176;
 Mon, 03 Jun 2019 06:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190531113223.27474-1-colin.king@canonical.com>
In-Reply-To: <20190531113223.27474-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Jun 2019 15:48:27 +0200
Message-ID: <CAPDyKFpo6EqOp0mqVj7yHdttoh957QSZ8sFzHMs+QFz-cHETew@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: remove redundant check of slots == 0
To:     Colin King <colin.king@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 at 13:32, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The calculation of slots results in a value in the range 1..8
> and so slots can never be zero.  The check for slots == 0 is
> always going to be false, hence it is redundant and can be
> removed.
>
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index ab9e2b901094..f70436261746 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2044,8 +2044,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>
>         slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
>         dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> -       if (slots == 0)
> -               return -ENODEV;
>
>         BUG_ON(slots > MAX_SLOTS);
>
> --
> 2.20.1
>
