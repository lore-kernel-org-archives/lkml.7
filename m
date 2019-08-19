Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A11C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AEF214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfHSVId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbfHSVId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:08:33 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDE6A36899
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 21:08:32 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b1so5853576wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LPz289eUqMdVK44r3XmdrIn3iZGWOuftMF6bJgSrgXw=;
        b=EoAd64x8I+WglB04NrMbBiBnIIAvyeT+4LOcl1GUFfnnmmM7eIFEuHo1SA8dna8MmU
         nG6HjcU2CagLj36XlBHQ3Wv3pwYySFpF02qF2N3e1enihibDJmKLSx1YPGESFByqbrgc
         ot0YT8uKR92gpjVXHFW4eCc3MVnZuI/Fk9QHVxokcUzijZEclscRu9rUf7+k0NxYIRrg
         XWgCFYufxiIItuW/gydNeNHrf398npVJPWGykibb4zh9qFM1rjZRVAXDucXOsP470jeD
         DYR1ySNI+z0xt3Yx8uz7V7ZVHecOySuhN8/AiEdjjNhyv3KHZllSpk8fVfHoT5ePxjID
         QwIQ==
X-Gm-Message-State: APjAAAX7+8hW9POLr5X5DtnZja5lM5yd0C7T/QO4vUJmvsh5NCI6dFTn
        GZ2akd1ZSAwkaG51p0CqcNxsEh6x7aeBAao6IOjy9SE68fP0NIhyZamGIWsOwbT3K9R3Bld+aRv
        UN3Udvi9T84alHyPn78+DQpEN
X-Received: by 2002:a1c:1ac2:: with SMTP id a185mr22464975wma.96.1566248911492;
        Mon, 19 Aug 2019 14:08:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzkGtqGEh4bXvK+QUgFZWjgeN4BxKK01EdaQMhbc46GISjxsEbgjr0J/8MhISgz5u3RfrvFQ==
X-Received: by 2002:a1c:1ac2:: with SMTP id a185mr22464968wma.96.1566248911216;
        Mon, 19 Aug 2019 14:08:31 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id 74sm28893350wma.15.2019.08.19.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 14:08:30 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:08:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jgg@ziepe.ca
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Message-ID: <20190819162733-mutt-send-email-mst@kernel.org>
References: <20190809054851.20118-1-jasowang@redhat.com>
 <20190810134948-mutt-send-email-mst@kernel.org>
 <360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
 <20190812054429-mutt-send-email-mst@kernel.org>
 <663be71f-f96d-cfbc-95a0-da0ac6b82d9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <663be71f-f96d-cfbc-95a0-da0ac6b82d9f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 04:12:49PM +0800, Jason Wang wrote:
> 
> On 2019/8/12 下午5:49, Michael S. Tsirkin wrote:
> > On Mon, Aug 12, 2019 at 10:44:51AM +0800, Jason Wang wrote:
> > > On 2019/8/11 上午1:52, Michael S. Tsirkin wrote:
> > > > On Fri, Aug 09, 2019 at 01:48:42AM -0400, Jason Wang wrote:
> > > > > Hi all:
> > > > > 
> > > > > This series try to fix several issues introduced by meta data
> > > > > accelreation series. Please review.
> > > > > 
> > > > > Changes from V4:
> > > > > - switch to use spinlock synchronize MMU notifier with accessors
> > > > > 
> > > > > Changes from V3:
> > > > > - remove the unnecessary patch
> > > > > 
> > > > > Changes from V2:
> > > > > - use seqlck helper to synchronize MMU notifier with vhost worker
> > > > > 
> > > > > Changes from V1:
> > > > > - try not use RCU to syncrhonize MMU notifier with vhost worker
> > > > > - set dirty pages after no readers
> > > > > - return -EAGAIN only when we find the range is overlapped with
> > > > >     metadata
> > > > > 
> > > > > Jason Wang (9):
> > > > >     vhost: don't set uaddr for invalid address
> > > > >     vhost: validate MMU notifier registration
> > > > >     vhost: fix vhost map leak
> > > > >     vhost: reset invalidate_count in vhost_set_vring_num_addr()
> > > > >     vhost: mark dirty pages during map uninit
> > > > >     vhost: don't do synchronize_rcu() in vhost_uninit_vq_maps()
> > > > >     vhost: do not use RCU to synchronize MMU notifier with worker
> > > > >     vhost: correctly set dirty pages in MMU notifiers callback
> > > > >     vhost: do not return -EAGAIN for non blocking invalidation too early
> > > > > 
> > > > >    drivers/vhost/vhost.c | 202 +++++++++++++++++++++++++-----------------
> > > > >    drivers/vhost/vhost.h |   6 +-
> > > > >    2 files changed, 122 insertions(+), 86 deletions(-)
> > > > This generally looks more solid.
> > > > 
> > > > But this amounts to a significant overhaul of the code.
> > > > 
> > > > At this point how about we revert 7f466032dc9e5a61217f22ea34b2df932786bbfc
> > > > for this release, and then re-apply a corrected version
> > > > for the next one?
> > > 
> > > If possible, consider we've actually disabled the feature. How about just
> > > queued those patches for next release?
> > > 
> > > Thanks
> > Sorry if I was unclear. My idea is that
> > 1. I revert the disabled code
> > 2. You send a patch readding it with all the fixes squashed
> > 3. Maybe optimizations on top right away?
> > 4. We queue *that* for next and see what happens.
> > 
> > And the advantage over the patchy approach is that the current patches
> > are hard to review. E.g.  it's not reasonable to ask RCU guys to review
> > the whole of vhost for RCU usage but it's much more reasonable to ask
> > about a specific patch.
> 
> 
> Ok. Then I agree to revert.
> 
> Thanks

Great, so please send the following:
- revert
- squashed and fixed patch

-- 
MST
