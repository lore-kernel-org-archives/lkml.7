Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD609C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996B206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zw2G0hL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDZWbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:31:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40635 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfDZWbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:31:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so2841707qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bcBnbz9dJZuhinHT7aE83xQUWlVFtJs996L1zcWbm6I=;
        b=zw2G0hL9iLlqp/+GOBfAJXPHZrzjs+stJdewFTfrBMkaI+BKlhFO9Bit+FwOOyIlEq
         rLxHlZBTBT6POOhIBS9CqftOk4CsyLZXuz/sHRJz/rlUcIhGQKr+p5Kt//Yhev/69fI3
         v4b1VX7LoR4Ozsb+0nXrKapii2heZqCjGVz9JuJDyZD1ZqnSEHIP6jsKMyVWhHN+qesd
         zywavHlz/JZvEouEB+RaUeN6/0m4wCcGcPVuCnGGqy6Np+K8CKkOV5E9UyUX84pg6Rfe
         Muqgd2Xu+qZqxiKSTI8XK3TppBqzruQ0Elpi10Sqd46L8npHpKR4lL9z0JlgtFxwTZYx
         25EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bcBnbz9dJZuhinHT7aE83xQUWlVFtJs996L1zcWbm6I=;
        b=rw/BuvFmUcuoSg/VN5WEGmzQbCQ7UYWfXFduUs8PXVNLMJQxyZW4NsjQ9WTBvhaM94
         ohVG6sHT0DUSC6nv9hoaR+wyXfSNVcA7vrkFa8LJCpvnqSIbA/njdcLxrah4Asz0qwrz
         tUpUhQ6fXrq4EwAWEMtYCv5ym04xhOBXRH3vSssxdRhmiu0lyNf4xgu5FHBrXLziD+Qc
         X17v/VmbzQNCQjO+F90RWiKPNvJjqqYub988iXYZiRXgWDyaR+bdfA4pVLP8zDLLyj4i
         2HrI5F/tFmAiUIxwoGrsRyhUK+Ab/qQ5EXilAmIcE5oHqIW8wVFkLE+sDK0sqtcyfeNS
         mT/w==
X-Gm-Message-State: APjAAAV2G10VXPts7iVra9pbkFCl2T84m7g0knA1VDL0lE2SaCrGhY0S
        pxya4XPm01+9PLMNWL3+7vDzUw==
X-Google-Smtp-Source: APXvYqxs0dd8VsVwivSemBU68pF77Y9BeF8p1x3lm1P4XYCHzhSKHFN1nQwORZbtnSpsRPmlAJ9hIg==
X-Received: by 2002:a37:7a84:: with SMTP id v126mr37573315qkc.335.1556317862060;
        Fri, 26 Apr 2019 15:31:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h27sm17701461qtc.1.2019.04.26.15.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:31:01 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:30:56 -0700
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
Message-ID: <20190426153056.6c8f64ba@cakuba.netronome.com>
In-Reply-To: <20190426220226.GW4041@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
        <20190426073231.4008-4-esben@geanix.com>
        <20190426114013.333e62c8@cakuba.netronome.com>
        <20190426205912.GI4041@lunn.ch>
        <20190426140856.78b786ee@cakuba.netronome.com>
        <20190426220226.GW4041@lunn.ch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2019 00:02:26 +0200, Andrew Lunn wrote:
> On Fri, Apr 26, 2019 at 02:08:56PM -0700, Jakub Kicinski wrote:
> > On Fri, 26 Apr 2019 22:59:12 +0200, Andrew Lunn wrote:  
> > > On Fri, Apr 26, 2019 at 11:40:13AM -0700, Jakub Kicinski wrote:  
> > > > On Fri, 26 Apr 2019 09:32:22 +0200, Esben Haabendal wrote:    
> > > > > The use of buffer descriptor APP4 field (32-bit) for storing skb pointer
> > > > > obviously does not work on 64-bit platforms.
> > > > > As APP3 is also unused, we can use that to store the other half of 64-bit
> > > > > pointer values.
> > > > > 
> > > > > Contrary to what is hinted at in commit message of commit 15bfe05c8d63
> > > > > ("net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit")
> > > > > there are no other pointers stored in cdmac_bd.
> > > > > 
> > > > > Signed-off-by: Esben Haabendal <esben@geanix.com>    
> > > > 
> > > > This is a bit strange, the driver stores the host's virtual address into
> > > > the HW descriptor?    
> 
> Lets try that again
> 
> Hi Jakub

:)

> > > Hi Jukub  
> > 
> > I need to start keeping track of all the ways my name gets spelled :)
> > I find it entertaining :)  
> 
> Sorry. 
> 
> And i prefer entertaining over offended :-)

Certainly no offence taken! :)

> > > This is reasonably common. You need some sort of cookie which links
> > > the hardware descriptor to the skbuf it points to. The hardware makes
> > > no use of it, it is just a cookie.  
> > 
> > Right, but accesses to HW descriptor memory ring are significantly 
> > more expensive, especially on platforms which are not coherent with 
> > DMA operations (everything but x86?)
> >
> > A preferable design is to have two descriptor rings - one for HW
> > descriptors and one for software context, no?  
> 
> Modern drivers do that. But this driver seems to be quite old.  And if
> you look at what it is used on, PPC & MICROBLAZE, they are old
> architectures, i don't think hardware access are that as expensive as
> for modern architectures.

True, my comment was certainly more of a suggestion than a blocker.

Looking closer at the series it kind of looks like a soft IP.
Esben, is there anything architecture specific here?  Should we perhaps
drop the dependency on the architectures in patch 6 completely?
