Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB856C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18D62166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D95KMBvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbfKGM03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:26:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfKGM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:26:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7CEBqs097588;
        Thu, 7 Nov 2019 12:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=Vtl1MPXVCsQLaOG3ggV3jAcmHOG87IQnMeFvh9uHPK8=;
 b=D95KMBvbyNN76WObU4+x7TqhGQ0bxnuOOEf/KNIMi2wq1SyMGCAQHluZ+I+8576zNjcC
 j5TDi+HjM865djydrAIHNAR1DXIClnkuaBvhnsZoTfPcQKj8vfurZGd3nKkkBqJdgUOd
 PNUrso6zA6WC8xGRrydESC2aYTv48RpR4wpvEXtgoBqmQiXOJW+kJxJHDMK3/0mgQeyp
 LJCXAMrH9NX9U4lPUHxaJAFAm9c6LtOxQ4btO9Ryt3f6viUXE9zBFrbqngH+0Wf2Jwk2
 XVJ7u00hY21juXKjajV9BYq9BsdSV1gN7LPy7zb90FQCOj7OHyOyRT9E2PPVDYPu9QwJ jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w41w0wqts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 12:26:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7CEFwO064132;
        Thu, 7 Nov 2019 12:26:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w41wh2jsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 12:26:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7CQCr1029409;
        Thu, 7 Nov 2019 12:26:12 GMT
Received: from abi.no.oracle.com (/141.143.213.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 04:26:12 -0800
Message-ID: <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
From:   Knut Omang <knut.omang@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 07 Nov 2019 13:26:09 +0100
In-Reply-To: <20191107115806.GP8314@dhcp22.suse.cz>
References: <20191107115404.3030723-1-knut.omang@oracle.com>
         <20191107115806.GP8314@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 12:58 +0100, Michal Hocko wrote:
> On Thu 07-11-19 12:54:04, Knut Omang wrote:
> > With the restructuring done in commit 9adeaa226988
> > ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> > 
> > it is no longer possible for code external to mm to access
> > the name of a kmem_cache as struct kmem_cache has effectively become
> > opaque. Having access to the cache name is helpful to kernel testing
> > infrastructure.
> > 
> > Expose a new function kmem_cache_name to mitigate that.
> 
> Who is going to use that symbol? It is preferred that a user is added in
> the same patch as the newly added symbol.

Yes, I am aware that that's the normal practice, 
we're currently using cache->name directly in the kernel 
unit test framework KTF (https://github.com/oracle/ktf/)
which we are working (https://lkml.org/lkml/2019/8/13/111) to get 
into the kernel in one form or another.

To me this seems like a natural part of an API for the kmem_cache
data structure now that it has in effect become opaque, so it seemed 
appropriate to get it in close in time to the patch that no longer 
makes this possible, instead of someone else hitting this down the road.

Thanks,
Knut

> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > ---
> >  include/linux/slab.h | 1 +
> >  mm/slab_common.c     | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 4d2a2fa55ed5..3298c9db6e46 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -702,6 +702,7 @@ static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
> >  }
> >  
> >  unsigned int kmem_cache_size(struct kmem_cache *s);
> > +const char *kmem_cache_name(struct kmem_cache *s);
> >  void __init kmem_cache_init_late(void);
> >  
> >  #if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index f9fb27b4c843..269a99dc8214 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -82,6 +82,15 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
> >  }
> >  EXPORT_SYMBOL(kmem_cache_size);
> >  
> > +/*
> > + * Get the name of a slab object
> > + */
> > +const char *kmem_cache_name(struct kmem_cache *s)
> > +{
> > +	return s->name;
> > +}
> > +EXPORT_SYMBOL(kmem_cache_name);
> > +
> >  #ifdef CONFIG_DEBUG_VM
> >  static int kmem_cache_sanity_check(const char *name, unsigned int size)
> >  {
> > -- 
> > 2.20.1

