Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E8CECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBF21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="D5+EdfmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfJKIKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:10:35 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:52210 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfJKIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:10:35 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E1BB22E12F2;
        Fri, 11 Oct 2019 11:10:31 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bzgTl2DuO4-ASd4XdAF;
        Fri, 11 Oct 2019 11:10:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570781431; bh=wh/Pd1D21iHrg12jf/Voq3fQgm2Mq1wFYn7SIl0plDg=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=D5+EdfmRAbxjv3GrpiSS1cplNqNrm9403ev/N3GFGaXKv8t4LL+uxfkI9f+4+rCmh
         RBG6hdHkZ0TNJogQuWgR2lBEYfIL4bdKDyD0JUbTADIwXfl4TzmwfQs7CIYY/HrXR7
         wa8WyuK4PvuPAmlSIv7YeesAU/gXBvrtlPGgB754=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id M2GnoVIO4V-ASIqrHvq;
        Fri, 11 Oct 2019 11:10:28 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [Patch v4 2/2] mm/rmap.c: reuse mergeable anon_vma as parent when
 fork
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        cai@lca.pw, shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191011072256.16275-1-richardw.yang@linux.intel.com>
 <20191011072256.16275-2-richardw.yang@linux.intel.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8b38be36-ab2b-2bdd-13a1-ff49aeef1f32@yandex-team.ru>
Date:   Fri, 11 Oct 2019 11:10:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011072256.16275-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 10.22, Wei Yang wrote:
> In function __anon_vma_prepare(), we will try to find anon_vma if it is
> possible to reuse it. While on fork, the logic is different.
> 
> Since commit 5beb49305251 ("mm: change anon_vma linking to fix
> multi-process server scalability issue"), function anon_vma_clone()
> tries to allocate new anon_vma for child process. But the logic here
> will allocate a new anon_vma for each vma, even in parent this vma
> is mergeable and share the same anon_vma with its sibling. This may do
> better for scalability issue, while it is not necessary to do so
> especially after interval tree is used.
> 
> Commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma hierarchy")
> tries to reuse some anon_vma by counting child anon_vma and attached
> vmas. While for those mergeable anon_vmas, we can just reuse it and not
> necessary to go through the logic.
> 
> After this change, kernel build test reduces 20% anon_vma allocation.
> 
> Do the same kernel build test, it shows run time in sys reduced 11.6%.
> 
> Origin:
> 
> real    2m50.467s
> user    17m52.002s
> sys     1m51.953s
> 
> real    2m48.662s
> user    17m55.464s
> sys     1m50.553s
> 
> real    2m51.143s
> user    17m59.687s
> sys     1m53.600s
> 
> Patched:
> 
> real	2m39.933s
> user	17m1.835s
> sys	1m38.802s
> 
> real	2m39.321s
> user	17m1.634s
> sys	1m39.206s
> 
> real	2m39.575s
> user	17m1.420s
> sys	1m38.845s
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

> ---
>   mm/rmap.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c34414567474..2c13e2bfd393 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -268,6 +268,19 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>   {
>   	struct anon_vma_chain *avc, *pavc;
>   	struct anon_vma *root = NULL;
> +	struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
> +
> +	/*
> +	 * If parent share anon_vma with its vm_prev, keep this sharing in in
> +	 * child.
> +	 *
> +	 * 1. Parent has vm_prev, which implies we have vm_prev.
> +	 * 2. Parent and its vm_prev have the same anon_vma.
> +	 */
> +	if (!dst->anon_vma && src->anon_vma &&
> +	    pprev && pprev->anon_vma == src->anon_vma)
> +		dst->anon_vma = prev->anon_vma;
> +

I believe that in present code "prev" cannot be NULL if !dst->anon_vma && src->anon_vma is true.
It would be safer to check this explicitly.

>   
>   	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>   		struct anon_vma *anon_vma;
> 
