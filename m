Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3546E2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7QOH9fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLCUTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:19:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbfLCUTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575404390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvoBxuvp3G0/XLbvffQRipup1lCyNBJiGiUdnNoPbls=;
        b=h7QOH9fKDTe8uO3xFTJ2KhQsA2cB/McXPPrqBTcP1ehOQd75gWcC0D0JDfzTEWefqzByjS
        F5AKsNzJx4ate24mJFyEsBhJetX8KOeRfdlWxfecIqHFNE0VoZYKHvCu3cLTfH4k7q0R1K
        6BcdOBQOC0zT8DTl0yZi35pV41pS4j4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-aWMtr73wNcenDs-Qh4wH_g-1; Tue, 03 Dec 2019 15:19:48 -0500
Received: by mail-qv1-f71.google.com with SMTP id a4so2993320qvn.14
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QmtzDLYDSTNcDSWhu8MKh0ZRRQ2IxQ2t+dts0IfGnuc=;
        b=EaiSheX414WcpjobAnJMdMXpeyqojxM+W31GNjknW2Lio3VVv20ARluZ+0KcJzgxjs
         TMv1lmMHUxzc1lMtEZfi07PE8Jfo4uprrcEib847xdpcPfdlaasmNOmvO6Y/bGTJNXq7
         +vG+SiillDaWYmIl9XY6xh9nUgMD/B+vq5yQsCmTZRdO4+6EnPFRVbBI5vVwxg9oQYOT
         fGWRJ0ZyRYZan6DC3gDeurgYdc+dehrrAbC99PN05jCbCqaaFBF3o52C1h80FDDhDPHH
         SnwtHzobXnJLdQt9TZiXxowVZhVwPEcU8p0mkPo0OpxdrV8/jKWM913Q9c10fJByWwtC
         yarg==
X-Gm-Message-State: APjAAAVUggoVS1Ti7QDYdPedi/1RzW9iG+67slAexHr13X4Fcd0FNI0Q
        1DAlpoF95KAgQkAnQ8Yu+KbkDeVdNw02T+3aQQr/QLnr7mT09XgHoXzqhDhjCefYF3FApr4kH/I
        /QxYcqevQnMGmz++kjtbnO/FX
X-Received: by 2002:a05:620a:210e:: with SMTP id l14mr7328301qkl.18.1575404388181;
        Tue, 03 Dec 2019 12:19:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNAGftONrxG7OOOmA1p2XeS+kBT15c+ObkoyL77kRsuzntoDuyINOMAAxBlSMFnthhkga2lw==
X-Received: by 2002:a05:620a:210e:: with SMTP id l14mr7328279qkl.18.1575404387958;
        Tue, 03 Dec 2019 12:19:47 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id s44sm2425816qts.22.2019.12.03.12.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:19:47 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:19:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com
Subject: [PATCH RFC net-next v8 2/3] mlx4: use new txqueue timeout argument
Message-ID: <20191203201804.662066-3-mst@redhat.com>
References: <20191203201804.662066-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203201804.662066-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: aWMtr73wNcenDs-Qh4wH_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v7:
=09build fix

 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/e=
thernet/mellanox/mlx4/en_netdev.c
index aa348230bd39..2c2ff1f0ea6d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1367,20 +1367,14 @@ static void mlx4_en_tx_timeout(struct net_device *d=
ev, unsigned int txqueue)
 {
 =09struct mlx4_en_priv *priv =3D netdev_priv(dev);
 =09struct mlx4_en_dev *mdev =3D priv->mdev;
-=09int i;
+=09struct mlx4_en_tx_ring *tx_ring =3D priv->tx_ring[TX][txqueue];
=20
 =09if (netif_msg_timer(priv))
 =09=09en_warn(priv, "Tx timeout called on port:%d\n", priv->port);
=20
-=09for (i =3D 0; i < priv->tx_ring_num[TX]; i++) {
-=09=09struct mlx4_en_tx_ring *tx_ring =3D priv->tx_ring[TX][i];
-
-=09=09if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, i)))
-=09=09=09continue;
-=09=09en_warn(priv, "TX timeout on queue: %d, QP: 0x%x, CQ: 0x%x, Cons: 0x=
%x, Prod: 0x%x\n",
-=09=09=09i, tx_ring->qpn, tx_ring->sp_cqn,
-=09=09=09tx_ring->cons, tx_ring->prod);
-=09}
+=09en_warn(priv, "TX timeout on queue: %d, QP: 0x%x, CQ: 0x%x, Cons: 0x%x,=
 Prod: 0x%x\n",
+=09=09txqueue, tx_ring->qpn, tx_ring->sp_cqn,
+=09=09tx_ring->cons, tx_ring->prod);
=20
 =09priv->port_stats.tx_timeout++;
 =09en_dbg(DRV, priv, "Scheduling watchdog\n");
--=20
MST

