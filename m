Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80863C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5416D216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMJX5LA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGDHWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:22:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41052 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGDHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:22:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so3517642lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqFQucJA68+LfUIF6PsmEVF8+AEtjKWUJb7Uq0uRSO8=;
        b=CMJX5LA3Iq/AnR8kOQVB/604GMxrDUOprx6uTQFKGqvpRDPoXa+sKHKl3e4cdQXgfD
         4uA0JPNgBa4vNdt9VhAXGP4G/6Sw7hdD9mwybYBeXxCLAqWcrAO0YpooNeSdJUTZ8jZH
         4WJJC3lDPhI+e6+RqCI2h4LHE9Y0Flm+RGAhO68n1zcGv9w0i+1K4858z7knfegErIet
         YosMOlwfxeiCQ+VPAvJ/73zMiLPUaBwMOR6lHlidBHiQfHeQJQZ+NgdQxgrlA5zG9CCd
         IG8412Na3RS0+/AsO3XTB8G/FozzUx4ptmN02hnY+GckXEezQqJzaYVKlYSwanALxR09
         TElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqFQucJA68+LfUIF6PsmEVF8+AEtjKWUJb7Uq0uRSO8=;
        b=B3frszeZS3pHIGbcaOzB206s6dSpudSdWqdnfAP2OqVj7l3xelNdxa1saMlDKS8SHf
         /nX9G/moNnE22ef1KA3bfCAnn2MZz/1f5gMjpvCaOQdgAwnVA68OWYm85hfPL+ZhYanW
         qB3A44m0JJ5/+VaSFLi6YDxhomRYAaylhUbOaO8kWqk+64UJr6ryzw/cEMfZ7dSUkJMM
         krzOT3hQJRw+c7G1LACFtkq2wivxDIbnCY+KKcj5Lll7AsIN4KbeqwfXSAP40QrjOtdU
         pXKPmKv1dYfoeEBEs9E2X3oEnZRiWJnlpGwOeStuE4Qt1LStcIx8cuLlz4Z3Isb5tVsh
         Ut3w==
X-Gm-Message-State: APjAAAUIYquSUZ7Z9TYnXg9v/VAf8jFgbukT+WW1fkYEKxDEi1vSDfkk
        G2JWWxzOmPfg7jY9Jl7NLPTQiq+ZUr8ijBVgJZpRww==
X-Google-Smtp-Source: APXvYqynHwsot+XX5IFHli2hQMu+J3uhahUul8EBgUfkRdJBS2rD6AJj0I7kGNyHUl0psqXlBoI1EIIsBBUT+qDq/oo=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr4205328lfp.61.1562224954848;
 Thu, 04 Jul 2019 00:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190703171924.31801-1-paweldembicki@gmail.com> <20190703171924.31801-5-paweldembicki@gmail.com>
In-Reply-To: <20190703171924.31801-5-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:22:23 +0200
Message-ID: <CACRpkdYsA5437Sb8J539AJ=cYtnO2MiD7w7V_Emrmk8dNKbaEQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] net: dsa: vsc73xx: Assert reset if iCPU is enabled
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 7:21 PM Pawel Dembicki <paweldembicki@gmail.com> wrote:

> Driver allow to use devices with disabled iCPU only.
>
> Some devices have pre-initialised iCPU by bootloader.
> That state make switch unmanaged. This patch force reset
> if device is in unmanaged state. In the result chip lost
> internal firmware from RAM and it can be managed.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

My devices do not have direct access to the reset line so I
can't assert reset no matter how I try, if it works for you, the
code is certainly better like this.

Yours,
Linus Walleij
