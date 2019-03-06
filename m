Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C99C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD3920675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfCFHSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:18:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfCFHSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:18:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5867A3082E0E;
        Wed,  6 Mar 2019 07:18:21 +0000 (UTC)
Received: from hp-dl380pg8-02.lab.eng.pek2.redhat.com (hp-dl380pg8-02.lab.eng.pek2.redhat.com [10.73.8.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E7FB600C5;
        Wed,  6 Mar 2019 07:18:14 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com
Subject: [RFC PATCH V2 0/5] vhost: accelerate metadata access through vmap()
Date:   Wed,  6 Mar 2019 02:18:07 -0500
Message-Id: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 06 Mar 2019 07:18:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to access virtqueue metadata through kernel virtual
address instead of copy_user() friends since they had too much
overheads like checks, spec barriers or even hardware feature
toggling. This is done through setup kernel address through vmap() and
resigter MMU notifier for invalidation.

Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
obvious improvement.

Thanks

Changes from V4:
- use invalidate_range() instead of invalidate_range_start()
- track dirty pages
Changes from V3:
- don't try to use vmap for file backed pages
- rebase to master
Changes from V2:
- fix buggy range overlapping check
- tear down MMU notifier during vhost ioctl to make sure invalidation
  request can read metadata userspace address and vq size without
  holding vq mutex.
Changes from V1:
- instead of pinning pages, use MMU notifier to invalidate vmaps and
  remap duing metadata prefetch
- fix build warning on MIPS

Jason Wang (5):
  vhost: generalize adding used elem
  vhost: fine grain userspace memory accessors
  vhost: rename vq_iotlb_prefetch() to vq_meta_prefetch()
  vhost: introduce helpers to get the size of metadata area
  vhost: access vq metadata through kernel virtual address

 drivers/vhost/net.c   |   6 +-
 drivers/vhost/vhost.c | 434 ++++++++++++++++++++++++++++++++++++++++++++------
 drivers/vhost/vhost.h |  18 ++-
 3 files changed, 407 insertions(+), 51 deletions(-)

-- 
1.8.3.1

