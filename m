Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B741C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAB4218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552692364;
	bh=nj0iRvY0Saa4oVgdx3caQWpiV14l4fyy6GIkpTwqOsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sqKm7ozCr1XTpysE+SBwC9ydhntsQr2yQGbS2HyvXFU7Ay755syXp+/rzK8hYqNQw
	 FNIB1Ig1LLwert3WgkHrJC1CEd/to1/6ZAnm6Z/rVW1BGvBDt3yEDT5JV1Rg7JcgrG
	 5RNArTbeYUAh4puC2+9kxPpdS3h0KZ8J3swZJOSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfCOX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:26:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42524 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCOX0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:26:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id b2so7430453pgl.9;
        Fri, 15 Mar 2019 16:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jN4lslZoo0XzcPQMuFQEoVt8Mtr1usouygAU6nGhbcw=;
        b=e8SvcZjNFKNCNVbYJASPX6D4/41vBO5wfN6ukn17/mLQZjv43QR51rT7RUITZuJitg
         +YCFWndZmjRtCSzB+K0PFsFlIIAQrAS2wTfgVlfJUUejccR2qW9Nm0pwxGWaMxJ39VO2
         t5u6zvN5oGtv3Rm/aMEqH7tzLQolkWy8Ar8DgI08uHAvEouy9j55AZNIzfR9p2EemoHs
         HXmYwpOOa1EG63+8bNFGayP8zIW166EE9mn6bS42oPxdG3bqe1wkyLmZDXtc9+yok5PS
         HVmPNji9oFxP0QFtFak4WVmAeKDS/JVQi0LALj6kiXdv6Wd4dyemsIdoAkfefqz6ntFs
         1OLw==
X-Gm-Message-State: APjAAAXPzm+xzbaiWn7NrMt6FG9xzaijjj9paoxeSn2TW8yLZtGSnuBZ
        N3eD9kjTsSvVYwqq0M5UUw==
X-Google-Smtp-Source: APXvYqxeZUXGHdtOMd5RHCEV4FkI/BSTuYMQnJGaThDJmgZ9XFtMKtCiSZ4WrnACJJ8WAcCg/TXIlA==
X-Received: by 2002:a63:2ad4:: with SMTP id q203mr6036478pgq.43.1552692360740;
        Fri, 15 Mar 2019 16:26:00 -0700 (PDT)
Received: from localhost ([172.56.6.21])
        by smtp.gmail.com with ESMTPSA id j24sm8260569pgl.58.2019.03.15.16.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:25:59 -0700 (PDT)
Date:   Fri, 15 Mar 2019 18:25:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 03/12] dt-bindings: mtd: ingenic: Use standard
 ecc-engine property
Message-ID: <20190315232536.GA23734@bogus>
References: <20190313222259.28704-1-paul@crapouillou.net>
 <20190313222259.28704-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313222259.28704-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 23:22:50 +0100, Paul Cercueil wrote:
> The 'ingenic,bch-controller' property is now deprecated and the
> 'ecc-engine' property should be used instead.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v5: New patch
> 
>  Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
