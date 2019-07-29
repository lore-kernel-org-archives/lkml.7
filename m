Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F34C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 02:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB712085A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 02:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMUkO3xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfG2CaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 22:30:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41762 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2CaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 22:30:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so27190796pff.8;
        Sun, 28 Jul 2019 19:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sd/DjDKLeclOpZaxncDp/vjS9lj3GlycX2/FHJjPnxs=;
        b=BMUkO3xi4i5Xc3KrFoN5BWow64A86h/9Icz0HkUm4MQDgmut7d6OdEBpHl1UHTYIlx
         DkwSKRZOyyvD1ZA9MKj2Ga6VuqYq7sg9SJ99OBV00l5GQ9h2p68TScg4mVFak0q7YHcj
         XsCvJ4sCVNxByWe2ppiN5tkxjhAFEnIy/Utf1TmjOSMVFPnfysw3WWbjuaRv3AGlQnFt
         ePVl300eQknArGxDN/EaObpWs+d6JxIA8RsKlpu41OOF7/zsef0le6CiPWtySNsw1DpO
         yuH2cNtaubcBktdVBFPNoFXacioUyCJGU6OFvJ54nwqLTmuTsQMg7BHusq/NmOo/dKq6
         0iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sd/DjDKLeclOpZaxncDp/vjS9lj3GlycX2/FHJjPnxs=;
        b=ZglRInrJBHpZQHQKmChSu02OCMjcUYjkv97gTmHbVzSN4FhyhfVAIuENiT8Dlsq1YC
         80n85CXnVA0cOC6pqgIn1hfJ9XcOwy5IlyxD+zGxi13k60smL5+Hnzr38Kc3nkOKUdIM
         1uFBv9djKuk7RmTCw9CNUcYSYLHMK1BBKDwMxJTQgPqvxY5RE54+h7OSJ1+WENKZRyrH
         o7RUsECAISSyboTti3EOhIuTJsdtYLmIgA8Rl/p59rhUI7q6uPBEs31FjcpbbOt5d53f
         8Wz655tB1zr1uPcJyZOpy+r2e2V4izdcOkv2LwruAlUt34+CdVAzdt5H4ZzhW+eamizz
         6zFw==
X-Gm-Message-State: APjAAAUrpuvSZxCwUaldoVJRM4O8YL0jqGSbXhOjONhzSu3Rh34Bi3qY
        jHERvsHf3I/CMXqOTbMxMhw=
X-Google-Smtp-Source: APXvYqzdf1rHwoSc3NoauOY0IX65jj4xPPvhB4ljTe0Trb7U/qI87Y3y5Nc5ce7lPDVuoWA8nIWddQ==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr32754682pfm.200.1564367404905;
        Sun, 28 Jul 2019 19:30:04 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id d6sm52862840pgf.55.2019.07.28.19.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 19:30:04 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     martin.petersen@oracle.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, rfontana@redhat.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] target: iscsi: iscsi_target_tpg: Fix a possible null-pointer dereference in iscsit_tpg_add_network_portal()
Date:   Mon, 29 Jul 2019 10:29:56 +0800
Message-Id: <20190729022956.18192-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In iscsit_tpg_add_network_portal(), there is an if statement on line 496
to check whether tpg->tpg_tiqn is NULL:
    if (tpg->tpg_tiqn)

When tpg->tpg_tiqn is NULL, it is used on line 508:
    pr_debug(..., tpg->tpg_tiqn->tiqn, ...);

Thus, a possible null-pointer dereference may occur.

To fix this bug, tpg->tpg_tiqn is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/target/iscsi/iscsi_target_tpg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 8075f60fd02c..bf97be36ec1f 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -505,9 +505,11 @@ struct iscsi_tpg_np *iscsit_tpg_add_network_portal(
 		spin_unlock(&tpg_np_parent->tpg_np_parent_lock);
 	}
 
-	pr_debug("CORE[%s] - Added Network Portal: %pISpc,%hu on %s\n",
-		tpg->tpg_tiqn->tiqn, &np->np_sockaddr, tpg->tpgt,
-		np->np_transport->name);
+	if (tpg->tpg_tiqn) {
+		pr_debug("CORE[%s] - Added Network Portal: %pISpc,%hu on %s\n",
+			tpg->tpg_tiqn->tiqn, &np->np_sockaddr, tpg->tpgt,
+			np->np_transport->name);
+	}
 
 	return tpg_np;
 }
-- 
2.17.0

