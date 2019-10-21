Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4C7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF9C214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571646836;
	bh=hGLzhBE4xkGtiLhVS+A//J3+6WAAB/KlzKp2VNekAyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=emVzdrWVK3WwTDniqt/DF0UmOD9vNzOg+LppheaF6nG+5SD8rxkFXAhPZn20FTFNB
	 YkR4EMyNbOx9clifmvoPc5N690FGdFZh5cxRhyDaxzhYVW7nEYPhWpXsDGQ1XGo5wH
	 QuMfXmmzgK+RYm4lzSjrZ5a8bg77WdWKm0Yexfzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfJUIdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:33:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfJUIdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:33:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7940DAEF9;
        Mon, 21 Oct 2019 08:33:53 +0000 (UTC)
Date:   Mon, 21 Oct 2019 10:33:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com, aneesh.kumar@linux.ibm.com,
        anshuman.khandual@arm.com, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, bp@alien8.de, cai@lca.pw,
        catalin.marinas@arm.com, christophe.leroy@c-s.fr, dalias@libc.org,
        damian.tometzki@gmail.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        gerald.schaefer@de.ibm.com, glider@google.com, gor@linux.ibm.com,
        gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com,
        hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca,
        linux-mm@kvack.org, logang@deltatee.com, luto@kernel.org,
        mark.rutland@arm.com, mgorman@techsingularity.net,
        mingo@redhat.com, mm-commits@vger.kernel.org, mpe@ellerman.id.au,
        osalvador@suse.de, pagupta@redhat.com, pasha.tatashin@soleen.com,
        pasic@linux.ibm.com, paulus@samba.org,
        pavel.tatashin@microsoft.com, peterz@infradead.org,
        richard.weiyang@gmail.com, richardw.yang@linux.intel.com,
        robin.murphy@arm.com, rppt@linux.ibm.com, stable@vger.kernel.org,
        steve.capper@arm.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, vbabka@suse.cz,
        will@kernel.org, willy@infradead.org,
        yamada.masahiro@socionext.com, yaojun8558363@gmail.com,
        ysato@users.sourceforge.jp, yuzhao@google.com
Subject: Re: [patch 07/26] mm/memunmap: don't access uninitialized memmap in
 memunmap_pages()
Message-ID: <20191021083352.GE9379@dhcp22.suse.cz>
References: <20191019031939.9XlSnLGcS%akpm@linux-foundation.org>
 <20191021082610.GC9379@dhcp22.suse.cz>
 <8ae0ba46-371b-9fed-0225-2c05bd3d6748@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae0ba46-371b-9fed-0225-2c05bd3d6748@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 10:28:16, David Hildenbrand wrote:
> On 21.10.19 10:26, Michal Hocko wrote:
> > Has this been properly reviewed? I do not see any Acks nor Reviewed-bys.
> > 
> 
> As I modified this patch while carrying it along, it at least has my
> implicit Ack/RB.

OK, thanks!
-- 
Michal Hocko
SUSE Labs
