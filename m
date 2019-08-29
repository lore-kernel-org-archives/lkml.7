Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F263C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2270D2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Qe9XDW3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfH2WFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:05:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36131 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfH2WFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:05:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so5740504edu.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ZxGXwVeB3Ocxw6bgG5TMQclIXy8SsLYSgLmSszN4yuk=;
        b=Qe9XDW3q/HEBxHI2C3p7LZdL3JTn45uGcMo5jJsgUfhnvmPG+hI3MIIp/6hRpRs5wq
         FfIbBwBwNST/DiWiq+i//IMuNddnrGSGhjNLQwLYHh+/qpz0YznE8hVM6bgwqk+O2V8c
         HIL6TU82DU0M5uhENSuwUBVKhXSSKlxb8im7RDC9m0+YDybghOwNj82jA6glalHO17fe
         A5g0JuxeB56iz1vt5oKOcpxU83Eindw6ilz2rm064Wno3YtG6YW4xT6n+Fv3i9vFfa0k
         XygARabs0k8b6y5xZ/woClO1eTf8LjVIKgB8sGzW9+PbSt+SAwmlpptyLgH1cfWmluAn
         URbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ZxGXwVeB3Ocxw6bgG5TMQclIXy8SsLYSgLmSszN4yuk=;
        b=WuvZKS0yEIvlZ7ZzDpDbs3siwjmPXooRSrztL1PEGha8pTyRRhx/06U3wRw9JDasU2
         PSXshbVdV3iDMtBsydGyoFSoedEx8h4bu/2BWNhi3S+OJ66cV4hPcr28wORCx/8BWDZU
         +Rql+KU1y7h0jt0UV5Fvngg7DwJu6ICoGQcK7Lo3kHOA4Q1/8Cvn+l2CuGItew4b06To
         ZNFGTpdrCxfRUEiOFZK3O6qq5ChvOPHQCNP27/2vevU0ncOl/DmYm5zJJC1fdVS4ELQo
         jImHgRqfAn45lXn09ociMpqkEu8aCFoWLTfAr4wfzYQ/PhCQHd/s/5qm3Zt3fD8THJNL
         sB9g==
X-Gm-Message-State: APjAAAXFzMQ4unq+nmMUSxDDTDsGYP54C3I21xUbS2RDVpw3urFSbDG8
        aTh5iMaH30kftp6oSUOhrwYYNA==
X-Google-Smtp-Source: APXvYqzp7vhc8FlS7++q2xqaYVdE4JZ5G8h0HvL3Z6PzRN5SgOsDQCLCK6/YQKML+P5d/yDQ2PaQPA==
X-Received: by 2002:a17:907:2102:: with SMTP id qn2mr4468380ejb.266.1567116329904;
        Thu, 29 Aug 2019 15:05:29 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m6sm533750eja.53.2019.08.29.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:05:29 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:05:04 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 05/15] net: sgi: ioc3-eth: allocate space
 for desc rings only once
Message-ID: <20190829150504.68a04fe4@cakuba.netronome.com>
In-Reply-To: <20190830000058.882feb357058437cddc71315@suse.de>
References: <20190829155014.9229-1-tbogendoerfer@suse.de>
        <20190829155014.9229-6-tbogendoerfer@suse.de>
        <20190829140537.68abfc9f@cakuba.netronome.com>
        <20190830000058.882feb357058437cddc71315@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 00:00:58 +0200, Thomas Bogendoerfer wrote:
> On Thu, 29 Aug 2019 14:05:37 -0700
> Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> 
> > On Thu, 29 Aug 2019 17:50:03 +0200, Thomas Bogendoerfer wrote:  
> > > +		if (skb)
> > > +			dev_kfree_skb_any(skb);  
> > 
> > I think dev_kfree_skb_any() accepts NULL  
> 
> yes, I'll drop the if
> 
> > > +
> > > +	/* Allocate and rx ring.  4kb = 512 entries  */
> > > +	ip->rxr = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
> > > +	if (!ip->rxr) {
> > > +		pr_err("ioc3-eth: rx ring allocation failed\n");
> > > +		err = -ENOMEM;
> > > +		goto out_stop;
> > > +	}
> > > +
> > > +	/* Allocate tx rings.  16kb = 128 bufs.  */
> > > +	ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);
> > > +	if (!ip->txr) {
> > > +		pr_err("ioc3-eth: tx ring allocation failed\n");
> > > +		err = -ENOMEM;
> > > +		goto out_stop;
> > > +	}  
> > 
> > Please just use kcalloc()/kmalloc_array() here,  
> 
> both allocation will be replaced in patch 11 with dma_direct_alloc_pages.
> So I hope I don't need to change it here.

Ah, missed that!

> Out of curiosity does kcalloc/kmalloc_array give me the same guarantees about
> alignment ? rx ring needs to be 4KB aligned, tx ring 16KB aligned.

I don't think so, actually, I was mostly worried you are passing
address from get_page() into kfree() here ;) But patch 11 cures that,
so that's good, too.

> >, and make sure the flags
> > are set to GFP_KERNEL whenever possible. Here and in ioc3_alloc_rings()
> > it looks like GFP_ATOMIC is unnecessary.  
> 
> yes, I'll change it
