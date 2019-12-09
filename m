Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA34C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0C120692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OplCVjKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLIQ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:29:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726562AbfLIQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575908963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNvyL4Y9eRzqtb2H2E84LxRf2YADQJydGhMMLpn/rvY=;
        b=OplCVjKrQSFLDMx/tmvrPsGWR7m0hGjhyqJ0G5TJ73BOQTEuNV+rxXwF87MkIL0jP46S2S
        GDltfyvLtnRarPiz42sRnEy0j41hE+ibyd27us4fB+KjX8PowXkqeDgiagb1EAoMsNb39I
        xeY4GH+iwxjBxDr4s8Qpyuv5XUmh1t0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-tAbvzKvuMXmwhfb7sJlOGA-1; Mon, 09 Dec 2019 11:29:22 -0500
Received: by mail-qv1-f72.google.com with SMTP id a4so4924223qvn.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQxMVxgAtK5y0CyKs1BCEj6d5vwE3qN67Xvd5FZmfgk=;
        b=VNt5zOAeDM70NhOOBdGXKoiGsfCS9WBmThesBF40SHxXV63CquOS3josLIhjhLjsid
         cO77iRjL/jLyY9N5DQRXg0/zcyKBXX98fgYC+amxds0MqewVhqHXVCvXpwe0PUBMIq37
         AjgvdUJ3xhnUTigNkLFpzmCodJ8XdWeh53VLt6wEvAZM0lqjf1DeP3aYEifE/zGMYnSM
         uqBghtOkRi6SOKbFqJcnQVYV816VCNeXO2npgSTjkV1tQtkFct/alAnX+iHUbDBsAZQJ
         dOI1viAs1GoNGLn+97EKmsSd/QFsMhyS5arCYrqjqxsQLl3CezET9zh5osa9rEwIqJcS
         JZ3Q==
X-Gm-Message-State: APjAAAXAzQU0rya0VYRKA+t2IUTLkSFz2scTzoteBXGiHbq1RYe9UnLp
        m4ym8TIvQteCNN/CdMhX/MCo3mYS/Qx0A2oj/9km9jhlG7cSO+/GHlsgaB+J/I3x2/xYd/M9I/r
        q6rv0/v/GJFh7CqGAp6D6p/0s
X-Received: by 2002:ac8:7699:: with SMTP id g25mr14525697qtr.75.1575908962218;
        Mon, 09 Dec 2019 08:29:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBHx4JNZAzW5zOl78IJTl/Z39c+yCCpUqxZ1MccFYIr6NFhza1xXBFpnvMlezVfnTZjFAmuw==
X-Received: by 2002:ac8:7699:: with SMTP id g25mr14525689qtr.75.1575908962077;
        Mon, 09 Dec 2019 08:29:22 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id x19sm19777qtm.47.2019.12.09.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:29:21 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:29:16 -0500
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
X-MC-Unique: tAbvzKvuMXmwhfb7sJlOGA-1
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

