Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65114C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC5D2075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573132427;
	bh=7dg6pWFItyEU5sWS7AZS5WQyKuQHR/36sAei8N8uU+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j5gVImG0xn6xplNGugxpu0JzRUdLVAn2YgHVI1vALio4Zdz0CUeUt4XKDaRHk5/0K
	 jhkLxJXAum26eCltL234utQHZATbJ/uP2GcOrIxogBja0J1LMq8RfHnDk0h3PcP+dL
	 vVuxnLKxJ3oCj4+tQ4oDCq8+EfniCHuCi1Az14lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfKGNNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:13:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:57766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727619AbfKGNNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:13:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB4B9B169;
        Thu,  7 Nov 2019 13:13:43 +0000 (UTC)
Date:   Thu, 7 Nov 2019 14:13:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
Message-ID: <20191107131342.GT8314@dhcp22.suse.cz>
References: <20191107115404.3030723-1-knut.omang@oracle.com>
 <20191107115806.GP8314@dhcp22.suse.cz>
 <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-11-19 13:26:09, Knut Omang wrote:
> On Thu, 2019-11-07 at 12:58 +0100, Michal Hocko wrote:
> > On Thu 07-11-19 12:54:04, Knut Omang wrote:
> > > With the restructuring done in commit 9adeaa226988
> > > ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> > > 
> > > it is no longer possible for code external to mm to access
> > > the name of a kmem_cache as struct kmem_cache has effectively become
> > > opaque. Having access to the cache name is helpful to kernel testing
> > > infrastructure.
> > > 
> > > Expose a new function kmem_cache_name to mitigate that.
> > 
> > Who is going to use that symbol? It is preferred that a user is added in
> > the same patch as the newly added symbol.
> 
> Yes, I am aware that that's the normal practice, 
> we're currently using cache->name directly in the kernel 
> unit test framework KTF (https://github.com/oracle/ktf/)
> which we are working (https://lkml.org/lkml/2019/8/13/111) to get 
> into the kernel in one form or another.

Please add the export with a patch that really needs it.

> To me this seems like a natural part of an API for the kmem_cache
> data structure now that it has in effect become opaque, so it seemed 
> appropriate to get it in close in time to the patch that no longer 
> makes this possible, instead of someone else hitting this down the road.

Well, this is something for SLAB maintainers but I do not really think
the name is something the in kernel code should care about. It is solely
for presenting reasonable statistics to the userspace and that code
workds just fine AFAIK.
-- 
Michal Hocko
SUSE Labs
