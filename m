Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D09C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA821217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfHHHTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:19:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfHHHTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:19:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A6F169081;
        Thu,  8 Aug 2019 07:19:31 +0000 (UTC)
Received: from [10.36.117.55] (ovpn-117-55.ams2.redhat.com [10.36.117.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 925F310016EB;
        Thu,  8 Aug 2019 07:19:29 +0000 (UTC)
Subject: Re: [PATCH 2/2] s390/mm: Use refcount_t for refcount
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190808071826.6649-1-hslester96@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <49f59848-00dd-660b-c192-a11beafbe277@redhat.com>
Date:   Thu, 8 Aug 2019 09:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190808071826.6649-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 08 Aug 2019 07:19:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.19 09:18, Chuhong Yuan wrote:
> Reference counters are preferred to use refcount_t instead of
> atomic_t.
> This is because the implementation of refcount_t can prevent
> overflows and detect possible use-after-free.
> So convert atomic_t ref counters to refcount_t.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  arch/s390/include/asm/gmap.h |  4 +++-
>  arch/s390/mm/gmap.c          | 10 +++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index fcbd638fb9f4..37f96b6f0e61 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -9,6 +9,8 @@
>  #ifndef _ASM_S390_GMAP_H
>  #define _ASM_S390_GMAP_H
>  
> +#include <linux/refcount.h>
> +
>  /* Generic bits for GMAP notification on DAT table entry changes. */
>  #define GMAP_NOTIFY_SHADOW	0x2
>  #define GMAP_NOTIFY_MPROT	0x1
> @@ -46,7 +48,7 @@ struct gmap {
>  	struct radix_tree_root guest_to_host;
>  	struct radix_tree_root host_to_guest;
>  	spinlock_t guest_table_lock;
> -	atomic_t ref_count;
> +	refcount_t ref_count;
>  	unsigned long *table;
>  	unsigned long asce;
>  	unsigned long asce_end;
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 39c3a6e3d262..cd8e03f04d6d 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -67,7 +67,7 @@ static struct gmap *gmap_alloc(unsigned long limit)
>  	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
>  	spin_lock_init(&gmap->guest_table_lock);
>  	spin_lock_init(&gmap->shadow_lock);
> -	atomic_set(&gmap->ref_count, 1);
> +	refcount_set(&gmap->ref_count, 1);
>  	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
>  	if (!page)
>  		goto out_free;
> @@ -214,7 +214,7 @@ static void gmap_free(struct gmap *gmap)
>   */
>  struct gmap *gmap_get(struct gmap *gmap)
>  {
> -	atomic_inc(&gmap->ref_count);
> +	refcount_inc(&gmap->ref_count);
>  	return gmap;
>  }
>  EXPORT_SYMBOL_GPL(gmap_get);
> @@ -227,7 +227,7 @@ EXPORT_SYMBOL_GPL(gmap_get);
>   */
>  void gmap_put(struct gmap *gmap)
>  {
> -	if (atomic_dec_return(&gmap->ref_count) == 0)
> +	if (refcount_dec_and_test(&gmap->ref_count))
>  		gmap_free(gmap);
>  }
>  EXPORT_SYMBOL_GPL(gmap_put);
> @@ -1594,7 +1594,7 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce,
>  			continue;
>  		if (!sg->initialized)
>  			return ERR_PTR(-EAGAIN);
> -		atomic_inc(&sg->ref_count);
> +		refcount_inc(&sg->ref_count);
>  		return sg;
>  	}
>  	return NULL;
> @@ -1682,7 +1682,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
>  			}
>  		}
>  	}
> -	atomic_set(&new->ref_count, 2);
> +	refcount_set(&new->ref_count, 2);
>  	list_add(&new->list, &parent->children);
>  	if (asce & _ASCE_REAL_SPACE) {
>  		/* nothing to protect, return right away */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
