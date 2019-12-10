Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB60BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5C12077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce1UR3Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLJNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:05:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56076 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727443AbfLJNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575983099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eNW85TJiVrfXL/ZGCG2VfYculhggK+TL5+4s0Y/nnQ=;
        b=ce1UR3CpE4y/k4EUbjyl4ZIhwJYFHWjErayZIBXJb/TTwP7YcGL8a/WNfdlw1zaBKXW8lw
        1RAYJxZ3LUxYN9FnRYX4FMSp429nJmxQfY58mMvIAIz3JVSu5tc3Tf4coCXnnrmqfVBEqk
        bZ89ZRFcIIxJo2P0oSM6strEYiXvk6g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-KqErqmgVO1udH-BaZ0clNQ-1; Tue, 10 Dec 2019 08:04:58 -0500
Received: by mail-qt1-f197.google.com with SMTP id h14so1823095qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9ppGS7fm6SZMGx/U7neET6k7mTCQfQI5kEQjvcd/YA=;
        b=pC5xxNT7MBrfMp+iD3GmdGjiguOWxfWMaDAszPIntanzn69yPpIDWulgMhz0C84x9B
         hy1kEcRrkc9vzy5JQ55ky+2OJsKtA+k+aSlj/W0iGJhgw2cyfNeci+99fOl3Qse6OfnV
         nDEpqWG4TW5zGISrk87JmZ+jqykS94rJnHuXha+luJKBBWcgUuEw1FMoGlElhBc00nNv
         TMg6CeJFjghL/UsThRatvGmawf5s79Jo1tX9FGST/RXyrP0+20pkE2G2O/wrqNStomAL
         bexzsijFWsBBifopooxyo5fVhmCO3oOKgSDInCx1lHZEktERALEm9FkVLl3IABoE1dCK
         wMVw==
X-Gm-Message-State: APjAAAV2/N5PUy98bEdBFyH7ziIZtDLeH+fNY5UwM8dEaib2YFN4lWrz
        KWQ0iqaPla0U6dyWsqdLPZs9qwvlc3loneWLqIB6s7Tla7lXoxqXCBx4SCZr/plai+dAgf2mY1+
        DUhrqhFoOAgzxEOUTzbDwymTu
X-Received: by 2002:ac8:936:: with SMTP id t51mr27723084qth.212.1575983096249;
        Tue, 10 Dec 2019 05:04:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWPe3g8zfEiNjmoeJrevzpnBuyLsoh4sh45qptZPEMLWSJ0KDxY9JnMocSEHn/0pDfmr1CGQ==
X-Received: by 2002:ac8:936:: with SMTP id t51mr27723059qth.212.1575983095995;
        Tue, 10 Dec 2019 05:04:55 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id d23sm1112811qte.32.2019.12.10.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:04:55 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:04:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com
Subject: [PATCH net-next v10 2/3] mlx4: use new txqueue timeout argument
Message-ID: <20191210130014.47179-3-mst@redhat.com>
References: <20191210130014.47179-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210130014.47179-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: KqErqmgVO1udH-BaZ0clNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20191210130450.6ENvezvD7NbmM4CUSGaIbpgKrjw3hGMUucyUPj-JhIg@z>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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

