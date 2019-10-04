Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C056C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C89222CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="T6SmeEEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfJDQd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:33:59 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:60052 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727587AbfJDQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:33:58 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 85C542E1569;
        Fri,  4 Oct 2019 19:33:54 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id nWp6vumrBQ-XrN0IFUp;
        Fri, 04 Oct 2019 19:33:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570206834; bh=ukwWMT0M4WMAhyW+DY5+USKRuUhjpcCz/2GXBQpfOoE=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=T6SmeEEZp7N1X45t5VIybaCbKEBKRlCiNIj75gWi/hZJ9yt6CDzywcqjWB0ivHe4x
         pAvHEh7usqgYZ2+RrvAwlAS3aud304u+rKM1p3XNeqfFIuWrIfSxMVVHaMiUgf7mCp
         jlpg7l+eYLLIP7AQ6RWS4BkFX13/Vvnw1CXxZSBs=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8808::1:a])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id PRCoHVn9Jm-XrH877W3;
        Fri, 04 Oct 2019 19:33:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/rmap.c: reuse mergeable anon_vma as parent when fork
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191004160632.30251-1-richardw.yang@linux.intel.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <b5a8b1ba-c698-257f-854b-33f4fd922091@yandex-team.ru>
Date:   Fri, 4 Oct 2019 19:33:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004160632.30251-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 19.06, Wei Yang wrote:
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

Makes sense. This might have much bigger effect for scenarios when task
unmaps holes in huge vma as red-zones between allocations and then forks.

Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   mm/rmap.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d9a23bb773bf..12f6c3d7fd9d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -262,6 +262,17 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
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
> +	if (pprev && pprev->anon_vma == src->anon_vma)
> +		dst->anon_vma = prev->anon_vma;
>   
>   	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>   		struct anon_vma *anon_vma;
> 
