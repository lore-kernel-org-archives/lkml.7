Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48686C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0CB20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfDSTAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfDSTAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:00:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D30F430BC642;
        Fri, 19 Apr 2019 06:01:19 +0000 (UTC)
Received: from xz-x1 (ovpn-12-224.pek2.redhat.com [10.72.12.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1A0E60BE0;
        Fri, 19 Apr 2019 06:01:01 +0000 (UTC)
Date:   Fri, 19 Apr 2019 14:00:57 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 04/28] mm: allow VM_FAULT_RETRY for multiple times
Message-ID: <20190419060057.GE13323@xz-x1>
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190320020642.4000-5-peterx@redhat.com>
 <20190418201108.GJ3288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418201108.GJ3288@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 19 Apr 2019 06:01:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 04:11:08PM -0400, Jerome Glisse wrote:

[...]

> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> A minor comment suggestion below but it can be fix in a followup patch.

[...]

> > +/*
> > + * Returns true if the page fault allows retry and this is the first
> > + * attempt of the fault handling; false otherwise.  This is mostly
> > + * used for places where we want to try to avoid taking the mmap_sem
> > + * for too long a time when waiting for another condition to change,
> > + * in which case we can try to be polite to release the mmap_sem in
> > + * the first round to avoid potential starvation of other processes
> > + * that would also want the mmap_sem.
> > + */
> 
> You should be using kernel function documentation style above.

I'm switching to this:

/**
 * fault_flag_allow_retry_first - check ALLOW_RETRY the first time
 *
 * This is mostly used for places where we want to try to avoid taking
 * the mmap_sem for too long a time when waiting for another condition
 * to change, in which case we can try to be polite to release the
 * mmap_sem in the first round to avoid potential starvation of other
 * processes that would also want the mmap_sem.
 *
 * Return: true if the page fault allows retry and this is the first
 * attempt of the fault handling; false otherwise.
 */

I'm still keeping the r-b, assuming that's ok.

Thanks!

-- 
Peter Xu
