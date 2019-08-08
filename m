Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D32C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6D7217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfHHLgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:36:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfHHLgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:36:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E92130EA191;
        Thu,  8 Aug 2019 11:36:13 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 625835DA5B;
        Thu,  8 Aug 2019 11:36:08 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     amit@kernel.org, mst@redhat.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, pagupta@redhat.com
Subject: [PATCH v2 0/2] virtio_console: fix replug of virtio console port
Date:   Thu,  8 Aug 2019 17:06:04 +0530
Message-Id: <20190808113606.19504-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 08 Aug 2019 11:36:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the issue with unplug/replug of a port in virtio
console device, which fails with an error "Error allocating inbufs\n".

Patch 2 makes virtio packed ring code compatible with virtio split ring.
Tested the packed ring code with the qemu virtio 1.1 device code posted
here [1].

Changes from v1[2]
-----
Make virtio packed ring code compatible with split ring - [Michael]

[1]  https://marc.info/?l=qemu-devel&m=156471883703948&w=2
[2] https://lkml.org/lkml/2019/3/4/517

Pankaj Gupta (2):
  virtio_console: free unused buffers with port delete
  virtio_ring: packed ring: fix virtqueue_detach_unused_buf

 drivers/char/virtio_console.c | 14 +++++++++++---
 drivers/virtio/virtio_ring.c  |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.21.0

