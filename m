Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C7C2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F614206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEjnOtbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfLJChJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:37:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20771 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbfLJChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575945426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKlOPTsPIdqSrBsnPqvTtgA2zsB5MINy3LoQKcLT7RQ=;
        b=gEjnOtbwGj0XlzIwueHF3d8GS9ZJoj5EgAaA2hxAngRkkuJSZvYxU1spBjKLtg6f1EwtbQ
        M+BgJmSSztOaGUN01uvYfAcgLSMEwsC7aeBoFtxrCCgCYiM0FC0OddeMe6iPyFXaEtjsAq
        qkrjVWTW4XX3OftQe28r5PVqIx7dGTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-a_EyqVN2MEiIz10jbrwHIw-1; Mon, 09 Dec 2019 21:37:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22EB9DB20;
        Tue, 10 Dec 2019 02:37:02 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-0.rdu2.redhat.com [10.10.123.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D1B560555;
        Tue, 10 Dec 2019 02:37:01 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Disable IRQ when taking hugetlb_lock in
 set_max_huge_pages()
From:   Waiman Long <longman@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20191209160150.18064-1-longman@redhat.com>
 <20191209164907.GD32169@bombadil.infradead.org>
 <a7ea9e1a-be9e-e6ee-5b30-602166041509@redhat.com>
Organization: Red Hat
Message-ID: <1209d9ba-9d82-4dfc-5cdf-a2641814af75@redhat.com>
Date:   Mon, 9 Dec 2019 21:37:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a7ea9e1a-be9e-e6ee-5b30-602166041509@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: a_EyqVN2MEiIz10jbrwHIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 7:46 PM, Waiman Long wrote:
> On 12/9/19 11:49 AM, Matthew Wilcox wrote:
>> On Mon, Dec 09, 2019 at 11:01:50AM -0500, Waiman Long wrote:
>>> [  613.245273] Call Trace:
>>> [  613.256273]  <IRQ>
>>> [  613.265273]  dump_stack+0x9a/0xf0
>>> [  613.281273]  mark_lock+0xd0c/0x12f0
>>> [  613.341273]  __lock_acquire+0x146b/0x48c0
>>> [  613.401273]  lock_acquire+0x14f/0x3b0
>>> [  613.440273]  _raw_spin_lock+0x30/0x70
>>> [  613.477273]  free_huge_page+0x36f/0xaa0
>>> [  613.495273]  bio_check_pages_dirty+0x2fc/0x5c0
>> Oh, this is fun.  So we kicked off IO to a hugepage, then truncated or
>> otherwise caused the page to come free.  Then the IO finished and did th=
e
>> final put on the page ... from interrupt context.  Splat.  Not something
>> that's going to happen often, but can happen if a process dies during
>> IO or due to a userspace bug.
>>
>> Maybe we should schedule work to do the actual freeing of the page
>> instead of this rather large patch.  It doesn't seem like a case we need
>> to optimise for.
> I think that may be a good idea to try it out.

It turns out using workqueue is more complex that I originally thought.
I currently come up with the following untested changes to do that:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac65bb5e38ac..629ac000318b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1136,7 +1136,7 @@ static inline void ClearPageHugeTemporary(struct
page *pag
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page[2].mapping =3D NULL;
=C2=A0}
=C2=A0
-void free_huge_page(struct page *page)
+static void __free_huge_page(struct page *page)
=C2=A0{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Can't pass hstate in her=
e because it is called from the
@@ -1199,6 +1199,82 @@ void free_huge_page(struct page *page)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&hugetlb_lock);
=C2=A0}
=C2=A0
+/*
+ * As free_huge_page() can be called from softIRQ context, we have
+ * to defer the actual freeing in a workqueue to prevent potential
+ * hugetlb_lock deadlock.
+ */
+struct hpage_to_free {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *page;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hpage_to_free=C2=A0=C2=A0=C2=
=A0 *next;
+};
+static struct hpage_to_free *hpage_freelist;
+#define NEXT_PENDING=C2=A0=C2=A0 ((struct hpage_to_free *)-1)
+
+/*
+ * This work function locklessly retrieves the pages to be freed and
+ * frees them one-by-one.
+ */
+static void free_huge_page_workfn(struct work_struct *work)
+{
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hpage_to_free *curr, *next;
+
+recheck:
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curr =3D xchg(&hpage_freelist, NULL);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!curr)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
+
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (curr) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 __free_huge_page(curr->page);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 next =3D READ_ONCE(curr->next);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 while (next =3D=3D NEXT_PENDING) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_relax();
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D READ_=
ONCE(curr->next);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 kfree(curr);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 curr =3D next;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (work && READ_ONCE(hpage_freelist)=
)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto recheck;
+}
+static DECLARE_WORK(free_huge_page_work, free_huge_page_workfn);
+
+void free_huge_page(struct page *page)
+{
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Defer freeing in softIRQ cont=
ext to avoid hugetlb_lock deadlock.
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (in_serving_softirq()) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct hpage_to_free *item, *next;
+
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /*
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * We are in serious trouble if kmalloc fails. In this
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * case, we hope for the best and do the freeing now.
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 item =3D kmalloc(sizeof(*item), GFP_KERNEL);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (WARN_ON_ONCE(!item))
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_page=
_now;
+
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 item->page =3D page;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 item->next =3D NEXT_PENDING;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 next =3D xchg(&hpage_freelist, item);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 WRITE_ONCE(item->next, next);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 schedule_work(&free_huge_page_work);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Racing may prevent some of de=
ferred huge pages in hpage_freelist
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from being freed. Check here =
and call schedule_work() if that
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is the case.
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hpage_freelist && !work_pending(&=
free_huge_page_work))
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 schedule_work(&free_huge_page_work);
+
+free_page_now:
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __free_huge_page(page);
+}
+
=C2=A0static void prep_new_huge_page(struct hstate *h, struct page *page, i=
nt
nid)
=C2=A0{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&page->lru);

---------------------------------------------------------------------------=
--------------------------

I think it may be simpler and less risky to use spin_lock_bh() as you
have suggested. Also, the above code will not be good enough if more
lock taking functions are being called from softIRQ context in the future.

So what do you think?

Cheers,
Longman

Cheers,
Longman

