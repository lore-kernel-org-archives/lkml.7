Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BE7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033ED20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxlRxKxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDHJLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:11:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33858 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:11:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id o199so1802463lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3Mnt2T+RPJQz/wkUMli6rTox/zjiE1/T8uCy+uKjoI=;
        b=yxlRxKxtpb9otW+PPcm06iBq9oX6mD7ZeY1/BaeCjRhHKyVk4g5uF3sowb1uxyOk2R
         xeMRNd+S0s0LaWdaKZJLNJCWKoXc9DgswwArPNIeCsBmY8rJw3b4juQrkB9cYmDxf12Q
         /1fehVC8PcKTYP4pTTncDi8pOkYe9GlRFvbbAblLFveJG0h09Ajzw+1vMYM4ZDxJe51V
         CrbjtXA4I7aMYGv6oGN1T62mhOFqn5EnRhMCSUaluCjbiftDafFpmOVNNML6Nb9eaciS
         xo1al+ICkhgdgXrzabYAK0ZWGHSiEs72ecYSbK3QJwuItGbH9DVwkIBmUd00Ta1hbnVA
         4iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3Mnt2T+RPJQz/wkUMli6rTox/zjiE1/T8uCy+uKjoI=;
        b=K5oic6jQmI8wwlSARFyEkMDkb4n0mfDjKDwTtVefF58Rfk0WVPrecvpe2FmVVqxrP9
         kW5eojiaWhUGBJwUYaR0U1BNa2pTxP2CCXjydTwlP5HGL2RTCoAFm9ibHRZrXAFIPs0R
         NdEhr/8ZhI2HiNxYhKYqxv4ttbejyEp727rOttk6m9ODPe7NruP6ffHxSqskt5Vu5fAT
         XwBMCq+uQcHZch3nxtfQwPkhXdgGsau9FjbHEGWuVOA4BhZu+UF9mxYlpK8VEkcEGu1n
         jzlktZt0hvEgY1Zx9oIEg2FdzgzjiI0GDbNaI4pInul+8epCqgSZ4wX/mmf4rU3E/SQA
         Gixg==
X-Gm-Message-State: APjAAAUOUWrZTagersx/2EtKaVBVJq7JQtm/eQXbVPxL6e72y7ida9Jn
        gFxJvD0ZuN1HlCiT36AiJ2BDK2owIVS4Z5rDEGaczg==
X-Google-Smtp-Source: APXvYqxp25tiLbnJCv1zryVw1Hms4+pMYMTFCiLNSjIE3SEMU5DuvyxWksHCOjtxJKYpTUjzdsRCU9C16pfGTCvOrR0=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr14803356lfy.128.1554714696647;
 Mon, 08 Apr 2019 02:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190407211027.14012-1-alexandre.belloni@bootlin.com> <20190407211027.14012-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190407211027.14012-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 11:11:25 +0200
Message-ID: <CACRpkdan8jsK4BJ1zeGBAj0EMeDhcd4uNHfjHVDeA+P3GsVH1Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] rtc: coh901331: switch to rtc_time64_to_tm/rtc_tm_to_time64
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 11:10 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Call the 64bit versions of rtc_tm time conversion now that the range is
> enforced by the core.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
