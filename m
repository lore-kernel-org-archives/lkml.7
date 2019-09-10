Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6BC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F9E21479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568138431;
	bh=zol/Jw0oSCFl4O2QYN4xe8B2UqECSwFKVlUV7QcKGF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rbBS/kRrtL0U+pogCETxAosZtcyvY8O28sXMDAXnTc7M7jeLaczKlf4Kq0BAJh7mu
	 LJDMhwvmlR0GBeuX0mfj2SRObdFpZEL4TUBzBYP/dRxm0D2fhs0W3BL9u+55GxT3Sd
	 Z9xeaOegC0olKNLjfZyV4CY2JeV++i1tPiptmPKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfIJSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:00:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfIJSAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:00:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FCC7AF8D;
        Tue, 10 Sep 2019 18:00:28 +0000 (UTC)
Date:   Tue, 10 Sep 2019 20:00:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oscar Salvador <osalvador@suse.de>,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v9 0/8] stg mail -e --version=v9 \
Message-ID: <20190910180026.GE4023@dhcp22.suse.cz>
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190910124209.GY2063@dhcp22.suse.cz>
 <CAKgT0Udr6nYQFTRzxLbXk41SiJ-pcT_bmN1j1YR4deCwdTOaUQ@mail.gmail.com>
 <20190910144713.GF2063@dhcp22.suse.cz>
 <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
 <20190910175213.GD4023@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910175213.GD4023@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 19:52:13, Michal Hocko wrote:
> On Tue 10-09-19 09:05:43, Alexander Duyck wrote:
[...]
> > All this is providing is just a report and it is optional if the
> > hypervisor will act on it or not. If the hypervisor takes some sort of
> > action on the page, then the expectation is that the hypervisor will
> > use some sort of mechanism such as a page fault to discover when the
> > page is used again.
> 
> OK so the baloon driver is in charge of this metadata and the allocator
> has to live with that. Isn't that a layer violation?

Another thing that is not clear to me is how these marked pages are
different from any other free pages. All of them are unused and you are
losing your metadata as soon as the page gets allocated because the page
changes its owner and the struct page belongs to it.
-- 
Michal Hocko
SUSE Labs
