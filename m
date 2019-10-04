Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E69C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374DD215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k3uUdgwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfJDSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:16:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43758 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJDSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:16:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so6635991qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oE8kJevCjFytZL5gkVb9MuZ6rIst5eLpSx35aqrnebg=;
        b=k3uUdgwfl9Cz0kx/EDhh59plZ+l28scx0fVqHmhifNeXUymGqaSl7Uf4puFaTIz2ST
         oa+Vb7NxDocz3oofGxej2mZedKtpy/fJielHurjm8p2w/npL/WpdrLS7bi05YaUwuNv4
         NYQq6tFmutgh1NQzItIp+i9kt2iUGhgjwhHgUldfUNx68xXL1gYaHIhiTxrl2yvGag55
         n2pPwX7wud/ntgUiBYsdUI3bF4eTs4cJDp83ZVc/P7cnBcWLsx70OWDeIHKlvGDqbYnk
         V7j8EWSb1CNc6BFWDW3K9oEKYy95dBGaEcuYfsDye4fgx7J8YlXq3gLWqRefhfCK0dvz
         pxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oE8kJevCjFytZL5gkVb9MuZ6rIst5eLpSx35aqrnebg=;
        b=VakqGn8j1bjSsvhDXR5kyy2yUmNIZRqV7U8nTCXAOTjwa/jwuogmkN5E5iIgrSKRdn
         MaYS/fgrzkTlM+WTlkWCIFGr+q/wJU1SZarRdABBcfCw5XAeneYBWN+I+aPOEA1S3sXD
         DOc/P3WfjDJZ47igOilGmKlZ2bNxzeuZFTC4emLLabvj63mOoOOHjntro5/DsUS2AUYo
         4guDyGfoZwyvw5DcKTkQ9vBovy6O2llHzYNJJ7Mlkbq2WDGNlnyGT0gG8G6iD9MPqzqg
         oupxvSKvIVj9gMYjC3UBHSGnNj7Ctc0tctLRabrGWDo6yHuUf4OjZwr9n6gRnvL+ofdq
         n4ZQ==
X-Gm-Message-State: APjAAAXSS1V1fvCe8ccMCGBi5/uj3kl7yTw7yGruYpGqPn1gfMJi+iCI
        feq4Ec5ni7E4fubNka2Zl7GCrQ==
X-Google-Smtp-Source: APXvYqyLD4FU0kk1pDF8XqG+vg9smodSRU4af+tYKvmuGU4fCYOwPtKL+q2OaApNxmlOwxF2Jqizig==
X-Received: by 2002:a37:2e01:: with SMTP id u1mr11588779qkh.455.1570213009234;
        Fri, 04 Oct 2019 11:16:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v5sm5089978qtk.66.2019.10.04.11.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:16:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGS8G-0007JC-41; Fri, 04 Oct 2019 15:16:48 -0300
Date:   Fri, 4 Oct 2019 15:16:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Waisman <nico@semmle.com>
Subject: Re: [PATCH v2] cxgb4: do not dma memory off of the stack
Message-ID: <20191004181648.GA28069@ziepe.ca>
References: <20191001153917.GA3498459@kroah.com>
 <20191001165611.GA3542072@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001165611.GA3542072@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:56:11PM +0200, Greg KH wrote:
> Nicolas pointed out that the cxgb4 driver is doing dma off of the stack,
> which is generally considered a very bad thing.  On some architectures
> it could be a security problem, but odds are none of them actually run
> this driver, so it's just a "normal" bug.
> 
> Resolve this by allocating the memory for a message off of the heap
> instead of the stack.  kmalloc() always will give us a proper memory
> location that DMA will work correctly from.
> 
> Reported-by: Nicolas Waisman <nico@semmle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to for-rc, thanks

Jason
