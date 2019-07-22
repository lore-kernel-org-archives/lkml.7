Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7DBC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BF721BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuO1BvyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfGVNmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:42:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45295 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfGVNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:42:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id v18so15297723uad.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyYB86RN0dwd4EULEBIRa3DFNYh1x6Mf9BF1tEQUtcc=;
        b=DuO1BvyPUHlTBv8+4qMc5iPAN01crsg/PmFwH9BVFPitVjC7/UQnmGRQU9BxuPXngJ
         5+wLqJwE6tK/yuHuDsPigZg49HK+TSoa3pd+zy8CaF2LAkdWq8779DzdW1DEO38mzD+j
         iUXttNfP62Bxw2edQcUCo5sxPfyWJk0sFlWTMG0k1kUCbJv4TPNDzVsJzjAoBiYPWiTj
         9baHYDk5v5wDE22A57NtIVEGQGayb2lQgSHAst001JYs6kaI5gVcaK8bQcE1JBSs83DZ
         CKxiHd8lS8g2kwPfTE7mIc+cFUaw4VdcfmfOEN8mHH8uDxcJ7JLiHKkqgc0xrpx95Id+
         39Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyYB86RN0dwd4EULEBIRa3DFNYh1x6Mf9BF1tEQUtcc=;
        b=GKwTM0Tz4k6Jx6jq/0dTAtZqqMlKSoZUO78YypDmQpPZULP55OjwXpZcfvtV7io3rC
         Kpo13Xi8kuf2g1rcsqga+qBPhdRAK2xKCJP7oO0wXkauSLeuW+Bdia90kt5RSCb16SsP
         xe6X8/iwEq1pEvUSq9d00j5yl+5WVAoQekqjwgi1Hjl9utaOQS+6qz8r/qCDWycOSKFr
         kSn135YAca1mtXrLwsXr2FDNUOc8DsNABrDd6HYD0eSsOuJagVXxxWRNlU9T6qabsCa4
         jV6QgDmAR8n56FghxLuCfWx2+3Q6J/6oZZeNRR41G1pjMjtaqpjpPv+HpRWD2MlLLl7a
         G5IQ==
X-Gm-Message-State: APjAAAWjHDZ8MdBKzHAYjdftSMSSlvkYbwcvtB4kZYTYFz9g7HbxZaLF
        kNGrna6pjPk9XuiPHbToBGakHAyUiWhjSC5U6dG05w==
X-Google-Smtp-Source: APXvYqzEIiTIABeiBw+DkvyOKzYlmedRLJ9DgybTuLxLYm1YWhx6yJte7P1MneNTg+DNylIhmiIEKwH7ZHH6siy6KUs=
X-Received: by 2002:ab0:70b1:: with SMTP id q17mr17349220ual.100.1563802943364;
 Mon, 22 Jul 2019 06:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
In-Reply-To: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:41:47 +0200
Message-ID: <CAPDyKFrykZ3TGvHjmf+AYZ=DQB+_HPjMf+s5QWUC+oNHErX=6w@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 at 12:00, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> When the SD host controller tries to probe again due to the derferred
> probe mechanism, it will always keep the SD host device as runtime
> resume state due to missing the runtime put operation in error path
> last time.
>
> Thus add the pm_runtime_put_noidle() in error path to make the PM runtime
> counter balance, which can make the SD host device's PM runtime work well.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied for fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6ee340a..603a5d9 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -624,6 +624,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         sdhci_cleanup_host(host);
>
>  pm_runtime_disable:
> +       pm_runtime_put_noidle(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>
> --
> 1.7.9.5
>
