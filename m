Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE933C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB1920818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554905251;
	bh=RvrzFLWFoRGtXvMBckjYnjSWaNIL1IAOyxANfv2fH68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QgevZS9EeHGxsQUuOkZM8FPjNfCmatiMdnVJ0VJNfI9XtqdHEb4xZIiTVSVd566dF
	 HL91SOMiQ3DW4rDly29eo9J/nHgniFFIoHlxi3otBS4xsX53mnUmGXV7urnLO81jww
	 rDVtzNon0KrhadmrK6aqV1wEX7g4KGDCYQZbbpaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfDJOHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:07:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45265 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbfDJOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:07:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so1832978oia.12;
        Wed, 10 Apr 2019 07:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dGE+vhQXT4wAY4VdKvHrQT0Qr/mnBc7Qx9QmijhXZjw=;
        b=Y57fXUim3q3jPPIiALVqGphe80AtwDUyJjsAoz3iYdEFZDyLhopFiWvgwPlNxCaRcc
         Vf20xvc1AWbq172L4byec3W+IM76D4o6SJ9NlT1/q/BfY48nI2FtJxHSCcBBpU0dzs5Z
         st1MTWtWitmuJVqh5LzoDAjZB95eGN7afP6vIg8VEUoDQCEIor24EiKkzAkpSGGhdv8b
         vuFVDMFmXUaJL2XgEbSTLTlPYwrMuv/DZP3u7xsd5EGuNcp5he1johisajeipF7awWXx
         sr3ZiBara0EEqQcR/X936m5shhAqvxUFc1HCzrOCKKDDdnzzaBZ0SAnw4cBavv9iwxfP
         fxug==
X-Gm-Message-State: APjAAAWEt9M7oNmg6peNAy6XRoWjdd9Sf1Thd8BAvdEK9M6XDGldsE5r
        EJhB/Ka0LIBjblSJ33RZrg==
X-Google-Smtp-Source: APXvYqxdb/NO6IesHnQFi7sDUG7rQ/3dDG7xQrQJVqbWHSv3MraUpo6nWW9hyt4kwJUD5hUv+fM/Zg==
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr2833746oif.38.1554905249136;
        Wed, 10 Apr 2019 07:07:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m124sm14455877oia.3.2019.04.10.07.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 07:07:28 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:07:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] of: Improve of_phandle_iterator_next() error message
Message-ID: <20190410140727.GA17374@bogus>
References: <20190403175633.1839-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403175633.1839-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:56:33AM -0700, Florian Fainelli wrote:
> Understanding why of_phandle_iterator_next() returns an error can
> sometimes be hard to decipher based solely on the error message, a
> typical error example is that #foo-cells = <X> and the phandle property
> used has a smaller number of cells specified, e.g.:
> 
> 	#thermal-sensor-cells = <1>;
> 	phandle = <&scmi_sensor>
> 
> instead of:
> 
> 	phandle <&scmi_sensor 0>;
> 
> Instead, make it clear what the expectations are towards debugging
> incorrect Device Tree faster:
> 
> OF: /thermal-zones/scmi-thermal: #thermal-sensor-cells = 1, found 0 instead
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/of/base.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied.

Rob
