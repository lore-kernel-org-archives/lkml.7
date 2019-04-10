Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E78C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A02F20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554904611;
	bh=N8wWF4mt4uxFFT7fVSC7POcIG3X0yFtEiD4KkVBG5UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BYnkdLDK8YJGGq1w6W7qV89WLvjNFi+4yC060w3s3fSPSOi+SzU++48I4SyUQ0fMa
	 3DUXW71QHytudN4NWxM5Zfmdb81zDiJldaRXfppJxOOTR3XEzYTEthDnxiQE3sWWBM
	 c0aSNLCkELXoITFdxe4tyNCNNVZShBuG9ZBuCKzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfDJN4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:56:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42259 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbfDJN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:56:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id 103so1966622otd.9;
        Wed, 10 Apr 2019 06:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9wHU6OXz7jYCVcXbXfWTNfEtZHB/ROeE+wXFopTNNQ=;
        b=k51Uwtaf0VMYv6I4o4CtjvjUQkObx4pKu63UdoIZoLe3EHvzXSh+NA756VC4Z7DAJR
         JZT/c2LZZtVvsKcE7+0jMJ4dFIs+ajkhXzeVhu3JWdApiT8B32jgIVFXU6I95/ZG2JVe
         JISmzeTPLyxeKfOH0jGIxI7VPqZxZYACk+HFLyAZ/OzCIspVlBAeTUDq59HgN7I6tWhM
         hOvKhCbRXUenpi8dM/0eKSUJ2/ZcmQifjjgXN601rL6kJ32XLQw8Goo6KOLRxer6dfQH
         RXD3wZkB2SMGwrYdLLVPmeCypUQrDDqQ17FA2e2dhdMs5CZzSJl6H4EJWQAzZ/vvwxDo
         EG5g==
X-Gm-Message-State: APjAAAVWiZSBDCS1KGlfHj5C3jn+S92+frevL0juWvJ2Qs0u+ilabDz8
        5mVE0bMn/8gY3P3C/qSgNWvn9jM=
X-Google-Smtp-Source: APXvYqzgkJhj/i+rNzOG9HHT0S+BoNQFVrdb300ydUh5N1rMQBjE1BtoguMLYgwrTUHSLu38GVfXnw==
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr28270573otc.246.1554904609205;
        Wed, 10 Apr 2019 06:56:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s31sm15586216otb.35.2019.04.10.06.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:56:48 -0700 (PDT)
Date:   Wed, 10 Apr 2019 08:56:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     pierre Kuo <vichy.kuo@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of: reserved_mem: fix reserve memory leak
Message-ID: <20190410135648.GA25739@bogus>
References: <20190219074500.16454-1-vichy.kuo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219074500.16454-1-vichy.kuo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 03:45:00PM +0800, pierre Kuo wrote:
> The __reserved_mem_init_node will call region specific reserved memory
> init codes, but once all compatibled init codes failed, the memory region
> will left in memory.reserved and cause leakage.
> 
> Take cma reserve memory DTS for example, if user declare 1MB size,
> which is not align to (PAGE_SIZE << max(MAX_ORDER - 1,
> pageblock_order)), rmem_cma_setup will return -EINVAL.
> Meanwhile, rmem_dma_setup will also return -EINVAL since "reusable"
> property is not set. If finally there is no reserved memory init pick up
> this memory, kernel will left the 1MB leak in memory.reserved.
> 
> This patch will remove this kind of memory from memory.reserved, only
> when __reserved_mem_init_node return neither 0 nor -ENOENT.
> 
> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
>  drivers/of/of_reserved_mem.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

As no one else seems to have any comments, I've applied it.

Rob
