Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA4DC31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7417E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfFQOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:50:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfFQOuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:50:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B7B3AEF1;
        Mon, 17 Jun 2019 14:50:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Jun 2019 16:50:17 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: mm/vmalloc: uninitialized variable access in
 pcpu_get_vm_areas
In-Reply-To: <CAK8P3a3sjuyeQBUprGFGCXUSDAJN_+c+2z=pCR5J05rByBVByQ@mail.gmail.com>
References: <20190617121427.77565-1-arnd@arndb.de>
 <20190617141244.5x22nrylw7hodafp@pc636>
 <CAK8P3a3sjuyeQBUprGFGCXUSDAJN_+c+2z=pCR5J05rByBVByQ@mail.gmail.com>
Message-ID: <fb05c3956eba18a8b01e8a8fa0396c7b@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-17 16:44, Arnd Bergmann wrote:
> On Mon, Jun 17, 2019 at 4:12 PM Uladzislau Rezki <urezki@gmail.com> 
> wrote:
>> 
>> On Mon, Jun 17, 2019 at 02:14:11PM +0200, Arnd Bergmann wrote:
>> > gcc points out some obviously broken code in linux-next
>> >
>> > mm/vmalloc.c: In function 'pcpu_get_vm_areas':
>> > mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> >     insert_vmap_area_augment(lva, &va->rb_node,
>> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >      &free_vmap_area_root, &free_vmap_area_list);
>> >      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > mm/vmalloc.c:916:20: note: 'lva' was declared here
>> >   struct vmap_area *lva;
>> >                     ^~~
>> >
>> > Remove the obviously broken code. This is almost certainly
>> > not the correct solution, but it's what I have applied locally
>> > to get a clean build again.
>> >
>> > Please fix this properly.
>> >
> 
>> >
>> Please do not apply this. It will just break everything.
> 
> As I wrote in my description, this was purely meant as a bug
> report, not a patch to be applied.

That's a perfect way to attract attention! :)

> 
>> As Roman pointed we can just set lva = NULL; in the beginning to make 
>> GCC happy.
>> For some reason GCC decides that it can be used uninitialized, but 
>> that
>> is not true.
> 
> I got confused by the similarly named FL_FIT_TYPE/NE_FIT_TYPE

Names are indeed very confusing, that is true.  Very easy to mix up 
things.

--
Roman

