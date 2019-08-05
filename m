Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99138C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707EA20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKnr9ylp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfHEKN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:13:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33036 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfHEKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:13:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so7353371ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyWiii3HO9p+TFpHcYcc5tlXunPtGl4mlPSEP3RBVd4=;
        b=tKnr9ylpIW+IXa6FxC3GCzb1q95d3SE8d9g053PBTuKou/c62RvDkCMC5NfX/Q86kl
         EczsGJ/brZyHZbfKP/Ky4oXP9VeAMorleLLaayDh6ccR5TSNU4TZKsC3UCH6KvKHUr3Q
         ZiWT8PJ2D1Co+E7jiJdupebDFE0QKtFjJUObWjjPx3phvmnvYxoE/rAhpjOcv6+OIS6P
         Nw5EiJaFv9nYRYSCfbkRtOVcBn9ybiXKtu1su88/MYZswFeZtsafvTIph4Xh4ROiIoyA
         apKDPNECky9qV5SGzHpJKFXxBbvYk2OYfYtRS3EM99oLlNIJ22fiPkqLpb5owyfi55ww
         MCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyWiii3HO9p+TFpHcYcc5tlXunPtGl4mlPSEP3RBVd4=;
        b=gGH/BdPhxSPB4f0U2D2ObNwI1J25GBPRpxVT6f5TU9yjcx42XE2PwebdoSYSmw0+bs
         fLDyxqewbT42fin1wRKSBcIPctad4QBXQ5Gw3ZQxPPn+Nvxv2xpksK/O5CGO2maaanPZ
         PtNkFP3GdJjO2/+8n2Zdy5jFrmAo9iHvixRCFun8mcGFpQ3vLpd0b2IKd0IiJZI6knG/
         7MLfGasV5ONtLshaduH4F6aHhD3hdgNkGAQ0q6EwrYShrNQTPH+SKFq9kzf5HMGXA9F5
         GDotRS8MbdTr+R6xqPVyZUny0pbdnkQL9CR6udERVEzd1nSoRSuFRikWRH5Os8eIgXE7
         lcLQ==
X-Gm-Message-State: APjAAAWGwGgjNZUQLbKF6pQzsBKt6D9QykCYw31zpaPIdpRR1iI6PM2w
        XVYucS0lCocq6qMxMLJM8uAJzG4ZuvFitDywKBw5ZA==
X-Google-Smtp-Source: APXvYqwEAD5hMUt9shkAn/sfk0eGbfMNEwTTV9vY/J0lOGBJvfYm/cAHmt0MUBPZTHVqJdNBLXBJ8o3s15tDgrjmvK8=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr14816614ljm.180.1565000033697;
 Mon, 05 Aug 2019 03:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <ff410d312ed0047b5a36e5113daf7df78bcf1aa8.1564048446.git.baolin.wang@linaro.org>
 <17af5e761e0515d288a7ea4078ac9aa4a82a7a4e.1564048446.git.baolin.wang@linaro.org>
In-Reply-To: <17af5e761e0515d288a7ea4078ac9aa4a82a7a4e.1564048446.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:13:42 +0200
Message-ID: <CACRpkdagg+E08E0Ywsn0jnbfcnB=mM5fmbjbGETGGtwHqBtRYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: sprd: Combine the condition of MISC_PIN and COMMON_PIN
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:56 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Since the follow-up pin design on Spreadtrum platform has some changes,
> some configuration of MISC_PIN moved to COMMON_PIN. To support current
> pin design and keep backward compatibility, we should combine the
> condition of MISC_PIN and COMMON_PIN to configure an individual pin.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Yours,
Linus Walleij
