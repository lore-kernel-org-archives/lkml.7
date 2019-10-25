Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C2C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021B020684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572034226;
	bh=6FDizwZ3MQTwoS4h+bYYVMkIgdMsbhU5jZT9IMpj0lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mvw2kebrncd1TOODT49LphvJj/u7clhOvHKqlJ8bry821jwJ6xq8uUAY/G7QVCjRp
	 qaCKcBuQRl4nIxkCSB0HCEv9bAWGXEw+01kDsvQ2I1tMFqFquadgj3QwWOdiOTYbmI
	 OgvI7zIrnKMyfjK50oNKglrCZvPdBdjWc8BvGfzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfJYUKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:10:25 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39187 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfJYUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:10:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id v138so2424521oif.6;
        Fri, 25 Oct 2019 13:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E0aSqqQFk6FlgluTswnJmfefV24lB3iric22ShoTlBg=;
        b=og3+YXwYri52qPiyrZclCqtkRW4UZpbMTlXnFUvzpMwn1Ly331SfWq5Eg0RumAIrgs
         4RiMGHYBcAn0xDrDYVSwHB8YRBs8nbUyJoB7SOH42Oy0URHgjl6TM/4CIs/Mk2BHydkJ
         tWMMZAbrUCmM1TTToMiRUQhARl0+fJvobt7SLFjRP3FEeKdwIvsoF67Zy4FR2FYhBQoh
         VnEhpUO6yY6s84Ca1xYYTQQEhrkh2hfI0OXw/hx5zw4iEyAXzp5QXRi2Cs57yI6rQS+w
         pYHADuUKgw7Sxjj3XTjKBnaoYy4TO0ndE6fgrHIu3ekVJu3XDPnEwvYZIjcjc3LoE7GR
         R+3A==
X-Gm-Message-State: APjAAAW71xKelnKt4qG9jKp60PC7alTRjmXLH7f5xUq42cPbXdWZG8k+
        uALc/DXrfuWOYo8L8puGq/tpmOo=
X-Google-Smtp-Source: APXvYqy/HeraBjME9wYcyWenGUt9mnz1kGw6zr3COTFo8MFtdYiDJEIygclcgNx9MS4BUfE0lclDBg==
X-Received: by 2002:aca:5116:: with SMTP id f22mr4629829oib.30.1572034223854;
        Fri, 25 Oct 2019 13:10:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm855896oie.4.2019.10.25.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 13:10:23 -0700 (PDT)
Date:   Fri, 25 Oct 2019 15:10:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        pawell@cadence.com, peter.chen@nxp.com, nsekhar@ti.com,
        kurahul@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add binding for the TI wrapper
 for Cadence USB3 controller
Message-ID: <20191025201022.GA28229@bogus>
References: <20191024114717.30984-1-rogerq@ti.com>
 <20191024114717.30984-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024114717.30984-2-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 14:47:16 +0300, Roger Quadros wrote:
> TI platforms have a wrapper module around the Cadence USB3
> controller. Add binding information for that.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/usb/ti,j721e-usb.yaml | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
