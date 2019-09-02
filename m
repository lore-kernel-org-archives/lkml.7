Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F297C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA4122CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431553;
	bh=MziprxUVasHyivEhTHO1cfsK+KWfSouhFiYkqAZPe8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iCn7a4Z32NeMgfdwsWxTYw0+56pKhuITO/x2oZvzbIqobfO/pYPPMpAOgyI+NPY6l
	 2MscLEu3zd2AWa4D7nelQwdSlowG5OJHcTR5ed3ijWspAfRifatWW1y0u5YW7x7APc
	 PYLZZfG+C0mtm8oJGOWYi2g+Ka3+nP/I0o52zfUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfIBNjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:39:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35562 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbfIBNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so3981678wmj.0;
        Mon, 02 Sep 2019 06:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=GVEasEqqeIWhgTsA62bLGjzbtsMIu+aXOa3k3gYlHts=;
        b=l05Yn9opFlsP/UNbOSbOicXXxD+CHEnyx5CyGl8i5bw9k92l0wFCNNRzi0mn27zDVc
         /Kmm+P5BKUNKJ8UTLBDhzTWuJBnM+DebmTeCdD5LvGJRlrDWa1V2LxrjM37v4bTe5W1g
         HEmUPE335JqsfHl8hD/wxarrJQKfwjM+r8hU8xWPSP0GRbG0jKOYvb4cAAjiX316/99z
         f1eMoW+HXbQbR9fRwM8eSdPhUDXu6WAGKQB88pEoSrASsWdubZlXrz/Cfb3IYD9CedIQ
         8RaReiC/ACxiVzri8gC+Dj7wU4X5lMQBMMNGjQHdr5Q7IRbvALVamIXVeqlQpFDlBlPW
         zsJA==
X-Gm-Message-State: APjAAAUTSAo6L2vF9TS7XK3m9aIjoPN5KwSYSWCDsVujQLHeIEMsQ7sY
        hTAwaSRMdryYqrs6svuqrW9z/aC9Nw==
X-Google-Smtp-Source: APXvYqybfmVuJa9iOGJ2fvD1GWg5NV6+g4arEqtk0dHjj3pS8kjaPdVIiMcwXoDWIDF9AQ5On+rsZA==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr8364988wmi.12.1567431547140;
        Mon, 02 Sep 2019 06:39:07 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id c8sm14124965wrn.50.2019.09.02.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:06 -0700 (PDT)
Message-ID: <5d6d1b7a.1c69fb81.24dbf.bee8@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:06 +0100
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: usb: mtk-xhci: support USB wakeup
 for MT8183
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
 <1567150854-30033-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567150854-30033-3-git-send-email-chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 15:40:49 +0800, Chunfeng Yun wrote:
> Support USB wakeup by ip-sleep mode for MT8183
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

