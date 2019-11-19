Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE8B21852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StVLCVqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKSLBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:01:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25797 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbfKSLBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574161291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wSp/F3aaHP5Q45hBptTm2n+6Yz9U6VCZsc0e0XK22/M=;
        b=StVLCVqvPQoKiPjjQ9A5DOZnFprE7+NEzmSsDTyYbiOrodKQ4F4UNJ++Ph8025RXlmtHDS
        elkbOYinBvfaRVsO8pEs8lImJHy/ZMWFOseVo34iSmyVEF4Ho8gZr56vErdcCgGCJ2/EKq
        K2p7d00uS9giHApxJYv6rboW3tqzi3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-jBesbjVsPNuTu7nPnemEHA-1; Tue, 19 Nov 2019 06:01:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DDD6800EBE;
        Tue, 19 Nov 2019 11:01:27 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-41.ams2.redhat.com [10.36.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 469A960BE0;
        Tue, 19 Nov 2019 11:01:22 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH net-next 0/6] vsock: add local transport support
Date:   Tue, 19 Nov 2019 12:01:15 +0100
Message-Id: <20191119110121.14480-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jBesbjVsPNuTu7nPnemEHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new transport (vsock_loopback) to handle
local communication.
This could be useful to test vsock core itself and to allow developers
to test their applications without launching a VM.

Before this series, vmci and virtio transports allowed this behavior,
but only in the guest.
We are moving the loopback handling in a new transport, because it
might be useful to provide this feature also in the host or when
no H2G/G2H transports (hyperv, virtio, vmci) are loaded.

The user can use the loopback with the new VMADDR_CID_LOCAL (that
replaces VMADDR_CID_RESERVED) in any condition.
Otherwise, if the G2H transport is loaded, it can also use the guest
local CID as previously supported by vmci and virtio transports.
If G2H transport is not loaded, the user can also use VMADDR_CID_HOST
for local communication.

Patch 1 is a cleanup to build virtio_transport_common without virtio
Patch 2 adds the new VMADDR_CID_LOCAL, replacing VMADDR_CID_RESERVED
Patch 3 adds a new feature flag to register a loopback transport
Patch 4 adds the new vsock_loopback transport based on the loopback
        implementation of virtio_transport
Patch 5 implements the logic to use the local transport for loopback
        communication
Patch 6 removes the loopback from virtio_transport

@Jorgen: Do you think it might be a problem to replace
VMADDR_CID_RESERVED with VMADDR_CID_LOCAL?

Thanks,
Stefano

Stefano Garzarella (6):
  vsock/virtio_transport_common: remove unused virtio header includes
  vsock: add VMADDR_CID_LOCAL definition
  vsock: add local transport support in the vsock core
  vsock: add vsock_loopback transport
  vsock: use local transport when it is loaded
  vsock/virtio: remove loopback handling

 MAINTAINERS                             |   1 +
 include/net/af_vsock.h                  |   2 +
 include/uapi/linux/vm_sockets.h         |   8 +-
 net/vmw_vsock/Kconfig                   |  12 ++
 net/vmw_vsock/Makefile                  |   1 +
 net/vmw_vsock/af_vsock.c                |  49 +++++-
 net/vmw_vsock/virtio_transport.c        |  61 +------
 net/vmw_vsock/virtio_transport_common.c |   3 -
 net/vmw_vsock/vmci_transport.c          |   2 +-
 net/vmw_vsock/vsock_loopback.c          | 217 ++++++++++++++++++++++++
 10 files changed, 283 insertions(+), 73 deletions(-)
 create mode 100644 net/vmw_vsock/vsock_loopback.c

--=20
2.21.0

