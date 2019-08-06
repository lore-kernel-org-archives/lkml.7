Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B4FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5D020C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BTdL1q7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbfHFSA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:00:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36449 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:00:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so85524068qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bxAi2AWxQLWDF2luvIMl7f/UII4L9fAd8kmJBO8r+QM=;
        b=BTdL1q7uIftWEibqtpJ2qBvmgEl0z+WwHsvtywklotBDG0PpIzsdOkQu2MzqaTeVMo
         J8yB+abqQuKUfiuWe/VFhxZeK+LmVGsRDJrUW0pAsCMH6f998wxdNClpsRBWqGB3q9lb
         DIpOye+uQcyUXo3ondmYhnMZVp8o4EzhV4Jc5CR26nszzO7s8uyzHULN5JfFJg0w74zH
         z8baH6w71w2QWD+OqIA5XxvbMLZRSmwRHv4BH8MQpHSlnp9Rj+9dezQk76GZ8Y6Ui0Zs
         IOpf4eY2syFgOUh+A2Lc1gcx6oZthg+JUv4GWxh92CjWmzVf23Jl3OmhSvoxCjauSNqR
         3A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bxAi2AWxQLWDF2luvIMl7f/UII4L9fAd8kmJBO8r+QM=;
        b=lX/sh4Vqy9eD0J0RSERr2K/wgrz0DZWPlhsm0UJntwQWPp8LrXnZiG+ZY9/Koxrrws
         ZrY4lP5JYX2vCzMeJISKxkFx8LRBx7/fLdTRFDPRyEKg6kKkpE4fFWN1wrEQNlKyQPun
         cudpQ7gOjK/d5stDpWPNB5Ex1E60AKiOzk/59cKF5GtgxKOxDBgbFDGl9wETsRUWrWY8
         fffo/kjLQexVyQquoXYYdG/SPvzJYDerw6KDhNig9A6at/IP5cn/4XL0hgjFQDYs283T
         UCNOL32RHm2yCixvkwPH/xMhau9CMwjhgq1KAwG9E745ijg9v2R0cg955uXGk4VFE2Ex
         wkRg==
X-Gm-Message-State: APjAAAV3LJl7d1xc8th9KvvbqhghM5MEoYRa/+3wj/tNzL2KgBdIE1DG
        o8Bp3Utn0XxUhvrXeF1bLqlXSg==
X-Google-Smtp-Source: APXvYqwCmY0NZ93DbaUKqBGemthRcu66UNlk2zMQT2HujC+QqBl8bAE/pDy0q9npLsbnQ5I+0N19GQ==
X-Received: by 2002:a0c:c107:: with SMTP id f7mr4227804qvh.150.1565114428225;
        Tue, 06 Aug 2019 11:00:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o12sm36309954qkg.99.2019.08.06.11.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 11:00:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv3l5-0000Eu-8Q; Tue, 06 Aug 2019 15:00:27 -0300
Date:   Tue, 6 Aug 2019 15:00:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] mm: cleanup the hmm_vma_handle_pmd stub
Message-ID: <20190806180027.GM11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-12-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:49PM +0300, Christoph Hellwig wrote:
> Stub out the whole function when CONFIG_TRANSPARENT_HUGEPAGE is not set
> to make the function easier to read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
