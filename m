Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EFEC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7345F206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559718196;
	bh=LvrC2wPTwJLBJguYmdQfn8G6H/mGovzxa8sZBtIgO1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FTKN+IAFkfOOU2X2U8fXSZitVUSOhrkBp4swfG4so9prfuWHavFqnMUlbhRMZpToy
	 /7JVLgNfeOUbV57CmBmkpNVeeTCL+k4zp02mgkElLFBrmiukPAcdPYGX3NfNCvn3f2
	 O+3J6xF/x9xPbN8pH2sV7QpeDbsZLyA5hkcLgSgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFEHDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:03:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbfFEHDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:03:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D4C8ADE0;
        Wed,  5 Jun 2019 07:03:14 +0000 (UTC)
Date:   Wed, 5 Jun 2019 09:03:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190605070312.GB15685@dhcp22.suse.cz>
References: <20190605060229.GA9468@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605060229.GA9468@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-06-19 11:32:29, Bharath Vedartham wrote:
> In __alloc_pages_node, there is a VM_BUG_ON on the condition (nid < 0 ||
> nid >= MAX_NUMNODES). Remove this VM_BUG_ON and add a VM_WARN_ON, if the
> condition fails and fail the allocation if an invalid NUMA node id is
> passed to __alloc_pages_node.

What is the motivation of the patch? VM_BUG_ON is not enabled by default
and your patch adds a branch to a really hot path. Why is this an
improvement for something that shouldn't happen in the first place?

> 
> The check (nid < 0 || nid >= MAX_NUMNODES) also considers NUMA_NO_NODE
> as an invalid nid, but the caller of __alloc_pages_node is assumed to
> have checked for the case where nid == NUMA_NO_NODE.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  include/linux/gfp.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 5f5e25f..075bdaf 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -480,7 +480,11 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order, int preferred_nid)
>  static inline struct page *
>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>  {
> -	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> +	if (nid < 0 || nid >= MAX_NUMNODES) {
> +		VM_WARN_ON(nid < 0 || nid >= MAX_NUMNODES);
> +		return NULL; 
> +	}
> +
>  	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
>  
>  	return __alloc_pages(gfp_mask, order, nid);
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
