Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DA7C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A06B21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562683843;
	bh=/n6jTTuHJhmFmkjwNZDYQdh1BaMLyfpRIzzWvYKfgaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GKblgtDS4oIdXe7hNyHFPBtw9v4xs9yGgVSpP6GerjQOZO6lHB9aDzGxQJ6kYQzHB
	 XjMrV0IGS90+j9jD+siaapz3RmDHnsK8UHTLrwlepm7c++qii8jwz1tbBiy3nd+Aa2
	 7ulTvsvuP3G6Mw72xqSCcZktP854MYteBcMo+RTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfGIOum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:50:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46691 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIOul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:50:41 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so43666631iol.13;
        Tue, 09 Jul 2019 07:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46Epk3/36kPZgwCBdnESdwm9AsP3sDBy9DMR2D84jbQ=;
        b=hkgFFc5/VI7BIoBmJPBtBw8GoabELst//bcs2QbX4p4WVrLMFqitBnW7bEuLMEfKZ4
         rvYsX6J58lGU10zqJZSQuVDuZP5Gqx7CT5aoWcI+zClbOcaScS/QGRyG+33ZksLRKWa7
         OhZ7loRLL0/lND/lexnGNGFd7Gb8hW9Kd7z6NlUQ6fRRPMJLDlpY9vwvwsghanRgXNdU
         4UOBoFHWDI73ASJRbJwgus49lKv4Oh3MviOxllo7PraRBGEnJCpGjRHIl+zOzVY2EIRa
         WAfuiUFhub58X6RoqXVvjigZ0b6bax0b8SP9ZEo5zw/UDm19ugeJPuS2SKYKDUYb30kE
         g4vw==
X-Gm-Message-State: APjAAAWTj1bUH6sg0NxvO7Yhw4ANeAzZnw+Zsq7BZZA9G+qwgF1UnqCB
        1Kq4X8KKS/RZaTpyjLa9txRbXMf19g==
X-Google-Smtp-Source: APXvYqzHI8qSCiXN6FftFD/8DWYZDs1KQ1ycSN/veVfBVhoubY3v9ODlSdRUq4IMRUPQR2RPAVWsOA==
X-Received: by 2002:a5e:9701:: with SMTP id w1mr161447ioj.294.1562683840732;
        Tue, 09 Jul 2019 07:50:40 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k2sm16925748iom.50.2019.07.09.07.50.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:50:40 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:50:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: sun6i-dsi: Add R40 MIPI-DSI
 compatible (w/ A64 fallback)
Message-ID: <20190709145039.GA313@bogus>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614164324.9427-7-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 22:13:21 +0530, Jagan Teki wrote:
> The MIPI DSI controller on Allwinner R40 is similar on
> the one on A64 like doesn't associate any DSI_SCLK gating.
> 
> So, add R40 compatible and append A64 compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
