Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829BBCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5474620659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGVn7exy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503751AbfJXRZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:25:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36799 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503725AbfJXRZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571937910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eP2BoDS+qKrOlRNhNKzclArVzVRVn8mElyDMenO637o=;
        b=eGVn7exyLJJCrgjP+2Gu3hw9XjVzcS5fzgw1/IkygtvTyeOfhA6SI1IEoynMj2LHWC+dQZ
        ttlAcCW5f8mWPR8FHDXUB36AHh5SVlQ4AD26RETXMnXWrRFk6ojTa/4NfbEmDNfkLiY95E
        pi48T08Eru7uNQKxQy7fYce+j7HpgJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-OkiuWhTnNpmoMk868-NPYg-1; Thu, 24 Oct 2019 13:25:09 -0400
Received: by mail-wm1-f71.google.com with SMTP id o8so1265586wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEHK/Mm+/W2s4S1uZhkuoDS67kM3geWIeg5D1P9O+N8=;
        b=qqxxeomcxEQaWEyOZn1PP/dBDTHI45GdNBELl1FXUWTuFQPAEUk/wYxB9ZYomsAcrc
         fgp8JdnbDXFwMCp0gLnAiCRNwblmY69VIspZ/XAzzlxbYpnlmKazMKV32lcAaHG017O2
         XoF5rPGmqnMfYV/JmqEurkPmc5n2JGKm0T6V49ZHBaMmuH/5ImKykvD+lGDmhD93HWCv
         TehHP7cShqaYNJv6oWtjInmOdwA+nww7lo/7nyMdDdpkK9Zurf25EPFvQi7deSq0/Z1p
         hcaoZzfd/S4zLnl/Ni2q3LdxKH7PAzyKUeO/xnffGJwEMFjNjl1xjzKd16aamfQmbM57
         HJbw==
X-Gm-Message-State: APjAAAUPcvU+4CDR7AVYKJAnZvTnsT3T/2i0pjnfiFo19/aPviPxEcEH
        /lphx28cZOIEmTiQeDKB1uvJfDrqwD3VPwd1mzeG80y7V0xViAr3WFSTQ3umV3Zg9WcKL1VsGXv
        Ec16scu4+OX+hk7a5PL/vynNe
X-Received: by 2002:adf:fec3:: with SMTP id q3mr4844752wrs.343.1571937907943;
        Thu, 24 Oct 2019 10:25:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+10+EuLZ+rBVSTixGZLcQx5XS8FxFqlBPvpQbaowcsIkiyMX0FX0F2OQ+sQ4I41O86D0+1g==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr4844734wrs.343.1571937907744;
        Thu, 24 Oct 2019 10:25:07 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 200sm4253443wme.32.2019.10.24.10.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:25:07 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] mvpp2: refactor frame drop routine
Date:   Thu, 24 Oct 2019 19:24:56 +0200
Message-Id: <20191024172458.7956-2-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024172458.7956-1-mcroce@redhat.com>
References: <20191024172458.7956-1-mcroce@redhat.com>
MIME-Version: 1.0
X-MC-Unique: OkiuWhTnNpmoMk868-NPYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some code down to remove a backward goto.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 111b3b8239e1..33f327447b70 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2957,14 +2957,8 @@ static int mvpp2_rx(struct mvpp2_port *port, struct =
napi_struct *napi,
 =09=09 * by the hardware, and the information about the buffer is
 =09=09 * comprised by the RX descriptor.
 =09=09 */
-=09=09if (rx_status & MVPP2_RXD_ERR_SUMMARY) {
-err_drop_frame:
-=09=09=09dev->stats.rx_errors++;
-=09=09=09mvpp2_rx_error(port, rx_desc);
-=09=09=09/* Return the buffer to the pool */
-=09=09=09mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
-=09=09=09continue;
-=09=09}
+=09=09if (rx_status & MVPP2_RXD_ERR_SUMMARY)
+=09=09=09goto err_drop_frame;
=20
 =09=09if (bm_pool->frag_size > PAGE_SIZE)
 =09=09=09frag_size =3D 0;
@@ -2995,6 +2989,13 @@ static int mvpp2_rx(struct mvpp2_port *port, struct =
napi_struct *napi,
 =09=09mvpp2_rx_csum(port, rx_status, skb);
=20
 =09=09napi_gro_receive(napi, skb);
+=09=09continue;
+
+err_drop_frame:
+=09=09dev->stats.rx_errors++;
+=09=09mvpp2_rx_error(port, rx_desc);
+=09=09/* Return the buffer to the pool */
+=09=09mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
 =09}
=20
 =09if (rcvd_pkts) {
--=20
2.21.0

