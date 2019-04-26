Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C1FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C82320869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="y3CxS4sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDZVJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:09:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42654 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfDZVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:09:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so5707662qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NzzwjZB4Zpm/sXOItuTKbND263PZe8l6h7o+VV6+vXM=;
        b=y3CxS4sjCgUJ+E6uT8jqjM/F/1Ncta8tCOwDPylrk60k8BJZ6LshLHV/rXRRZkj/RL
         suFq6zjJ6jL97rEWRJFYLy0uxIYOzCJ5W/Xs72Q3mmUaStV8tocwh0kv+fF7O6L3OprF
         o4/iUviCOmzVFeQ+XZQtn3/DBQtx1WL+FLEn2FLO8nbZmFxqHEAtIY7NVU+3OPemRj28
         dKV+QQkuVWrydvkZJiCWQHMtuF5uwnHbiiMdqP0ed8ZUQRHjsLi91BzetMSkhZpSJc/7
         6re94gmpHk1Is7ZHHWcHeI/gmzBQmf/oBAS3a0KDX5RG1Ti42wJj8VU9vrcDm5Re+2rw
         /7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NzzwjZB4Zpm/sXOItuTKbND263PZe8l6h7o+VV6+vXM=;
        b=Y3KCWsUYYHYSM2+QxNPbPIolw0eqJc1A7+N/u8uHctxrIcUgulVXEpn62VeOV9n+ds
         Q4YHzfz1vt+gRivAZ17lLeGOxpbNgzTCIcM32jLnWEN1eIDoxQliaz3iqLIEqe0elxhQ
         BhgjI17odKC81b3tEsjIvcsJgFfUkpGdvpCjefcV8aunQfb1kVjM0uEaHDjbKsNvgfYn
         RdB43LieRis7NK3CYY1eJOsgHPTLaguViD+tHqGMHjy+s4JCb5AkWKZiALASLBxQFUKr
         3liEy3Knla8iE2pN52vPXFcebxEcjWee5oA27PPZLx/3ozFI3DtNooo/EbKc6a6l75x4
         b7/A==
X-Gm-Message-State: APjAAAUYRhHyLkZJfqM136iC8ocnyvy41b7d4WGubxYFJb3KCAItXxXE
        P37E0EzpthifIdDXQQOUWrQxMQ==
X-Google-Smtp-Source: APXvYqxnOHcHUG0xrdHBwl+LD9J5CTgrSYuxlzSI8/+7T9/LmuuzGzcCdqvi4F1Tj43kOFsvNl0vVw==
X-Received: by 2002:a0c:b114:: with SMTP id q20mr38376551qvc.12.1556312940982;
        Fri, 26 Apr 2019 14:09:00 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y18sm14589697qty.78.2019.04.26.14.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 14:09:00 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:08:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] net: ll_temac: Fix support for 64-bit platforms
Message-ID: <20190426140856.78b786ee@cakuba.netronome.com>
In-Reply-To: <20190426205912.GI4041@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
        <20190426073231.4008-4-esben@geanix.com>
        <20190426114013.333e62c8@cakuba.netronome.com>
        <20190426205912.GI4041@lunn.ch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 22:59:12 +0200, Andrew Lunn wrote:
> On Fri, Apr 26, 2019 at 11:40:13AM -0700, Jakub Kicinski wrote:
> > On Fri, 26 Apr 2019 09:32:22 +0200, Esben Haabendal wrote:  
> > > The use of buffer descriptor APP4 field (32-bit) for storing skb pointer
> > > obviously does not work on 64-bit platforms.
> > > As APP3 is also unused, we can use that to store the other half of 64-bit
> > > pointer values.
> > > 
> > > Contrary to what is hinted at in commit message of commit 15bfe05c8d63
> > > ("net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit")
> > > there are no other pointers stored in cdmac_bd.
> > > 
> > > Signed-off-by: Esben Haabendal <esben@geanix.com>  
> > 
> > This is a bit strange, the driver stores the host's virtual address into
> > the HW descriptor?  
> 
> Hi Jukub

I need to start keeping track of all the ways my name gets spelled :)
I find it entertaining :)

> This is reasonably common. You need some sort of cookie which links
> the hardware descriptor to the skbuf it points to. The hardware makes
> no use of it, it is just a cookie.

Right, but accesses to HW descriptor memory ring are significantly 
more expensive, especially on platforms which are not coherent with 
DMA operations (everything but x86?)

A preferable design is to have two descriptor rings - one for HW
descriptors and one for software context, no?
