Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BF120873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfENVL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:11:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36175 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:11:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id c14so191933qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=qULCzBdQcxHh1C2O8j06vBUB9AzYlN4esxwCWasX1SQ=;
        b=R8/sye07lijIlkC8GyK5WSyMf/bFu5108dfoev2HIhF/CzoPBo1PzWFQPOhdEMEEHo
         JQlV/ACrIBY3mCGP4eBISXuCR6/ziRgdd61jI14z1sIlt1R5LE/ZacqJMBL0iG11XeQ7
         lUIjcBiG2QD2tH08K1DYSEF0PEkRRVd/JfUZsoACHSihYjcHDCidDwJ2WrQw9/1J1jdw
         EDPaQ7aKuG+eshAXBCEDB1foBTIgdHuk3WNXSRDUN8gLWKsB8o07QrayCBEnWPcoR7gQ
         dyu4J2A4dq82ja9yOwKaeWSEKGrcwCkGhuWgcIT96BFnHBE+Da8GcpvFAPmqI6eUNWgZ
         73wA==
X-Gm-Message-State: APjAAAX+fSvlEQXMDLr68ML7vfdxy9DczDf66+ZPZ060ZnaZdcfzspSf
        57YuLcSomn8x+cI4aCZQ9820yg==
X-Google-Smtp-Source: APXvYqxmZ0SoPCfFH0lsC6mFWej9UEaIAHl3b5sj9Rk3s8zGc9PLlPE58FGHNqVgQ1TOJiOuRs78Bw==
X-Received: by 2002:a37:4f8a:: with SMTP id d132mr16914864qkb.272.1557868318291;
        Tue, 14 May 2019 14:11:58 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
        by smtp.gmail.com with ESMTPSA id f16sm8168845qkk.19.2019.05.14.14.11.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 14:11:57 -0700 (PDT)
Date:   Tue, 14 May 2019 17:11:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, benbjiang@tencent.com,
        jasowang@redhat.com, j.neuschaefer@gmx.net, mst@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, yuehaibing@huawei.com
Subject: [PULL] vhost: cleanups and fixes
Message-ID: <20190514171147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 050f4c4d2fbbd8217d94dc21051cc597d2a6848b:

  virtio/s390: enable packed ring (2019-05-12 13:11:36 -0400)

----------------------------------------------------------------
virtio: fixes, features

s390 has packed ring support.
several fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Halil Pasic (3):
      virtio/s390: use vring_create_virtqueue
      virtio/s390: DMA support for virtio-ccw
      virtio/s390: enable packed ring

Jiang Biao (1):
      virtio/virtio_ring: do some comment fixes

Jonathan Neuschäfer (1):
      tools/virtio/ringtest: Remove bogus definition of BUG_ON()

Paolo Bonzini (1):
      vhost-scsi: remove incorrect memory barrier

YueHaibing (1):
      virtio_ring: Fix potential mem leak in virtqueue_add_indirect_packed

 drivers/s390/virtio/virtio_ccw.c | 52 +++++++++++++++++++---------------------
 drivers/vhost/scsi.c             |  1 -
 drivers/virtio/virtio_ring.c     | 28 ++++++++++++----------
 include/linux/virtio.h           | 17 -------------
 tools/virtio/ringtest/ptr_ring.c |  1 -
 5 files changed, 40 insertions(+), 59 deletions(-)
