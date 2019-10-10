Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FFDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7582190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zRKZvZ6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbfJJI3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:29:52 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:37624 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733108AbfJJI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:29:52 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id D56712E15D0;
        Thu, 10 Oct 2019 11:29:47 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Zc688KOaea-TiVmdN0E;
        Thu, 10 Oct 2019 11:29:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570696187; bh=hLJ/aLE1zH4IN571wxoIu2uw5Z79/QiM5/xU95wGKRY=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=zRKZvZ6kX56PyRt2T8Xphz93/xAsoc/Env+se02AJ7ZxRyCwDs39GtZgBxTJ3LnbB
         C1ZCrWUFYh1mpxvzqlPPq0NENg/D/bVtbGrBsW7RPVUAanG26vl+KcQe493DgCThmY
         5ve2W5rGVuNS8LPuiiS6f1IoTOLMXZirWNiI8Lks=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id yLNF14isCU-TiISECQI;
        Thu, 10 Oct 2019 11:29:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: "reuse mergeable anon_vma as parent when fork" causes a crash on
 s390
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
References: <1570656570.5937.24.camel@lca.pw>
 <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
 <20191010023601.GA4793@richard> <20191010031516.GA5060@richard>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8e0d9999-9ee3-78e5-2737-5a504243413c@yandex-team.ru>
Date:   Thu, 10 Oct 2019 11:29:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010031516.GA5060@richard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2019 06.15, Wei Yang wrote:
> On Thu, Oct 10, 2019 at 10:36:01AM +0800, Wei Yang wrote:
>> Hi, Qian, Shakeel
>>
>> Thanks for testing.
>>
>> Sounds I missed some case to handle. anon_vma_clone() now would be called in
>> vma_adjust, which is a different case when it is introduced.
>>
> 
> Well, I have to correct my statement. The reason is we may did something more
> in anon_vma_clone().
> 
> Here is a quick fix, while I need to go through all the cases carefully.

Oops, I've overlooked this case too.

You have to check src->anon_vma
otherwise in  __split_vma or copy_vma dst could pick completely random anon_vma.

Also checking prev will not hurt, just to be sure.

So, something like this should work:

if (!dst->anon_vma && src->anon_vma &&
     prev && pprev && pprev->anon_vma == src->anon_vma)
       dst->anon_vma = prev->anon_vma;

> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 12f6c3d7fd9d..2844f442208d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -271,7 +271,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>           * 1. Parent has vm_prev, which implies we have vm_prev.
>           * 2. Parent and its vm_prev have the same anon_vma.
>           */
> -       if (pprev && pprev->anon_vma == src->anon_vma)
> +       if (!dst->anon_vma && pprev && pprev->anon_vma == src->anon_vma)
>                  dst->anon_vma = prev->anon_vma;
>   
>          list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
> 
>> BTW, do you have the specific test case? So that I could verify my change. The
>> kernel build test doesn't trigger this.
>>
>> Thanks a lot :-)
>>
>> On Wed, Oct 09, 2019 at 03:21:11PM -0700, Shakeel Butt wrote:
>> -- 
>> Wei Yang
>> Help you, Help me
> 
