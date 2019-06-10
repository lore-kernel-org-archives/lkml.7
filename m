Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7BAC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C009D20684
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNFvBfUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbfFJIJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:09:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39400 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfFJIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:09:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so5489499wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AHbBoNdIbLCnL7MQeHwxnggzxKGcT0xwi4pBjNCzCs8=;
        b=uNFvBfUPi63D1NpjdY35rfr6/UNfuXx39NuW3UWhMRQGdMexJ6xw40qI0V9+Mx07m/
         bhdhH9ALdyyShib2lvpxJvxfdoUpLLa9GJtQv7502r+MuwHzqRxgU3PT7WToTA+P3EoU
         Zm5GdCye4UChxCqrx5f+w3HOEjgiiWAHqGqoqIBCmYDqkRoGAWZ8fL4wrkyat1zx9K00
         9WfYtT87c+idQgOd3qG06aolFvMIFYmQFaZcbaOmGjPctXt3fO4eAIG+zM5ZhBI4D102
         eaMJ4THAuUjtbaz9BfvUDcVPYkNrREftdF+HQASv8w5OEKl19zMWLrHBgPglPlao7qo/
         9Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AHbBoNdIbLCnL7MQeHwxnggzxKGcT0xwi4pBjNCzCs8=;
        b=UhGddIxZKXvrGu5I19tG6a2MxMUoHwdBcAr20hLZZkLVLX0MAACVnfXszMnp9is3b+
         Pkf/ShibNcJhZ1UzDtjxzEfyVbBE5z/F29eOBQ69LBFW5tk2bWARKyKReDc5diKRrnec
         9BBf3i7MdEVIWj6EhAzMwhk7z/C87D8MfYHHUB752buvUg39UaEeyKbn8jv9xwvCogr6
         1fgpwytxpFO9Os4gqB0XR+zPn8kw4CU4na6V5BNl0XNUZnXIvmsj0Xmemkq8S6QQM3X4
         RDX7QHWiPRXjgeL50qpXtH75k7Re1VrLKt1xPPLuzG8KsavqUYXyGplgoPpJw2kKNE0u
         aU/g==
X-Gm-Message-State: APjAAAX0mrd9mi2r4+vTh7fvayPwtbPi7aaf99Y1NjH+eNbNRhKbJwzv
        3sNlt/362YShEiKzMy4fO4J8atLckd8=
X-Google-Smtp-Source: APXvYqx8JFDG+ejx5iCIQPaIT5vunGsFslORGm0QwzBtX02VrZEE3uUZt416WifYz8RdOIRiM2muGQ==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr20454082wrx.247.1560154141203;
        Mon, 10 Jun 2019 01:09:01 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a2sm5426455wmj.9.2019.06.10.01.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 01:09:00 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:08:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: core: Support multiple OF child devices of the
 same type
Message-ID: <20190610080859.GJ4797@dell>
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
 <1559687743-31879-2-git-send-email-hancock@sedsystems.ca>
 <20190605063108.GF4797@dell>
 <7561b2af-52b4-af78-f854-00ba0b86c822@sedsystems.ca>
 <20190605184505.GT4797@dell>
 <3a961f58-05d0-95ab-95e1-6d336336193c@sedsystems.ca>
 <20190606052700.GZ4797@dell>
 <bf3b9399-39c9-effb-8406-4eac2403da5c@sedsystems.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf3b9399-39c9-effb-8406-4eac2403da5c@sedsystems.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jun 2019, Robert Hancock wrote:

> On 2019-06-05 11:27 p.m., Lee Jones wrote:
> >>>> Without having the .of_full_name support, both MFD cells ended up
> >>>> wrongly matching against the i2c@c0000 device tree node since we just
> >>>> picked the first one where of_compatible matched.
> >>>
> >>> What is contained in each of their resources?
> >>
> >> These are the resource entries for those two devices:
> >>
> >> static const struct resource dbe_i2c1_resources[] = {
> >> {
> >> 	.start		= 0xc0000,
> >> 	.end		= 0xcffff,
> >> 	.name		= "xi2c1_regs",
> >> 	.flags		= IORESOURCE_MEM,
> >> 	.desc		= IORES_DESC_NONE
> >> },
> >> };
> >>
> >> static const struct resource dbe_i2c2_resources[] = {
> >> {
> >> 	.start		= 0xd0000,
> >> 	.end		= 0xdffff,
> >> 	.name		= "xi2c2_regs",
> >> 	.flags		= IORESOURCE_MEM,
> >> 	.desc		= IORES_DESC_NONE
> >> },
> >> };
> > 
> > This is your problem.  You are providing the memory resources through
> > *both* DT and MFD.  I don't believe I've seen your MFD driver, but it
> > looks like it's probably not required at all.  Just allow DT to probe
> > each of your child devices.  You can obtain the IO memory from there
> > directly using the usual platform_get_resource() calls.
> 
> As far as I can tell, the DT child devices underneath a PCIe device
> don't get probed and drivers loaded automatically - possibly for valid
> reasons. The MFD driver appears to be required in order to actually get
> drivers attached to those DT nodes.

You need to call of_platform_populate().

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
