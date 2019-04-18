Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3B7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B683C2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbfDRMp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:45:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfDRMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:45:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83FA681129;
        Thu, 18 Apr 2019 12:45:25 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CC6519C65;
        Thu, 18 Apr 2019 12:45:11 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        osalvador@suse.de
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org>
        <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com>
        <CAPcyv4iW=xhhUQbg0bt=xCgVaR_jUvATeLxSoCfvzG5gTEAX6A@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 18 Apr 2019 08:45:10 -0400
In-Reply-To: <CAPcyv4iW=xhhUQbg0bt=xCgVaR_jUvATeLxSoCfvzG5gTEAX6A@mail.gmail.com>
        (Dan Williams's message of "Wed, 17 Apr 2019 19:09:12 -0700")
Message-ID: <x49lg07eb3d.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 18 Apr 2019 12:45:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

>> On Wed, Apr 17, 2019 at 3:59 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Wed, Apr 17, 2019 at 3:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> >
>> > On Wed, 17 Apr 2019 11:38:55 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>> >
>> > > The memory hotplug section is an arbitrary / convenient unit for memory
>> > > hotplug. 'Section-size' units have bled into the user interface
>> > > ('memblock' sysfs) and can not be changed without breaking existing
>> > > userspace. The section-size constraint, while mostly benign for typical
>> > > memory hotplug, has and continues to wreak havoc with 'device-memory'
>> > > use cases, persistent memory (pmem) in particular. Recall that pmem uses
>> > > devm_memremap_pages(), and subsequently arch_add_memory(), to allocate a
>> > > 'struct page' memmap for pmem. However, it does not use the 'bottom
>> > > half' of memory hotplug, i.e. never marks pmem pages online and never
>> > > exposes the userspace memblock interface for pmem. This leaves an
>> > > opening to redress the section-size constraint.
>> >
>> > v6 and we're not showing any review activity.  Who would be suitable
>> > people to help out here?
>>
>> There was quite a bit of review of the cover letter from Michal and
>> David, but you're right the details not so much as of yet. I'd like to
>> call out other people where I can reciprocate with some review of my
>> own. Oscar's altmap work looks like a good candidate for that.
>
> I'm also hoping Jeff can give a tested-by for the customer scenarios
> that fall over with the current implementation.

Sure.  I'll also have a look over the patches.

-Jeff
