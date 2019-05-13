Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC97EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C792084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557768531;
	bh=k9xv+jQWbkhEpWnQ3Z11jaYsOjDpElOPyTd9y6S7GS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fyk7RO35560hQNuhZvB4dO69+a1jJiLVcUQnbqrS7MFEh1VuXGiz5xWWqUqJY8/5o
	 dk36xxF5QjA8rhPdZlPccVMltmZoMLCk1w775MVpZdnyWxZH0N8vpVk/sG8Rn/VfLp
	 5ZghHYT1ER8Obrx+IhXDHrw21/yVaychWTlADzFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfEMR2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:28:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39553 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbfEMR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:28:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id r7so8057541otn.6;
        Mon, 13 May 2019 10:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6feJZa0aw0GZsImOuxnHSsC5EDhjfyRhfdFCIT3tJFo=;
        b=iw6CCBAjGaEZHhI3xBxvM1pc625Ns8SoayZZUxKfxKHBp5aeJrnih7WCGWgneFVefi
         W3cGTwV4yw9UHFnGy8+JYJ+f8M70BNRtQZSybFRRBQUZm2x8I/yd1BA5U80vZqIl/qQ4
         IxnISui5sckr8Vxtx1N+BWdk7MxFrv4xVxmPePVylgk7/g56BvZdzXjKpVuklr2ihqUi
         3EfnhtQFTFGcUuEOwoGO+ZjtmPP5uoUaTdESwClUFZxj0Q/xSBnwjjBwKoLG/wzEtDme
         wUjSVqiqFACm/n57Zloc57VwGpOLDjDSOoQIvgl7egd6xN1QxjuE6rw35Bhm9E6MuIWG
         CSfA==
X-Gm-Message-State: APjAAAUMkmFv2SJLhFOqzbHD8Z/bX2Wy6L+z0sm87kqm4XYu8G8pSTMg
        PmGXY3qJ7d2x4TNy/W1KVHqLcLo=
X-Google-Smtp-Source: APXvYqxW/0x7M65XCFbh2CtdKwvaAnoHUcFJ/jpvEKj+sZqkwTWbn2hNdCW+F0o0Ism5B8ky398RwQ==
X-Received: by 2002:a9d:6288:: with SMTP id x8mr254754otk.79.1557768529379;
        Mon, 13 May 2019 10:28:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h194sm1094992oib.58.2019.05.13.10.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:28:48 -0700 (PDT)
Date:   Mon, 13 May 2019 12:28:47 -0500
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
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [v3 PATCH] dt-binding: usb: add usb-role-switch property
Message-ID: <20190513172847.GA15347@bogus>
References: <c3596e996c9ab39c6b9bc14b93309244c4a55014.1557306151.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3596e996c9ab39c6b9bc14b93309244c4a55014.1557306151.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 17:17:44 +0800, Chunfeng Yun wrote:
> Add a property usb-role-switch to tell the driver that use
> USB Role Switch framework to handle the role switch,
> it's useful when the driver has already supported other ways,
> such as extcon framework etc.
> 
> Cc: Biju Das <biju.das@bp.renesas.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3:
>     add property type, modify description suggested by Heikki
> 
> v2:
>     describe it in terms of h/w functionality suggested by Rob
> 
> v1:
>     the property is discussed in:
>     [v2,2/7] dt-bindings: usb: renesas_usb3: add usb-role-switch property
>     https://patchwork.kernel.org/patch/10852497/
> 
>     Mediatek and Hisilicon also try to use it:
>     [v4,3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
>     https://patchwork.kernel.org/patch/10918385/
>     [v4,6/6] usb: mtu3: register a USB Role Switch for dual role mode
>     https://patchwork.kernel.org/patch/10918367/
> 
>     [v6,10/13] usb: dwc3: Registering a role switch in the DRD code
>     https://patchwork.kernel.org/patch/10909981/
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
