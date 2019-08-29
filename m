Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C9022CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oS3dg9bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfH2JdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:33:10 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34611 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2JdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:33:09 -0400
Received: by mail-ua1-f68.google.com with SMTP id r10so953797uam.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwMS525ywtt6sOg3VAxDrxJAxwOW0CWRYuAHzYt0J9c=;
        b=oS3dg9bS3cPrcgG3vOeds6Of/Z1OhxHH73UTSEEvjU7LQ1QpYpJ0chV+hWPiPMuxth
         h7Awf8JulKMThePAbEgZUhZRbWVWQzNylBVGm90uwKXHvOIx5ZNbRzsohHMdpJg6gqJA
         3QKuzxTcr+kvW+arPvTtiX5ufTTwT4Lly1rMnYwTDxk37yXuHjs1OUZebbBGXp9+0B6S
         M/u5dKDxHju7704K8VWl5kP/MGnbJhnpXTZD/T4xXCmn2vgWEGTfmIP9+OOndzaVpDQz
         uHTfQ9XH65cFSil6BEoX816DV/tqY9tQ3sigPeehTuGujw3ArKxmssehbbVEpXpUIthD
         oITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwMS525ywtt6sOg3VAxDrxJAxwOW0CWRYuAHzYt0J9c=;
        b=U5k3hr0IYTghuSZrm96UbL0N0BsgRt98sQYmBqL7WcgQDu2Kb+Awjaj99BvigDBtQb
         YwJAGlyx+30iMnVXqlBoIQcO5OI3a8q8JQKK58pL+fX2TBSqeyHlDKLZm1p36lXQ0Elb
         esSqK1wUHE3db1ja8Oyi2izE/yHCWYNL8enZ7oSS8PWLhJf2r+2ngSvJiyOwtD0xWGg2
         1RCF6wdK83lIWZMb9nk1CoBDZftvyrRCetcy/V9kBkS/IDRioeTqYx0S7UjkroMdGEzO
         CfNtYM4VD/v3EpDwRTb764CUsfOvJKfp+06E8XZrFP4ZZ+0w4P8y2MQEqd289L//t6n3
         uufw==
X-Gm-Message-State: APjAAAWx49XsoC0i4BRVi8bxIvykcMOB4ThTTa0x6JEC51SW55167t8J
        lfkYUcB5WQj6SOzX6wDHe9RrxInYk5A+amiCaWSm7g==
X-Google-Smtp-Source: APXvYqw4cMfDzwrNTgPt2rfd0EXbGJVRlkTiKDXTWWUi6fN0jj1iS+RcuKcfAvqHKkgKC3y15uSqQbomLBZcx4qiVk4=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr4257943uae.15.1567071188564;
 Thu, 29 Aug 2019 02:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190829014645.4479-1-zhang.lyra@gmail.com>
In-Reply-To: <20190829014645.4479-1-zhang.lyra@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 11:32:32 +0200
Message-ID: <CAPDyKFp_+YuPOjURiE0YhT0uotZi=P2sRVYNr3ejgZmrMaN=tA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/5] a few fixes for sprd's sd host controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 at 03:47, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> With this patch-set, both sd card and mmc can be setup.  This patch-set was
> verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
>
> Changes from v1:
> - Added Reviewed-by and Tested-by of Baolin;
> - Added fixes tag for all patches in this series.
>
> Chunyan Zhang (5):
>   mmc: sdhci-sprd: fixed incorrect clock divider
>   mmc: sdhci-sprd: add get_ro hook function
>   mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>   mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
>   mmc: sdhci-sprd: clear the UHS-I modes read from registers
>
>  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>

Thanks, but I amended the current applied patches, assuming the only
change change you did was to put the fixes tag on one single line (for
each patch).

Kind regards
Uffe
