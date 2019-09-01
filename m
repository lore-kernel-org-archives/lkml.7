Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30591C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B03206BA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfIASCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:02:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfIASCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 14:02:52 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FB287FDCD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2019 18:02:52 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id v16so13431529qtp.14
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 11:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NtIlrG6bXqato3AHyRhqkP1r1EyQzXXXF+1WVjQfhrI=;
        b=jHw2p6VqOdOrYqsjQ+GQl2p/kG4ibqg0hnOL6sR7yp6EsUnM1PuVZQvKOij7iSmg2F
         wRl7CI+Uxpr81w5rcOPHhIj8A8I9mPY6qzM1npvXTQnTY6lJVFXexxjJLjeEEgwRSpMk
         aj9QJf8xS6fo1dPQJJXCaVNirVw5hyb6cHGxfgUxIfvYaUIEB0Vmz+mmZ8NhLq5PW/9f
         BeFkLrC1GossL1aTQVrh1JIDL01bk25+760L7W+AU4kp0EoQqrfp5e7YB+nD+Bh20anu
         Bem7lUE/yz3kWCnAlnAOMyN5icEaC6NBihISh34ouL+mHUo1wWJQr45ATMC1VeNon00t
         vauA==
X-Gm-Message-State: APjAAAXVY+ZvRjN0z7AgfUmUJlDpEUwvWnmBXaWxHogahvFMtM3FWrRV
        mbNu5sQeSbS8l3/ffOwnvwsCVvfrOKfMQOyopR8BqBz3r98pnkF2nq/hByWE2gI6ubYL4eX4Ocl
        eCM9dIKhkmy9w5yI/LtoDO7C5
X-Received: by 2002:a37:480d:: with SMTP id v13mr24849058qka.295.1567360971410;
        Sun, 01 Sep 2019 11:02:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRyGzOcE8hglKRycEb420hPDRNv3fnUOZqre0cmbUtVArhzSlANFmNqbwZR2kZ23xgEdav+Q==
X-Received: by 2002:a37:480d:: with SMTP id v13mr24849044qka.295.1567360971215;
        Sun, 01 Sep 2019 11:02:51 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id i20sm5379783qkk.67.2019.09.01.11.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 11:02:49 -0700 (PDT)
Date:   Sun, 1 Sep 2019 14:02:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jgg@ziepe.ca
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Message-ID: <20190901140220-mutt-send-email-mst@kernel.org>
References: <20190809054851.20118-1-jasowang@redhat.com>
 <20190810134948-mutt-send-email-mst@kernel.org>
 <360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
 <20190812054429-mutt-send-email-mst@kernel.org>
 <663be71f-f96d-cfbc-95a0-da0ac6b82d9f@redhat.com>
 <20190819162733-mutt-send-email-mst@kernel.org>
 <9325de4b-1d79-eb19-306e-e7a8fa8cc1a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9325de4b-1d79-eb19-306e-e7a8fa8cc1a5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:29:32AM +0800, Jason Wang wrote:
> 
> On 2019/8/20 上午5:08, Michael S. Tsirkin wrote:
> > On Tue, Aug 13, 2019 at 04:12:49PM +0800, Jason Wang wrote:
> > > On 2019/8/12 下午5:49, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 12, 2019 at 10:44:51AM +0800, Jason Wang wrote:
> > > > > On 2019/8/11 上午1:52, Michael S. Tsirkin wrote:
> > > > > > On Fri, Aug 09, 2019 at 01:48:42AM -0400, Jason Wang wrote:
> > > > > > > Hi all:
> > > > > > > 
> > > > > > > This series try to fix several issues introduced by meta data
> > > > > > > accelreation series. Please review.
> > > > > > > 
> > > > > > > Changes from V4:
> > > > > > > - switch to use spinlock synchronize MMU notifier with accessors
> > > > > > > 
> > > > > > > Changes from V3:
> > > > > > > - remove the unnecessary patch
> > > > > > > 
> > > > > > > Changes from V2:
> > > > > > > - use seqlck helper to synchronize MMU notifier with vhost worker
> > > > > > > 
> > > > > > > Changes from V1:
> > > > > > > - try not use RCU to syncrhonize MMU notifier with vhost worker
> > > > > > > - set dirty pages after no readers
> > > > > > > - return -EAGAIN only when we find the range is overlapped with
> > > > > > >      metadata
> > > > > > > 
> > > > > > > Jason Wang (9):
> > > > > > >      vhost: don't set uaddr for invalid address
> > > > > > >      vhost: validate MMU notifier registration
> > > > > > >      vhost: fix vhost map leak
> > > > > > >      vhost: reset invalidate_count in vhost_set_vring_num_addr()
> > > > > > >      vhost: mark dirty pages during map uninit
> > > > > > >      vhost: don't do synchronize_rcu() in vhost_uninit_vq_maps()
> > > > > > >      vhost: do not use RCU to synchronize MMU notifier with worker
> > > > > > >      vhost: correctly set dirty pages in MMU notifiers callback
> > > > > > >      vhost: do not return -EAGAIN for non blocking invalidation too early
> > > > > > > 
> > > > > > >     drivers/vhost/vhost.c | 202 +++++++++++++++++++++++++-----------------
> > > > > > >     drivers/vhost/vhost.h |   6 +-
> > > > > > >     2 files changed, 122 insertions(+), 86 deletions(-)
> > > > > > This generally looks more solid.
> > > > > > 
> > > > > > But this amounts to a significant overhaul of the code.
> > > > > > 
> > > > > > At this point how about we revert 7f466032dc9e5a61217f22ea34b2df932786bbfc
> > > > > > for this release, and then re-apply a corrected version
> > > > > > for the next one?
> > > > > If possible, consider we've actually disabled the feature. How about just
> > > > > queued those patches for next release?
> > > > > 
> > > > > Thanks
> > > > Sorry if I was unclear. My idea is that
> > > > 1. I revert the disabled code
> > > > 2. You send a patch readding it with all the fixes squashed
> > > > 3. Maybe optimizations on top right away?
> > > > 4. We queue *that* for next and see what happens.
> > > > 
> > > > And the advantage over the patchy approach is that the current patches
> > > > are hard to review. E.g.  it's not reasonable to ask RCU guys to review
> > > > the whole of vhost for RCU usage but it's much more reasonable to ask
> > > > about a specific patch.
> > > 
> > > Ok. Then I agree to revert.
> > > 
> > > Thanks
> > Great, so please send the following:
> > - revert
> > - squashed and fixed patch
> 
> 
> Just to confirm, do you want me to send a single series or two?
> 
> Thanks
> 

One is fine.

-- 
MST
