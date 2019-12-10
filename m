Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32B7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91382077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8ohfh20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfLJNJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:09:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727421AbfLJNJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575983365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNvyL4Y9eRzqtb2H2E84LxRf2YADQJydGhMMLpn/rvY=;
        b=i8ohfh20OiFjRcrmIMX+7VPcH8sqk/OLeXfzv5GYWsRq2z1CHTjSy2w42mTY4J+HQtMX7F
        o/HZvqIeh57NXt/HJxaLbbX0p7sTVSPYze3jMHMEMID7SWifQOB7F1acN+2c4uFmfUf8/d
        phvrJ5lOBRckI8e+0PNSUqwIzFWCrps=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160--n0XPiBcOCufKblxPn6lzg-1; Tue, 10 Dec 2019 08:09:24 -0500
Received: by mail-qv1-f72.google.com with SMTP id c22so6788506qvc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQxMVxgAtK5y0CyKs1BCEj6d5vwE3qN67Xvd5FZmfgk=;
        b=RXY3dcF63mAmIw5zPckM0Y47IySBJblbLtV3f4D7GVVZustW1b8PDvrKvMr+KWjAIp
         NIaYUVWT1yG0NDTz8N2KWQ9bZUqKPDOyEIG2YcachwP1jAQCUkNaziMQUDEzLnN5oUUn
         A1qdrWDj02p066/u3ytDVb1JS1BBVW9nvDVUb3I66p0I4nmAFCyurE+LeYM5mak+aeYm
         iTtLpMKC6U2URBTgSF4+7WNmOmxDJghfSSX/YF0xbQBjF5XJplqLtB+qo0/8ypucJsbb
         qngIfAl7lcYg/k282g1PEHbX8RzV9kU58Bd3q+NRQt2fOTZLEZ36y+VQuio7VnkfM8ut
         4mNA==
X-Gm-Message-State: APjAAAUL5SIWnH/+yVmClbrXFkt/ajsw7WIBxK4sJO78evBh1DtM4024
        1JLkw0m4w0AIIYl5RTr2gWPNCwn/SbvMIr6oALW4GqX37t7Alfmi7t/fSIop5xvtBc7rE7he/5H
        jBL2YDAUslnu18Uqu926mHKdQ
X-Received: by 2002:a05:620a:911:: with SMTP id v17mr12704473qkv.251.1575983363389;
        Tue, 10 Dec 2019 05:09:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7ER+Suti7b7WGSHiGKo0njA6UpaXbA4+jGOZ4LZZhkiLlbT0G0TM3FUm0G1znF25VZZnGAw==
X-Received: by 2002:a05:620a:911:: with SMTP id v17mr12704462qkv.251.1575983363208;
        Tue, 10 Dec 2019 05:09:23 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id x32sm1074057qtx.84.2019.12.10.05.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:09:22 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:09:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net-next v11 3/3] netronome: use the new txqueue timeout
 argument
Message-ID: <20191210130837.47913-4-mst@redhat.com>
References: <20191210130837.47913-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210130837.47913-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: -n0XPiBcOCufKblxPn6lzg-1
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

