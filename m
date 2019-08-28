Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CF0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320782189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfH1Hcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:32:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39783 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfH1Hck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:32:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id g8so1855179edm.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCgA4t/5pcDwS4QgIYXprPCQLaL6xdTakPz+1sovORo=;
        b=TQ0tmRzuLTGUnB8pstU6sjQ6jP1bLSal64fRbwZxlBvH+SREQl7vTEOADMtnyCiHl2
         8SXyzoteVcIEuEdPCmk41Mp4RP5cjVFnHyj58auEA6ZNwdGGMiE2Os0uEibpOy72AA2I
         /i7YImAvevn0FZl3IKstngf1nhFxvHEAlaIAg+OGzb7CUrvp4Gp19BnGiPTjpClOEwI4
         wVhLBkkb6tPNbC+sYUoqFRq8SDr5MajSGdVh60g05br05/GighkTCF3LV2WV17XC3kf/
         5wELWwhbwdhnNg/5R6yZdw+ZI+7rWrwwBjbBf0gCiJ/VXxisoFN8MzQU8L+xilVS7OyV
         j4Yw==
X-Gm-Message-State: APjAAAUNFG0ul/bg6Ip/Bzqx62hhprNo1AFFlFwVuAnnUPuI66WyvV1i
        NknWReyi+3vMSjZiTXl8RtQPGmOPdcc=
X-Google-Smtp-Source: APXvYqyWf5a6inhokdlPaucsclb/zRnVxKM5TpIv9SCwV8PJTtP33X0hMrbctgOtg0YkgLQu+etJ4w==
X-Received: by 2002:a17:906:1112:: with SMTP id h18mr1880539eja.165.1566977559083;
        Wed, 28 Aug 2019 00:32:39 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id z9sm283723edr.54.2019.08.28.00.32.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 00:32:38 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id k1so1609847wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:32:38 -0700 (PDT)
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr3019968wmh.125.1566977558460;
 Wed, 28 Aug 2019 00:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190827123131.29129-1-mripard@kernel.org>
In-Reply-To: <20190827123131.29129-1-mripard@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Aug 2019 15:32:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65d3SjJEU_zqXqEKakTYoOB7tk_fo7OkJ_Gvq5Yok+_=A@mail.gmail.com>
Message-ID: <CAGb2v65d3SjJEU_zqXqEKakTYoOB7tk_fo7OkJ_Gvq5Yok+_=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: sun4i-i2s: Revert "ASoC: sun4i-i2s: Remove
 duplicated quirks structure"
To:     Maxime Ripard <mripard@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 27, 2019 at 8:31 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> This reverts commit 3e9acd7ac6933cdc20c441bbf9a38ed9e42e1490.
>
> It turns out that while one I2S controller is described in the A83t
> datasheet, the driver supports another, undocumented, one that has been
> inherited from the older SoCs, while the documented one uses the new
> design.
>
> Fixes: 3e9acd7ac693 ("ASoC: sun4i-i2s: Remove duplicated quirks structure")
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

This patch got applied as

    455b1d42e82c ("ASoC: sunxi: Revert initial A83t support")

The new subject is very confusing. If anything it should read

    ASoC: sun4i-i2s: Split H3 and later SoC support from A83T support

ChenYu
