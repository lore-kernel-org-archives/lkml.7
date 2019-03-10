Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C3DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 03:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D0E20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 03:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCJDok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 22:44:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37627 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCJDoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 22:44:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id m9so883919qkl.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 19:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nRXLzWeU4z+b7ipw3vwMHvW9wI+iQexMMBB+tqRzUWM=;
        b=rzNnUp7uX/rEjIoh4570TrsSfvStuU/uupRutv1Wdhy87uFNyqR08jvOJt2twdI5CR
         dOOz46h0NyRNgqjkLGmO+6G2CoojqqOmUnffYaMjGD5/LjKu/E5w/wa57IMI4kswbvYc
         y+n4lfjn2T2hS4CQtGtOz1d3zxi2imsSG6NN8iWEEg+1n6gDkijIXDVcUlJJfAg7L4/t
         h207tzHfHjkYBvVn8SREzUJ4wuKfFBLU92MqPltwx4stF4UwyO1e5GMvQ88Ez07VAArk
         +781ebuM5tTGCUioKqDkNYtgK282izb0FwZeglECkDQ5pF/p6xiyP8GSIhsYDFwWgGvW
         wAqg==
X-Gm-Message-State: APjAAAVX2LdmlQYMDmto71KO2T9449i2KWyZbAalFuc4OhnaF6kqt8du
        vO8DCjp31Dhm7CvdQmghj6khXQ==
X-Google-Smtp-Source: APXvYqwBjxVJkdkqgbm4Xvggdaqod/RnYlhVL7XKz7paGDJntytTInboUZ76z7Dwdx+is6yj5WY5hQ==
X-Received: by 2002:a37:e50c:: with SMTP id e12mr19569582qkg.327.1552189477754;
        Sat, 09 Mar 2019 19:44:37 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v18sm1167741qkj.13.2019.03.09.19.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 19:44:36 -0800 (PST)
Date:   Sat, 9 Mar 2019 22:44:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, cohuck@redhat.com, jroedel@suse.de, mst@redhat.com,
        pasic@linux.ibm.com, wei.w.wang@intel.com
Subject: [PULL] virtio,vhost: cleanups and fixes
Message-ID: <20190309224435-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cfdbb4ed31aa777d59b288810f66eb06249ee5b7:

  vhost: silence an unused-variable warning (2019-03-06 11:32:37 -0500)

----------------------------------------------------------------
virtio: fixes, cleanups

Several fixes, most notably fix for virtio on swiotlb systems.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Arnd Bergmann (1):
      vhost: silence an unused-variable warning

Cornelia Huck (3):
      virtio-ccw: diag 500 may return a negative cookie
      virtio-ccw: wire up ->bus_name callback
      virtio: hint if callbacks surprisingly might sleep

Halil Pasic (1):
      s390/virtio: handle find on invalid queue gracefully

Joerg Roedel (5):
      swiotlb: Introduce swiotlb_max_mapping_size()
      swiotlb: Add is_swiotlb_active() function
      dma: Introduce dma_max_mapping_size()
      virtio: Introduce virtio_max_dma_size()
      virtio-blk: Consider virtio_max_dma_size() for maximum segment size

Wei Wang (2):
      virtio-balloon: improve update_balloon_size_func
      virtio_balloon: remove the unnecessary 0-initialization

 Documentation/DMA-API.txt               |  8 ++++++++
 Documentation/virtual/kvm/s390-diag.txt |  3 ++-
 drivers/block/virtio_blk.c              | 10 ++++++----
 drivers/s390/virtio/virtio_ccw.c        | 12 +++++++++++-
 drivers/vhost/vhost.c                   |  2 +-
 drivers/virtio/virtio.c                 |  2 ++
 drivers/virtio/virtio_balloon.c         |  6 ++++--
 drivers/virtio/virtio_ring.c            | 11 +++++++++++
 include/linux/dma-mapping.h             |  8 ++++++++
 include/linux/swiotlb.h                 | 11 +++++++++++
 include/linux/virtio.h                  |  2 ++
 include/linux/virtio_config.h           | 13 +++++++++++++
 kernel/dma/direct.c                     | 11 +++++++++++
 kernel/dma/mapping.c                    | 14 ++++++++++++++
 kernel/dma/swiotlb.c                    | 14 ++++++++++++++
 15 files changed, 118 insertions(+), 9 deletions(-)
