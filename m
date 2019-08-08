Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF8DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE20820665
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niJ6VOHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbfHHHGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:06:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39599 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfHHHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:06:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so39564320pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhOztrYOcMaetAi1IIzoeHE8LU0BVHaDWGM4hdIixHw=;
        b=niJ6VOHJrVgzKY5hrs6pU6RoN95/fkf5eTgBBrkDqmH8msTcQHZrENtoqSBXA04emc
         fX/RIIVr15s5gAV/FGbB+fq6LhPdGy9peKswDV0k3pBsCh8gDwn9Ytydx8OB8iMYGHNy
         hO5Cl/tTOIqUuarE2NCad4eT54sTwBoB7RtbE1YUk4cRg2bmwewPE2QwDEQTuZk13YwM
         eTJa7a00h8u1A9cz0YXa0LSR/HZPnu9S+VK1v7D/IbEgXZeOnYf6bF0NosWYi0f3wLcZ
         DQLVceEX+EhUr4t7c0za7Wl/4gqsHoRDpeqGAvsIvkAQitziYHH7EAT5LwPvIR4g9e7L
         M1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhOztrYOcMaetAi1IIzoeHE8LU0BVHaDWGM4hdIixHw=;
        b=oaxo19Drtg0zpPE16O3CRZje1WgLPRNkFzxREqc5v7YXzRsyoXNufisNwjjlxmax39
         LvMtnJdT53EhvLV7oln6BvCfgtAkHl+qA+uqMsd1Hu9Qy3lcTX8IWYYpSCsixeMO16Ua
         hUZRJeKFog6isIyNmc0j3fnGLcWlpt9z4pD28fb369J0aogPbmaZgbJOeKg4ckQhPelu
         eFbC5yeJrOvaeaYKql2KMIFDY1W5Eh4M9BYQJ7VgVHfoL3kuK1wLc0pH5k5pbryhM+ek
         qWk+QgJdu0XtaUWP/5qdQ3MHpXYi71h1BACGQqyqYiSxqot0zvTHsBOU+uRwaeB3Nzxc
         QWtw==
X-Gm-Message-State: APjAAAVN/U9549vyxS4OCMnmKEu17c1OD7wQUjAve0bK62DlscUTM1/V
        5GSLtA/t/XkcsIjsPIvzpBQ=
X-Google-Smtp-Source: APXvYqz/WJxPK8dO0nVCyI69NWrjEAovFCV+LKNaEbGaBo0wKzLjJbmhq801H4J7+DuGmfgWvxFeKg==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr2556121pjv.100.1565247965576;
        Thu, 08 Aug 2019 00:06:05 -0700 (PDT)
Received: from localhost.localdomain ([122.163.44.6])
        by smtp.gmail.com with ESMTPSA id 125sm130848890pfg.23.2019.08.08.00.06.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:06:04 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] regulator: core: Add of_node_put() before return
Date:   Thu,  8 Aug 2019 12:35:53 +0530
Message-Id: <20190808070553.13097-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function of_get_child_regulator(), the loop for_each_child_of_node()
contains two mid-loop return statements. Ordinarily the loop gets the
node child at the beginning of every iteration and automatically puts
child after the main body has been executed. However in the case of a
mid-loop return child is not put, which may cause a memory leak.
Hence create a new label, err_node_put, that puts child and then returns
the required value; edit the mid-loop return statements to instead go to
this new label.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Create a new label to put the node and return regnode.

 drivers/regulator/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e0c0cf462004..4a27a46ec6e7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -381,12 +381,16 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 		if (!regnode) {
 			regnode = of_get_child_regulator(child, prop_name);
 			if (regnode)
-				return regnode;
+				goto err_node_put;
 		} else {
-			return regnode;
+			goto err_node_put;
 		}
 	}
 	return NULL;
+
+err_node_put:
+	of_node_put(child);
+	return regnode;
 }
 
 /**
-- 
2.19.1

