Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B23C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582062168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAmpOuMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391307AbfEXLvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:51:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45411 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391023AbfEXLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:51:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id r76so2924981lja.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVGSSaSKko66gmIM4yeSPo0D27KVf/MwdUcazG0psBs=;
        b=CAmpOuMMgs9LNo7ffRbh2niHdnt9B+qRNFjXwdDDbdmKYvjsctl3g/iYhVPPMDXmNQ
         C9nCmUdsHuo/sXnalkykTGtXCI08h3hJXnqYckZEQBOV2H3XvVNS2Dw0rjzrSYLTAsBL
         PISC6f5iKEvlGI7Y6GmykNJP1NipS2yfbNBChNABwwmH3qY+78D78zSMqo5TqjyQXizP
         N6maHehsRnJvSf/9qt0lNOhnhc8rlvG2SJf4Qp9lq/WFS+WXiJgVk6bOrtkAm0MeZzsU
         Wt5vp0P7eU7nQmhGwG7OeUGt7wJgtBOx7tUcinuSNvgXlABpan0CL5MHMchYDegM9OD1
         c+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVGSSaSKko66gmIM4yeSPo0D27KVf/MwdUcazG0psBs=;
        b=G1PIDti+d2qeeN4teRl6km76OqLdcaIyBVmU0j21zzRl2dflNz4rxHpopPZNTSkmks
         uF4qeuau2NbhpInju8yiwAkLnIdto6/5AZFUk8vami4qGe8kIqNKOVCNd0Nn1PQ8ekfN
         nB+GR8uR5O0iSJZ9QTlGZHB+5j5ehkKoH8RJJfZa5wDGEk0WiA2Mf7kJngbvRwQtolSV
         AhYpsM4wmHDwoykJaioPcK9MloysibJ+hpAWEoqC3Dj+GUyynlINGCYj55gmXdtKo/5e
         HuCvKbnPxP4ZosACC2133KvGIrZPpJ/TzyxwAAa0weWlMF7x8NwYc0v80bDgnDaXoFVm
         a6xQ==
X-Gm-Message-State: APjAAAUO78FTzdZjHvcQcXkHhSiv1V0yGwAp6TT+bjjB9n2jyklXSlTl
        zfH4grE7jKzvXsfFa9gKLGmUAVHkord8s0QeuHFt+A==
X-Google-Smtp-Source: APXvYqzGplebYUdWzYGmasp0vQj8eWkrY4uvvmACdfcAYttZqHwEGva24jRGrNIllzpYWD5Z+5whxlKgLAX04p3HNOg=
X-Received: by 2002:a2e:874b:: with SMTP id q11mr23966805ljj.48.1558698682215;
 Fri, 24 May 2019 04:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org> <20190520083101.10229-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190520083101.10229-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:51:10 +0200
Message-ID: <CACRpkdZTE-FZAht+txxVXYwe42uN_f1uPthLiKG54-=_YueUnw@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: Modify pinctrl memory map
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        alec.lin@bitmain.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:31 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Earlier, the PWM registers were included as part of the pinctrl memory
> map, but this turned to be useless as the muxing is being handled by the
> SoC pin controller itself. So, lets modify the pinctrl memory map to
> reflect the same.
>
> Fixes: 07b734fbdea2 ("dt-bindings: pinctrl: Add BM1880 pinctrl binding")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied.

Yours,
Linus Walleij
