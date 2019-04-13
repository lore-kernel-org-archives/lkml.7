Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0541FC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8464218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0lSxxLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfDMBaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:30:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38518 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfDMB2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so13009424wmc.3;
        Fri, 12 Apr 2019 18:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SbUxWC7ocAPcnPndePq12ffMIMYmJrPizxLl3RKPd+4=;
        b=f0lSxxLlkYlNmEWCR2zFD9Xz5agbfUlNMsjGhNIhwbF5BbcI/m4qEA4YLFZIHsQoXs
         Qn69NdznEzYWmI7VJ9IpfBZcg0E8fy9gj2PwNF7R+arAzpy27tNj9qqrImt8AHeRA5lM
         LeahW+dKru2S/DLJykm2XGW0YVUbOOUpUGp/pfyOWs7n0vJUdBldf6RTNjhfXCDF+jfZ
         YuHtrm5v9OCHzvahsjbJmcehRTrrOaAtYh8lRVTf6iPCvEg6CVP+6X606j1SPuOgyh4E
         2wevOPD09nuU6w1q3Qv+y3gQBE5a/UbLzSBUQrN0QdCeurTF1vLcWWAJK4/CQGx4diuQ
         SJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SbUxWC7ocAPcnPndePq12ffMIMYmJrPizxLl3RKPd+4=;
        b=TBPb+rWe9kxI4C19vbkL2pfGi1f91r02EqyId/Z6h3CPoml4irW4OWkMkVL1c4WIzB
         KBC5EFiP8Qn2sPQpkvhF3AKOnsi9BTP7bNPYOzT8Nrw2IyvUYfrNMvFsUE76d/kmQUHC
         MKo0aALq6P24YTuskggxEHom2340vLPwGqCm/bPrTks9Gh7gNdTALC9KOtn3fe/lknh+
         Xq6Jy4zFGmGB1dPpao2BPCb/I9E2ycNndKU8S8sdoZcUP2ptSrzlMbUO+/Uj9jzAbvnJ
         If0tFwDUnLBp5ozB8wYVqHRG9eGRRsVVihrEnKGGPZEOzfqFA4lnJYlnDZmS6sBcjz/f
         OwCA==
X-Gm-Message-State: APjAAAVk/zMdE/9Smgc3GUbgrFkVWG7qjaDCWfL1ZuElJYSNqgPfyJo9
        4iWKlVmKD/52C+gnziOwY6A=
X-Google-Smtp-Source: APXvYqw6wLgcwiv0fcPq6tie4eXkC31jiakyzpcLGx5bzAYUAxVmEfAzXxT9//ntYih2K/TV4OSFBQ==
X-Received: by 2002:a1c:2b41:: with SMTP id r62mr13801383wmr.94.1555118923077;
        Fri, 12 Apr 2019 18:28:43 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:42 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 11/24] net: dsa: mt7530: Let DSA handle the unsetting of vlan_filtering
Date:   Sat, 13 Apr 2019 04:28:09 +0300
Message-Id: <20190413012822.30931-12-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver, recognizing that the .port_vlan_filtering callback was never
coming after the port left its parent bridge, decided to take that duty
in its own hands. DSA now takes care of this condition, so fix that.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:
Patch is new.

 drivers/net/dsa/mt7530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8bb0837792b1..2279362450fc 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -908,8 +908,6 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 			   PCR_MATRIX(BIT(MT7530_CPU_PORT)));
 	priv->ports[port].pm = PCR_MATRIX(BIT(MT7530_CPU_PORT));
 
-	mt7530_port_set_vlan_unaware(ds, port);
-
 	mutex_unlock(&priv->reg_mutex);
 }
 
@@ -1019,6 +1017,8 @@ mt7530_port_vlan_filtering(struct dsa_switch *ds, int port,
 		 */
 		mt7530_port_set_vlan_aware(ds, port);
 		mt7530_port_set_vlan_aware(ds, MT7530_CPU_PORT);
+	} else {
+		mt7530_port_set_vlan_unaware(ds, port);
 	}
 
 	return 0;
-- 
2.17.1

