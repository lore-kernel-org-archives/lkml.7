Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5ECC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D522166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405603AbfHIGsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405239AbfHIGsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E8F72CD811;
        Fri,  9 Aug 2019 06:48:54 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46ADF1001925;
        Fri,  9 Aug 2019 06:48:49 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     amit@kernel.org, mst@redhat.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, pagupta@redhat.com,
        xiaohli@redhat.com
Subject: [PATCH v3 0/2] virtio_console: fix replug of virtio console port
Date:   Fri,  9 Aug 2019 12:18:45 +0530
Message-Id: <20190809064847.28918-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 09 Aug 2019 06:48:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the issue with unplug/replug of a port in virtio
console driver which fails with an error "Error allocating inbufs\n".
Patch 1 makes use of 'virtqueue_detach_unused_buf' function to detach
the unused buffers during port hotunplug time.
Patch 2 updates the next avail index for packed ring code.
Tested the packed ring code with the qemu virtio 1.1 device code posted
here [1].

Changes from v2
 Better change log in patch2 - [Greg]
Changes from v1[2]
 Make virtio packed ring code compatible with split ring - [Michael]

[1]  https://marc.info/?l=qemu-devel&m=156471883703948&w=2
[2]  https://lkml.org/lkml/2019/3/4/517

Pankaj Gupta (2):
  virtio_console: free unused buffers with port delete
  virtio: decrement avail idx with buffer detach for packed ring

 char/virtio_console.c |   14 +++++++++++---
 virtio/virtio_ring.c  |    6 ++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
-- 
2.21.0

