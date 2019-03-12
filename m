Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D788BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A448D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xYRhAyEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfCLFOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:14:48 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59170 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbfCLFOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:14:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 13D308EE14F;
        Mon, 11 Mar 2019 22:14:47 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7WtYXw-QTR3T; Mon, 11 Mar 2019 22:14:46 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3BBB58EE130;
        Mon, 11 Mar 2019 22:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552367686;
        bh=AW3dolA78+lzEd83tz6QQ+NipDZU+vh1dNrlssMHnVU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xYRhAyEtbC9eyaeABxwkOllNzY+9kjpj9FhbZaQeAldW3lO5vxwuVmjyIp3KNFqBG
         LD4cAqF1Nc+zpH6hIwFgFhhJvaNSxmq46EBcnVR1m2djSf239RlCYCBinxR2v67gmY
         JHvGMLPDK4DrxvhtR46iCuydqs9rTvtKEn+Y8lKk=
Message-ID: <1552367685.23859.22.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, mst@redhat.com
Cc:     hch@infradead.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Date:   Mon, 11 Mar 2019 22:14:45 -0700
In-Reply-To: <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
References: <20190308141220.GA21082@infradead.org>
         <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
         <20190311095405-mutt-send-email-mst@kernel.org>
         <20190311.111413.1140896328197448401.davem@davemloft.net>
         <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 10:59 +0800, Jason Wang wrote:
> On 2019/3/12 上午2:14, David Miller wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> > Date: Mon, 11 Mar 2019 09:59:28 -0400
> > 
> > > On Mon, Mar 11, 2019 at 03:13:17PM +0800, Jason Wang wrote:
> > > > On 2019/3/8 下午10:12, Christoph Hellwig wrote:
> > > > > On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
> > > > > > This series tries to access virtqueue metadata through
> > > > > > kernel virtual
> > > > > > address instead of copy_user() friends since they had too
> > > > > > much
> > > > > > overheads like checks, spec barriers or even hardware
> > > > > > feature
> > > > > > toggling. This is done through setup kernel address through
> > > > > > vmap() and
> > > > > > resigter MMU notifier for invalidation.
> > > > > > 
> > > > > > Test shows about 24% improvement on TX PPS. TCP_STREAM
> > > > > > doesn't see
> > > > > > obvious improvement.
> > > > > 
> > > > > How is this going to work for CPUs with virtually tagged
> > > > > caches?
> > > > 
> > > > Anything different that you worry?
> > > 
> > > If caches have virtual tags then kernel and userspace view of
> > > memory
> > > might not be automatically in sync if they access memory
> > > through different virtual addresses. You need to do things like
> > > flush_cache_page, probably multiple times.
> > 
> > "flush_dcache_page()"
> 
> 
> I get this. Then I think the current set_bit_to_user() is suspicious,
> we 
> probably miss a flush_dcache_page() there:
> 
> 
> static int set_bit_to_user(int nr, void __user *addr)
> {
>          unsigned long log = (unsigned long)addr;
>          struct page *page;
>          void *base;
>          int bit = nr + (log % PAGE_SIZE) * 8;
>          int r;
> 
>          r = get_user_pages_fast(log, 1, 1, &page);
>          if (r < 0)
>                  return r;
>          BUG_ON(r != 1);
>          base = kmap_atomic(page);
>          set_bit(bit, base);
>          kunmap_atomic(base);

This sequence should be OK.  get_user_pages() contains a flush which
clears the cache above the user virtual address, so on kmap, the page
is coherent at the new alias.  On parisc at least, kunmap embodies a
flush_dcache_page() which pushes any changes in the cache above the
kernel virtual address back to main memory and makes it coherent again
for the user alias to pick it up.

James

