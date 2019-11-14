Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE082C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C2A206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573695061;
	bh=ekp58GBTrClX8cFPDQVWsf4D6j9AjAEbLxZMdx3Tt3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iG+S9eMsYItR2BoNc2USF6ThwwIT2yZ8MKcA1AUD+nEHXWmYbF6AIR9mxbIM72XMl
	 iUI6V90g1HNR7xhgMzISa68XyFoNj8ylu5ewWhqAjhkRsUnag0IRG/Vr2N9djXmOZi
	 xe+qSdFubdZ98AYD/997oXiielDz/BapKVHXqWW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKNBbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 20:31:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45797 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfKNBbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:31:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so3720521oir.12;
        Wed, 13 Nov 2019 17:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPZmkyPT605AJagOwd6DqFqPdy9BZ1g9xndRjb0oTmU=;
        b=pRVkmE20IiiWNIsPQ7YWk1/+EPIvQXvGOp/u2upRpp3QAPUyLSdzuR9WYShtmWwEze
         pRr/LWvgUski/EygEJJRnBTbYXcrrjvT4dTQSBIDtJXHODKeBPBmdSCfF2qOC3sFLjM8
         HH7d0M8lUTNFxLxJZWWt1l76DQRmdF/IXZbvj0zf4lKjgCKURsPJoengQZZY34lsr4tK
         SAwRoSbfmsNyO7WAQCYb/J6bhCcqLzTiaPb5OeD/oauKbIBl5VOBK0GySxHtpEmLGTYi
         uEbY5+Fq7YS+tpVlyOy1d0xZE9y5sO1ui0mcBho0kPHawByLb5cBogvw8eH8fsZFB3ET
         W8AQ==
X-Gm-Message-State: APjAAAXJyzNnP23XPsrwzStFLPosfdX3so3tPA00UXbiB+OtIANlZyZo
        sGAA8Fo+FcVR0lkCRgqjKw==
X-Google-Smtp-Source: APXvYqyzRyS3pL4SlXiW0bp1nR8dUvkiggu3JwQlJk9vxIaR821lrhV+Abpdp88G31DGZTOpOOp4eg==
X-Received: by 2002:aca:40b:: with SMTP id 11mr1460236oie.106.1573695059333;
        Wed, 13 Nov 2019 17:30:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z189sm1282249oiz.33.2019.11.13.17.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:30:58 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:30:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 2/3] dt-bindings: usb: atmel: Mark EP child node as
 deprecated
Message-ID: <20191114013057.GA20150@bogus>
References: <20191107153128.11038-1-gregory.clement@bootlin.com>
 <20191107153128.11038-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107153128.11038-3-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Nov 2019 16:31:27 +0100, Gregory CLEMENT wrote:
> There is no need to describe the end point in the deice tree. These
> properties won't be use anymore, so mark them as deprecated to keep
> the old device tree documented.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../devicetree/bindings/usb/atmel-usb.txt     | 56 +------------------
>  1 file changed, 3 insertions(+), 53 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
