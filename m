Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F3EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663E7206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfHMOFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbfHMOFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:05:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F28EF30A5A64;
        Tue, 13 Aug 2019 14:05:35 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F5537FB8C;
        Tue, 13 Aug 2019 14:05:30 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     mst@redhat.com, amit@kernel.org
Cc:     virtualization@lists.linux-foundation.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, pagupta@redhat.com
Subject: [PATCH v4 0/2] virtio_console: fix replug of virtio console port
Date:   Tue, 13 Aug 2019 19:35:27 +0530
Message-Id: <20190813140529.12939-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 13 Aug 2019 14:05:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the issue with unplug/replug of a port in virtio
console driver which fails with an error "Error allocating inbufs\n".

Patch 1 updates the next avail index for packed ring code.
Patch 2 makes use of 'virtqueue_detach_unused_buf' function to detach
the unused buffers during port hotunplug time.

Tested the packed ring code with the qemu virtio 1.1 device code posted
here [1]. Also, sent a patch to document the behavior in virtio spec as
suggested by Michael.

Changes from v3
- Swap patch 1 with patch 2  - [Michael]
- Added acked-by tag by Jason in patch 1
- Add reference to spec change
Changes from v2
- Better change log in patch2 - [Greg]
Changes from v1[2]
- Make virtio packed ring code compatible with split ring - [Michael]

[1]  https://marc.info/?l=qemu-devel&m=156471883703948&w=2
[2]  https://lkml.org/lkml/2019/3/4/517
[3]  https://lists.oasis-open.org/archives/virtio-dev/201908/msg00055.html

Pankaj Gupta (2):
  virtio: decrement avail idx with buffer detach for packed ring
  virtio_console: free unused buffers with port delete

 char/virtio_console.c |   14 +++++++++++---
 virtio/virtio_ring.c  |    6 ++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
-- 
2.21.0

