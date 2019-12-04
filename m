Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E67C2154A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+5KquLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfLDMER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:04:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42586 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:04:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id i5so3283449pgj.9;
        Wed, 04 Dec 2019 04:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dDGPKtBgp3h3EHMEwrPDJs+i5FCz6x10d30Qfj8cLXo=;
        b=G+5KquLIPyJO0zJboz7wysKUs0fhu4LYyUcRaQcq8kKSnIY8RT4e7G7P1TZA/W7BS9
         tu1CIQHu8ZSxMVEkQr6X0X8Aufd6k3hp65D6J2VAf1CS5l9OmFKOrVEJIfdSrUfRyhrh
         gGVlkLnyZpXCD5j76b9CJp4IFHCwnuodXfqHVLtS5gAGw+ZFcBYYQ9xA0BegL2+aRc13
         L2KgDuwJasldw0IEKNiMAOCa2Pa8vpNPlNgeOlrtGGqm8rmqkM8WSP6pNT80UL7qG5tj
         QuAhcc8//BiOPKzS05gHbcHPgmSWOvK21cq7tLyOfZTci+w5q4TedQuTEnOEBxzkO/89
         cyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dDGPKtBgp3h3EHMEwrPDJs+i5FCz6x10d30Qfj8cLXo=;
        b=oJvRRflhGT+CkE4kxQzsuj7ZBfzJjJTtHJfb448L2nEzHR9XZJWSpjIm2+IfUqvB7f
         lJLHYXA1UXyxcln5YmGObTSAkr9r0BG2U1spxRTvgr/ndWhFfmyWqXcrUtl0FuuHkFt9
         nsnEeONbovJvFHHM5DVFA9XU0beNzAor8nJePI85hmevE7wqT86ItpyrK+MccP6tjRHa
         KWS875Sah9ypCUBC5MfTxnKauQ+Bku9+UiTIYv+/3MvVG/GN2OzZO/h4Re6H4nQFz+oi
         W9lamVAp5uqqg9W+ExpCMElmezZ9mcg+yCShHx/ZnBsbwED6eMXYktNkun4t02oNr0Ri
         YMmQ==
X-Gm-Message-State: APjAAAVqRJNis/rXbHpkvBFmDpPs5AwyPYJcgFYQBNnvXd/ji1sJA4YK
        SkBj0qOF59WOxk+2wGGZC6Q=
X-Google-Smtp-Source: APXvYqziLwVs+guBWhEUUaw5KZIu96pJmkavqOVglly3MfmqrCcMBoE8vJV0ZG6RkkL1Qpdx1RkcJQ==
X-Received: by 2002:a63:181a:: with SMTP id y26mr3189363pgl.423.1575461055913;
        Wed, 04 Dec 2019 04:04:15 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:cdb:94ce:3984:ab1:9b44:803])
        by smtp.gmail.com with ESMTPSA id f69sm6895076pje.32.2019.12.04.04.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 04:04:15 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Include: Linux: rculist_nulls: Add docbook comment headers
Date:   Wed,  4 Dec 2019 17:33:57 +0530
Message-Id: <20191204120357.11658-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch adds docbook comment headers for hlist_nulls_first_rcu
and hlist_nulls_next_rcu in rculist_nulls.h.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 include/linux/rculist_nulls.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 517a06f36c7a..d796ef18ec52 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -38,9 +38,17 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 	}
 }
 
+/**
+ * hlist_nulls_first_rcu - returns the first element of the hash list.
+ * @head: the head for your list.
+ */
 #define hlist_nulls_first_rcu(head) \
 	(*((struct hlist_nulls_node __rcu __force **)&(head)->first))
 
+/**
+ * hlist_nulls_next_rcu - returns the element of the list next to @node.
+ * @node: Element of the list.
+ */
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
-- 
2.17.1

