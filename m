Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B33C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542322080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCuAMHPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfLCUSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:18:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727309AbfLCUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575404331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzfchXBORmVAXVWCchalHt0Yn1js9G37mDNvONQ3Wls=;
        b=BCuAMHPfyZpG8I9aKGXGyLHrazi+WMWRziA54L8OLUR63lFFMJX4KNo4qMZ//xec18ggK6
        qss696NrS7Z15+TTPp6KgBi/bj60ECBf97p0GQLGR1XgRUSAtQ59h8ZUuNDxqjxoN7DmNA
        +J67jEtogTZ1kj7dTcvXqLgr8Acopxk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-zvL-YLsUOz--jNGYvX_WVg-1; Tue, 03 Dec 2019 15:18:50 -0500
Received: by mail-qt1-f198.google.com with SMTP id t20so3343369qtr.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1eT8WcO+phWqOZ5pmGdX1qqI1UY1VLfXJPwN7V6jCjo=;
        b=jht9JJPtVzi6Wh3cYufEF55AhqTbEtQRUGdcJ13uS0qN0u+7V3WsTZS0chi4dvyu02
         tCw/fvpFve9yLCW6qEkOcluHpKpOSA6wn2rDuTtp+PxnHtAp8/W9UFKYkI4keINmRhd0
         GQSCcN3/TJBHyuz+BK/D/bqOvAdQIDWdUUtTJPALGJw8QLxNpoPyPNZUIlLVZ1CgOGB5
         EL0BpZojceyu/qrnXGwY/whzmFEuwWouH+x4jK9bbkeKU1SeiZIO/HGXyhX6Pn+b612u
         6UC3y0wAIjKtnh7lJ5yGXJY6090MLIYH+bJYZoQK88Etu9LnmFw1B8synWDXC+lzU5w1
         Iq2A==
X-Gm-Message-State: APjAAAVgDtI5eqKpayB/tD6nL0VqW3hg+2YjRWIN6CqwOBtiuGKEzN6L
        9sYgWbaSFCnsr6GBSMr7h/4gQn8YhJk+9vGUb5P/Fmy2zsDDPK5DtVWe14n9dN71yWvsM5dU3pl
        RxETrwPsZ99sUuh3pikrh12hy
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr6993492qkf.344.1575404329219;
        Tue, 03 Dec 2019 12:18:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqysczwdd3R/V/nqPtkylMkEJge0arlFCdi6l3hYYdJyHzUT6UlaH9W1E/8BHEBhaPjqmCAnFg==
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr6993469qkf.344.1575404329019;
        Tue, 03 Dec 2019 12:18:49 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id s127sm2357687qkc.44.2019.12.03.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:18:48 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:18:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH RFC net-next v8 3/3] netronome: use the new txqueue timeout
 argument
Message-ID: <20191203201804.662066-4-mst@redhat.com>
References: <20191203201804.662066-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203201804.662066-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: zvL-YLsUOz--jNGYvX_WVg-1
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

Changes from v7:
=09combine two warnings into one

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

