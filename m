Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807ACC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EDC2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX6E9bvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLCHcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:32:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727469AbfLCHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575358341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8wShJUZhIPRvHwuVROe4jfsRpfx1Wn6vaFNLNcy50o=;
        b=YX6E9bvb8p4mIGoJVYo3yuUkWdtqVNHLGYI1Qd8hKHjPbnuhJaKx8qId/FXTZRLCzyJDeV
        R1P+fMNY34YgdZd8LRygRUs+3eyVCi/m9SkvOZoRCO+5UrFOD8CFI67jQdmcN7/gYRwN3t
        BiH8+YBh5+nAkNXI5BfjYFt/lS0VRy0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-dTjvKjIhMu6Rmaimuxe-SQ-1; Tue, 03 Dec 2019 02:32:20 -0500
Received: by mail-qt1-f199.google.com with SMTP id c8so1783275qte.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 23:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwSFHekH13o2QJMVsrxXSIHF6QQ380ubnLoCLySwb1o=;
        b=ZDXWQ6CLjRIGYhdJ2IGbQdh04ASLe0pDReyUw0ZuffHTlysdTPXEOx1flu6FGbGYEX
         dCs1GgaH/xO9dKo98hdbNczgUPoSX8DRMx+WUkdt3/nP7IPv3rsBdW2jKlJwN4FoV6yz
         JuRsrACNGb1YtShXO1nGE5rW3ygVLd+4mbtxSOeweoMBp7nVogdIhWYZBu7gGx+FC7Oa
         TIZov4ZuUsnEpRvbUqwZfpHQ7DKIIb0A7/uQgxCfBwbccjhG5IHeIGAgNfji58l6oFbG
         8VpaPk7YDswFuDYFCUJHeedG72ar7zX02TKb4PGWuxmQm1CLSbGDxSIx/4JAf7pwDcSA
         A9pQ==
X-Gm-Message-State: APjAAAXkLqWHSCGzfSaQDPmZ6HKeg1DFVHwrnvd27aa8S0sypHQ0CHbl
        MDD/iMtsYElx1Z22hx+o46lJOWqupZYHD7X5qPvtC1DrN6TfqAnjK8aA+PZHY9BF+GMJcu78lqo
        mNVQC77CUwlrHfm65FAdIFrGF
X-Received: by 2002:a37:404c:: with SMTP id n73mr3711279qka.292.1575358339505;
        Mon, 02 Dec 2019 23:32:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPaIxtXBZQ4fHmWb1RYGKoL1DTAUuB7vZrs880mGPQQ0Qr4coSTbpggTuqOoohiw8W26zU9w==
X-Received: by 2002:a37:404c:: with SMTP id n73mr3711260qka.292.1575358339311;
        Mon, 02 Dec 2019 23:32:19 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id 132sm1285704qkh.14.2019.12.02.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:32:18 -0800 (PST)
Date:   Tue, 3 Dec 2019 02:32:14 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        oss-drivers@netronome.com
Subject: [PATCH RFC v7 net-next 3/1] netronome: use the new txqueue timeout
 argument
Message-ID: <20191203072757.429125-2-mst@redhat.com>
References: <20191203071101.427592-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203072757.429125-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: dTjvKjIhMu6Rmaimuxe-SQ-1
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

untested

 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/=
net/ethernet/netronome/nfp/nfp_net_common.c
index 41a808b14d76..26f1fb19d0aa 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1323,13 +1323,8 @@ nfp_net_tx_ring_reset(struct nfp_net_dp *dp, struct =
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
+=09nn_warn(nn, "TX timeout on ring: %d\n", txqueue);
 =09nn_warn(nn, "TX watchdog timeout\n");
 }
=20
--=20
MST

