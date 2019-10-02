Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEB5C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F2521D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE/IKrkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfJBVtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:49:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbfJBVtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570052960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6hrbSzRsq3ds3VXbb+ea03n+mD5K/aT75kBKzIeL8jA=;
        b=WE/IKrkTyQBhZsBmGz1Aan8xw9jaSNC2ap8NmwsFAXrUfiLTTqS0DwaaEGHX56O1bQmus8
        HsDxvs3pgSrSLFN9zHfJtJeIG/uE+LySkxW/Vdsi4U08ML1UHdOKwTRnWSIYVUCgXrPSQX
        giO5RxIOEfgLLfzhbCcHKtd7Z0vebt8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-iY6xSkVvNPOK9qwR4X0Dfw-1; Wed, 02 Oct 2019 17:49:17 -0400
Received: by mail-wr1-f70.google.com with SMTP id i15so140049wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Nxu/xtXSQjos9JiDu4uBaxvkGFvYrw3zPm6tflCvQ=;
        b=q3LYISbx62wPFzX9ndevKLy/Hl7N6wmV+P90I19bB1udxcNrEJ888C38jNOsGnA1Vt
         2i3+OMRJP6X4uxwBFmco6gcb9Y59+uKYJ1cv9//8/ga4a414BYeDj8NGZvb7ygpPiwJH
         CRX4dAPMzizWiiSe0ihY+O5w7KzozF3E6Ojswg4v11IWuX6nhnI8Q91ES25LGpAokzZy
         +eMabmLoBVoka8613ypIDhlRmKcadE2TTi1+snzZAENTQ4XS+VzNczeTfgQtI90o4dc+
         1XxkI/zbp2gmQrXjmG+N66hxPS0GYnuoRo4l5QyjzOqeTF6YHJc/Zh+SqbCN9X4Zw8D7
         4lww==
X-Gm-Message-State: APjAAAVVt4Wd7pHvdQFufifib3XFByu/MQpEREHT3Goq745gTyRgdWsn
        2o8hbnpdALuxroosxY2UFIvzyZPOFFT9WS+FvT5J798hdumMWQ+NizngEu62auLAx90W3l5vHdB
        vYH38BNyo95S7C85PNXrwme8s
X-Received: by 2002:a5d:5381:: with SMTP id d1mr4344231wrv.315.1570052956907;
        Wed, 02 Oct 2019 14:49:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcda7tsHRm1GWdgqm+B0tMOadsyXb2f93B2ypRL7Ehj9AtMyoWBctUTBe8ehgAUne8St50sw==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr4344222wrv.315.1570052956685;
        Wed, 02 Oct 2019 14:49:16 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-208.cust.vodafonedsl.it. [93.70.69.208])
        by smtp.gmail.com with ESMTPSA id q66sm965836wme.39.2019.10.02.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:49:16 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mvpp2: remove misleading comment
Date:   Wed,  2 Oct 2019 23:49:04 +0200
Message-Id: <20191002214904.10887-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: iY6xSkVvNPOK9qwR4X0Dfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recycling in mvpp2 has gone long time ago, but two comment still refers
to it. Remove those two misleading comments as they generate confusion.

Fixes: 7ef7e1d949cd ("net: mvpp2: drop useless fields in mvpp2_bm_pool and =
related code")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 111b3b8239e1..5fea65256b9d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2863,7 +2863,7 @@ static void mvpp2_rx_csum(struct mvpp2_port *port, u3=
2 status,
 =09skb->ip_summed =3D CHECKSUM_NONE;
 }
=20
-/* Reuse skb if possible, or allocate a new skb and add it to BM pool */
+/* Allocate a new skb and add it to BM pool */
 static int mvpp2_rx_refill(struct mvpp2_port *port,
 =09=09=09   struct mvpp2_bm_pool *bm_pool, int pool)
 {
@@ -2871,7 +2871,6 @@ static int mvpp2_rx_refill(struct mvpp2_port *port,
 =09phys_addr_t phys_addr;
 =09void *buf;
=20
-=09/* No recycle or too many buffers are in use, so allocate a new skb */
 =09buf =3D mvpp2_buf_alloc(port, bm_pool, &dma_addr, &phys_addr,
 =09=09=09      GFP_ATOMIC);
 =09if (!buf)
--=20
2.21.0

