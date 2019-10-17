Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B9BFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6E020869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502478AbfJQMoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388531AbfJQMoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:44:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5127B30650DA;
        Thu, 17 Oct 2019 12:44:09 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-195.ams2.redhat.com [10.36.117.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E17AC5D9CA;
        Thu, 17 Oct 2019 12:44:03 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH net 0/2] vsock/virtio: make the credit mechanism more robust
Date:   Thu, 17 Oct 2019 14:44:01 +0200
Message-Id: <20191017124403.266242-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 17 Oct 2019 12:44:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes the credit mechanism implemented in the
virtio-vsock devices more robust.
Patch 1 sends an update to the remote peer when the buf_alloc
change.
Patch 2 prevents a malicious peer (especially the guest) can
consume all the memory of the other peer, discarding packets
when the credit available is not respected.

Stefano Garzarella (2):
  vsock/virtio: send a credit update when buffer size is changed
  vsock/virtio: discard packets if credit is not respected

 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.21.0

