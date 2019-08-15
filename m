Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0172086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYsw60Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfHOFhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:37:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41005 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfHOFhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:37:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so687819pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 22:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIpDVpiLKG4T/AqzOyc5Muze7etgK/xNCDgOaaLNelU=;
        b=LYsw60GgN93vPxfOn9aKbmk/bXex3AM+T4lgry6t5JtcGeYTt1R2y2EPyNSLsyb33S
         J8cgXilw4IHdFyv1QxwRu0l/NTEnMfSDw2qntcv+6rfMcqEROiW0aQt40qSDFVCFTQrE
         C9wxqMWdi55XDKRXpGscMmOif0DbC0RPivx4fo7PocWCDa2hJuiTxHaXxUMN4UHPTINf
         W9ZkAgwI/RlZZ5GLsLibYxZlXQaNN7gL6Ks0ybEzrpCFwMBWFL9hY+TJ7RS0MGZGKIFr
         qn1btsV0oV7ML8sMBV2dRizFaOtnsZz2t2ZhrdkEwLfGFYza7QmJAWe4AnK5oZP6Glns
         iwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIpDVpiLKG4T/AqzOyc5Muze7etgK/xNCDgOaaLNelU=;
        b=PuLSNKQHcQcNBY2kOX9kDFJSpzlQwO5+4TSZPhd4jIj/pwIrJX/YY38081QDCei1uu
         rJwBGfzUP3rJTpAds+CL3nZR4vZyLFwDpjcTgF4fatEbaqil1KbWNG2Bzu7rKajlapHK
         g6TNuxUoeF7wMQGbEBif0iwmy8SKUNvCPAjYAKF1gk6EL5IZpyfV/66Av2Hqs291y4ZV
         DT3BhywK+VAX+OpwIejR7cuhHyr69VcBKl7X7EYXlYxCOQOS+JbKaArnTQ1CUYHxjpRU
         fSJ5RZMg2UF78H1Vfz+NoIKi4ZIbKlxxXu+JwBwW0XWEoQZyhIKAkdxh/ex+RCy2W6L5
         bS3w==
X-Gm-Message-State: APjAAAWXig5+k3HEO/JyF3o+eqO5exKpPWRI1z+uqvsL2ivf1/NUI2Lq
        Wp1/frAIp/qgGfarxhdF4Oo=
X-Google-Smtp-Source: APXvYqyl9b8gLWSg3ch7ClVhXiD78YRu14UqmkPjkfSTKpFFzHDzkgJ6YZKogNgO1OfIY6fYm63i/Q==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr2882250plr.68.1565847438842;
        Wed, 14 Aug 2019 22:37:18 -0700 (PDT)
Received: from localhost.localdomain ([110.225.3.176])
        by smtp.gmail.com with ESMTPSA id g1sm1292539pgg.27.2019.08.14.22.37.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 22:37:18 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] regulator: core: Add label to collate of_node_put() statements
Date:   Thu, 15 Aug 2019 11:07:04 +0530
Message-Id: <20190815053704.32156-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190813112156.GB5093@sirena.co.uk>
References: <20190813112156.GB5093@sirena.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function of_get_child_regulator(), the loop for_each_child_of_node()
contains two mid-loop return statements, each preceded by a statement
putting child. In order to reduce this repetition, create a new label,
err_node_put, that puts child and then returns the required value;
edit the mid-loop return blocks to instead go to this new label.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Submit this as a separate patch instead of updating a previous patch.

 drivers/regulator/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7a5d52948703..4a27a46ec6e7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -380,16 +380,17 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 		if (!regnode) {
 			regnode = of_get_child_regulator(child, prop_name);
-			if (regnode) {
-				of_node_put(child);
-				return regnode;
-			}
+			if (regnode)
+				goto err_node_put;
 		} else {
-			of_node_put(child);
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

