Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B0C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1359820838
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o+Sw+Ft9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfGZPpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:45:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37315 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGZPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:45:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so53023498qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0XvBgQp2/E+/Ic94KFJvx3PoeHBC2K6bMN+dYGtrzrU=;
        b=o+Sw+Ft9tBTCMfQnjjV7hQQHUdyNoWUSjIb4imOvsb2LbKFd1Q5NbuyDRu/AsB0VyP
         URzry2DDvBoWY/MzinDkwxqdipoU7eQxWimCd8F9Wq4pH2nxNhL0VEiztP0eXgfDnVhe
         qmeSCQ2RfaMf6HFkHqhsbZs1xw/iQNrwM9UEb0q7YJO4WRAfVYJT1pLZHckgpLWDFEW5
         ezBU84Ow58+f91moEdhmpcwYTGEj4uyoRch1AjlQz/y6ZgqBFNCIZvJUNmWtnVdWYvE1
         CtR3H87yaXERTd9RsoCTTWIViWcACY1Iwet3M5jz6s3WZSDa8csEbMTwgddUyXEsLr51
         dtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0XvBgQp2/E+/Ic94KFJvx3PoeHBC2K6bMN+dYGtrzrU=;
        b=rL6AeoTsakDvMvAlRdVVio4yTaOy4phdLp0ylurixB/tdH0l7uiekXSH81kCe45bH9
         1xZtSYN4iFYSx4nbhwoSF3Q/0dXsMOkq/euYey55466SR06Iwv3roeFtT9vqiPF8bZia
         jwMOR4w9xiBb2KVBLK/cCOPOElV6wzjHQZrUsjGCdINVi995rj3rgr+H+ryAQ81RzwsN
         b8lnetOGOP3L3WFf/UCxMwx2AnzVhxa9ZDx1BQ+mbkNa/FVWxyzsMPhyRgbvbltN2Jxj
         ufDTnUejJnvjEmMEUjgXnK3nkADTVNcCjcKve5rC4tl7KLtdp3szZ9qTxY6CiVGy4tmA
         8H8w==
X-Gm-Message-State: APjAAAVCp5obDfncY2amg0EC3n4gpoIsPRrdlPLCnwXW4ldtrJE06lJq
        0a2+jG/l9qZvndZ+gGL+gT8EovwqG1PO2A==
X-Google-Smtp-Source: APXvYqz8sQPW4m3GzwcT9XhmjAeoy2UAD2U4rkt48bJMq/KWyyCMGm6hjyKnT+STDp46Ymz4NgJRKg==
X-Received: by 2002:aed:33e6:: with SMTP id v93mr67774336qtd.157.1564155934207;
        Fri, 26 Jul 2019 08:45:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a23sm22076094qtp.22.2019.07.26.08.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 08:45:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hr2PU-0007qj-F6; Fri, 26 Jul 2019 12:45:32 -0300
Date:   Fri, 26 Jul 2019 12:45:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 0/7] mm/hmm: more HMM clean up
Message-ID: <20190726154532.GA29678@ziepe.ca>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:56:43PM -0700, Ralph Campbell wrote:
> Here are seven more patches for things I found to clean up.
> This was based on top of Christoph's seven patches:
> "hmm_range_fault related fixes and legacy API removal v3".
> I assume this will go into Jason's tree since there will likely be
> more HMM changes in this cycle.
>
> Changes from v1 to v2:
> 
> Added AMD GPU to hmm_update removal.
> Added 2 patches from Christoph.
> Added 2 patches as a result of Jason's suggestions.
> 
> Christoph Hellwig (2):
>   mm/hmm: replace the block argument to hmm_range_fault with a flags
>     value
>   mm: merge hmm_range_snapshot into hmm_range_fault
> 
> Ralph Campbell (5):
>   mm/hmm: replace hmm_update with mmu_notifier_range
>   mm/hmm: a few more C style and comment clean ups
>   mm/hmm: remove hugetlbfs check in hmm_vma_walk_pmd
>   mm/hmm: remove hmm_range vma

For all of these:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

I've applied this to hmm.git, excluding:

>   mm/hmm: make full use of walk_page_range()

Pending further discussion.

Based on last cycle I've decided to move good patches into linux-next
earlier and rely on some rebase if needed. This is to help Andrew's
workflow.

So, if there are more tags/etc please continue to send them, I will
sort it..

Thanks,
Jason
