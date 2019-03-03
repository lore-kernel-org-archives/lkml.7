Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8DC4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EF120857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfCCH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfCCH1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:27:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C815981F0E;
        Sun,  3 Mar 2019 07:27:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7513B5D9CA;
        Sun,  3 Mar 2019 07:27:03 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id BAAAB1819AFE;
        Sun,  3 Mar 2019 07:27:02 +0000 (UTC)
Date:   Sun, 3 Mar 2019 02:27:02 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>, peterz@infradead.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        riel@surriel.com, mhocko@suse.com,
        ying huang <ying.huang@intel.com>,
        jrdr linux <jrdr.linux@gmail.com>, jglisse@redhat.com,
        aneesh kumar <aneesh.kumar@linux.ibm.com>, david@redhat.com,
        raquini@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Message-ID: <701776300.4537344.1551598022408.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190302185144.GD31083@redhat.com>
References: <20190302171043.GP11592@bombadil.infradead.org> <a5234d11b8cc158352a2f97fc33aa9ad90bb287b.1551550112.git.jstancek@redhat.com> <20190302185144.GD31083@redhat.com>
Subject: Re: [PATCH v2] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.28, 10.4.195.18]
Thread-Topic: mm/memory.c: do_fault: avoid usage of stale vm_area_struct
Thread-Index: pAmRXCN5CetzZ5PIfXitNyEm+tfURQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 03 Mar 2019 07:27:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> Hello Jan,
> 
> On Sat, Mar 02, 2019 at 07:19:39PM +0100, Jan Stancek wrote:
> > +	struct mm_struct *vm_mm = READ_ONCE(vma->vm_mm);
> 
> The vma->vm_mm cannot change under gcc there, so no need of
> READ_ONCE. The release of mmap_sem has release semantics so the
> vma->vm_mm access cannot be reordered after up_read(mmap_sem) either.
> 
> Other than the above detail:
> 
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Thank you for review, I dropped READ_ONCE and sent v3 with your
Reviewed-by included. I also successfully re-ran tests over-night.

> Would this not need a corresponding WRITE_ONCE() in vma_init() ?

There's at least 2 context switches between, so I think it wouldn't matter.
My concern was gcc optimizing out vm_mm, and vma->vm_mm access happening only
after do_read_fault().

