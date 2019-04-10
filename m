Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EC2C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABF62084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXCIGi+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfDJBAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:00:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41098 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDJA5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so776322wrq.8;
        Tue, 09 Apr 2019 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Chj9KtDJT/wkGeKvUfmnO4vF/AIJeuWUVWocJsy+PHU=;
        b=NXCIGi+RJCCgPNV4NZMemb7PhHBtkjdA+eRXmftexQfJL+t+vfsgHOpLOctK/NedlC
         nVEedgBecY5cTX3TzdyXixn19om4vO77qb1kwzwC+DdRjk4KoDDa7lyLrZTGYUdWFiK3
         qQcsJJkqUHXLNbAHiXeZ4fBCAYejVf9ZqyAPCkmeNqo5UhUO91tChjsnY5VxV03dfmly
         3qx8tfPXXHFlXxiAZJRYxl84BWsXVRmpPG2fyiWjMnGFbGdvJkVqbyT/bR43UJnKpwIe
         EcJvGIm1d7JX5Qob6sJ2SEmnUJ07sMw/uGUg3p/aKckJ/oEKKumkCj8vQM8rNAJU2KJf
         /Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Chj9KtDJT/wkGeKvUfmnO4vF/AIJeuWUVWocJsy+PHU=;
        b=D2Hwcqco4c+z6nanQaPmCwthze91n8yzdsv5dAzV9yRDTNjl1NRlKyx81GFvC6RNbZ
         SJzWiQTx6UC4zZBssslVUjyW/CQKaW50VBGHdLXfDVzJ/SWlX2h+5jr70iI3eCVpvgM8
         92WodS2B3S4scGMq5kZoSEWiOSjo46TvzxriOdF2k34Ye784u//RZq/7vO5CaFcMmUxg
         KIGO4D/pP4GGe0UFkugGwbNjoe/RDzBFjctgX/XxNRkhQwXG7znKSnocTSJDVeB3Rj/y
         UYn5kDBw6HqK8Hb4z9VeIGMXD7tcGjwBi4lHk5RhP7FHBoZyfrzvlOghbFyKID124f1y
         k0bg==
X-Gm-Message-State: APjAAAXwu6NSTL7mnxdDZS+hmegh+q10jZBlj6+JACp87EbSkqhPjFaB
        YHRkc2q2zNec9y9b4zKgSPM=
X-Google-Smtp-Source: APXvYqzL+tXVDORnvMhry6wvtupini6Qb/9eW+tQUHDQVEP/9h7JdnuMpy0YSsc1Et918sUFmGZQAQ==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr19421699wro.189.1554857841861;
        Tue, 09 Apr 2019 17:57:21 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:20 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 02/22] net: dsa: Fix pharse -> phase typo
Date:   Wed, 10 Apr 2019 03:56:40 +0300
Message-Id: <20190410005700.31582-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
None

 net/dsa/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index e1fae969aa73..fde4e9195709 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -196,7 +196,7 @@ static int dsa_port_vlan_check(struct dsa_switch *ds, int port,
 	if (!dp->bridge_dev)
 		return err;
 
-	/* dsa_slave_vlan_rx_{add,kill}_vid() cannot use the prepare pharse and
+	/* dsa_slave_vlan_rx_{add,kill}_vid() cannot use the prepare phase and
 	 * already checks whether there is an overlapping bridge VLAN entry
 	 * with the same VID, so here we only need to check that if we are
 	 * adding a bridge VLAN entry there is not an overlapping VLAN device
-- 
2.17.1

