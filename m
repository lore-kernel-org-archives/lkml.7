Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7DCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158FD20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A87rgvcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfJ2K7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:59:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfJ2K7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572346753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4H37NaZ5rR8UXp8a7OmDerkp1JUcZ+4ZN2lsi4O5BPY=;
        b=A87rgvcr9JiWYd+LtbwOpjLit1b7QJ5pgW8yGP49pj+gEFFzY5GK3F4/iVHPhD0OP4kJya
        JB1VQjGX4WLvmlzHxtcrSw0/fx5HikLNuzoDFkhdVlqOMmAiLpC2bUTge2+1BWU0UzlMld
        5ktMvs/Wg6/eGXF3x60txldLEMGaH+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-voWsV6VkMl6WJ232Z5GOIg-1; Tue, 29 Oct 2019 06:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FCF21005500;
        Tue, 29 Oct 2019 10:59:08 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A8395C1B2;
        Tue, 29 Oct 2019 10:58:49 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com, lulu@redhat.com
Subject: [RFC PATCH 0/2] virtio: allow per vq DMA domain
Date:   Tue, 29 Oct 2019 18:58:41 +0800
Message-Id: <20191029105843.12061-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: voWsV6VkMl6WJ232Z5GOIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have use a single parent for all DMA operations. This tends
to complicate the mdev based hardware virtio datapath offloading which
may not implement the control path over datapath like ctrl vq in the
case of virtio-net.

So this series tries to intorduce per DMA domain by allowing trasnport
to specify the parent device for each virtqueue. Then for the case of
virtio-mdev device, it can hook the DMA ops for control vq back to
itself and then using e.g VA or PA to emulate the control virtqueue
operation.

Vhost-mdev may use similar idea. Note, compiling test only.

Jason Wang (2):
  virtio: accept parent as a parameter when allocating virtqueue
  virtio: allow query vq parent device

 drivers/virtio/virtio_ring.c  | 36 +++++++++++++++++++++++++----------
 include/linux/virtio_config.h |  2 ++
 2 files changed, 28 insertions(+), 10 deletions(-)

--=20
2.19.1

