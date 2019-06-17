Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195ECC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E330121E6C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="fpSn1Xtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfFQIAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:00:05 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:47010 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfFQIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:00:05 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 7DD8E2DC0032;
        Mon, 17 Jun 2019 04:00:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1560758404;
        bh=5QkXNKOOo0s2HTA34p3+KiFaxnv3E6XBHbEwuPKBFG0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=fpSn1XtkYo6WrcCUGmOHOdZNywi1QvmzZY4+xl5VCZcWBCS6cuFJZ4Bg2jHTm2zY8
         aYj0YNe/GRufQBNqq5+D7BZJoH7Dn8clBz8eWh+9DhApm6D2taMEl1kfnO2F6+Wwzb
         W/+P5ndUYX5vLbVjdyP/q4c9p8ZDU/KgUYY2gWgVt67XpYFuY/1smVdKIiqeVeDgUY
         IMScq2G8iC8m3NQohxE0YI6tBs4TWuMudkSBjYzWLTSC87fTJvMfpwG+q9IMGNH5mD
         RnVpWZi4IaX8NK6tE9+QSrU4P/kSXip/FRVYnW1+AJI3BwkbUp/NcXjaPLwWhKHsol
         FxRQytR6bvv3iqTI+YFo7MYLtaJKh+WxmAU8njIhyNQx79yOWxYve4SwKeNQp50dHu
         RxEim3BmKhIKnR2H4sLXR0ViD6QCTWOZdbrCXzx4MUJj28vB90o6g68qZ+X5iBAMpR
         mfAG+vFEnT6PnOIFxsOcp0U29z01riqSThlWBY5r9dZ8PSrP/9EBD5QuVH7KTn7am6
         bkB1UUJzPncn528VAjWChGL3S00VbOCyChWhvdfQYd9EvR2H1LSd3hJS2fhgjPjAel
         GGjg9VwpTKbymgxG0K3NPax7j8K+tzKTYxHeuow6IFIG1vVdoXuMbECzFWtF7/Juz8
         uTnUA0b1u27vtiMZkiQy2/TY=
Received: from Hawking (ntp.lan [10.0.1.1])
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5H800Al057250
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 18:00:00 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     "'Christoph Hellwig'" <hch@infradead.org>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'David Hildenbrand'" <david@redhat.com>,
        "'Oscar Salvador'" <osalvador@suse.com>,
        "'Michal Hocko'" <mhocko@suse.com>,
        "'Pavel Tatashin'" <pasha.tatashin@soleen.com>,
        "'Wei Yang'" <richard.weiyang@gmail.com>,
        "'Arun KS'" <arunks@codeaurora.org>, "'Qian Cai'" <cai@lca.pw>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Ingo Molnar'" <mingo@kernel.org>,
        "'Josh Poimboeuf'" <jpoimboe@redhat.com>,
        "'Jiri Kosina'" <jkosina@suse.cz>,
        "'Mukesh Ojha'" <mojha@codeaurora.org>,
        "'Mike Rapoport'" <rppt@linux.vnet.ibm.com>,
        "'Baoquan He'" <bhe@redhat.com>,
        "'Logan Gunthorpe'" <logang@deltatee.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>
References: <20190617043635.13201-1-alastair@au1.ibm.com> <20190617043635.13201-6-alastair@au1.ibm.com> <20190617065921.GV3436@hirez.programming.kicks-ass.net> <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org> <20190617071527.GA14003@infradead.org>
In-Reply-To: <20190617071527.GA14003@infradead.org>
Subject: RE: [PATCH 5/5] mm/hotplug: export try_online_node
Date:   Mon, 17 Jun 2019 18:00:00 +1000
Message-ID: <068d01d524e2$aa6f3000$ff4d9000$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKozGZqZYmaEl7M6DfiQR95qivs4QHbD3aSAzdXr9kBRRd62QEU+eDhpLzIGCA=
Content-Language: en-au
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Mon, 17 Jun 2019 18:00:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Monday, 17 June 2019 5:15 PM
> To: Alastair D'Silva <alastair@d-silva.org>
> Cc: Peter Zijlstra <peterz@infradead.org>; Andrew Morton <akpm@linux-
> foundation.org>; David Hildenbrand <david@redhat.com>; Oscar Salvador
> <osalvador@suse.com>; Michal Hocko <mhocko@suse.com>; Pavel Tatashin
> <pasha.tatashin@soleen.com>; Wei Yang <richard.weiyang@gmail.com>;
> Arun KS <arunks@codeaurora.org>; Qian Cai <cai@lca.pw>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@kernel.org>; Josh Poimboeuf
> <jpoimboe@redhat.com>; Jiri Kosina <jkosina@suse.cz>; Mukesh Ojha
> <mojha@codeaurora.org>; Mike Rapoport <rppt@linux.vnet.ibm.com>;
> Baoquan He <bhe@redhat.com>; Logan Gunthorpe
> <logang@deltatee.com>; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; linux-nvdimm@lists.01.org
> Subject: Re: [PATCH 5/5] mm/hotplug: export try_online_node
> 
> On Mon, Jun 17, 2019 at 05:05:30PM +1000, Alastair D'Silva wrote:
> > On Mon, 2019-06-17 at 08:59 +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 17, 2019 at 02:36:31PM +1000, Alastair D'Silva wrote:
> > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > >
> > > > If an external driver module supplies physical memory and needs to
> > > > expose
> > >
> > > Why would you ever want to allow a module to do such a thing?
> > >
> >
> > I'm working on a driver for Storage Class Memory, connected via an
> > OpenCAPI link.
> >
> > The memory is only usable once the card says it's OK to access it.
> 
> And all that should go through our pmem APIs, not not directly poke into
mm
> internals.  And if you still need core patches send them along with the
actual
> driver.

I tried that, but I was getting crashes as the NUMA data structures for that
node were not initialised.

Calling this was required to prevent uninitialized accesses in the pmem
library.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece



