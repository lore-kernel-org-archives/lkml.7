Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FA9C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED2A20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQskidRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDMBb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:31:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33392 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDMB2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so1597963wmi.0;
        Fri, 12 Apr 2019 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pGHCdu08Epvcz5qn5rKpnrfJ9NHFsNkt36mH1O/j4iQ=;
        b=NQskidRUozL+8AwPmj8cvVCV5nsKuUwjtE5NIhx7ra1F1+Vl+6SWbyuWUBa9pG35sR
         pWxqkmVI0R19GzClJwGmE5LtA3UNva4kVqX/+ZODDmIpB9kqeNmUfZuZYVDhA4RKvXGz
         BWLyzNS7pNUo5Jk29p4IfCL0z/8qxhixmGWQlrglkHFxTDryzcCh9BgbpVepaw3mNOXm
         T91V1TcsIzqhZ4rYzWsu9UygzApLCOOELnrXIkIqVMP8mmSuv5D1I6qfC3bVZAA4pYrz
         0gW3ahyAjTww3dq528FYOoV8nplfz5Y8XQYEK7fwsG1r45+i5B7l5KsrMBeUr+k6Ud7R
         6ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pGHCdu08Epvcz5qn5rKpnrfJ9NHFsNkt36mH1O/j4iQ=;
        b=lMaM9CxP6C9RwPlRlWGQ5BjVgIghgdLdc3raIQey+fIJmgpi6HMN2v1CY2UEfuVUvQ
         SzH6I3idUpx6R8rhz7E1qqFEEXpB6/ooYO90lA2Mf3pLkjWwmqfLPt353I/2UOASPZZj
         VyJ+sG5Itol0T4GIULelE3CHV2fxfKlE5TOL4BK063Abo51feVVEn0Zq4zUXbbbMfFTr
         3lt/mTOLCrn0EwUyyDBZf15oUw+Rsv9Cp2Um+Zz/+/iawYYo/H6mg4e6q1CFoTO6d5Fc
         xYdV0q1BHCm6qzXB09gmxPSae6tb7Ip6084j8dIPUGQBchTE5/Cuhszw3atf3SUWl2qL
         znMQ==
X-Gm-Message-State: APjAAAXcl4BDKkT/vfAWrPQAePKPjGL7DdwEurtGeBgDNWYp/GB/GuGG
        lQCpQ2N7FJrgHwY2y66S9SoDzWpHrS0=
X-Google-Smtp-Source: APXvYqxwwjxSeaol82+NJ226rUgcJBvbKQvJspvrP9L0FPM8On/yu2QSjef/uM0PEgp/Mnqu5W0eDA==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr13463448wma.71.1555118912179;
        Fri, 12 Apr 2019 18:28:32 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:31 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 02/24] net: dsa: Fix pharse -> phase typo
Date:   Sat, 13 Apr 2019 04:28:00 +0300
Message-Id: <20190413012822.30931-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
None

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

