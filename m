Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BE4C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C97222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USpebXJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfIZCWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 22:22:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44714 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZCWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:22:51 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so2260341iog.11;
        Wed, 25 Sep 2019 19:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=10vX59mQYy8Tc+NqURfA0R9aLlqGAxMNJFo5UFdLhy0=;
        b=USpebXJ5TmoF0i/bedzYqndBE0M8zV7hyc+yKaKRu+BI6GqqkI6DwWxcLdolnqYMBn
         XuZkxRpLqIxzuN02lvjeP8x4RFe3qIxmBN8whFaJLyeQv8k/5wdwoc+vyx8mYog+J2vj
         PEHy3alG5ZH1QdIAsNgUnQ+piFp2UL7cohi+hJ8HNkql35D92FqenrJBuitMOqMbQTNC
         VtckhBSpK/nMZSgyqOy+n2g0r+pdiZ5W8xiqtG0yXIerqSjqZjVj0kjwR0UY87/vL8gp
         sadvJplQdgAnc8OgwBRK9tZ+Jm6R9htObSciSmJHJYLbx56NxrTYwb9iHkZU8Vx/GtMH
         7gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=10vX59mQYy8Tc+NqURfA0R9aLlqGAxMNJFo5UFdLhy0=;
        b=RZqz4wPuZZOBkn7ksSWJt/0C+0EzpHHsdi5AGPkLirkJ8AFMDXJHvB2EM6jgvgcbNK
         IRwg5A4MQ7hno2jPqItx5Nuuk90TYwKWQIWbHWpfBjsjS3q6R2aXTTVao2QZqE95114G
         PE7Aw06b7pYpxOSSrJKfZM6/FNyVuXpbd4v2v5Pta9OKmzCSBtz/kQNaX+6n/EIL2Lxk
         zi1JSAbwXIIBKnclp4wW/NSbQMhRCYqW3IuwTa6UypsvDUri4WU1r/BjgjcTiuredCvN
         aPD4dSk+yyJyW11SbfzStcG23InCZFpljKv+NmZnRHVoKRV5zK9V6pMNrKPJUkr2jIGS
         AyWw==
X-Gm-Message-State: APjAAAXjmtMKs0cWb0S/+vrBxItBA/h7tDtrncgYe4TzA5m2fhKGG9h6
        ZlvdeUu+Vh+IMH0nhmfkiK0=
X-Google-Smtp-Source: APXvYqxk4jfTvZGF+NDfvRCfmcUwC9fIu2oKQKHFrzHueaDapX647rr23TS3TzS0Dh3phKSLEylXRw==
X-Received: by 2002:a5d:9714:: with SMTP id h20mr1293081iol.294.1569464570634;
        Wed, 25 Sep 2019 19:22:50 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id o16sm199578ilf.80.2019.09.25.19.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:22:49 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     jakub.kicinski@netronome.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        John Hurley <john.hurley@netronome.com>,
        Colin Ian King <colin.king@canonical.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: flow_offload: fix memory leak in nfp_abm_u32_knode_replace
Date:   Wed, 25 Sep 2019 21:22:35 -0500
Message-Id: <20190926022240.3789-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925182846.69a261e8@cakuba.netronome.com>
References: <20190925182846.69a261e8@cakuba.netronome.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nfp_abm_u32_knode_replace if the allocation for match fails it should
go to the error handling instead of returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	- Reused err variable for erorr value returning.
---
 drivers/net/ethernet/netronome/nfp/abm/cls.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/cls.c b/drivers/net/ethernet/netronome/nfp/abm/cls.c
index 23ebddfb9532..b0cb9d201f7d 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/cls.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/cls.c
@@ -198,14 +198,18 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
 		if ((iter->val & cmask) == (val & cmask) &&
 		    iter->band != knode->res->classid) {
 			NL_SET_ERR_MSG_MOD(extack, "conflict with already offloaded filter");
+			err = -EOPNOTSUPP;
 			goto err_delete;
 		}
 	}
 
 	if (!match) {
 		match = kzalloc(sizeof(*match), GFP_KERNEL);
-		if (!match)
-			return -ENOMEM;
+		if (!match) {
+			err = -ENOMEM;
+			goto err_delete;
+		}
+
 		list_add(&match->list, &alink->dscp_map);
 	}
 	match->handle = knode->handle;
@@ -221,7 +225,7 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
 
 err_delete:
 	nfp_abm_u32_knode_delete(alink, knode);
-	return -EOPNOTSUPP;
+	return err;
 }
 
 static int nfp_abm_setup_tc_block_cb(enum tc_setup_type type,
-- 
2.17.1

