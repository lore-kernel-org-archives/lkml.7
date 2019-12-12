Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825902253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov0pRfT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfLLVBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:01:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730779AbfLLVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576184469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/xmP+Vw2t1eL6SnJM6qLcIwF2tU6JDfLGMm9tBVuHw=;
        b=Ov0pRfT0QN4+Ypbp6RFbMBZdt+9CLXkDyLkckootafS17GnsigCmpvRe9MzPsc82Oso00c
        M5k0Q0eUhsgXdb6uRNaKVGbC79SKbbGLUFnQGtFyAGwi40i97A/bENrCRLdm570XgKqudC
        ua9gBkBgdXSZVaH8aAmpB0BUeVymdAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-MzWPlqBOPM2DK_2Zu9ivkA-1; Thu, 12 Dec 2019 16:01:05 -0500
X-MC-Unique: MzWPlqBOPM2DK_2Zu9ivkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43A3618FE892;
        Thu, 12 Dec 2019 21:01:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7823B51154;
        Thu, 12 Dec 2019 21:01:03 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>, aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <295a82ae-a575-b6a0-ae89-3196fea45b9f@redhat.com>
Date:   Thu, 12 Dec 2019 16:01:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191212190427.ouyohviijf5inhur@linux-p48b>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 2:04 PM, Davidlohr Bueso wrote:
> There have been deadlock reports[1, 2] where put_page is called
> from softirq context and this causes trouble with the hugetlb_lock,
> as well as potentially the subpool lock.
>
> For such an unlikely scenario, lets not add irq dancing overhead
> to the lock+unlock operations, which could incur in expensive
> instruction dependencies, particularly when considering hard-irq
> safety. For example PUSHF+POPF on x86.
>
> Instead, just use a workqueue and do the free_huge_page() in regular
> task context.
>
> [1]
> https://lore.kernel.org/lkml/20191211194615.18502-1-longman@redhat.com/
> [2]
> https://lore.kernel.org/lkml/20180905112341.21355-1-aneesh.kumar@linux.=
ibm.com/
>
> Reported-by: Waiman Long <longman@redhat.com>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>
> - Changes from v1: Only use wq when in_interrupt(), otherwise business
> =A0=A0 as usual. Also include the proper header file.
>
> - While I have not reproduced this issue, the v1 using wq passes all
> hugetlb
> =A0=A0 related tests in ltp.
>
> mm/hugetlb.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ac65bb5e38ac..f28cf601938d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -27,6 +27,7 @@
> #include <linux/swapops.h>
> #include <linux/jhash.h>
> #include <linux/numa.h>
> +#include <linux/workqueue.h>
>
> #include <asm/page.h>
> #include <asm/pgtable.h>
> @@ -1136,7 +1137,13 @@ static inline void
> ClearPageHugeTemporary(struct page *page)
> =A0=A0=A0=A0page[2].mapping =3D NULL;
> }
>
> -void free_huge_page(struct page *page)
> +static struct workqueue_struct *hugetlb_free_page_wq;
> +struct hugetlb_free_page_work {
> +=A0=A0=A0 struct page *page;
> +=A0=A0=A0 struct work_struct work;
> +};
> +
> +static void __free_huge_page(struct page *page)
> {
> =A0=A0=A0=A0/*
> =A0=A0=A0=A0 * Can't pass hstate in here because it is called from the
> @@ -1199,6 +1206,36 @@ void free_huge_page(struct page *page)
> =A0=A0=A0=A0spin_unlock(&hugetlb_lock);
> }
>
> +static void free_huge_page_workfn(struct work_struct *work)
> +{
> +=A0=A0=A0 struct page *page;
> +
> +=A0=A0=A0 page =3D container_of(work, struct hugetlb_free_page_work,
> work)->page;
> +=A0=A0=A0 __free_huge_page(page);
> +}
> +
> +void free_huge_page(struct page *page)
> +{
> +=A0=A0=A0 if (unlikely(in_interrupt())) {

in_interrupt() also include context where softIRQ is disabled. So maybe
!in_task() is a better fit here.


> +=A0=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0=A0 * While uncommon, free_huge_page() can be at =
least
> +=A0=A0=A0=A0=A0=A0=A0=A0 * called from softirq context, defer freeing =
such
> +=A0=A0=A0=A0=A0=A0=A0=A0 * that the hugetlb_lock and spool->lock need =
not have
> +=A0=A0=A0=A0=A0=A0=A0=A0 * to deal with irq dances just for this.
> +=A0=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0 struct hugetlb_free_page_work work;
> +
> +=A0=A0=A0=A0=A0=A0=A0 work.page =3D page;
> +=A0=A0=A0=A0=A0=A0=A0 INIT_WORK_ONSTACK(&work.work, free_huge_page_wor=
kfn);
> +=A0=A0=A0=A0=A0=A0=A0 queue_work(hugetlb_free_page_wq, &work.work);
> +
> +=A0=A0=A0=A0=A0=A0=A0 /* wait until the huge page freeing is done */
> +=A0=A0=A0=A0=A0=A0=A0 flush_work(&work.work);
> +=A0=A0=A0=A0=A0=A0=A0 destroy_work_on_stack(&work.work);

The problem I see is that you don't want to wait too long while in the
hardirq context. However, the latency for the work to finish is
indeterminate.

Cheers,
Longman

