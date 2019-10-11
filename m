Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162F5ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36FC21A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570807813;
	bh=mWzK30KLrenvFfL0/1O7TqKRHnSKYTD2TTvXVJi2gX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YF6Ip+XGgiRsKSJ+LREIHcgVS7QCyEgAK64Yu+OGcJsafZJASvFc49vYt3X1YGLf5
	 DuxVeeXU5866SLECvnw7ivvvtFn3oOToLEy+bB0dbDesjrGgymKfyPz0NTvxAxn8eY
	 jj+Je/TiyCnpgwvflbEJdMwA4dY4QqmR90oAmCXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfJKPaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:30:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38802 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:30:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id m16so8330153oic.5;
        Fri, 11 Oct 2019 08:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c0RmIaIYlsHlHoHCRHVl9+9lkSFQiZD24NJsXUdq5dE=;
        b=I/ihoWihPyGjxIJfndgEkvdWQO+evb+w2VeBPiBuhxgV6Cd6JBElkabTVWUXb7vghU
         yrsgitPsu8vlABBOpxjsNciXRbOiUlQyW0O7NOWdqNmk5e3/SuYV1dreVxs0A+rTUl6i
         7vFVCykjGms18SJaSLAzlH9d7ef2F2HI0hj6yi0pwGOxOxRvpO/stPhwCWKFm0A5X9J9
         EclJYREJ6shwNzWsWdc8ZUMhnerx4JvTaWtOmjb1Odmuux0hdxLca177kYwgJ1W9UpJ7
         x/8Kup9zK+oKHheictTLd/CGXIby+xA6vbJFSbs7f3uxXGd+eDT2M7pvo/K4WcsvaRw4
         P64A==
X-Gm-Message-State: APjAAAVC4CUgAm0fac0k9SfTxylDgQk1FmDqMn1JLSRpuVifzG/gUcix
        BZ5GZ720vGiNJZ3s/gdG2g==
X-Google-Smtp-Source: APXvYqxEBkIB8HeA9nyxw2DqeQtU+M0+yBlWyz40opogflPnTQ/+drXWdB97qZnjTL3j/pd9hhE/vQ==
X-Received: by 2002:a05:6808:114:: with SMTP id b20mr12951071oie.114.1570807810537;
        Fri, 11 Oct 2019 08:30:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm2819235otd.60.2019.10.11.08.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:30:09 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:30:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: imx: fix native-mode setting
Message-ID: <20191011153009.GA10322@bogus>
References: <20190918193853.25689-1-martin@kaiser.cx>
 <20191005130921.12874-1-martin@kaiser.cx>
 <20191005130921.12874-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005130921.12874-2-martin@kaiser.cx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Oct 2019 15:09:20 +0200, Martin Kaiser wrote:
> Move the native-mode setting inside the display-timing node. Outside of
> display-timing, it is ignored.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> changes in v2
>  move parts of the commit message into the cover letter
> 
>  Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
