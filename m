Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B47C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90D420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfCKSOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:14:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40026 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfCKSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:14:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ECD2F14C61512;
        Mon, 11 Mar 2019 11:14:13 -0700 (PDT)
Date:   Mon, 11 Mar 2019 11:14:13 -0700 (PDT)
Message-Id: <20190311.111413.1140896328197448401.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, hch@infradead.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311095405-mutt-send-email-mst@kernel.org>
References: <20190308141220.GA21082@infradead.org>
        <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
        <20190311095405-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 11:14:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 11 Mar 2019 09:59:28 -0400

> On Mon, Mar 11, 2019 at 03:13:17PM +0800, Jason Wang wrote:
>> 
>> On 2019/3/8 下午10:12, Christoph Hellwig wrote:
>> > On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
>> > > This series tries to access virtqueue metadata through kernel virtual
>> > > address instead of copy_user() friends since they had too much
>> > > overheads like checks, spec barriers or even hardware feature
>> > > toggling. This is done through setup kernel address through vmap() and
>> > > resigter MMU notifier for invalidation.
>> > > 
>> > > Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
>> > > obvious improvement.
>> > How is this going to work for CPUs with virtually tagged caches?
>> 
>> 
>> Anything different that you worry?
> 
> If caches have virtual tags then kernel and userspace view of memory
> might not be automatically in sync if they access memory
> through different virtual addresses. You need to do things like
> flush_cache_page, probably multiple times.

"flush_dcache_page()"
