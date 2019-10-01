Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DEC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA39F20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKrIw+4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfJAUbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:31:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46304 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJAUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:31:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so8884646pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0nEmCdmuZByzNoNnOV1jcHHS8Z8PRCf+YDKHiUxNJ0M=;
        b=OKrIw+4ShwFIAjxlX1uGIz2YIBx5WFOjCuowidjB2hlPMHhAlRtozPMQNxS25R4UaE
         hE4/EarRbK86kyXuHzwtIA05EnpOwMfaEomDq4SuFyke+HblJ2RIU6S6ONVQUo/4f5sh
         au5ZNPtDVPEmyKo9rehWwe3XoeSaSs+rELa6bac4coYBS11J+sliaFXs+n+Dd3avPMGu
         YQYJr27FyWZrojr3Z1TqSFZKz6InA8LIHat5L4iPOuFegBjv/5cICvErPODMqF0Bdm/S
         dCrGWm5t05oNyY5QXvD9OadsZgX2lxN+iX9yoI5w3C3rkb7L2If+ghef0lbyGdMV3MKJ
         0rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0nEmCdmuZByzNoNnOV1jcHHS8Z8PRCf+YDKHiUxNJ0M=;
        b=PbsshKYOB6NH6gFyZRFUT+Dvpam8qQJAE3dxTm+94WPT3pMOcKVVRcvtpviI/FLhb/
         ItiOWnWf0Etad01V6LXRQUEpvmF5i1R9GZo5qrDEd6y7gvEjXMW4oVd7xT3qWKXPWSkh
         ZyLUFYOszfkqkm21zZWE91T1NKsmlHyJX+T+eVCeiIYDe+yMcQWu/33En3/G9McWBmjP
         L2Z0o1VVooAEj2FLKyXqemIwdoca+jag1zqjCN/tADpOoafNnVNmz8gwNEr2u6L5HtjJ
         mExBoJReLw14/nIj9/FMXDVTceAOYEcx/Ce7U+YNCSyy5OmffIYFJnKYJomoSaKwui/1
         UlhA==
X-Gm-Message-State: APjAAAVVbe9hAbfNNU10wjyo+oZt1P7+UyNT7AWpNspze/2MwCrnZY1+
        AjcRx2Yx0k7vRJjTXTyhvdvBTTnUCDQ=
X-Google-Smtp-Source: APXvYqypcluBQ1GqXYvGpQc613MpfOwm6zi+5T9kSlQW1byDDdDCmfnK2KSZmewOqPscBrorsCFjFw==
X-Received: by 2002:aa7:9486:: with SMTP id z6mr201671pfk.118.1569961907492;
        Tue, 01 Oct 2019 13:31:47 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z21sm16480243pfa.119.2019.10.01.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 13:31:46 -0700 (PDT)
Date:   Tue, 1 Oct 2019 13:31:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <fac13297-424f-33b0-e01d-d72b949a73fe@suse.cz>
Message-ID: <alpine.DEB.2.21.1910011318050.38265@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com> <20190904205522.GA9871@redhat.com> <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com> <20190909193020.GD2063@dhcp22.suse.cz> <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com> <20190927074803.GB26848@dhcp22.suse.cz> <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com> <20190930112817.GC15942@dhcp22.suse.cz> <20191001054343.GA15624@dhcp22.suse.cz>
 <fac13297-424f-33b0-e01d-d72b949a73fe@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019, Vlastimil Babka wrote:

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..2c48146f3ee2 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2129,18 +2129,20 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		nmask = policy_nodemask(gfp, pol);
>  		if (!nmask || node_isset(hpage_node, *nmask)) {
>  			mpol_cond_put(pol);
> +			/*
> +			 * First, try to allocate THP only on local node, but
> +			 * don't reclaim unnecessarily, just compact.
> +			 */
>  			page = __alloc_pages_node(hpage_node,
> -						gfp | __GFP_THISNODE, order);
> +				gfp | __GFP_THISNODE | __GFP_NORETRY, order);

The page allocator has heuristics to determine when compaction should be 
retried, reclaim should be retried, and the allocation itself should retry 
for high-order allocations (see PAGE_ALLOC_COSTLY_ORDER).  
PAGE_ALLOC_COSTLY_ORDER exists solely to avoid poor allocator behavior 
when reclaim itself is unlikely -- or disruptive enough -- in making that 
amount of contiguous memory available.

Rather than papering over the poor feedback loop between compaction and 
reclaim that exists in the page allocator, it's probably better to improve 
that and determine when an allocation should fail or it's worthwhile to 
retry.  That's a separate topic from NUMA locality of thp.

In other words, we should likely address how compaction and reclaim is 
done for all high order-allocations in the page allocator itself rather 
than only here for hugepage allocations and relying on specific gfp bits 
to be set.  Ask: if the allocation here should not retry regardless of why 
compaction failed, why should any high-order allocation (user or kernel) 
retry if compaction failed and at what order we should just fail?  If 
hugetlb wants to stress this to the fullest extent possible, it already 
appropriately uses __GFP_RETRY_MAYFAIL.

The code here is saying we care more about NUMA locality than hugepages 
simply because that's where the access latency is better and is specific 
to hugepages; allocation behavior for high-order pages needs to live in 
the page allocator.

>  
>  			/*
> -			 * If hugepage allocations are configured to always
> -			 * synchronous compact or the vma has been madvised
> -			 * to prefer hugepage backing, retry allowing remote
> -			 * memory as well.
> +			 * If that fails, allow both compaction and reclaim,
> +			 * but on all nodes.
>  			 */
> -			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
> +			if (!page)
>  				page = __alloc_pages_node(hpage_node,
> -						gfp | __GFP_NORETRY, order);
> +								gfp, order);
>  
>  			goto out;
>  		}

We certainly don't want this for non-MADV_HUGEPAGE regions when thp 
enabled bit is not set to "always".  We'd much rather fallback to local 
native pages because of its improved access latency.  This is allowing all 
hugepage allocations to be remote even without MADV_HUGEPAGE which is not 
even what Andrea needs: qemu uses MADV_HUGEPAGE.
