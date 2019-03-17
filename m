Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA11BC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6F2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="oePQeXqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfCQMXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:23:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40101 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfCQMXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:23:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so14034053wri.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkrYZLLM/svtOayGyKhgfyVlvewbzak9YejfanGGyf0=;
        b=oePQeXqNxnitLQbzw0Aawm6Vo99ZCdQ/8op5I3x4fwVrpgXZ2vFVP1djMmyk2alitV
         qofim9f9tS2F5P9wAsXdjq+0bUb5WU2Mtn3VkDbUiZ3Tp2kuwwAS8xls8CuTc8VT6goj
         GSE5DV7ux8Cw8qGjcj/10/O4xvKA30+v+l8U73QmHl/Xw8IzQdOTNMUMCHj9+TEzrl/C
         1g8NYZs+UmDN67YSBNnvQCQ7HgNDo9zxvmDEmB6all/KIRy9CmsudSgg/y/NXsvOs2hX
         fDAbajPOiKh09vXGErNa2yAD4ozRKjdEFY8IEAhA+IMwqTZh2eicDXmJBEkdQexIkkW/
         2l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RkrYZLLM/svtOayGyKhgfyVlvewbzak9YejfanGGyf0=;
        b=fRA9QjYMNc6tlZr41GPtuqV727MadeyRDs/XMe4SQpaNi9fFJf8af1sM9cUcWxvpTs
         KR5gyuh8cWR0iMxFgOgDxMQ/kauuqBZ5Wgd2SgpbcH6IfxUGEvv7Hi46LjYj/pVUlegj
         o7K2I3LY5p8pfVKPjxipTaSgjEb5EIIIm5gVdqvDfcPIHAPoakJ1qWY7+nc7oIL2qGa0
         y0bmLMgByHflHQlnj2xSe82Cvk2rGmuaq8WZ2IEmxnaoZViR1PqOXzLb2+dmvebISu75
         HLRskV1EMu6pGIgRekRfJZaXCIj0GFwtN0tWpK3au9M9gLdXk8fac3QccARL5gY0z3Af
         jwvg==
X-Gm-Message-State: APjAAAX+9pQCHd1twJWQIuADeE4TU9iWkHtwOQX163RXSNFC/Sz9V7Px
        T4gF01ZspZb4XuwCWx5HDHsfUw==
X-Google-Smtp-Source: APXvYqykp3hijQu1uj0lzMf4Uoky4HuSBXbY8DXMXl/9GDVA7jpoICzZrCSLrarmtQJ+oUDwgJVQrw==
X-Received: by 2002:adf:a10b:: with SMTP id o11mr8265755wro.91.1552825383526;
        Sun, 17 Mar 2019 05:23:03 -0700 (PDT)
Received: from snf-864.vm.snf.arr ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id z10sm5453292wrs.11.2019.03.17.05.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:23:02 -0700 (PDT)
From:   Nikos Tsironis <ntsironis@arrikto.com>
To:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com
Cc:     mpatocka@redhat.com, paulmck@linux.ibm.com, hch@infradead.org,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] list_bl: Add hlist_bl_add_before/behind helpers
Date:   Sun, 17 Mar 2019 14:22:54 +0200
Message-Id: <20190317122258.21760-3-ntsironis@arrikto.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190317122258.21760-1-ntsironis@arrikto.com>
References: <20190317122258.21760-1-ntsironis@arrikto.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hlist_bl_add_before/behind helpers to add an element before/after an
existing element in a bl_list.

Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
---
 include/linux/list_bl.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 3fc2cc57ba1b..ae1b541446c9 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -86,6 +86,32 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
 	hlist_bl_set_first(h, n);
 }
 
+static inline void hlist_bl_add_before(struct hlist_bl_node *n,
+				       struct hlist_bl_node *next)
+{
+	struct hlist_bl_node **pprev = next->pprev;
+
+	n->pprev = pprev;
+	n->next = next;
+	next->pprev = &n->next;
+
+	/* pprev may be `first`, so be careful not to lose the lock bit */
+	WRITE_ONCE(*pprev,
+		   (struct hlist_bl_node *)
+			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
+}
+
+static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
+				       struct hlist_bl_node *prev)
+{
+	n->next = prev->next;
+	n->pprev = &prev->next;
+	prev->next = n;
+
+	if (n->next)
+		n->next->pprev = &n->next;
+}
+
 static inline void __hlist_bl_del(struct hlist_bl_node *n)
 {
 	struct hlist_bl_node *next = n->next;
-- 
2.11.0

