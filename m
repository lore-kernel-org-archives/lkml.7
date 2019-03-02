Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF5CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78E420830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfCBSAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:00:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfCBSAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:00:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5437AC04BD22;
        Sat,  2 Mar 2019 18:00:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FB875D704;
        Sat,  2 Mar 2019 18:00:11 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3F9DC1819AFF;
        Sat,  2 Mar 2019 18:00:10 +0000 (UTC)
Date:   Sat, 2 Mar 2019 13:00:09 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        peterz@infradead.org, riel@surriel.com, mhocko@suse.com,
        ying huang <ying.huang@intel.com>,
        jrdr linux <jrdr.linux@gmail.com>, jglisse@redhat.com,
        aneesh kumar <aneesh.kumar@linux.ibm.com>, david@redhat.com,
        aarcange@redhat.com, raquini@redhat.com, rientjes@google.com,
        kirill@shutemov.name, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org
Message-ID: <913961507.4507772.1551549609679.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190302171043.GP11592@bombadil.infradead.org>
References: <0b7a4604529e16ace8d65a42dac7c78582e7fb28.1551538524.git.jstancek@redhat.com> <20190302171043.GP11592@bombadil.infradead.org>
Subject: Re: [PATCH] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.21, 10.4.195.4]
Thread-Topic: mm/memory.c: do_fault: avoid usage of stale vm_area_struct
Thread-Index: C10Zhz2Qec5wJx/oT6sHbvbZS5ZXDA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 02 Mar 2019 18:00:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> On Sat, Mar 02, 2019 at 04:11:26PM +0100, Jan Stancek wrote:
> > Problem is that "vmf->vma" used in do_fault() can become stale.
> > Because mmap_sem may be released, other threads can come in,
> > call munmap() and cause "vma" be returned to kmem cache, and
> > get zeroed/re-initialized and re-used:
> 
> > This patch pins mm_struct and stores its value, to avoid using
> > potentially stale "vma" when calling pte_free().
> 
> OK, we need to cache the mm_struct, but why do we need the extra atomic op?
> There's surely no way the mm can be freed while the thread is in the middle
> of handling a fault.

You're right, I was needlessly paranoid.

> 
> ie I would drop these lines:

I'll send v2.

Thanks,
Jan

> 
> > +	mmgrab(vm_mm);
> > +
> ...
> > +
> > +	mmdrop(vm_mm);
> > +
> 
