Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D1F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlSv/r5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLJNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:09:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51691 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727541AbfLJNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575983387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1m4l6D3s+2g8XxkMBtJ4pgp0ukAmRJI6+mhxccXIzk=;
        b=hlSv/r5MNr4Vl/FxYocNS3uHINq0UEwyhdU3iJucUI706wn6xQJmn4rq6VO8CBWQx5jIRA
        KJTuKWcsWrGt9AGcZdRTpKqIflShXz+kOOos/cuvP96fJx07GEYt4DAegMkkm2ILWukba4
        Ez/cQ1SEY5vodIJqW47TPnFwdWS4pWY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-b5gIHD82NGSun5koszxZWQ-1; Tue, 10 Dec 2019 08:09:46 -0500
Received: by mail-qv1-f72.google.com with SMTP id p9so6744769qvq.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arAx5zhnIVjaTnukE0oB8KOOT1PX3zCb62NUiTGRsxo=;
        b=mJbZM5UIWAL6aWC7fQWIGOWXuNjWLNVhI6E4R3WE7HDXseiPKzubo4dA9VB2HdamFE
         7n/vNzR076W5wbiUefT+ZRI28vP0G6BQ7W06J7ISZkUMh239LdV/LpddkeeO+W8ET6Yv
         X4BkgyYvk+9StVpkTb7zE9X0vAQpLxBxyl9UYk03DvweSGb8UmStoK4l/QhD8Eu9mcJk
         cjcXgzBDdqCXK6Xq2OZsFN0jtv+D4usL2GwzC6Npc55sZdh/v6osqC/UHqTCe0ocjm/R
         gdefy4BL+5Tb4lbCFiV90FIBjMEkAr2yZAhCBe3l0Y9mcyEtM95PSMM+3Tc/2KfUHL6W
         eqfw==
X-Gm-Message-State: APjAAAVBk95LsIp+YXBgHTeYQyMy7vUI2bWJ2CkvjN11ReaBAwu0jobI
        8d1Ya55Jr3+PsiRhOssYtalPVMaTnuDDhX1zhi5tbCpM2Ec4rGJYVfJMDmwKI3Cj8OZWT4fc4Fj
        RJB7RuVa/B/cS6aK2boH4lYxV
X-Received: by 2002:ac8:1c4e:: with SMTP id j14mr968376qtk.300.1575983385753;
        Tue, 10 Dec 2019 05:09:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0NdqPQY5+CMuG066RsSLy1C9s67XUjynq5xyNWeBMJDtPlMed8sZPRLdRNcHBm75IprM/Dw==
X-Received: by 2002:ac8:1c4e:: with SMTP id j14mr968365qtk.300.1575983385613;
        Tue, 10 Dec 2019 05:09:45 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id w29sm1102558qtc.72.2019.12.10.05.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:09:44 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:09:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com
Subject: [PATCH net-next v11 2/3] mlx4: use new txqueue timeout argument
Message-ID: <20191210130837.47913-3-mst@redhat.com>
References: <20191210130837.47913-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210130837.47913-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: b5gIHD82NGSun5koszxZWQ-1
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

