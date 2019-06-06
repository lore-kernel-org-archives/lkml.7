Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F45C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D30A20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b7Ke+YQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfFFOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:50:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37461 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfFFOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:50:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so2977129qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1KZ92zYILDahESjfhKhGayobjVbu/FpDMrdITCcqxXo=;
        b=b7Ke+YQBkCx0E3J0pPZLpVAC9+rc5KsP4dWKu6yYwvNpCeAE6ZlL7KwRbHU1HIMTmR
         2RMPZTyzms2qJ9eSY3qs49MIRBlxAbkWtM+PujgB/sGs5ktaPGkmc4WI8d0QDlNDUPHh
         sfNgztIs306AZWaamr9shlfnp6NFEcGjvbPp4UGL/kgELIBzA+NK9H2uVuX+vdYT777X
         BsDBGa52jWe3ot4nZts5c5RUSdmdufhR4MqA97EvW6AppKqL9zcp+ECY2R0nLelNDqrP
         26RpOweY9H0frhbjZy7FHYcVKISux2zzL6bkUzgsTQOA2nnJ3fssOueO1pAMKFpcNIAX
         jCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1KZ92zYILDahESjfhKhGayobjVbu/FpDMrdITCcqxXo=;
        b=T9U+QthmlynWXMi8pfj7XhDlX0CjErgHZsbVNiHef6n8joS2HbXvyl73bzECP4ktE+
         jLpBkaRpxZAgMdKVJRUdZaDkq1z0eMdxCDrt+BjHcCxppB1sUwkf1/ll4X8oaPsxDYcN
         5JH8HpBYBO+iROjtTx0GR6Ss3n73B4Vyl6R8mXYs6j53c4/DmQ6HboqI3VLluLG9NgLS
         TGFlCgsgn3S2MHzsXQzsCYiur5PX6Qby+tU623CfXrpiWmmWb9fdBaq2s4egalq/Wj0y
         ypcWNcHd3j9WfmzUXj2h1R+SaOqYqBtZTKayT+9I53550mXBk3xBUjDXFLFC526bw41A
         sIcw==
X-Gm-Message-State: APjAAAXQ6geaAVGQKlNeB5878dxIDHDJynTEcXwOSrYWOYnMgubW9pnv
        EJR4pqzLoiaaQu3tmBALapzaUQ==
X-Google-Smtp-Source: APXvYqxuH5l+9gMPCGPPkKKitahZmqZNXo76okgbLdEMX4KzOyGog26q61BBeC0cRApFtWnBihOSAQ==
X-Received: by 2002:aed:2de7:: with SMTP id i94mr41055012qtd.129.1559832619679;
        Thu, 06 Jun 2019 07:50:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 29sm1219227qty.87.2019.06.06.07.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 07:50:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYtic-0001BO-M8; Thu, 06 Jun 2019 11:50:18 -0300
Date:   Thu, 6 Jun 2019 11:50:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rcampbell@nvidia.com, Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call
 hmm_range_unregister()
Message-ID: <20190606145018.GA3658@ziepe.ca>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-5-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506232942.12623-5-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:29:41PM -0700, rcampbell@nvidia.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> The helper function hmm_vma_fault() calls hmm_range_register() but is
> missing a call to hmm_range_unregister() in one of the error paths.
> This leads to a reference count leak and ultimately a memory leak on
> struct hmm.
> 
> Always call hmm_range_unregister() if hmm_range_register() succeeded.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/hmm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 35a429621e1e..fa0671d67269 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>  		return (int)ret;
>  
>  	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> +		hmm_range_unregister(range);
>  		/*
>  		 * The mmap_sem was taken by driver we release it here and
>  		 * returns -EAGAIN which correspond to mmap_sem have been
> @@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>  
>  	ret = hmm_range_fault(range, block);
>  	if (ret <= 0) {
> +		hmm_range_unregister(range);

While this seems to be a clear improvement, it seems there is still a
bug in nouveau_svm.c around here as I see it calls hmm_vma_fault() but
never calls hmm_range_unregister() for its on stack range - and
hmm_vma_fault() still returns with the range registered.

As hmm_vma_fault() is only used by nouveau and is marked as
deprecated, I think we need to fix nouveau, either by dropping
hmm_range_fault(), or by adding the missing unregister to nouveau in
this patch.

Also, I see in linux-next that amdgpu_ttm.c has wrongly copied use of
this deprecated API, including these bugs...

amd folks: Can you please push a patch for your driver to stop using
hmm_vma_fault() and correct the use-after free? Ideally I'd like to
delete this function this merge cycle from hmm.git

Also if you missed it, I'm running a clean hmm.git that you can pull
into the AMD tree, if necessary, to get the changes that will go into
5.3 - if you need/wish to do this please consult with me before making a
merge commit, thanks. See:

 https://lore.kernel.org/lkml/20190524124455.GB16845@ziepe.ca/

So Ralph, you'll need to resend this.

Thanks,
Jason
