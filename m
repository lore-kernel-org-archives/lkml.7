Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C6C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DA3218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaqgVE1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGDHpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:45:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43236 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGDHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:45:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so5136157ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqIbRmpqLMGOAT/gnCMxZj540BB+nzZMlAbEvE7fDYw=;
        b=LaqgVE1ssRbhWRJYHPBJhjqh1E8z7JtSWBk911qy/D6r9hoZ3eK1gS+E0H4HqyNfo+
         X2d7vDwKXfMv1lslLTwS47ZIau/5Xn0/1EgFb2Rup+kBttMFiDvppkhRTITPthtcNJwj
         2kDGQBGwgicxgJSJlTRgCgbR+lMO6pGTpiGY5Dl1irjYQavim9ri6XiOh7HtXgUTV+q2
         qY+teMEzE0tgqp6rf674urI9PnH8HCyBhwie21kZy9Anw3Df+hVf83jSHwdaMBKy5iG+
         5BR2O7VurH+pRwKn6pW0JZ4IKVIsN35yPePp/ilP3wgAYhhb7LTFswtXr1ORP6PWbfNE
         WL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqIbRmpqLMGOAT/gnCMxZj540BB+nzZMlAbEvE7fDYw=;
        b=auaqlRknqVZFYQE2usxng350ic8CWe28yyzILGeD+AXKtjngywLv/1J8+uFa5pw4bj
         ILRkglL/A7k/XVu0lykCO6IpwwEnjO2YR7QEie52hB4rAVTwUHKZiBvWJwbt8c+CabdY
         dk6A5uNWf3fVvQoxlRB/Jx9Jgycl2vXO0K9sIKFKxiXbPf2uOj1uibHlDRPF6EpH/mvY
         ucQPul0yJkNaAj6/v4lLDIV7s4DzwVQIYdlFn5ffNIukU9jYyqLkru8OZOu7+14v1FE2
         otPRLPqFSwzc6WJfeIJ5N6MFPe3PTz1GBUf5+8pejQw857QujI4wkKcaPXpPTmO5gMIg
         wWow==
X-Gm-Message-State: APjAAAVVaQ2d2+uaLzjMWhZLUwyA8lA4zNomirvWqNoEPjxhcUURyzfc
        paZbNqW3/CHua3hJRFXibbiAjNA1jMv2EZM/h1py9A==
X-Google-Smtp-Source: APXvYqyvGakK4ylSdsFrtpyn/uqOct9HbmkohFRyFJ5vpJo68nXnvqeMHK72Apyap33ZaUPwqSHgwe9f8bkEGi5kvxI=
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr24161474ljm.69.1562226340137;
 Thu, 04 Jul 2019 00:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190702105045.27646-1-vkoul@kernel.org> <20190702105045.27646-2-vkoul@kernel.org>
In-Reply-To: <20190702105045.27646-2-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:45:28 +0200
Message-ID: <CACRpkdatEKYaZF1LEy-O4qfbBFeMQihp4m3Y5TmgBQcXA+v2qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: qcom: Document missing gpio nodes
To:     Vinod Koul <vkoul@kernel.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 12:54 PM Vinod Koul <vkoul@kernel.org> wrote:

> The bindings for msm8998-pinctrl was missing gpio-ranges and
> gpio-reserved-ranges, so document them as well
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Patch applied with Bjorn's ACK.

Yours,
Linus Walleij
