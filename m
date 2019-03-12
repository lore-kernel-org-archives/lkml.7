Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC75C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D8320643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCLC4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:56:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfCLC4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 928DE88313;
        Tue, 12 Mar 2019 02:56:30 +0000 (UTC)
Received: from [10.72.12.17] (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A380460C4C;
        Tue, 12 Mar 2019 02:56:22 +0000 (UTC)
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
To:     Andrea Arcangeli <aarcange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191622.GP23850@redhat.com>
 <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
 <20190308194845.GC26923@redhat.com>
 <8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
 <20190311084525-mutt-send-email-mst@kernel.org>
 <20190311134305.GC23321@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4979eed5-9e3f-5ee0-f4f4-1a5e2a839b21@redhat.com>
Date:   Tue, 12 Mar 2019 10:56:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311134305.GC23321@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 12 Mar 2019 02:56:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/11 下午9:43, Andrea Arcangeli wrote:
> On Mon, Mar 11, 2019 at 08:48:37AM -0400, Michael S. Tsirkin wrote:
>> Using copyXuser is better I guess.
> It certainly would be faster there, but I don't think it's needed if
> that would be the only use case left that justifies supporting two
> different models. On small 32bit systems with little RAM kmap won't
> perform measurably different on 32bit or 64bit systems. If the 32bit
> host has a lot of ram it all gets slow anyway at accessing RAM above
> the direct mapping, if compared to 64bit host kernels, it's not just
> an issue for vhost + mmu notifier + kmap and the best way to optimize
> things is to run 64bit host kernels.
>
> Like Christoph pointed out, the main use case for retaining the
> copy-user model would be CPUs with virtually indexed not physically
> tagged data caches (they'll still suffer from the spectre-v1 fix,
> although I exclude they have to suffer the SMAP
> slowdown/feature). Those may require some additional flushing than the
> current copy-user model requires.
>
> As a rule of thumb any arch where copy_user_page doesn't define as
> copy_page will require some additional cache flushing after the
> kmap. Supposedly with vmap, the vmap layer should have taken care of
> that (I didn't verify that yet).


vmap_page_range()/free_unmap_vmap_area() will call 
fluch_cache_vmap()/flush_cache_vunmap(). So vmap layer should be ok.

Thanks


>
> There are some accessories like copy_to_user_page()
> copy_from_user_page() that could work and obviously defines to raw
> memcpy on x86 (the main cons is they don't provide word granular
> access) and at least on sparc they're tailored to ptrace assumptions
> so then we'd need to evaluate what happens if this is used outside of
> ptrace context. kmap has been used generally either to access whole
> pages (i.e. copy_user_page), so ptrace may actually be the only use
> case with subpage granularity access.
>
> #define copy_to_user_page(vma, page, vaddr, dst, src, len)		\
> 	do {								\
> 		flush_cache_page(vma, vaddr, page_to_pfn(page));	\
> 		memcpy(dst, src, len);					\
> 		flush_ptrace_access(vma, page, vaddr, src, len, 0);	\
> 	} while (0)
>
> So I wouldn't rule out the need for a dual model, until we solve how
> to run this stable on non-x86 arches with not physically tagged
> caches.
>
> Thanks,
> Andrea
