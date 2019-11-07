Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5032B2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCuEcUO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKGTNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:13:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42710 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbfKGTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573154030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgNhIjZI4iddcLSwbahuDC1ASugf6AydFI8zhHAyaP8=;
        b=dCuEcUO4hNMa5G56Op7z1oxJTY6XLKG6olagqyNcoHQWiVEYUBLpjftKDuaLGO2+Hy2Gt+
        VE94XiIOlwKJgmCFOPGfMgK2EbKrlqOUNAtegAEjal4RgUZbOez6xUllHcbj2ctbAVtGEo
        qCn+OTNdmeoja3WolkyDbhTmqRONYpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-AMmkt8STMOuG5w0S6f0kqA-1; Thu, 07 Nov 2019 14:13:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 235F91800D7B;
        Thu,  7 Nov 2019 19:13:25 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B312600D3;
        Thu,  7 Nov 2019 19:13:24 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ec1903c4-cec1-29bf-1a94-6cd12305d2ac@redhat.com>
Date:   Thu, 7 Nov 2019 14:13:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107190628.22667-1-longman@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: AMmkt8STMOuG5w0S6f0kqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 2:06 PM, Waiman Long wrote:
> A customer with large SMP systems (up to 16 sockets) with application
> that uses large amount of static hugepages (~500-1500GB) are experiencing
> random multisecond delays. These delays was caused by the long time it
> took to scan the VMA interval tree with mmap_sem held.
>
> The sharing of huge PMD does not require changes to the i_mmap at all.
> As a result, we can just take the read lock and let other threads
> searching for the right VMA to share in parallel. Once the right
> VMA is found, either the PMD lock (2M huge page for x86-64) or the
> mm->page_table_lock will be acquired to perform the actual PMD sharing.
>
> Lock contention, if present, will happen in the spinlock. That is much
> better than contention in the rwsem where the time needed to scan the
> the interval tree is indeterminate.
>
> With this patch applied, the customer is seeing significant improvements
> over the unpatched kernel.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/hugetlb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b45a95363a84..087e7ff00137 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4842,7 +4842,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsign=
ed long addr, pud_t *pud)
>  =09if (!vma_shareable(vma, addr))
>  =09=09return (pte_t *)pmd_alloc(mm, pud, addr);
> =20
> -=09i_mmap_lock_write(mapping);
> +=09/*
> +=09 * PMD sharing does not require changes to i_mmap. So a read lock
> +=09 * is enuogh.
> +=09 */
> +=09i_mmap_lock_read(mapping);
>  =09vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
>  =09=09if (svma =3D=3D vma)
>  =09=09=09continue;
> @@ -4872,7 +4876,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigne=
d long addr, pud_t *pud)
>  =09spin_unlock(ptl);
>  out:
>  =09pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
> -=09i_mmap_unlock_write(mapping);
> +=09i_mmap_unlock_read(mapping);
>  =09return pte;
>  }
> =20

This is a follow-up of my previous patch to disable PMD sharing for
large system.

https://lore.kernel.org/lkml/20190911150537.19527-1-longman@redhat.com/

This patch is simpler and has lower risk while still solve the customer
problem. It supersedes the previous patch.

Cheers,
Longman

