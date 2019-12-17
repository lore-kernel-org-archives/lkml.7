Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8AEC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E939224650
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR4ElEU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfLQTJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:09:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49576 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbfLQTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576609761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NENaWpF2BMQbcwSL1h9KL1ySYckZ6VjO2TK8UPKrc3A=;
        b=GR4ElEU6oEdb6kaMhVkBTkrvRcsl2r0jbr6dbxaG8f8K3Gvsi/vb0FHhivuumRyf8TLFOm
        Hpxh+3dXWV1S8D/AJuMt8B+PVDII+7UY1qVRn9Eul4GXfQ+0KEZU/84BQ+VUrHFJ5aLEt3
        pzIOVFeNg0O3RIauUFuedyaczj6Rvtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Ai4JOG3iNn2BZ4z8ZlDGSg-1; Tue, 17 Dec 2019 14:09:16 -0500
X-MC-Unique: Ai4JOG3iNn2BZ4z8ZlDGSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D6288E41BD;
        Tue, 17 Dec 2019 19:09:14 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-81.rdu2.redhat.com [10.10.123.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2922519C58;
        Tue, 17 Dec 2019 19:09:13 +0000 (UTC)
Subject: Re: [PATCH v3] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20191217170331.30893-1-longman@redhat.com>
 <20191217185557.tgtsvaad24j745gf@linux-p48b>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4f7b23c9-6e05-3b71-9a94-f8d494d8b0e1@redhat.com>
Date:   Tue, 17 Dec 2019 14:09:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191217185557.tgtsvaad24j745gf@linux-p48b>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 1:55 PM, Davidlohr Bueso wrote:
> On Tue, 17 Dec 2019, Waiman Long wrote:
>> Both the hugetbl_lock and the subpool lock can be acquired in
>> free_huge_page(). One way to solve the problem is to make both locks
>> irq-safe. However, Mike Kravetz had learned that the hugetlb_lock is
>> held for a linear scan of ALL hugetlb pages during a cgroup reparentli=
ng
>> operation. So it is just too long to have irq disabled unless we can
>> break hugetbl_lock down into finer-grained locks with shorter lock
>> hold times.
>>
>> Another alternative is to defer the freeing to a workqueue job.=A0 Thi=
s
>> patch implements the deferred freeing by adding a free_hpage_workfn()
>> work function to do the actual freeing. The free_huge_page() call in
>> a non-task context saves the page to be freed in the hpage_freelist
>> linked list in a lockless manner using the llist APIs.
>>
>> The generic workqueue is used to process the work, but a dedicated
>> workqueue can be used instead if it is desirable to have the huge page
>> freed ASAP.
>>
>> Thanks to Kirill Tkhai <ktkhai@virtuozzo.com> for suggesting the use
>> of llist APIs which simplfy the code.
>>
>> [v2: Add more comment & remove unneeded racing check]
>> [v3: Update commit log, remove pr_debug & use llist APIs]
>
> Very creative reusing the mapping pointer, along with the llist api,
> this solves the problem nicely (temporarily at least).
>
> Two small nits below.
>
> Acked-by: Davidlohr Bueso <dbueso@suse.de>
>
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>> mm/hugetlb.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> +static LLIST_HEAD(hpage_freelist);
>> +
>> +static void free_hpage_workfn(struct work_struct *work)
>> +{
>> +=A0=A0=A0 struct llist_node *node;
>> +=A0=A0=A0 struct page *page;
>> +
>> +=A0=A0=A0 node =3D llist_del_all(&hpage_freelist);
>> +
>> +=A0=A0=A0 while (node) {
>> +=A0=A0=A0=A0=A0=A0=A0 page =3D container_of((struct address_space **)=
node,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct p=
age, mapping);
>> +=A0=A0=A0=A0=A0=A0=A0 node =3D node->next;
>
> llist_next()
I could use this helper, but the statement is simple enough to understand=
.
>
>> +=A0=A0=A0=A0=A0=A0=A0 __free_huge_page(page);
>> +=A0=A0=A0 }
>> +}
>> +static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>> +
>> +void free_huge_page(struct page *page)
>> +{
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Defer freeing if in non-task context to avoid hugetlb_=
lock
>> deadlock.
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (!in_task()) {
>
> unlikely()?

Yes, I could use that too. For now, I am not going to post a v4 with
these changes unless that are other substantial changes that require a
respin.

Thanks,
Longman

