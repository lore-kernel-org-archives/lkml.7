Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290F3C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDD6208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOfBgz52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfFGVGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:06:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46272 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfFGVGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:06:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id m15so2882136ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngGsJ3sa6qftNEqIKxcUHf+2Y/2GL6FaDVqLdkUZI+U=;
        b=NOfBgz52VTuWpjz7V14ZcBELLxddIR64OTKQA2xzLIUhsP5/le33K3ipkbvzpS+NkU
         TWmkiy05Zzo+Sq8ohP322QzhhjfpVeWa3bmyyK/KZJLgA3RCPiaJ0nbUV6gxuUPQRsiR
         hJHfhpW/t6Z28Jy4XvFxx+geHjK/yYy5OuNGkeigArmPSC0v/6zCUFzp8bwFS1Iw/5bp
         +ekz1pj2MJaEvb2F+QqbdjFM3A6f0v3/J42m1DO7RMB9LDgmXsQxC/FZuZitbQv1Aow5
         +4H0ysai+Q1d9tSXFbGxA+jZGnU7StunRABpEMHuadstqz4nLOPTxZhqWZ+6jBCFPgMf
         fufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngGsJ3sa6qftNEqIKxcUHf+2Y/2GL6FaDVqLdkUZI+U=;
        b=MagiKt/V6Cu25HRCYjmnjb2VgC1svnE7sadTQ3pzOIWKDl83f1EfP/0TvTLm86BD2x
         Bk8RjkhhzE4FtiAkd+uAnLj0rZ28f4owZNhx7FcNg5pnM+nmrs5rYhJDWitRrRrWXubD
         91k50HcSERjNBrms+MOycAdVMj6sng+8xksZ2E7XVd/KL7oLSnonBHEzE0NKL7pDngaC
         6Kpcdpqdj3wxwsBNUxUNMQ92pXGyciV5oIHZTArfjE2bqmcjrLW+bsWmT2jiFRpzz2RN
         VAJHxu+QPPVXt92G8hqe1P8Zp1YvXT9gMiEoHxzumr1RWE1GX3uGoYQVz/AsH8mLDlq/
         2ZfA==
X-Gm-Message-State: APjAAAUg21u2cbIfOcYRBhnv2p2khvjMN8z0A/9mIKr1FdB/yXYa2orp
        XRtPSeNRQ6v/1IE+Gi3CSUbDMTV3nfHFEsmxOz55xA==
X-Google-Smtp-Source: APXvYqwzWHOHL3qBWLcwt+um28DnahteXeh1UMVYjgkOQaL8ZQiEb0mBtE051TG+KFU+85SgayUB0dlFm2sVY1/RIA0=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr5273384ljj.113.1559941594784;
 Fri, 07 Jun 2019 14:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <1559097838-26070-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1559097838-26070-1-git-send-email-92siuyang@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:06:27 +0200
Message-ID: <CACRpkdYYYxCti4zRzF1bG+cb+NAONVjg1ynOww5DpG7dzi1B6w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ns2: Fix potential NULL dereference
To:     Young Xiao <92siuyang@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 4:42 AM Young Xiao <92siuyang@gmail.com> wrote:

> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
>
> Signed-off-by: Young Xiao <92siuyang@gmail.com>

Patch applied with Ray's ACK.

Yours,
Linus Walleij
