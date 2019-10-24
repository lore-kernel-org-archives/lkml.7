Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6928CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A945720659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsFXKGx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503764AbfJXRZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:25:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53111 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503753AbfJXRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571937918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VpdbFdZ43dAdHsNmWOOWt4oPOrJUSHjTzkCpLMaCuuo=;
        b=GsFXKGx7kTPujXEL9R0eMQjBW3UQn6hApjMIQSS9MxgIYl26NpZScrydsne1sXOafkyrgP
        UudVun8t8HrAH2WFRVgeAgk45iEarGg0GDeTMIkZjq7kV4zGicROM01KYyUO9g0Rfzw2cf
        t9PwKs0ndgPBhiu9sJXW8YzhSEqVz+g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-X1dYfpkCOoCCINBSA3Hxjw-1; Thu, 24 Oct 2019 13:25:15 -0400
Received: by mail-wm1-f70.google.com with SMTP id l184so1545431wmf.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l73Ha7i7WUxT4bY8TPcGyLFhUvLl2Vyl/Ql8ZlKhlJA=;
        b=GXN5jVh11MP7Jm96SBuHm9Pa7xOZLHDuAd+G3hfyQF2X0vJALLmCd7W+ssFK71TpXH
         5fd/Fc4wO21gIlCttH9aBUTucc9g/jhjeBroYW+x1LVlrFyQfMLRNvFytfJVlGEDsAbR
         OxeLJWQCzPfyQgAsLY8L/vvn6so40yOhROhXXLSa6vrpKT2Z2p0fwYXnN7NPuJLfTi1o
         W6xEkZa54qj7Oprb0YW0SbCeGqAx2lplbAoR8a13SZdtD9/uWnYhQr/UmCX2JmX11Lrh
         s4N7zTqe3583QiadhaVz6/xWbbKTcfo0An14u3UPz3tOJouqhA5zew+IhHIp/BOzDeIw
         SD2Q==
X-Gm-Message-State: APjAAAUxH2nh3+XjZrxD640UysCKx72MtA03MnMsTRLnzHt4wqenmYw5
        Tr7/owTB4EcyHO9sy/92sacwEEB0X9jgZ1XZOsfD/SmKG3416gsygcYlucncqnpfSu7vwvgQGrS
        jmFHvykR5BDRE/PfbM/PyfFBN
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr5056834wru.286.1571937913968;
        Thu, 24 Oct 2019 10:25:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHb1xE6BrpQ9IL+1bpB0SlzJ+EkiGGWVx3kl5wPRrTnXwQf2aGUhZCPyS1D1C/Gt0smnGOBg==
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr5056818wru.286.1571937913738;
        Thu, 24 Oct 2019 10:25:13 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 200sm4253443wme.32.2019.10.24.10.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:25:13 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] mvpp2: sync only the received frame
Date:   Thu, 24 Oct 2019 19:24:57 +0200
Message-Id: <20191024172458.7956-3-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024172458.7956-1-mcroce@redhat.com>
References: <20191024172458.7956-1-mcroce@redhat.com>
MIME-Version: 1.0
X-MC-Unique: X1dYfpkCOoCCINBSA3Hxjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the RX path we always sync against the maximum frame size for that pool.
Do the DMA sync and the unmap separately, so we can only sync by the
size of the received frame.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 33f327447b70..15818e1d6b04 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2960,6 +2960,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct =
napi_struct *napi,
 =09=09if (rx_status & MVPP2_RXD_ERR_SUMMARY)
 =09=09=09goto err_drop_frame;
=20
+=09=09dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
+=09=09=09=09=09rx_bytes + MVPP2_MH_SIZE,
+=09=09=09=09=09DMA_FROM_DEVICE);
+
 =09=09if (bm_pool->frag_size > PAGE_SIZE)
 =09=09=09frag_size =3D 0;
 =09=09else
@@ -2977,8 +2981,9 @@ static int mvpp2_rx(struct mvpp2_port *port, struct n=
api_struct *napi,
 =09=09=09goto err_drop_frame;
 =09=09}
=20
-=09=09dma_unmap_single(dev->dev.parent, dma_addr,
-=09=09=09=09 bm_pool->buf_size, DMA_FROM_DEVICE);
+=09=09dma_unmap_single_attrs(dev->dev.parent, dma_addr,
+=09=09=09=09       bm_pool->buf_size, DMA_FROM_DEVICE,
+=09=09=09=09       DMA_ATTR_SKIP_CPU_SYNC);
=20
 =09=09rcvd_pkts++;
 =09=09rcvd_bytes +=3D rx_bytes;
--=20
2.21.0

