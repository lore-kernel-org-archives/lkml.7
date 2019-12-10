Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0E8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16362073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsY2OEUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLJOYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:24:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727509AbfLJOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575987840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1m4l6D3s+2g8XxkMBtJ4pgp0ukAmRJI6+mhxccXIzk=;
        b=BsY2OEUDdgVNd5BRVVkjDJ11txUdztibqYiWpM66ajiJbcKeBhYYex+GKa4/UxAeEBmrxO
        JyHG2Hw+qrUSN3koYE2Lp0/zV7XvQBVUNT283yT8futGnhQsaue7uTYVx6UvXlvL/N0T3I
        G1tH0AntNNuSO6fiNIGHPq4DGUH+CFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-06WqQzpqM8O5kmwDgk0DYw-1; Tue, 10 Dec 2019 09:23:59 -0500
Received: by mail-wm1-f69.google.com with SMTP id j203so1070457wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arAx5zhnIVjaTnukE0oB8KOOT1PX3zCb62NUiTGRsxo=;
        b=HFqZzaZn3RGa1k4DBtHlgx3FSkFXanG7EFHZ01iu0EBJzg/mmyjB7I3RLczxLHTVDn
         szc+2iDjZwb9LrMgk/p+iuipVcrVEWkMOkwIb5xHkQw2iA5gnYIxhmd4LgvYjyDj5TjR
         mLdDV6fToHda7hjOnlCpWbwlJ/AUOnKjkvn0/5AYNK/FoRH0PVzRa/AnfHbARl+F3e0g
         RWPF+JQO9qasLwI3er2GsMhMDZQZuqdMPDD2GEn5Ngmms/m/7E2KVEPtbNJ95Ye9Fjbv
         Kkmo96rgQeDkmKG1TuS1TBmRVDcTr2T05WEtlufaNojbJsj6GPZhq2/PpFJFLR+bCF5b
         c6kQ==
X-Gm-Message-State: APjAAAXNq9wk7GDD/zeuECZ6DKW8DZJXCPN4YmKown5pcH+aOpIj1axF
        VWMGtbyZS/sYk5tCvRB/A+2gzc/EqAzF9p2atDEfzbPa+kIRMJrwOKORk0q5V6NS9rXuT5VVsQD
        yNYfWQjx1r2zBovDFm+sJVqnc
X-Received: by 2002:a05:600c:388:: with SMTP id w8mr5408429wmd.177.1575987837744;
        Tue, 10 Dec 2019 06:23:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3iXOMR3qEF6e0xi6D2sYK7FHbDpCppXr1B3M6TQgnyG1PzoKqeN8Vu22ZrU4aPQPWYkHNDQ==
X-Received: by 2002:a05:600c:388:: with SMTP id w8mr5408414wmd.177.1575987837599;
        Tue, 10 Dec 2019 06:23:57 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id a14sm3533644wrx.81.2019.12.10.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:23:57 -0800 (PST)
Date:   Tue, 10 Dec 2019 09:23:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com
Subject: [PATCH net-next v12 2/3] mlx4: use new txqueue timeout argument
Message-ID: <20191210142305.52171-3-mst@redhat.com>
References: <20191210142305.52171-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210142305.52171-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: 06WqQzpqM8O5kmwDgk0DYw-1
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
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/e=
thernet/mellanox/mlx4/en_netdev.c
index 71c083960a87..43dcbd8214c6 100644
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

