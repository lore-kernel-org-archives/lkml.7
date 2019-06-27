Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A7EC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC90205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC4usCiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF0Rjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:39:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43201 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0Rjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:39:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so1331763pgv.10;
        Thu, 27 Jun 2019 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D32Ks5Fu7pyXBdYyciPpR5394J9zDQfs4fNW75Cd110=;
        b=XC4usCiLGHHdATHVUaFTzr5JEBLk/yeZisSfEhY1ayH7hLjyksJAjpW3ieT9Oo3iBr
         d+7/MdVHw1eueGnDmLsz8uJfDltaotexrMweqM7c+vhtYaYB2tmV4ps7R2cLN1Vil9uL
         yaO3YEVcb1PdWOctqZULRuLnAAM7ozJqo9u2NiqHTqYMFxmEcjGb09P45L30ajwJ2gLK
         fJ2rwya3nmjU27LHvkDJiJnXj0agM11Ilv2cVUuL56XSRy/edyx56t7P1pQTyVVCbaXu
         IfJC1Vvj5ZUolzSFLxdbgJQv0/uk7/5z8Dp7yZb6uGSsk22GKAfEYp/OR1NfDgIb4OZr
         W4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D32Ks5Fu7pyXBdYyciPpR5394J9zDQfs4fNW75Cd110=;
        b=mU1nkSfcksR02k9Fy6vVEQJa2uzC4nwHvIxX3dN0cx4M2BMTEyj/qfN1i8mOY/jEot
         JXvltnOT3fQflJsFn0W69qPu9o3tx8MJtAFiP4IF8ewRbej+PCJANT+yMDuKivqG6rBc
         FKBqKol/pKxYC9NQGfsnjImTLHTOeYNH2gi+YxFZ2uZ7S71fBkwrE6+D3528wbe6wAtm
         LYRbhTMckLtl7zGw3ynxyeVcNawZumD9dCJUKZBHb4E72q30akUVQyXSZsgY5U5iKtjJ
         2aXpLIdvL0TaoNW2cJGI7Cg9w+qzuNz1uMZWzodSsjeU8hMCJGFfnio9Fa6W8EKZyhWC
         ywrg==
X-Gm-Message-State: APjAAAUMHJsq6AWAMCjpzLB6WKZ6mIDpF/IHzLS//E2gCdXyBcjDyNpj
        7jUgZYLFNh+vi48+ZNniVqE=
X-Google-Smtp-Source: APXvYqy0icc/gOqP71bSCfkc1bgCphFNkt0hHXEaL8fKlmRyT9MTAissL3cxIzHMI+v9G5/zx3sgRw==
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr7508898pjp.114.1561657188590;
        Thu, 27 Jun 2019 10:39:48 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k14sm7003844pfg.6.2019.06.27.10.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:39:48 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 39/87] ethernet: bnxt: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:39:42 +0800
Message-Id: <20190627173942.3891-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f758b2e0591f..1a51edb7de37 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2622,8 +2622,6 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 			mapping = txr->tx_push_mapping +
 				sizeof(struct tx_push_bd);
 			txr->data_mapping = cpu_to_le64(mapping);
-
-			memset(txr->tx_push, 0, sizeof(struct tx_push_bd));
 		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
-- 
2.11.0

