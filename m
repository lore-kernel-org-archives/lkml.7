Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB20C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C81F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfG2QQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:16:12 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36419 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG2QQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:16:12 -0400
Received: by mail-ua1-f68.google.com with SMTP id v20so24189289uao.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AyvJSduUmZn33FbpJeTkP5NHm1ThVmp/uEoZugiTS6k=;
        b=Hdv75bp3y7N0KY9LQEjenz9ab3aSVFTwcD6WpRCNfc+twZKK2yxtzWZF/HDyNzfG5j
         oPPhEXpM1rbkNurayAbSYEnkZ5IhIkoefwlCerQT+JTM24jliJhE3dC3oaOlSYlnPE71
         iwXFJljKueslDOcFe/A9f5bzY8ySAt8FwjzXhXRhpQ1Q3uIq0BviDE9e7aiiSkyijxbY
         aSQQYvLC8K0YAU1QZjHWokVHC1qwKeum1EhBtlMl1innfnGP7P5v/8yS0QdIbj+E4kxl
         IK4k2nQE63WTmMWqjIu3GGObh7Jrb7LzOv7F1kjQLvM94h/nJAKBnO4g7LZ90WpV33HN
         9FPw==
X-Gm-Message-State: APjAAAWV12ns46RukSODcTrVCWBrVxTFcC7+i0tqMWyqHNBA3vk5PN/m
        juLKmx8OShoza5qniTUt8NnHtw==
X-Google-Smtp-Source: APXvYqwG8Q4XQWblCYfrnvjYrxOZIt94OjzyFiLAXTSDaMhX/fRr5dDybVH26+paFqcxZZfddeveUQ==
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr67985907uad.15.1564416971073;
        Mon, 29 Jul 2019 09:16:11 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id u5sm60539788uah.0.2019.07.29.09.16.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 09:16:10 -0700 (PDT)
Date:   Mon, 29 Jul 2019 12:16:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, jean-philippe@linaro.org, jroedel@suse.de,
        mst@redhat.com, namit@vmware.com, wei.w.wang@intel.com
Subject: [PULL] vhost,virtio: cleanups and fixes
Message-ID: <20190729121605-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 73f628ec9e6bcc45b77c53fe6d0c0ec55eaf82af:

  vhost: disable metadata prefetch optimization (2019-07-26 07:49:29 -0400)

----------------------------------------------------------------
virtio, vhost: bugfixes

Fixes in the iommu and balloon devices.
Disable the meta-data optimization for now - I hope we can get it fixed
shortly, but there's no point in making users suffer crashes while we
are working on that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      iommu/virtio: Update to most recent specification

Michael S. Tsirkin (2):
      balloon: fix up comments
      vhost: disable metadata prefetch optimization

Wei Wang (1):
      mm/balloon_compaction: avoid duplicate page removal

 drivers/iommu/virtio-iommu.c      | 40 ++++++++++++++++-------
 drivers/vhost/vhost.h             |  2 +-
 include/uapi/linux/virtio_iommu.h | 32 ++++++++++--------
 mm/balloon_compaction.c           | 69 +++++++++++++++++++++++----------------
 4 files changed, 89 insertions(+), 54 deletions(-)
