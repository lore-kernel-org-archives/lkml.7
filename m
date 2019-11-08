Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B80FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72AF21D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfKHQtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:49:13 -0500
Received: from gentwo.org ([3.19.106.255]:39020 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfKHQtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:49:13 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 535953E957; Fri,  8 Nov 2019 16:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 527E63E89A;
        Fri,  8 Nov 2019 16:49:12 +0000 (UTC)
Date:   Fri, 8 Nov 2019 16:49:12 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Knut Omang <knut.omang@oracle.com>
cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
In-Reply-To: <c77e82629f04f0183853884abbeddd871d8f5ab7.camel@oracle.com>
Message-ID: <alpine.DEB.2.21.1911081647230.756@www.lameter.com>
References: <20191107115404.3030723-1-knut.omang@oracle.com>  <20191107115806.GP8314@dhcp22.suse.cz>  <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com>  <20191107131342.GT8314@dhcp22.suse.cz>  <alpine.DEB.2.21.1911081534470.32431@www.lameter.com>
 <c77e82629f04f0183853884abbeddd871d8f5ab7.camel@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Knut Omang wrote:

> On Fri, 2019-11-08 at 15:37 +0000, Christopher Lameter wrote:
> > On Thu, 7 Nov 2019, Michal Hocko wrote:
> >
> > > On Thu 07-11-19 13:26:09, Knut Omang wrote:
> > > > On Thu, 2019-11-07 at 12:58 +0100, Michal Hocko wrote:
> > > > > On Thu 07-11-19 12:54:04, Knut Omang wrote:
> > > > > > With the restructuring done in commit 9adeaa226988
> > > > > > ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> > > > > >
> > > > > > it is no longer possible for code external to mm to access
> >
> > That patch only affected the memcg_cache_params structure and not
> > kmem_cache.
> >
> > And I do not see any references to the memcg_cache_param?
>
> Good point, I should have made explicit reference to it.
>
> It gets inlined into kmem_cache with CONFIG_SLUB if CONFIG_MEMCG is set
> (include/linux/slub_def.h, line 112)

Yes but that does not affect the "name" field on line 105

> > The fields that all allocators need to expose are listed in
> > the struct kmme_cache definition in linux/mm/slab.h.
>
> So I take that kmem_cache::name was still intended to be public,
> just that that broke due to the inlining of struct memcg_cache_param
> in slub_def.h?

The patch did not change the name field. I am not sure what is broken?

Maybe you need memcg_params to compose a name of the memcg with the slab
name?

