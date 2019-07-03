Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE6B2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McGlDSOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfGCMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:41:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38468 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:41:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so1670970lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xy4atC47KUkhRxvml94Kq1gg6hZsMUYINS4fjvWdvCo=;
        b=McGlDSOxEhWCKthKIE+gpLcPxbWgwKMrrLO60s7Qh4nwlG49H+YLqxceuhzil1otMt
         K37j2Icrf10zt7CxCWNJi1UDiM+ejYhV1kb2j1jWfRnwY8u9S0O8PtNMWArTBz4Gxb7w
         R6teFD8bDFWDPt5c9JoIKrYC48wvC/px85/MDRT+SA9nxDgoBNhSks7DE4FDo61vDmEL
         V0gSZfi9DaWn1asSSQN0/4VhIQ83nmB9GVns7ibbxOSDedWet6lcvPkvFoETlRymLS1n
         yo8SnuurCvS+8qYuBTeAx/GTnUFau/ttRSu97efdls7MS/OtVLUq/sefWcGcGf0dQr7l
         yuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xy4atC47KUkhRxvml94Kq1gg6hZsMUYINS4fjvWdvCo=;
        b=bddhppcK1XpFOBAqqlNxlP/CtGmkoVVYRK1hUPykYEp3R6YfoO3iE/P6lvq5/4wlUU
         EkjUNPW4sIQ/GPzMkCFmWhEJMUs68HIHffsZkA2923kALNz1H8s8B9vQeY85EJ1i8Y3O
         5dxEOu6DxwD4NhBqDFcnpqiEsqVAFezTnHfziFXGGzT3fR9YrcHfWE3JlRW59YUMk2wi
         jQyak+2rcBIBJhAZApAYjLXfL1PX9Lq0BazK+Vkr+GBnTzcjCqOHw6F5Xh3ghWr/srMv
         KCBjUWrAVJ2SRT02XI/gdQ8iecPO/nhAX0ajIrPim4M+RptqMByPvB9PzMqCLSUNFYSR
         Oi0A==
X-Gm-Message-State: APjAAAXBY43w9aU55aTYyYt76Kr1J2OnlSMGbQGXU2ma/lfOxn9sWuk6
        Ox8HOb2q1xjj3xPUmmA55fpUNdUTJvQGXRpFt8kH0Q==
X-Google-Smtp-Source: APXvYqxSZq8kK+Sf3ly/VpTa30WhTR81fi6H8aQwENAVhDZ+xbderjUjpKdryIIlUpIb+lO7f/hQ0SNAIZdSKuEFh/Q=
X-Received: by 2002:a19:7616:: with SMTP id c22mr18395121lff.115.1562157697300;
 Wed, 03 Jul 2019 05:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190701152723.624-1-paweldembicki@gmail.com> <20190703085757.1027-1-paweldembicki@gmail.com>
In-Reply-To: <20190703085757.1027-1-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jul 2019 14:41:26 +0200
Message-ID: <CACRpkdabQbVosWjD22E6pM8t3gu8c=5qNMEtRsp2HLV0PJ9nYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: dsa: Change DT bindings for Vitesse VSC73xx switches
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

On Wed, Jul 3, 2019 at 10:58 AM Pawel Dembicki <paweldembicki@gmail.com> wrote:

> This commit introduce how to use vsc73xx platform driver.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> Changes in v2:
> - Drop -spi and -platform suffix
> - Change commit message

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
