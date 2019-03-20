Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B40AC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A592183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oAlFYEHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCTBns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:43:48 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17729 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCTBns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:43:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c919ad10000>; Tue, 19 Mar 2019 18:43:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 Mar 2019 18:43:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 Mar 2019 18:43:45 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Mar
 2019 01:43:45 +0000
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Jerome Glisse <jglisse@redhat.com>,
        Dave Chinner <david@fromorbit.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com> <20190319141416.GA3879@redhat.com>
 <20190319212346.GA26298@dastard> <20190319220654.GC3096@redhat.com>
 <20190319235752.GB26298@dastard> <20190320000838.GA6364@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c854b2d6-5ec1-a8b5-e366-fbefdd9fdd10@nvidia.com>
Date:   Tue, 19 Mar 2019 18:43:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320000838.GA6364@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553046225; bh=VRts5Z1q6LA0/LXpkFz/+wZpaipDQFw/BhjEOL43QS0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oAlFYEHAJG3/FiIL3lz9zuWHb6J6kuhK7PZEYRupzKt3tHOkndh7nF6m49+WvCm5y
         x5J6pl/tx7hcezmlW+sgwKtV8XKzMSUUb+gNmW/yRSon6T/ad/lW9Owis8pJPPfJ1H
         dNT9P9t/j4CVJuWJCgajYBa9lIgoM+y818B5+Xpk8HcVXQefdppJJf3KqQ6u3DIzaK
         uFOZTNcdbS9F2lujFOkxNarsT/wOMp38SMHZOmafZi5+jfLqGSJJIajVj/V97lXaqB
         yW3ZMbS5OPeLbbLSjCQNYmJzyDpI60sWwqrCCHtfJvhJ6RoNXn6xIYEYKtvZ4Jhpw6
         4l3vEQ0D1pSCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 5:08 PM, Jerome Glisse wrote:
> On Wed, Mar 20, 2019 at 10:57:52AM +1100, Dave Chinner wrote:
>> On Tue, Mar 19, 2019 at 06:06:55PM -0400, Jerome Glisse wrote:
>>> On Wed, Mar 20, 2019 at 08:23:46AM +1100, Dave Chinner wrote:
>>>> On Tue, Mar 19, 2019 at 10:14:16AM -0400, Jerome Glisse wrote:
>>>>> On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
>>>>>> On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
>>>>>>> On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wr=
ote:
>>>>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>>>>> [...]
>>>>> Forgot to mention one thing, we had a discussion with Andrea and Jan
>>>>> about set_page_dirty() and Andrea had the good idea of maybe doing
>>>>> the set_page_dirty() at GUP time (when GUP with write) not when the
>>>>> GUP user calls put_page(). We can do that by setting the dirty bit
>>>>> in the pte for instance. They are few bonus of doing things that way:
>>>>>     - amortize the cost of calling set_page_dirty() (ie one call for
>>>>>       GUP and page_mkclean()
>>>>>     - it is always safe to do so at GUP time (ie the pte has write
>>>>>       permission and thus the page is in correct state)
>>>>>     - safe from truncate race
>>>>>     - no need to ever lock the page
>>>>
>>>> I seem to have missed this conversation, so please excuse me for
>>>
>>> The set_page_dirty() at GUP was in a private discussion (it started
>>> on another topic and drifted away to set_page_dirty()).
>>>
>>>> asking a stupid question: if it's a file backed page, what prevents
>>>> background writeback from cleaning the dirty page ~30s into a long
>>>> term pin? i.e. I don't see anything in this proposal that prevents
>>>> the page from being cleaned by writeback and putting us straight
>>>> back into the situation where a long term RDMA is writing to a clean
>>>> page....
>>>
>>> So this patchset does not solve this issue.
>>
>> OK, so it just kicks the can further down the road.
>>
>>>     [3..N] decide what to do for GUPed page, so far the plans seems
>>>          to be to keep the page always dirty and never allow page
>>>          write back to restore the page in a clean state. This does
>>>          disable thing like COW and other fs feature but at least
>>>          it seems to be the best thing we can do.
>>
>> So the plan for GUP vs writeback so far is "break fsync()"? :)
>>
>> We might need to work on that a bit more...
>=20
> Sorry forgot to say that we still do write back using a bounce page
> so that at least we write something to disk that is just a snapshot
> of the GUPed page everytime writeback kicks in (so either through
> radix tree dirty page write back or fsync or any other sync events).
> So many little details that i forgot the big chunk :)
>=20
> Cheers,
> J=C3=A9r=C3=B4me
>=20

Dave, Jan, Jerome,

Bounce pages for periodic data integrity still seem viable. But for the
question of things like fsync or truncate, I think we were zeroing in
on file leases as a nice building block.

Can we revive the file lease discussion? By going all the way out to user
space and requiring file leases to be coordinated at a high level in the
software call chain, it seems like we could routinely avoid some of the
worst conflicts that the kernel code has to resolve.

For example:

Process A
=3D=3D=3D=3D=3D=3D=3D=3D=3D
    gets a lease on file_a that allows gup=20
        usage on a range within file_a

    sets up writable DMA:
        get_user_pages() on the file_a range
        start DMA (independent hardware ops)
            hw is reading and writing to range

                                                    Process B
                                                    =3D=3D=3D=3D=3D=3D=3D=
=3D=3D
                                                    truncate(file_a)
                                                       ...
                                                       __break_lease()
   =20
    handle SIGIO from __break_lease
         if unhandled, process gets killed
         and put_user_pages should get called
         at some point here

...and so this way, user space gets to decide the proper behavior,
instead of leaving the kernel in the dark with an impossible decision
(kill process A? Block process B? User space knows the preference,
per app, but kernel does not.)
       =20

thanks,
--=20
John Hubbard
NVIDIA
