Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E96C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3D82064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfF0SpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:45:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0SpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39072C05168F;
        Thu, 27 Jun 2019 18:45:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 140405C1B4;
        Thu, 27 Jun 2019 18:45:00 +0000 (UTC)
Subject: Re: [PATCH-next] mm, memcg: Add ":deact" tag for reparented kmem
 caches in memcg_slabinfo
To:     Roman Gushchin <guro@fb.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190621173005.31514-1-longman@redhat.com>
 <20190626195757.GB24698@tower.DHCP.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cc7a0ac0-6f3a-4d0a-54b2-7387400aeb8c@redhat.com>
Date:   Thu, 27 Jun 2019 14:45:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626195757.GB24698@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 27 Jun 2019 18:45:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 3:58 PM, Roman Gushchin wrote:
> On Fri, Jun 21, 2019 at 01:30:05PM -0400, Waiman Long wrote:
>> With Roman's kmem cache reparent patch, multiple kmem caches of the same
>> type can be seen attached to the same memcg id. All of them, except
>> maybe one, are reparent'ed kmem caches. It can be useful to tag those
>> reparented caches by adding a new slab flag "SLAB_DEACTIVATED" to those
>> kmem caches that will be reparent'ed if it cannot be destroyed completely.
>>
>> For the reparent'ed memcg kmem caches, the tag ":deact" will now be
>> shown in <debugfs>/memcg_slabinfo.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Hi Waiman!
>
> Sorry for the late reply. The patch overall looks good to me,
> except one nit. Please feel free to use my ack:
> Acked-by: Roman Gushchin <guro@fb.com>
>
>> ---
>>  include/linux/slab.h |  4 ++++
>>  mm/slab.c            |  1 +
>>  mm/slab_common.c     | 14 ++++++++------
>>  mm/slub.c            |  1 +
>>  4 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index fecf40b7be69..19ab1380f875 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -116,6 +116,10 @@
>>  /* Objects are reclaimable */
>>  #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
>>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>> +
>> +/* Slab deactivation flag */
>> +#define SLAB_DEACTIVATED	((slab_flags_t __force)0x10000000U)
>> +
>>  /*
>>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>>   *
>> diff --git a/mm/slab.c b/mm/slab.c
>> index a2e93adf1df0..e8c7743fc283 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -2245,6 +2245,7 @@ int __kmem_cache_shrink(struct kmem_cache *cachep)
>>  #ifdef CONFIG_MEMCG
>>  void __kmemcg_cache_deactivate(struct kmem_cache *cachep)
>>  {
>> +	cachep->flags |= SLAB_DEACTIVATED;
> A nit: it can be done from kmemcg_cache_deactivate() instead,
> and then you don't have to do it in slab and slub separately.
>
> Since it's not slab- or slub-specific code, it'd be better, IMO,
> to put it into slab_common.c.

Thanks for the suggestion.

You are right. It will be cleaner to set the flag in
kmemcg_cache_deactivate(). I have just sent out a v2 patch to do that.

Cheers,
Longman

