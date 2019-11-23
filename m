Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEC4C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F25A2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwEVP9LA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKWQ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:56:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726705AbfKWQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574528160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2zzmCXVL6/qiRxw5VRJxtFFVEelD3xq1/ujpmzsTxFU=;
        b=bwEVP9LAvhMO7ZNnBjKdLXMLDPmTZXLZNMFAJl4IKgFZt13tdMXGm0ZTIE8UJkwrVu/6tC
        P26EejJ29Eo5UWJeIG9uXc70Zfa6547dWlvXRdJ9unOkcJiXOf+qyVRCogcNgqHfCvIy1r
        HZ4nOC06NNEYvnV4GhYfpjNhfvvkj3M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-YU6BSaBGPYCJ-HrxdtYD_A-1; Sat, 23 Nov 2019 11:55:59 -0500
Received: by mail-qt1-f199.google.com with SMTP id k27so1723457qtu.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 08:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oUPi4IjzCEcsGqjHvxV40TwATuFQ6qhdtMszb+yQ4YA=;
        b=jFBs0j0gRypwLAbcP27oUJn2jdPl4SsbYdsjHYGyj3unH6GETzxU9N7ySphFLnfbI1
         nCcKMqhcDNKYhC99Wk44TftLnMl01+UKCgpxr2U8VVtIYwq3vHtcXn7fx+54Y1SL4gH4
         ac3ozwDc4bgfxGmKOcHMXBXh6WhcinbHtjVv3A6mNmXC/m9cuQka//Htv74671rAVVej
         FscitYXpKfK0Hooe43rsmfQX2XRoYW5Kh2cOAL3UXjj70O3Ii/Qv76POQb6HKSHnIErH
         m1ORCeY8bxnWnJ0H+sYivIKVNtBiZy3x7ILkQDPFd7PJ4Zws2uJBZdrqjcncwf43S/VE
         WsqQ==
X-Gm-Message-State: APjAAAXkmYLR1f05gb6JYEThZ2knsY5N51PMD0ZwcTLhdU9/mAH+aTA4
        OlejVHdNEiJv6HVdatNm7S2tcyaUWW2twkS98nkUGr+BM0viRMEZMF/MMQVyXHdk5yEokgOZpeO
        /k6QnrVLH86TiR6umIQ9ipBkX
X-Received: by 2002:ac8:109:: with SMTP id e9mr10744670qtg.233.1574528158668;
        Sat, 23 Nov 2019 08:55:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5oU6z7kIgkAY+TdwrAkagYjcdcvZ06XXDl+M6D2/wPofNwFAEDJeY+TKLUO56xn44s6qvMg==
X-Received: by 2002:ac8:109:: with SMTP id e9mr10744651qtg.233.1574528158492;
        Sat, 23 Nov 2019 08:55:58 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id a3sm618985qkd.67.2019.11.23.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 08:55:57 -0800 (PST)
Date:   Sat, 23 Nov 2019 11:55:52 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, khazhy@google.com, lvivier@redhat.com,
        mimu@linux.ibm.com, pasic@linux.ibm.com, wei.w.wang@intel.com
Subject: [PULL] virtio: last minute bugfixes
Message-ID: <20191123115552-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-MC-Unique: YU6BSaBGPYCJ-HrxdtYD_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb=
:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_li=
nus

for you to fetch changes up to c9a6820fc0da2603be3054ee7590eb9f350508a7:

  virtio_balloon: fix shrinker count (2019-11-20 02:15:57 -0500)

----------------------------------------------------------------
virtio: last minute bugfixes

Minor bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Halil Pasic (1):
      virtio_ring: fix return code on DMA mapping fails

Laurent Vivier (1):
      virtio_console: allocate inbufs in add_port() only if it is needed

Michael S. Tsirkin (1):
      virtio_balloon: fix shrinker scan number of pages

Wei Wang (1):
      virtio_balloon: fix shrinker count

 drivers/char/virtio_console.c   | 28 +++++++++++++---------------
 drivers/virtio/virtio_balloon.c | 20 +++++++++++++-------
 drivers/virtio/virtio_ring.c    |  4 ++--
 3 files changed, 28 insertions(+), 24 deletions(-)

