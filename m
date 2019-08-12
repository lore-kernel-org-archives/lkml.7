Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC8920665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565652830;
	bh=5X4K74R6Jm2H1W+CPaV3SNZDyH+AnwbvRO0bhdXGG0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OWfjSVoOd9xt0utDtgCrA91j5x3ZIC8qMhH8Qbt2muZZEO+SIpEWx+O3t2a3Ca/XA
	 xSjf+KzqD0oJtrFKYttEMTwX8f9XIGH1bsM18KOakF3WrEdc1KLkPCA0N+Gm0wJEDa
	 HH2ujfU4l13rGjIokhyVY79Zo77jBZJUDGYJBMv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfHLXds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:33:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41614 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfHLXdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:33:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so12717454ota.8;
        Mon, 12 Aug 2019 16:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6bHPaRFqcGhFSYUdTz5B3aFVwCZHpxAG97JWTvxVzw4=;
        b=Dt4VNuQsE7iqHQ+rSKX4IAS/PwY4dTYna9eBq7lpYUL9XMCgng0xuxq1N0LoFQB8XT
         qPHtb5Smq6BIGciWsrTgmMaDGlJxXga7Zg+gKc3/nxG6nkC31F9AWMzP2OPkMtzgr7OH
         zWyvVPL6d92QHrjo6fJ8lYwnItw6waORL82tp+GbtALITis+U1GZ+GW1EMVXaJdHVkLX
         1I96KPqnkWZTS/o5TziMpBcvDxwSlDZCxeHCtczBtVDf5gTzauiMEN1h3pcnc+1uPrHO
         4w75rbtvYegoqUUaJPHhKo/hF1rbWtCfI0roA1SF6LcPoKoxmmQaAFDa7hZmKxUvLpu/
         GWJw==
X-Gm-Message-State: APjAAAWfGx0k1HIuSMHGodwbmgerOB1KnVjbS4BZRcL65CCSqz00zqvv
        SoTtolkyW+1YPyDZrv1Dpg==
X-Google-Smtp-Source: APXvYqy3ZSrnRg/dFnQxSBrlzzSsTNYNgx3mdXJ+vCQqb4BGoMvGyIn1a5u5is1I31VBhSAA4zuGag==
X-Received: by 2002:a02:1607:: with SMTP id a7mr1317294jaa.123.1565652822829;
        Mon, 12 Aug 2019 16:33:42 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id e26sm84364347iod.10.2019.08.12.16.33.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:33:42 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:33:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>, davem@davemloft.net,
        sagar.kadam@sifive.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz,
        sachin.ghadi@sifive.com, andrew@lunn.ch
Subject: Re: [PATCH 3/3] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
Message-ID: <20190812233341.GA22016@bogus>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
 <1563534631-15897-3-git-send-email-yash.shah@sifive.com>
 <alpine.DEB.2.21.9999.1907221446340.5793@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1907221446340.5793@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 02:48:40PM -0700, Paul Walmsley wrote:
> On Fri, 19 Jul 2019, Yash Shah wrote:
> 
> > DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added
> > 
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> 
> Thanks, queuing this one for v5.3-rc with Andrew's suggested change to 
> change phy1 to phy0.
> 
> Am assuming patches 1 and 2 will go in via -net.

I don't think that has happened.

Rob
