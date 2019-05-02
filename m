Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6284206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556826549;
	bh=JQ2yHnA+BjVC02StuEJhC50eoh4Q6GiWpbNzhkMQHPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A+r/R1WUU+99AkyLo3QXL5e2Qo0woYVxEC/zVqmuqcQ3eY6y/URHPX0+ZPfBE7Jgo
	 V8ZTnWX7Av/sA8j3osA+xrxcGqABmQeJB9twRFuYDgPs8WvLD67X+kY5YkgwuPjlxq
	 6NKkpUjQDUYRj4ZnEUwdD3N+wpNZ7+bVjU9CZoIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEBTtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:49:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40512 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfEBTtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:49:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id w6so3238598otl.7;
        Thu, 02 May 2019 12:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGfxNsDw3M/Z12wiu2wAdnzAwwHu4M4I58DLCLbAH48=;
        b=QQwHmsK8omy42O3otCY1DyojaqYe7wwKILP4sIpJpkug6TsiKo41S9vkcxVuMx3DNp
         pU/7YjlwEUm15wLams8mSotUrYv8GT6MMhctiGx+qGOsFxbRaCbCZptmYmKDO5EwT8sW
         qHiocKoAh7ejM9fYnAze+pslc3ne4tNElDfE7Ut0Pbwd9RgwbHKuYQYnIk04nxKW9yRr
         fQxW5xFiPhXKYSMmnbDAY5XtCr+N7IAHEBRt/0rPnLM8FPNIMBR0kKDkKsACVufC3782
         iAX1E5uXxyb+P8ooEGmOlNUybjfwxofWbYJWkdVUvatqX0i6MH4gYZWeNVaCgLH0vhZf
         s/KA==
X-Gm-Message-State: APjAAAUf3K+vUIO8dtx/wt5q6GVxI9wzUmMf/ugMtIn0Lioi3zBMcupL
        5vRF01JBBNMS+Y4xSlhfFw==
X-Google-Smtp-Source: APXvYqzYJ9AupEd9Umw0x6xgTlB7dtQUdfi0f3hYSCZGFwwsr29XCXUyJ7qIx36e0LDiOwYhqSkwBQ==
X-Received: by 2002:a9d:73d9:: with SMTP id m25mr3984524otk.356.1556826546929;
        Thu, 02 May 2019 12:49:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm89076oid.35.2019.05.02.12.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 12:49:05 -0700 (PDT)
Date:   Thu, 2 May 2019 14:49:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Yu Chen <chenyu56@huawei.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Min Guo <min.guo@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] dt-binding: usb: add usb-role-switch property
Message-ID: <20190502194905.GA22144@bogus>
References: <5756e05930f5e6a3940ad9d019399c8e63d24f18.1556454324.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5756e05930f5e6a3940ad9d019399c8e63d24f18.1556454324.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 08:27:46PM +0800, Chunfeng Yun wrote:
> Add a property usb-role-switch to tell Dual-Role controller driver
> that use USB Role Switch framework to handle the role switch between
> host mode and device mode, it's useful when the driver has already
> supported other ways, such as extcon framework etc.
> 
> Cc: Biju Das <biju.das@bp.renesas.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v1:
> the property is discussed in:
> [v2,2/7] dt-bindings: usb: renesas_usb3: add usb-role-switch property
> https://patchwork.kernel.org/patch/10852497/
> 
> Mediatek and Hisilicon also try to use it:
> [v4,3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
> https://patchwork.kernel.org/patch/10918385/
> [v4,6/6] usb: mtu3: register a USB Role Switch for dual role mode
> https://patchwork.kernel.org/patch/10918367/
> 
> [v6,10/13] usb: dwc3: Registering a role switch in the DRD code
> https://patchwork.kernel.org/patch/10909981/
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> index 0a74ab8dfdc2..c73950b72513 100644
> --- a/Documentation/devicetree/bindings/usb/generic.txt
> +++ b/Documentation/devicetree/bindings/usb/generic.txt
> @@ -30,6 +30,9 @@ Optional properties:
>  			optional for OTG device.
>   - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
>  			optional for OTG device.
> + - usb-role-switch: tells Dual-Role USB controller driver that we want to use
> +			USB Role Switch framework to handle the role switch
> +			between host mode and device mode.

Please describe this in terms of h/w functionality, not drivers and 
Linux things.

Rob
