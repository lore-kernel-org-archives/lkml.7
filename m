Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69455C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1C227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578090564;
	bh=ld9El4+0s1shXpn1ZSiv2ByRJH741Yyt0tOmYAuiwCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ytyebS+NLJLj+PpmaLaEHHNcQJGejNqN7RHK1Yd4LW7+6fIynwBcFoS+o4/ptBAob
	 2id9vPNGB3pePe9KXWIkUtRwKlPIulGsbfOGLpm2z13JbUC5+bkkwrvvxREKSjBLa2
	 wlLPf9eORTMXeHKtr58bhxuCaFjwnNG2IZO+CcKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgACW3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:29:23 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42735 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgACW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:29:23 -0500
Received: by mail-il1-f193.google.com with SMTP id t2so22496675ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=gGxgEmek66XClr+I4ZOssMbObOa7QPZhKH2BM6JU+5M=;
        b=FVH0GsSBJ11pgObOQ6IIh9j8ufnWpQkA+Hm73CuHE+VMnG9WEsqMBAVdOLevx2AEUf
         rPtA8EdKM9edbb6+DIV3tOKTPqp+fBAOBb1y8x430YYRkgYGSgwuSOJMbx5Jiybj4QCa
         0YW5dmzZGFS9lpoxHPZzI3J0f0tWuvbuajgIKC1K7Uc5a2tL7qXDeorlISxCZz56R7r0
         mGG0KW+VnlQeH8qMj7KfYw4V1xzUbtQZcFWLBehFny6ZuxAxzpCItzk102zSNZ2E/UiB
         xF41O1gcUpngfnH6ezU+DBbivE8Elb0z+Ux1CbLzd7p5vQdf7fVw6DdgeQYPg02uuFuW
         46iA==
X-Gm-Message-State: APjAAAWKLtJnX3Lj93G02UFA4Y6EhZGNuSEmxL1BCM61lyHb9VwUpsE9
        eJf4usRllmWO9YvgkoE+6PM2IFE=
X-Google-Smtp-Source: APXvYqwyRFU4neqvMSYM/zyzONPbXK/0jyT6P2nJUIahOZ89oJC8p7bevAHQZyIFYsD7UBGRSIG8Hw==
X-Received: by 2002:a92:8307:: with SMTP id f7mr73970836ild.183.1578090561794;
        Fri, 03 Jan 2020 14:29:21 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y62sm21424851ilk.32.2020.01.03.14.29.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:29:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:29:19 -0700
Date:   Fri, 3 Jan 2020 15:29:19 -0700
From:   Rob Herring <robh@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kamel.bouhara@bootlin.com, wsa@the-dreams.de,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, robh@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: at91: document optional bus
 recovery  properties
Message-ID: <20200103222919.GA32421@bogus>
References: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
 <20200103094821.13185-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103094821.13185-2-codrin.ciubotariu@microchip.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020 09:49:06 +0000, <Codrin.Ciubotariu@microchip.com> wrote:
> 
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> The at91 I2C controller can support bus recovery by re-assigning SCL
> and SDA to gpios. Add the optional pinctrl and gpio properties to do
> so.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
> 
> Changes in v2:
>  - none
> 
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
