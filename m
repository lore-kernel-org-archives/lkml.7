Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E1BC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36E821841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="bDHRQdKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfGBENs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 00:13:48 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:54194 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBENr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 00:13:47 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 7EC042DC009C;
        Tue,  2 Jul 2019 00:13:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1562040826;
        bh=gOEG661SveNiRUPN4YMnmMb923gb3S61Z9MG7QJfB3A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bDHRQdKUivQd0Z9H/c1TnPWau75xz43TVHbwOKn+JVuDU9sbeEYEAJnkGuZ16BW5Z
         tIpz0lRWdV0z7o4K4qAoePqu2rvAvVBoIMraIxyQkSw1JmxzVePCcJ2ovqgdsCN5FP
         f52/dPn/UgaFcen+hbl+zNyjof+c8ZXTdwvCnlrx6Z2IIjDVFEtl7pebobZiwXkHw2
         OgN6oBobxWQa4kpJCf9nNkao7jSSZLFj4dXaO0CRRjuD1PSSs/TTMt81tDo8mw4urZ
         azwP/bYvmBFXcn1cBpYK41rexObSU/csVCrygxEBCC4/qVa5QThohe1oVHDj1iOr9o
         M/3fNMusHv9He8Rm2xmjVcYmo10f3etlIXVh8Ny63kQ41DRKPOypMmC4f3BoVziny1
         mLhITM6P2L+/MTXJlDawc3qws6rCIn+Hh7lGvKEtF4kKm7OefNrxDEqZicDD0J/h0g
         ywonyQE7d9Pw4fCJmmDTqEloUDNpAdBMxq6KtbvekBfoRQNTGVsd25+b9YebxlxWcN
         G+vtLZ7mh8uhwU5USgEQLufzY7ujxc3u/Kv6jg/cu47fGAGjXg/mTkuFkHT4OTyDh9
         b6XZmUuh3k0cZDCj4tSdgV13oIxCWJRDnF28/3T9YcjkIN4yT/6rqMoj9ndpD7GNEY
         4DPLhPZw4sTeT1KYgYNvv9jY=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x624DPBD084759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Jul 2019 14:13:41 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <7f0ac9250e6fe6318aaf0685be56b121a978ce1b.camel@d-silva.org>
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 02 Jul 2019 14:13:25 +1000
In-Reply-To: <20190701104658.GA6549@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
         <20190626061124.16013-2-alastair@au1.ibm.com>
         <20190626062113.GF17798@dhcp22.suse.cz>
         <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
         <20190626065751.GK17798@dhcp22.suse.cz>
         <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
         <20190627080724.GK17798@dhcp22.suse.cz>
         <833b9675bc363342827cb8f7c76ebb911f7f960d.camel@d-silva.org>
         <20190701104658.GA6549@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Tue, 02 Jul 2019 14:13:42 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-01 at 12:46 +0200, Michal Hocko wrote:
> On Fri 28-06-19 10:46:28, Alastair D'Silva wrote:
> [...]
> > Given that there is already a VM_BUG_ON in the code, how do you
> > feel
> > about broadening the scope from 'VM_BUG_ON(!root)' to
> > 'VM_BUG_ON(!root
> > > > (root_nr == NR_SECTION_ROOTS))'?
> 
> As far as I understand the existing VM_BUG_ON will hit when the
> mem_section tree gets corrupted. This is a different situation to an
> incorrect section given so I wouldn't really mix those two. And I
> still
> do not see much point to protect from unexpected input parameter as
> this
> is internal function as already pointed out.
> 

Hi Michael,

I was able to hit this problem as the system firmware had assigned the
prototype pmem device an address range above the 128TB limit that we
originally supported. This has since been lifted to 2PB with patch
4ffe713b7587b14695c9bec26a000fc88ef54895.

As it stands, we cannot move this range lower as the high bits are
dictated by the location the card is connected.

Since the physical address of the memory is not controlled by the
kernel, I believe we should catch (or at least make it easy to debug)
the sitution where external firmware allocates physical addresses
beyond that which the kernel supports.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


