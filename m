Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F756CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7E205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbPVcZva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503782AbfJXRZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:25:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbfJXRZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571937924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXOnFSfNhNPTjcWXUtOF+yLaeNt74t+Dwru1WIRQ94c=;
        b=MbPVcZvavaWJcGjm4QE04X6Jxbfw30uPDtibbCAX/39r6u5Y+tvmWxPlNiVyPsb8Xm0kPq
        s3QYxE5lUEGl/byGIpcxLPWuGV6u/GdmMufo0O2KyKpqKqSFY3S33VBPrXqnxMKS2zcOM+
        9JEwKBSsr4dQoKGJCNUlL7cnnobyKuc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-e6puXzvDOx6fQKJSKd9i4A-1; Thu, 24 Oct 2019 13:25:20 -0400
Received: by mail-wr1-f70.google.com with SMTP id l4so10532560wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tLVyJdKCuQgsNv1sXrcha1cG9zhjVmljxh1NemQynM=;
        b=JZalOPNEOo2BeS2GElqpeAoAT9brktG/IVtYZIfPm5lN6ySUAcPcaNeeDjlyR6xjHF
         xBlHJkT+63hM4eTl+lzqGJUVmH82zNBACXwYM6bEbfrhE6KoPUOiU7hPEIZbWJ/lcGi9
         zkfTTQSPsCjyb18oIAk30C5igyhljSWkXmkyojHOMMqq+g6nfNdjhe8vEX7h5rORI1yJ
         L86QDo1HXGXWeg9kj7ibmhy6oET4T2fzttjEN2M5Rpe9JO0nRvVieCU4RJNdCIqmJ+ki
         bz+YY8rboFlMdApfGWvjThRaU4fm0gjX3J5fyVmE3Xn76M5/rQtVh7Tr6xzLt1AM3GQJ
         n3qg==
X-Gm-Message-State: APjAAAWmKrnzyBltK0L8MaauvPitZ50xeLQ/dhiDwMGjcVvt2GYGOqYE
        xTWa8csZhDIvKJKtUhDeCo4EAahe061MmeOkslOD8dZ96OfmpjuoxJkTxNfVCN6Pnw/tUizxwFX
        f9ZcatM7O9r9WgliO/bVAe2vn
X-Received: by 2002:a5d:424a:: with SMTP id s10mr4699710wrr.108.1571937918920;
        Thu, 24 Oct 2019 10:25:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyriwuqPsHKpY30rz7sHHDNla5FgdU0iJGQy5mR4Dg4Ubmi0Cx/2paGQ2bzZvi1RoZnn9Mlng==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr4699692wrr.108.1571937918722;
        Thu, 24 Oct 2019 10:25:18 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 200sm4253443wme.32.2019.10.24.10.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:25:18 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] mvpp2: prefetch frame header
Date:   Thu, 24 Oct 2019 19:24:58 +0200
Message-Id: <20191024172458.7956-4-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024172458.7956-1-mcroce@redhat.com>
References: <20191024172458.7956-1-mcroce@redhat.com>
MIME-Version: 1.0
X-MC-Unique: e6puXzvDOx6fQKJSKd9i4A-1
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

The packet rate increase is about 14% with a tc drop test: 1620 =3D> 1853 k=
pps

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 15818e1d6b04..a55de943d5cb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2963,6 +2963,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct n=
api_struct *napi,
 =09=09dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
 =09=09=09=09=09rx_bytes + MVPP2_MH_SIZE,
 =09=09=09=09=09DMA_FROM_DEVICE);
+=09=09prefetch(data);
=20
 =09=09if (bm_pool->frag_size > PAGE_SIZE)
 =09=09=09frag_size =3D 0;
--=20
2.21.0

