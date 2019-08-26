Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F316BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCF621848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZ0xugnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfHZF44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:56:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45697 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfHZF44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:56:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so14084699otp.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPO5IG68iw/9a2FqfYI87FbeMWrvdMb9WwJycQ8EVL0=;
        b=DZ0xugnRGsuwd8WFDwpSyZ2q5dzXqt6TzNm9M7rRj4hk73cD63nnWiSz3zBnMy8BsB
         2dbfe/dM0IYUSm4QdgU263wGi3i5mNtr01wk8OJFLCXNHjn/jFD+eabsQbM+C/kg6ZFY
         sM6QgoNDNEmhIGcu6g1PMgy6FEo9Lou08aM8s7o8mkan60pwcfOoO9GCSsvF9QaaZOxY
         K/ENfJ4coAqSK7jmBlEnXWpEnjqenzfN3fowR4HJrdE4VweFmm6OrX5Mha93XkN8EhEq
         ktOtzIoQF6vdANutCLrC1wPs5P4sQjClJj7XxfsBa57+UMzTBwe0FP1GqiflIWGh4jZg
         q06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPO5IG68iw/9a2FqfYI87FbeMWrvdMb9WwJycQ8EVL0=;
        b=kFeIb1zURLzCqFhU0yJ+gb+svhSCpQbkBJy1Ds7oIC+qqmg5vr2dbtKxfYjR4+ZrS1
         TaCN398cIcrnRCGvITj9mhaM+r/DXPscxscdkWGrI+8nhNAWQRgnMkTYfFKNdX0aEK6V
         ijmhN7pLt3Y979FkQceP/acGa4F+sGEL+Gum1FpHMI2j17XVIQ+mbncw3+qufTsY+u/W
         qd8cNKbGcpHN6EOoEKuA1REi2m1vlTW6T+cgabEVaMuk4gpc8neev8/YygL0oudeey8O
         q1wmFmPCagNib0W2ftWqa9XGN0f4QSOSGQbJenAUtcqWC/6cNlb7cJx/CRL8jMWs1YNE
         kBrw==
X-Gm-Message-State: APjAAAUcc8uWDPXDPElOvWyLjzyBA92BRSQVhv7WG2XlSUuO+KC/AXRu
        uGjYqdjqYIC771g13OaHkmZ8RIjSyqIZ86rLWHaxPQ==
X-Google-Smtp-Source: APXvYqy1bDX6YQEBSxkppHaxRD/QyCq7IzWqqwDDvQiXRrzpkIxBZTTxTJUZKBTiKjzHPusweI7ZER8+wlkqtfnRJms=
X-Received: by 2002:a9d:63d7:: with SMTP id e23mr13331340otl.269.1566799015442;
 Sun, 25 Aug 2019 22:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 26 Aug 2019 13:56:44 +0800
Message-ID: <CAMz4ku+o9KiqV4fJ17v4JwQCaTSxz1F6e+FBOnDssaVg1HztVw@mail.gmail.com>
Subject: Re: [PATCH 0/5] a few fixes for sprd's sd host controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 at 11:18, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> With this patch-set, both sd card and mmc can be setup.  This patch-set was
> verified on Unisoc's Whale2 and another mobile phone platform SC9863A.

Tested on my board, so for the whole patch set.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>

> Chunyan Zhang (5):
>   mmc: sdhci-sprd: fixed incorrect clock divider
>   mmc: sdhci: sprd: add get_ro hook function
>   mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>   mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
>   mmc: sdhci: sprd: clear the UHS-I modes read from registers
>
>  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>


-- 
Baolin Wang
Best Regards
