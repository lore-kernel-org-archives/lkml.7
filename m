Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9155FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1792087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCLDva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:51:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34387 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCLDv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:51:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id x20so1124807qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q5OtFmBn4kunq3TRH7QETyZ6fOkGOBD8DRouuexq1Q0=;
        b=DlXKBYDN4M+yxGxoxlbUQDEzy2HCI27SsF6HHQ6LYMbM5ek0CjD97YMpME2qyPVPz4
         SebGR12DAD2adfpSowLrR4Ur8Pf/0hCgD5TguH1ThXqOfq0kpDNYheDr5TVyI4sLe6gF
         GX6EJIM36KpbzZhwhYeNU/nx/P3fuGo6jaiESTT92C2Sf+mJdlDJwJ3PaxvB9qjyZxFa
         3EZ1Ug/9J046bS6TBIUv6gpt6ACeYvoEhWfEIZ9jMVHs1P5dMjIR03pPvCPodH4bICHn
         oHbdLeKt6wCb/9XJelUptdRjKw/lIz7oSXCnVnGp2on8zlOU6ZBNOGHoWgiXzH6C0jWI
         HkIw==
X-Gm-Message-State: APjAAAXO6RG+VZ3ZjTegcC+vomzMm8GseY99K0ScbgRPLmEEu0a6Yher
        g08wZNFSJ+RO51ZsPd1g87Htcg==
X-Google-Smtp-Source: APXvYqxm42I862OWQ7Skwz8qnWa/npKwc8mf8yAY+hqDoxpxxcCijWFoKhk0VDEIQ+MmxQonZIJ2AQ==
X-Received: by 2002:aed:3f81:: with SMTP id s1mr26463323qth.94.1552362688407;
        Mon, 11 Mar 2019 20:51:28 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id j139sm4250733qke.26.2019.03.11.20.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 20:51:27 -0700 (PDT)
Date:   Mon, 11 Mar 2019 23:51:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190311235100-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191622.GP23850@redhat.com>
 <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
 <20190308194845.GC26923@redhat.com>
 <8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
 <20190311084525-mutt-send-email-mst@kernel.org>
 <20190311134305.GC23321@redhat.com>
 <4979eed5-9e3f-5ee0-f4f4-1a5e2a839b21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4979eed5-9e3f-5ee0-f4f4-1a5e2a839b21@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:56:20AM +0800, Jason Wang wrote:
> 
> On 2019/3/11 下午9:43, Andrea Arcangeli wrote:
> > On Mon, Mar 11, 2019 at 08:48:37AM -0400, Michael S. Tsirkin wrote:
> > > Using copyXuser is better I guess.
> > It certainly would be faster there, but I don't think it's needed if
> > that would be the only use case left that justifies supporting two
> > different models. On small 32bit systems with little RAM kmap won't
> > perform measurably different on 32bit or 64bit systems. If the 32bit
> > host has a lot of ram it all gets slow anyway at accessing RAM above
> > the direct mapping, if compared to 64bit host kernels, it's not just
> > an issue for vhost + mmu notifier + kmap and the best way to optimize
> > things is to run 64bit host kernels.
> > 
> > Like Christoph pointed out, the main use case for retaining the
> > copy-user model would be CPUs with virtually indexed not physically
> > tagged data caches (they'll still suffer from the spectre-v1 fix,
> > although I exclude they have to suffer the SMAP
> > slowdown/feature). Those may require some additional flushing than the
> > current copy-user model requires.
> > 
> > As a rule of thumb any arch where copy_user_page doesn't define as
> > copy_page will require some additional cache flushing after the
> > kmap. Supposedly with vmap, the vmap layer should have taken care of
> > that (I didn't verify that yet).
> 
> 
> vmap_page_range()/free_unmap_vmap_area() will call
> fluch_cache_vmap()/flush_cache_vunmap(). So vmap layer should be ok.
> 
> Thanks

You only unmap from mmu notifier though.
You don't do it after any access.

> 
> > 
> > There are some accessories like copy_to_user_page()
> > copy_from_user_page() that could work and obviously defines to raw
> > memcpy on x86 (the main cons is they don't provide word granular
> > access) and at least on sparc they're tailored to ptrace assumptions
> > so then we'd need to evaluate what happens if this is used outside of
> > ptrace context. kmap has been used generally either to access whole
> > pages (i.e. copy_user_page), so ptrace may actually be the only use
> > case with subpage granularity access.
> > 
> > #define copy_to_user_page(vma, page, vaddr, dst, src, len)		\
> > 	do {								\
> > 		flush_cache_page(vma, vaddr, page_to_pfn(page));	\
> > 		memcpy(dst, src, len);					\
> > 		flush_ptrace_access(vma, page, vaddr, src, len, 0);	\
> > 	} while (0)
> > 
> > So I wouldn't rule out the need for a dual model, until we solve how
> > to run this stable on non-x86 arches with not physically tagged
> > caches.
> > 
> > Thanks,
> > Andrea
