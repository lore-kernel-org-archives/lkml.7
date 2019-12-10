Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1A2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E73206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8zu9xI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLJNA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:00:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54392 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727317AbfLJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575982857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9e82RZxMOLIpTiokhMnuko25lsVYhsTU5bajYGHD3E0=;
        b=V8zu9xI+ef3gpnHazMZjMQOemwfbPUiWLpeT3GSH+fU7axnNWwqrqeT/vq+xbq3zCfz+c6
        eiDcsdCR/KS2ddqH/NzlgCFExiHmmS0ENFWurm0mHYVu93Shie+Xui8GSLJR8MFLulQJwS
        jDbuqMSVIlD7iz861L2n9MuatQhDVK0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-q3ScnFJDO8iFhLQgwj5CnA-1; Tue, 10 Dec 2019 08:00:56 -0500
Received: by mail-qk1-f197.google.com with SMTP id g28so12151027qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wrMmlrBt1X+KXyyzVL2v0JpYF8+uVnrQFFbGuDQ2s1k=;
        b=WOzcyNnWKgiv/zYg6hi2/66iaaadTZ/neG5fPLe1d+Ja2SzNJeEGK1PsAm44DzKQH/
         sGHNf0G8bP2NmVc8j4k0gU7liO6cJsAPDcnodLb2trQlweNzGStJjZZ90W56saC7sMMN
         2jDRd5ebpuSEQ0nIbfSt1BBLrNf453dKDz+uHtM8ZkQEFmqFHwnV0zoesoIqY3dM3vyT
         BRccC7CqUr6oCdkSt8DZidGGDkA/zwL40jDTiLiUQRqlYrRguh/I8wnTlXlx60mzs1N2
         Ms5I+PmO2mlA2xpo2NAN3ghlsi7lhTZpiwapvZukjJ8bDmZnhZH6BdS8Dpbf759cjV62
         C41Q==
X-Gm-Message-State: APjAAAX/+YaInNfNjk27HOPbOi8jE+1YGe6j0IjQFGzvPo2ulSyuy3Hy
        j24WGIxHuYMJnShSRUM1p5/Olvqsfw9nocR7Tw1uM1wPTvnbv0KG3nxhvDGsBSWDFQLU+yQmQEX
        6Gf9BnnZ9Bv8D4SzwoQwvOww2
X-Received: by 2002:ae9:ec0a:: with SMTP id h10mr30081128qkg.303.1575982856005;
        Tue, 10 Dec 2019 05:00:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdPfBVccegJ+sVSh7D3UbOkyDGw8L3+H+QRIw+97A58lq6K5FGQi/nFFUXP/L4WSIDyLcgYg==
X-Received: by 2002:ae9:ec0a:: with SMTP id h10mr30081108qkg.303.1575982855810;
        Tue, 10 Dec 2019 05:00:55 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id n20sm138085qkk.54.2019.12.10.05.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:00:55 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:00:50 -0500
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
X-MC-Unique: q3ScnFJDO8iFhLQgwj5CnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

