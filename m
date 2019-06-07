Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3245C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824B1205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoToUoWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfFGWZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:25:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41940 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfFGWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:25:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so2715592lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGW8Zw9vrerYLKuQT2nRCi+4sph/YuDXDjL6O2OUlyY=;
        b=YoToUoWcx3852gvqkcDqaAMEmvxpkHkiUSN4e9zc8dZ3goxm71AXrawyITaIP5GLLS
         rx8hYH26Xwb+TFFur666Px//Tfwd4vaFmukaXEVxWybwGOTaBZBGIruWs4fpO789FIy6
         AHnYYBcAvstBHMkkTugoQ3vKfE+mGkEWW0d2EV8/DQkiXnUerfubSJdBuU70KlkB2QLa
         HB7QXW6NkYRO8/wG9fo4DrzI2En8SOVEcua2UQk/+9wJ4XDCsURRpCMV2n112gAgRjt/
         g+Wd1S1krdN31vYrT3InbPW9RpSg4p1pHwLs1HVgEEfY/NHDHfgty7gAJ/Au1Rlud4qS
         sDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGW8Zw9vrerYLKuQT2nRCi+4sph/YuDXDjL6O2OUlyY=;
        b=Cbo7+O14qN3Q5lCYJlbt4aB6TJMCyrISqr4DtXT+a4+6KOwpETgU6KCFEz3GEU1qfw
         qqkNW5D3OKUv+s9YrCOgnM/xhuhoVgYKRzmlQML0KZs12O0GpQhruk10aVcKlmemN5RN
         Lg7Qluk/qSDOTWhHGsHH9XxFaVtl2meXZYwzKakbQ8eoIeKpOLwdZ0dwzBp30KB0NOyV
         OIP+JK6k5WA7F4wrGP1raMrS+fZH9M1H9cBwqBW2MUpWcTno54YYADwgCXLSR5fnGysb
         uczqUzQ1p74YZ5s+smtkLLddXAeVR61IGKkILiOb/9fHn6oCG7WypkW2WfYKvGWuSAvM
         jJvA==
X-Gm-Message-State: APjAAAXQcbaJ5ZgWEG6keaH9xpE+u+VTUs1khk98fIeScBqWAOfnm1FJ
        +7P/JIgJYipSlcrBFjKLRmxUaiyKRUT+CO5C9K4hcQ==
X-Google-Smtp-Source: APXvYqxNvBh6hAcA49cetya1d7GzlkGbHULmzKnolLcB2hj9KdHRpewtAF6MLQb+nLBB50KHLqayPIOHqmuTwhkTOL0=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr14458737lfm.61.1559946324431;
 Fri, 07 Jun 2019 15:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
In-Reply-To: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:25:16 +0200
Message-ID: <CACRpkdYW3rezzJ3XAuuSNNsRiDh9nYNL8NNFjaZ=_NeXrmZbqA@mail.gmail.com>
Subject: Re: [PATCH 1/3 linux dev-5.1 arm/soc v2] ARM: dts: aspeed: Add SGPM pinmux
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 11:42 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
> supporting SGPIO in AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this part of the patch through the ARM SoC
tree. I guess Joel will queue this?

Yours,
Linus Walleij
