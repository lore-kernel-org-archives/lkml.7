Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A91C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37726206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRaw71dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfLKTHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:07:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37973 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfLKTHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:07:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id h20so864210otn.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hc42nBOfV8Wcb1mxtDsuyGJVG7qjP7ea1U94bkzCLiM=;
        b=lRaw71dW1nfaOP2hpcngw1LuuTldGurO3ijhNouCirvAZZvgaUUX92tsV6M8gwoCXl
         UjBotRIiZgFI7KDw3LAAL82B3ToPtE7MxYbuK8YKpfkSW1HnYQ6ixeMLYpxxK7WcoNQk
         3TxyjWzqcReztD1DEtJEMet5XQsat480SeBi+VY0sooS3bHz7UrcU5BFjfClZz6q050u
         1a0zNaTtxA6U2mbMVFyJEAfAeL4znfjrWYJ3cVzIl/US9sGeAD+y9zisHzYnqxEIHohp
         kcZ+pCel1fF2aZ2hCmqROqDn67WSN4io/nn//XsBh18KNOdAabOvLiZjgmjPALUCvMri
         w0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hc42nBOfV8Wcb1mxtDsuyGJVG7qjP7ea1U94bkzCLiM=;
        b=DeJL4DQIkMG1KGskGAiCQSiWqeIdbhUhR+uO0Xe0ZL27LyoWEJP9yQdJov6f6qVkQt
         u4mTUZyu+ksbPQUq6iSiR1JqsqE4xFMivHGdbmL/oySJXwHk7Ie59ToTcpQXOolTPABG
         qiRY6vCklkeFpeIcFxircQGp7JyEWZRHeBXiyOMOxi8ZlhhjWT2FusvjWEVhJniav6oj
         oNp6ZMuLIO7bJ2lXQHdS24+bBfAAnoqWHaReM5bs/uqsGow/M14xCc46pSShdiiplo+Y
         cOa3ptbLy1Z+DzxahL7kkN1F5Y7DRpkQ8RDWRntFDFHZuvJaX7LXFu7BbREMcEpwcOlL
         XPTg==
X-Gm-Message-State: APjAAAWaK1PghWP1noITKxIp/etgA+SfaRB4GR4G6+azZAlT+RdD4IWP
        wGGtCedYTNkI4lYgB98hHAn+U8OG
X-Google-Smtp-Source: APXvYqx5vEQQ0z8V60IbHxz8yo2rPss5wv9fE4Liofa+RQG8EZxeDcFYaagvcA1rndPYH3Ys+DbqRg==
X-Received: by 2002:a9d:175:: with SMTP id 108mr3406815otu.325.1576091257483;
        Wed, 11 Dec 2019 11:07:37 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b15sm1175034oti.23.2019.12.11.11.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 11:07:37 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:07:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, hch@lst.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stephan@gerhold.net,
        nsaenzjulienne@suse.de, arnd@arndb.de
Subject: Re: [PATCH v2] iommu/dma: Rationalise types for DMA masks
Message-ID: <20191211190735.GA5609@ubuntu-m2-xlarge-x86>
References: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:33:26PM +0000, Robin Murphy wrote:
> Since iommu_dma_alloc_iova() combines incoming masks with the u64 bus
> limit, it makes more sense to pass them around in their native u64
> rather than converting to dma_addr_t early. Do that, and resolve the
> remaining type discrepancy against the domain geometry with a cheeky
> cast to keep things simple.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
