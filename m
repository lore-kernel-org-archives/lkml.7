Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6056BCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D95217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfKATeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:34:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfKATeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:34:03 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73CFE81DE7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2019 19:34:03 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id m17so6043777wrb.20
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DDu4dZguSc1AuhYOU131Dph2BpOLdkpSLt78cfUXrP4=;
        b=gJLu2Xx5Vk6anaIpjAZVgHkZOxZN4EHdYF8YmoMr4nMT+4ImGLId6ThBf1MqKVRsM7
         XcPxCeJAud5+ctBCA0QA5oFZ9j+rbYKRqzyp4A/sJbds6ntk9MCvra+aWmiZgjFqDqBE
         1a5prUtIxhCZC5+/Bu2aGz11x0YaIoYpNw+GCRhCu5r/2AliOT1HSA5t5Bhr9vBCAVge
         WMERFRjNh8t5DjVayO8hhOpq6x2y8lu3eLJzHcOvp2pIzygTbLpFptG0C9bZ/J/g7ofS
         dMsu9EU5ULAGEBkk0k1UsG7fs8GWYJ55GnjOLRY8prW5E9fuS9G42WQfTjkySK6ywH5R
         udUA==
X-Gm-Message-State: APjAAAWoLvGlzYYKQZ4Pd9+7eiZUxohNy88YagKes8cGw9ssq87eJVmA
        0IzJ0XA8M6WrOIt765fvlozEdEkTcp0z+bwDJGK0BPdFJdsiuEGQJi1WBOjNkNWKq+oTufhbGVw
        BKLf500FjSzZlttFjcwQDQOj5
X-Received: by 2002:a1c:3dc4:: with SMTP id k187mr11325442wma.167.1572636841902;
        Fri, 01 Nov 2019 12:34:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz0xUERtPHGhyf71lfOGgMY82PECMv5XY2AKvQnIIKeMbgOF3SlGefp223udCXQMXep6c44yw==
X-Received: by 2002:a1c:3dc4:: with SMTP id k187mr11325432wma.167.1572636841676;
        Fri, 01 Nov 2019 12:34:01 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
        by smtp.gmail.com with ESMTPSA id 65sm12393239wrs.9.2019.11.01.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 12:34:00 -0700 (PDT)
Date:   Fri, 1 Nov 2019 15:33:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, yong.liu@intel.com
Subject: [PULL RESEND] virtio: fixes
Message-ID: <20191028042900-1-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could not figure out whether I sent this pull request or not. Sorry about
the noise if I did.

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to b3683dee840274e9997d958b9d82e5de95950f0b:

  vringh: fix copy direction of vringh_iov_push_kern() (2019-10-28 04:25:04 -0400)

----------------------------------------------------------------
virtio: fixes

Some minor fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vringh: fix copy direction of vringh_iov_push_kern()

Marvin Liu (1):
      virtio_ring: fix stalls for packed rings

Stefano Garzarella (1):
      vsock/virtio: remove unused 'work' field from 'struct virtio_vsock_pkt'

 drivers/vhost/vringh.c       | 8 +++++++-
 drivers/virtio/virtio_ring.c | 7 +++----
 include/linux/virtio_vsock.h | 1 -
 3 files changed, 10 insertions(+), 6 deletions(-)
