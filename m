Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADFFC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C91217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562966108;
	bh=84KH1NKKp+X9DBsNyPpI1JzWgMF+ovJKrSmV72XOuuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I5hcCahYmp30aFAK8L5N0qBy5ZstRwJ0kicyoEEEqcJV7OfhnKf9UzBb0PS3/PNpQ
	 P+Aj/8QXROKzHHjs52/fhbZjsAiIFwUyiH0DLGCPEI8jjo3au9eV6qecYBRyjTRhRr
	 BQnVAl3iVg/zosQF+4KyPx9xYBs8YJU9vIs2M/is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfGLVPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfGLVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:15:06 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A932146E;
        Fri, 12 Jul 2019 21:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562966105;
        bh=84KH1NKKp+X9DBsNyPpI1JzWgMF+ovJKrSmV72XOuuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBeYKAYPMDUjiMGytkc/Bk1Pr+hCn+LW0WUMb6dpBwAh4E1VPF/A3a2dCUdH1MFlK
         2VZOmEsYQBBJbUy49jLppevJHlscfQfA3aqVZz3WvS9ky3JdG54O1xE9jWHau+VM7r
         EEx6OqmJ86RmSsJQZ4xF9KiJmK95CTXO0ZcSjPiE=
Date:   Fri, 12 Jul 2019 14:15:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20190712141504.3518d0e6a9607f2304dfe6e3@linux-foundation.org>
In-Reply-To: <CAK8P3a3Eb1+imK+daiK=ctN6DhwSuTfnAnUUG9xK5rQo=pZ_uQ@mail.gmail.com>
References: <20190709211559.6ffd2f4e@canb.auug.org.au>
        <20190709134233.b50814f5a789244b9bdb573e@linux-foundation.org>
        <20190710070509.GB29695@dhcp22.suse.cz>
        <20190710173434.8081fa5410ccf0ccd72719b9@linux-foundation.org>
        <CAK8P3a3Eb1+imK+daiK=ctN6DhwSuTfnAnUUG9xK5rQo=pZ_uQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 12:59:45 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Jul 11, 2019 at 2:41 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> >
> > From: Yang Shi <yang.shi@linux.alibaba.com>
> > Subject: mm: shrinker: make shrinker not depend on memcg kmem
> >
> > Currently shrinker is just allocated and can work when memcg kmem is
> > enabled.  But, THP deferred split shrinker is not slab shrinker, it
> > doesn't make too much sense to have such shrinker depend on memcg kmem.
> > It should be able to reclaim THP even though memcg kmem is disabled.
> >
> > Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker.
> > When memcg kmem is disabled, just such shrinkers can be called in
> > shrinking memcg slab.
> >
> 
> Today's linux-next again fails without CONFIG_MEMCG_KMEM:
> 
> mm/vmscan.c:220:7: error: implicit declaration of function
> 'memcg_expand_shrinker_maps' [-Werror,-Wimplicit-function-declaration]
>                 if (memcg_expand_shrinker_maps(id)) {
>                     ^
> mm/vmscan.c:608:56: error: no member named 'shrinker_map' in 'struct
> mem_cgroup_per_node'
>         map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
>                                         ~~~~~~~~~~~~~~~~~~~~  ^
> 

Thanks.  With this and the mysterious list_del() corruption issue I
think I'll drop the patchset.

