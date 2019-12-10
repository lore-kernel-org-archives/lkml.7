Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3117DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EEA2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgQ8OgJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLJNE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:04:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55857 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727296AbfLJNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575983096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9e82RZxMOLIpTiokhMnuko25lsVYhsTU5bajYGHD3E0=;
        b=RgQ8OgJsJl+5pGlJMk0DRXg8pBevuODkkoUrX7/EDX6SfTlIc9XWZJb0xwEK6Aoy/mY7rE
        ITQJ01VbQxqUbEGjI16IEduNziVWlmraX2Mt7WmnzOpUr83R51F0ZfZbv505fHi9oBCkHi
        TCp3UklXqt4ubieCTV59cckujv4vHCk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-AmOPftSWPTG2TPdG7TRWrA-1; Tue, 10 Dec 2019 08:04:52 -0500
Received: by mail-qv1-f72.google.com with SMTP id g6so6786241qvp.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wrMmlrBt1X+KXyyzVL2v0JpYF8+uVnrQFFbGuDQ2s1k=;
        b=Et7HnoYi1BxjNAyz286FsLkWNekl/Fz6u4VraCCuTA+uxaVPf97JdcO2pGgZ5Lbgym
         mbRuG/SqNGbF4cm7K3SbmPa7r00iobbuwKMBLf2C0p0vwaQeD5l09Pq9vM7GQMXOzRTy
         Rnzb7sC+PyKmWFgafDIX0BasE2AfqVytvoug3DUQF6rGQuF1eyk7C2L7XDdhpwgvz/jY
         6VPUysoc3I+Gak0xi1opWy19BtMdAFe06RxZ6JlGKCJa0UNxGq/tBGbCZIZc3CDmWBdG
         EC1ablIPekd3UWIT+jNdXzJiTJcclhKFwT+UJNj7RBIQ0cJe8k2VYD5Ut/DSiGE+0azG
         EldA==
X-Gm-Message-State: APjAAAVQtRKsRCn7DvvzNpwgO677c7Vg1nhfcCqJkEvk9Tp02E5GGgzm
        b4EKIfHw6Z1VhZGgYu9cKf4kVsk10FBTVWQWZ8qmFwgEcK/zuHTJwu22mf4TxbzVGtVvR1WnQIB
        RcRHnM6GDXOurCP2WPL3rj36w
X-Received: by 2002:ac8:24c3:: with SMTP id t3mr4913484qtt.297.1575983091844;
        Tue, 10 Dec 2019 05:04:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvRMy+oBS/dEnpWmTMEn7uoVJylDeK7fazqXG08ZonVvSCZh4f/q1+l6V4b3jvu8EyJI4OOg==
X-Received: by 2002:ac8:24c3:: with SMTP id t3mr4913348qtt.297.1575983090215;
        Tue, 10 Dec 2019 05:04:50 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id t38sm1070453qta.78.2019.12.10.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:04:49 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:04:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net-next v10 3/3] netronome: use the new txqueue timeout
 argument
Message-ID: <20191210130014.47179-4-mst@redhat.com>
References: <20191210130014.47179-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210130014.47179-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: AmOPftSWPTG2TPdG7TRWrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20191210130445.MPRrIuKxOCRZ1UK5zAdmHr92QUJyB6pg2P2KGIiFok0@z>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/=
net/ethernet/netronome/nfp/nfp_net_common.c
index 41a808b14d76..eb1f9bed4833 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1323,14 +1323,8 @@ nfp_net_tx_ring_reset(struct nfp_net_dp *dp, struct =
nfp_net_tx_ring *tx_ring)
 static void nfp_net_tx_timeout(struct net_device *netdev, unsigned int txq=
ueue)
 {
 =09struct nfp_net *nn =3D netdev_priv(netdev);
-=09int i;
=20
-=09for (i =3D 0; i < nn->dp.netdev->real_num_tx_queues; i++) {
-=09=09if (!netif_tx_queue_stopped(netdev_get_tx_queue(netdev, i)))
-=09=09=09continue;
-=09=09nn_warn(nn, "TX timeout on ring: %d\n", i);
-=09}
-=09nn_warn(nn, "TX watchdog timeout\n");
+=09nn_warn(nn, "TX watchdog timeout on ring: %u\n", txqueue);
 }
=20
 /* Receive processing
--=20
MST


