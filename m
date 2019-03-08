Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86022085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfCHM4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:56:15 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44412 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfCHM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:56:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id d2so20993787qti.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A+ONulh89ZRd0TBrQbX2xsE4uKRIImlni/lkNnnezk4=;
        b=SFCssSluseXuKt5XHxkpoGHXvE9oYrXo+49YrlgkQgVpWjj+OGe+EXOy+/w4WmyOcM
         RBYApM1qft4QCaUcweoANwIz7MOYsqrYRcKHH+eisOzrS/wkEepHGfOYaE6mIRqoz10t
         xgHwjhaVZA5zKwshUCVS/jQo9D5OhtLow4UyXMXL8eqR4y1GJAbPLpvmx8S7IrNWjuWI
         qg2TymzPkTn7S5WwiHoPrmyexmrtwSAHlM62XHeTYpq9fQ98mM63ngDpDaJI2Pf5nLmR
         nYcjgBTZSJkhJ1Yz+EJK7NdMCPVuZIXfPoX+/UpEF4fxqKKCeRf3wlo2qj7LFXHmLrqX
         8g+w==
X-Gm-Message-State: APjAAAVWMEz4krq+Y4rYW92uZKLCTyilDdjgqXQhVUVhHg8JLIel8glp
        RFb00lMq/9HdC38mnmiUQNvx1A==
X-Google-Smtp-Source: APXvYqzpMhMBKy1jpKKr6R0JL9ZfZz/BygDitVhs5ihNJGMR5qa+oBECnJQrUvrvVc+PbC/lY2Xgtw==
X-Received: by 2002:a0c:927a:: with SMTP id 55mr14838918qvz.226.1552049768331;
        Fri, 08 Mar 2019 04:56:08 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id j9sm2940101qki.21.2019.03.08.04.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 04:56:07 -0800 (PST)
Date:   Fri, 8 Mar 2019 07:56:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190308075506-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191720.GF3835@redhat.com>
 <43408100-84d9-a359-3e78-dc65fb7b0ad1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43408100-84d9-a359-3e78-dc65fb7b0ad1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 04:58:44PM +0800, Jason Wang wrote:
> 
> On 2019/3/8 上午3:17, Jerome Glisse wrote:
> > On Thu, Mar 07, 2019 at 12:56:45PM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Mar 07, 2019 at 10:47:22AM -0500, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> > > > > +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
> > > > > +	.invalidate_range = vhost_invalidate_range,
> > > > > +};
> > > > > +
> > > > >   void vhost_dev_init(struct vhost_dev *dev,
> > > > >   		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> > > > >   {
> > > > I also wonder here: when page is write protected then
> > > > it does not look like .invalidate_range is invoked.
> > > > 
> > > > E.g. mm/ksm.c calls
> > > > 
> > > > mmu_notifier_invalidate_range_start and
> > > > mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.
> > > > 
> > > > Similarly, rmap in page_mkclean_one will not call
> > > > mmu_notifier_invalidate_range.
> > > > 
> > > > If I'm right vhost won't get notified when page is write-protected since you
> > > > didn't install start/end notifiers. Note that end notifier can be called
> > > > with page locked, so it's not as straight-forward as just adding a call.
> > > > Writing into a write-protected page isn't a good idea.
> > > > 
> > > > Note that documentation says:
> > > > 	it is fine to delay the mmu_notifier_invalidate_range
> > > > 	call to mmu_notifier_invalidate_range_end() outside the page table lock.
> > > > implying it's called just later.
> > > OK I missed the fact that _end actually calls
> > > mmu_notifier_invalidate_range internally. So that part is fine but the
> > > fact that you are trying to take page lock under VQ mutex and take same
> > > mutex within notifier probably means it's broken for ksm and rmap at
> > > least since these call invalidate with lock taken.
> > > 
> > > And generally, Andrea told me offline one can not take mutex under
> > > the notifier callback. I CC'd Andrea for why.
> > Correct, you _can not_ take mutex or any sleeping lock from within the
> > invalidate_range callback as those callback happens under the page table
> > spinlock. You can however do so under the invalidate_range_start call-
> > back only if it is a blocking allow callback (there is a flag passdown
> > with the invalidate_range_start callback if you are not allow to block
> > then return EBUSY and the invalidation will be aborted).
> > 
> > 
> > > That's a separate issue from set_page_dirty when memory is file backed.
> > If you can access file back page then i suggest using set_page_dirty
> > from within a special version of vunmap() so that when you vunmap you
> > set the page dirty without taking page lock. It is safe to do so
> > always from within an mmu notifier callback if you had the page map
> > with write permission which means that the page had write permission
> > in the userspace pte too and thus it having dirty pte is expected
> > and calling set_page_dirty on the page is allowed without any lock.
> > Locking will happen once the userspace pte are tear down through the
> > page table lock.
> 
> 
> Can I simply can set_page_dirty() before vunmap() in the mmu notifier
> callback, or is there any reason that it must be called within vumap()?
> 
> Thanks


I think this is what Jerome is saying, yes.
Maybe add a patch to mmu notifier doc file, documenting this?


> 
> > 
> > > It's because of all these issues that I preferred just accessing
> > > userspace memory and handling faults. Unfortunately there does not
> > > appear to exist an API that whitelists a specific driver along the lines
> > > of "I checked this code for speculative info leaks, don't add barriers
> > > on data path please".
> > Maybe it would be better to explore adding such helper then remapping
> > page into kernel address space ?
> > 
> > Cheers,
> > Jérôme
