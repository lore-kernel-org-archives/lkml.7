Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3ABC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883542082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576881934;
	bh=3C+B2ysqfREEI7rfSpJKeNGLAp0nRjh1KbKbLxKJ4Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QgpeN6dL2EF+MHh4wO5Rno2fctyKEyTBCLCV7+lMYEhW+cZq/Uolc1BesjDCyY+Rw
	 JYkJgltY4Tu94fjGd2Lq86WASFIUjmXMGu74M0MfQHJwYxm7l0XtleMCdHNJaL9JIU
	 I1IG1/TYN6L1evfbiHsdP0OZ6ThPihaO9s/pjWSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLTWpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:45:33 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45527 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:45:33 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so9258374iln.12;
        Fri, 20 Dec 2019 14:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CY9sMs+zro4McTGd9aPHOfBOz472x2dTm0RnIrjREH0=;
        b=pRD19i2lAH4lO1uoc9Lg9tOc+0RJ115hOM3taE0yT82s+GVZjwZp6T7UZrWg4reqhY
         YOrfVIpQ/v7Ear5G2977HgWJtTGJa80ENx/nTqbgZfQYNmN+Z3NKsZ0CpeDmVMPsBbfo
         XJBIcns5syD6cZCvvWRx1j1Rnh4SGsrXgn/PT6z72iTbIJBx1gIOFqVA7KSHQ11Ej3xz
         xueD41lPtCLdjLc/Lr6Vl485MHIaLNi/sXmwCwV+9eEbrRu/BVKffkehlpNCU97D7UnJ
         JT6/3ktNgKLM+GxoEeBWCu4hmFd/NabcvXHS8E7jsaeCVBhlVLU1YpLmn9jp1mbZ1gq9
         Atmw==
X-Gm-Message-State: APjAAAVzdD170RhIGvWaPVt0oESS7XZaLnzHxLtNrXKWug5cPz6znGTs
        D08mrpXOQMYgxFsMopMVxg==
X-Google-Smtp-Source: APXvYqyIXFLQKvMNyT4CvtPyK5CJUbTKi6uMqY/7MWchstbPBwwZAsx97u2f2VEcT0G9XSIKsUHQNw==
X-Received: by 2002:a92:8307:: with SMTP id f7mr14881259ild.73.1576881932586;
        Fri, 20 Dec 2019 14:45:32 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t12sm3864906ioj.82.2019.12.20.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 14:45:32 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:45:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     p.zabel@pengutronix.de, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, lee.jones@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 3/3] dt-bindings: resets: Convert Allwinner legacy resets
 to schemas
Message-ID: <20191220224531.GA20297@bogus>
References: <20191219090712.947490-1-maxime@cerno.tech>
 <20191219090712.947490-3-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219090712.947490-3-maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 10:07:12 +0100, Maxime Ripard wrote:
> The Allwinner SoCs have a legacy set of bindings (and a framework to
> support it in Linux) for their reset controllers.
> 
> Now that we have the DT validation in place, let's split into separate file
> and convert the device tree bindings for those resets to schemas, and mark
> them all as deprecated.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../allwinner,sun6i-a31-clock-reset.yaml      | 68 +++++++++++++++++++
>  .../reset/allwinner,sunxi-clock-reset.txt     | 21 ------
>  2 files changed, 68 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sun6i-a31-clock-reset.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
> 

Applied, thanks.

Rob
