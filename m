Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ACCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C3218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCTXGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:06:52 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43305 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfCTXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:06:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TNEARE5_1553123205;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNEARE5_1553123205)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Mar 2019 07:06:48 +0800
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
To:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     chrubis@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
        kirill@shutemov.name, osalvador@suse.de, stable@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAFqt6zbqYyzVB3HbYXv19jo8=3hGC=XZAkwvE8PCVdLOKTeG1g@mail.gmail.com>
 <20190320151630.9c7c604a96f0a892c29befdc@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e8077900-e2d2-681a-9a2e-9dd500e7c83c@linux.alibaba.com>
Date:   Wed, 20 Mar 2019 16:06:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190320151630.9c7c604a96f0a892c29befdc@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/19 3:16 PM, Andrew Morton wrote:
> On Wed, 20 Mar 2019 11:23:03 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
>>> --- a/mm/mempolicy.c
>>> +++ b/mm/mempolicy.c
>>> @@ -447,6 +447,13 @@ static inline bool queue_pages_required(struct page *page,
>>>          return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
>>>   }
>>>
>>> +/*
>>> + * The queue_pages_pmd() may have three kind of return value.
>>> + * 1 - pages are placed on he right node or queued successfully.
>> Minor typo -> s/he/the ?
> Yes, that comment needs some help.  This?
>
> --- a/mm/mempolicy.c~mm-mempolicy-make-mbind-return-eio-when-mpol_mf_strict-is-specified-fix
> +++ a/mm/mempolicy.c
> @@ -429,9 +429,9 @@ static inline bool queue_pages_required(
>   }
>   
>   /*
> - * The queue_pages_pmd() may have three kind of return value.
> - * 1 - pages are placed on he right node or queued successfully.
> - * 0 - THP get split.
> + * queue_pages_pmd() has three possible return values:
> + * 1 - pages are placed on the right node or queued successfully.
> + * 0 - THP was split.
>    * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
>    *        page was already on a node that does not follow the policy.
>    */

It looks good to me. Thanks, Andrew.

Yang

> _

