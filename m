Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1785EC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E185721850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ckYufb+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfGEMdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:33:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38717 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfGEMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:33:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so7737051qkk.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SM8/4exhoEHGZvFQb+ptk62AOWI2rKv8kDwMIolo8dI=;
        b=ckYufb+JTejpyz8pDQLhV2fiq+FAfmAMJXOQOHzRQuW89WYkHU4Lnaf8DM+LDzsQly
         7DR9KgHXKyZJ5SQnARXpB7b0GDPR+IzumhAhjFElKZoaWbVQqBzOGuOt2mXTD7nzuXt5
         rht4Mpc03KaerdCaAGd9Zz+VR1Rrl9rREPc+1J7nPBLLCwdHhPvxkD51oec3BWxH/q5A
         8y8smn0+FXxH8Gikf6Oak6WiJwqqFwAOKVh2vW+4toDJIiGZgqAhD4f+Uc2n5IztDsqL
         u3oZpE+TduYcqojeNfFd5skXHK2hBtPlP72gQxG0RENMyEEMZ5xl0dJFmnFf9EpIr4ix
         WIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SM8/4exhoEHGZvFQb+ptk62AOWI2rKv8kDwMIolo8dI=;
        b=ts9BNZEqlQGPpIt3qyM+qW9nMSqN/Pb/eh6RsvXnbwHmLrNGnq8Ng6OOv7JXvIC40N
         bPf42qBdPJL4h+mzgOsQHD6ttAOcaXkRzm0nGwspQBI1AAZUQrmM49YZbtkULChGG6J9
         R8K5iwwCZ2SpYt71uc4vEW/nYSH4vXb9icW7NTfH8VWVc/z6zhVquAh0taNJOHEZWD4+
         /izUX5KPZ5bn9E0TR1UDaRIlfEWCvbv1yL17TG/JVHyg3UDWMH69GbseywCYD0L0O6Ko
         IpPBAmCOX/vmvrtnLkzhIYa5ENHxiAZf3XRIEwUnGJfOtCfT554PdXqzs6GRUBQdT1wh
         WACA==
X-Gm-Message-State: APjAAAWrscDdju1LBUnBdWCpy9QsaXwRBwdY+1Br+glVcB8tz3X6iySk
        pHmRzL2sMkjLyn0bwOIHCHjdAA==
X-Google-Smtp-Source: APXvYqyX4DTV+YYFhT5OJ/l0wgbSemi0wOkZLMZP/Jtfy+M9HG6Dx7KgQV0v8jgq8UDEfu8Mwq0uQg==
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr2848006qke.171.1562330018204;
        Fri, 05 Jul 2019 05:33:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z33sm2504614qtc.56.2019.07.05.05.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 05:33:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hjNPE-0008UP-St; Fri, 05 Jul 2019 09:33:36 -0300
Date:   Fri, 5 Jul 2019 09:33:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
Message-ID: <20190705123336.GA31543@ziepe.ca>
References: <20190703220214.28319-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703220214.28319-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:02:08PM -0700, Christoph Hellwig wrote:
> Hi Jérôme, Ben and Jason,
> 
> below is a series against the hmm tree which fixes up the mmap_sem
> locking in nouveau and while at it also removes leftover legacy HMM APIs
> only used by nouveau.

As much as I like this series, it won't make it to this merge window,
sorry.

Let's revisit it in a few weeks at rc1.

Regards,
Jason
