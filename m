Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4C5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A83521783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnnv74Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfJVOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:14:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbfJVOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571753685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3mPV7Lvqud62ejV9ltsaZ32Xw/m6Chr/EI0mwJ2l8R8=;
        b=dnnv74ZckAe18m0+YiFthesAW314sKo1B2kOIrxYqH5HgD+9KL6lwi/AT+eCxaiH0P1wJR
        TXZ63nTmaPcH+Xre8A5KaZTQG5nlIela2A+Dr+32QIKqoBcuLHyIJ+cmLeKo4Mi4AsCLkR
        1x/rcsEBlDDYZHPk+uOzMkrRB/cRekY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-bO08ke6lNK-x6mA2Oc_shw-1; Tue, 22 Oct 2019 10:14:44 -0400
Received: by mail-wr1-f69.google.com with SMTP id l4so6573124wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMPt/t32x+1ODJs2XSy8W133vtfVEltVTT+TH3yLruo=;
        b=uNKxH6xy6Sdr2FWA9GhT/VMVn2I4mitiH564I0YwBfnx6NwvjhhYsCXWwpODGMb/gH
         WUmTFRCwXvQ6U2DWScmuEPfZPlpLEMfNUD25ozwlkIn0RbJ6NQiLn+eBCk0X7UPjSOgq
         Fquk8yH4BMPknLv42YtJULa9GCQLAbwbA1RkhZrezXoInFCJAYCXYQ+mwOjvQGCbzUXD
         UeBu4xwhhVutsTNb7d0a7gTGxzoW+c6VjRgHD6yslPRTlq8HsM5ecTkINBrCmwW+X4kW
         j0reVLnAUoSpm/XZl4iUZ/CBf8dQeiyCaZ1cLEjMptZt+x7o1kbXLMNGXpA4oWfgTtf7
         RDeg==
X-Gm-Message-State: APjAAAWVcQpUkCRvc6+zusBs+jGJRmIWIjm9DtGvFftJL4uXxbT/wmeZ
        RsdgXkSWqL1Qc5dIIAn5RaDTlNR0JSiukoGjH0GAoKdktfp2AdZmgc3yHBIz95enSiOEo1G1DEu
        Q92yIT4dFg5nK4eu//xmJ0FC1
X-Received: by 2002:a1c:1a95:: with SMTP id a143mr3101176wma.85.1571753683076;
        Tue, 22 Oct 2019 07:14:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwjYxSC4lQ+YDOYHCxAn6MLTwUvZVS5nL+m7CEVs7fbxB2mvutslNDGc4MQu6FR+JAKOxH8dg==
X-Received: by 2002:a1c:1a95:: with SMTP id a143mr3101149wma.85.1571753682811;
        Tue, 22 Oct 2019 07:14:42 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id r19sm11625521wrr.47.2019.10.22.07.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:14:41 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mvpp2: prefetch frame header
Date:   Tue, 22 Oct 2019 16:14:38 +0200
Message-Id: <20191022141438.22002-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: bO08ke6lNK-x6mA2Oc_shw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving traffic, eth_type_trans() is high up on the perf top list,
because it's the first function which access the packet data.

Move the DMA unmap a bit higher, and put a prefetch just after it, so we
have more time to load the data into the cache.

The packet rate increase is about 13% with a tc drop test: 1620 =3D> 1830 k=
pps

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 111b3b8239e1..17378e0d8da1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2966,6 +2966,11 @@ static int mvpp2_rx(struct mvpp2_port *port, struct =
napi_struct *napi,
 =09=09=09continue;
 =09=09}
=20
+=09=09dma_unmap_single(dev->dev.parent, dma_addr,
+=09=09=09=09 bm_pool->buf_size, DMA_FROM_DEVICE);
+
+=09=09prefetch(data);
+
 =09=09if (bm_pool->frag_size > PAGE_SIZE)
 =09=09=09frag_size =3D 0;
 =09=09else
@@ -2983,9 +2988,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct n=
api_struct *napi,
 =09=09=09goto err_drop_frame;
 =09=09}
=20
-=09=09dma_unmap_single(dev->dev.parent, dma_addr,
-=09=09=09=09 bm_pool->buf_size, DMA_FROM_DEVICE);
-
 =09=09rcvd_pkts++;
 =09=09rcvd_bytes +=3D rx_bytes;
=20
--=20
2.21.0

