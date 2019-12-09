Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B33C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D3520692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtgdPaUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLIQ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:29:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21392 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726408AbfLIQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575908973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNvyL4Y9eRzqtb2H2E84LxRf2YADQJydGhMMLpn/rvY=;
        b=CtgdPaUXHLr7wOYSR51eTk3XjiAgFnLa4/BHk6Uy7LJiRBJrDGTHpgwpwT8WAYWOeXZTMQ
        Z+DlxrfqC9i+CPyWbIxq29xfAjOYS+IZwSAX8j0SLiMm82HGqcFudxJx6YZMjLUsWytbeg
        DnKWY3vd9yN4H/t+Xyu+lw8P94vAA7U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-kC_5v7YMNQCgVDUGvrysxg-1; Mon, 09 Dec 2019 11:29:31 -0500
Received: by mail-qv1-f72.google.com with SMTP id g15so4909307qvq.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQxMVxgAtK5y0CyKs1BCEj6d5vwE3qN67Xvd5FZmfgk=;
        b=V18p9fxar1LM0QJHY4BU3GNkwxo8Jewya11oBpgt/lwy2Zqp65lmWzEO1W1zrwwkFn
         L4tWV0aY4flQ4vECxM8iQUs3Jq7faTVnr0rguYiLNrDIKLEBadW92PvIrs+CrGT4rUri
         QCAVTqcUvi9JlabnFLRXoLb0IQFtB6rVQSf9CkfnhG0JvH3yQ2REVg8DL0MkXy3qM/+J
         SPuEH7bLY0wxNyy6nO07bCqzGgw0AVi6stHtsZd96M308ZGIyCEv0Sf07ZZq3utx1JTs
         ZBTxO0RLYz22r4Ksb+Jw2ZI7aVAHReKqAuyZxvZS3zjhi8zBVzoQo2V/eF3kDH5Kd6/t
         juYA==
X-Gm-Message-State: APjAAAU/K77ZDwfs3i67tjb8qjxUqdwyj/Y/YuKxs4z4lO8cgBg7nnuM
        TDwSzYiSJV11D+1m3aKgZEkWpQFfQfYapr2vpgj3Jm6Ad76rJTIT20BlaVK0u/J/WxB9HY5cIjN
        ldnpEyHJK6Inb5Q+ZFgKjoOrp
X-Received: by 2002:a05:620a:899:: with SMTP id b25mr6205351qka.197.1575908971023;
        Mon, 09 Dec 2019 08:29:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFUcc6D6y2hR3oAFJBLyCpXqAb6UQCleKthwatt7HxCSSIjpA7ZaRTzyQmAILOaUj4yhzSHQ==
X-Received: by 2002:a05:620a:899:: with SMTP id b25mr6205322qka.197.1575908970851;
        Mon, 09 Dec 2019 08:29:30 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id f19sm420087qkk.69.2019.12.09.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:29:30 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:29:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net-next v9 3/3] netronome: use the new txqueue timeout
 argument
Message-ID: <20191209162727.10113-4-mst@redhat.com>
References: <20191209162727.10113-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191209162727.10113-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: kC_5v7YMNQCgVDUGvrysxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20191209162925.am-9jZmMn6_dEvS0ibjs0MahRRprQuhWap0AQARiylc@z>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/=
net/ethernet/netronome/nfp/nfp_net_common.c
index bd305fc6ed5a..d4eeb3b3cf35 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1324,14 +1324,8 @@ nfp_net_tx_ring_reset(struct nfp_net_dp *dp, struct =
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

