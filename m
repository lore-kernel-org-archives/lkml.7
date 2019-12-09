Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F03C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81DD2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N79GCO9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLIHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:51:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33113 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfLIHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:51:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so6793944pfb.0;
        Sun, 08 Dec 2019 23:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T93KpotdGkFqtc77qF2EAzOUEnvgTHpxwI5GuqbP7b4=;
        b=N79GCO9lrJQ9kFidXylgJv1/NvbaQAqEtR6ip+va41MyO8Wgd+bFaBgZEiMHDCDrVq
         /O7SGbGzDccjAXV+VBWPQxIv1atxpYo3eQLR5auqJD4thxtmZvN+aL3Yytab6RYvg9lv
         1V6p6yZ/oPNWMWtS6hQQjdoTItOaYTHN1hiV3bLulK+0xwjDK2U+yp9wJ+nWKG2Wq07f
         G6LBjWE+zT+vPRZPAfr68TWQb/hn3uJUYymefKC/jQt7eKAhNf0qBtURZgB1PtIS0Q5e
         DDE9Li0cONlHxzXeylpBE04Z2FrtzF8auwGonb4CCCVaDr2H5kpXJEVBustMlQqKcSlt
         s5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T93KpotdGkFqtc77qF2EAzOUEnvgTHpxwI5GuqbP7b4=;
        b=uI2hccKbWAcBaDU8OfRrNHGv9NjBAWrRVvmowIg0aX3WK6069zraJYMQPuTpsxKUnb
         67/zyk/rNnBYSkSJYJceYmFnjxUmEGe8FfOBkJkawHLMgj6DkkjxGt3GuZy5LM14dT7F
         4rh+mJ1N6Ky45XI+jKzApPoeDttpl5UXLJpB95WpCpmavVcdTJ4oiy15GkeRftm7FDmm
         ichtWK822XftG2Putu1ZEXxf/ozr4q21UkhinxDVa1vaSm+7UxT257dAxqP4r05s8ria
         WE3qB1VceWLSW1eaV1Tum7zpWSBgtpyI8aWupk1Cx3eMt1rLwqFJzkGr4KZhmu4F9uDQ
         3VpA==
X-Gm-Message-State: APjAAAXIz+uFDgyuUeYCkIZmAFTEkbiHs2QowUox13TOslQcKrTdR00m
        6WMXzH82V0Iut0+ktoGQx6WJuV1DAyQ=
X-Google-Smtp-Source: APXvYqwNTJADqjLqVulG110m73ntGwb1QV+9AeWkSqjiWMdSBPgBwYxtAeEGWPWOQtdlvx/w1QW8SQ==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr976843pff.240.1575877863074;
        Sun, 08 Dec 2019 23:51:03 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:13bf:5229:e955:851e:da75:6e07])
        by smtp.gmail.com with ESMTPSA id z10sm2881079pfa.184.2019.12.08.23.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 23:51:02 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] rculist.h: Add list_tail_rcu()
Date:   Mon,  9 Dec 2019 13:20:43 +0530
Message-Id: <20191209075043.17947-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch adds the macro list_tail_rcu() and document it.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 include/linux/rculist.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4b7ae1bf50b3..9f21efa525ab 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -40,6 +40,16 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
 
+/**
+ * list_tail_rcu - returns the prev pointer of the head of the list
+ * @head: the head of the list
+ *
+ * Note: This should only be used with the list header,
+ * but only if list_del() and similar primitives are not
+ * also used on the list header.
+ */
+#define list_tail_rcu(head)	(*((struct list_head __rcu **)(&(head)->prev)))
+
 /*
  * Check during list traversal that we are within an RCU reader
  */
-- 
2.17.1

