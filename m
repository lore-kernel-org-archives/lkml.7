Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C7C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C420830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfCBSwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:52:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfCBSwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:52:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C5D4307CEB2;
        Sat,  2 Mar 2019 18:51:47 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 220315D70A;
        Sat,  2 Mar 2019 18:51:45 +0000 (UTC)
Date:   Sat, 2 Mar 2019 13:51:44 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        peterz@infradead.org, riel@surriel.com, mhocko@suse.com,
        ying.huang@intel.com, jrdr.linux@gmail.com, jglisse@redhat.com,
        aneesh.kumar@linux.ibm.com, david@redhat.com, raquini@redhat.com,
        rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
Message-ID: <20190302185144.GD31083@redhat.com>
References: <20190302171043.GP11592@bombadil.infradead.org>
 <a5234d11b8cc158352a2f97fc33aa9ad90bb287b.1551550112.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5234d11b8cc158352a2f97fc33aa9ad90bb287b.1551550112.git.jstancek@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 02 Mar 2019 18:51:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

On Sat, Mar 02, 2019 at 07:19:39PM +0100, Jan Stancek wrote:
> +	struct mm_struct *vm_mm = READ_ONCE(vma->vm_mm);

The vma->vm_mm cannot change under gcc there, so no need of
READ_ONCE. The release of mmap_sem has release semantics so the
vma->vm_mm access cannot be reordered after up_read(mmap_sem) either.

Other than the above detail:

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Thanks,
Andrea
