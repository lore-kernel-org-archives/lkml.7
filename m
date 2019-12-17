Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B505224680
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fhRUhoT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfLQTqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:46:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37308 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQTqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:46:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so6559016qky.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AAJSJ3f+v8JezMBUsPh9A10z/EEOzUS8//0MnaZjfnE=;
        b=fhRUhoT5EFK8aFypWjMYWQEXn0A68rgujkbD304jvZXp3JfPv7k6NnGM/E1eum1xX4
         j4YBGl92dALG3hyS9Wp4s9pVH7AwsWIBlroXxcsopP4rErsVX+Z6jfn4YXdl/vhhLTRm
         QgkQlLxg9T3RDOCy7spNhNeAIr59mMTOn8ltk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AAJSJ3f+v8JezMBUsPh9A10z/EEOzUS8//0MnaZjfnE=;
        b=pp/NKUoNanYGjhzWpix+N8ZLlz+K4Y8k9CPdb3z0hoIdrW5EzjNPcyPX38cGUvH+OG
         7x43/wePJo0iS91TyWquYQMOQMjXETDxQjxD4BRxfy5UYXpqQ1Ors4IiUD0m55O+x/hu
         ZA4vsmWs6wpTxTgVQfx80wLxP+/DKka6siWiYpLdMUiexAQGeyIrMl001+dsrBPt3AfL
         iPui8mGODPOnlQF0EnEfsniX0SMhGaawGLJKWspZbSKARCQxyqm/rB1Urm4IZlqLnM2j
         E2XTsYozbiyf/cMKb+IaQXBIgFdU0kUz6BYKpVJ1tDFW8F/EpRSlO5rioMfYfZeayKvE
         n8Hg==
X-Gm-Message-State: APjAAAXdh/A/m9s2B3iVPa6hyO80OsDyVsL5cF4ys67+XFV6v/lXAdao
        dE52+w3LpaYqtvxy5ZNflt4k
X-Google-Smtp-Source: APXvYqy9DfX8rmJagE79oA+aX3MuQF2B+hC64bxfgeA67Y79HktVWq+Hd4AXz5HGRzz3Ht4ndkjCUw==
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr6718950qkg.43.1576611959080;
        Tue, 17 Dec 2019 11:45:59 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
        by smtp.gmail.com with ESMTPSA id i90sm5379922qtd.49.2019.12.17.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 11:45:58 -0800 (PST)
From:   Tianlin Li <tli@digitalocean.com>
To:     kernel-hardening@lists.openwall.com, keescook@chromium.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Tianlin Li <tli@digitalocean.com>
Subject: [PATCH] drivers/misc: have the callers of set_memory_*() check the return value
Date:   Tue, 17 Dec 2019 13:45:28 -0600
Message-Id: <20191217194528.16461-1-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now several architectures allow their set_memory_*() family of  
functions to fail, but callers may not be checking the return values.
If set_memory_*() returns with an error, call-site assumptions may be
infact wrong to assume that it would either succeed or not succeed at  
all. Ideally, the failure of set_memory_*() should be passed up the 
call stack, and callers should examine the failure and deal with it. 

Need to fix the callers and add the __must_check attribute. They also 
may not provide any level of atomicity, in the sense that the memory 
protections may be left incomplete on failure. This issue likely has a 
few steps on effects architectures:
1)Have all callers of set_memory_*() helpers check the return value.
2)Add __must_check to all set_memory_*() helpers so that new uses do 
not ignore the return value.
3)Add atomicity to the calls so that the memory protections aren't left 
in a partial state.

This series is part of step 1. Make sram driver check the return value of  
set_memory_*().

Signed-off-by: Tianlin Li <tli@digitalocean.com>
---
 drivers/misc/sram-exec.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index d054e2842a5f..cb57ac6ab4c3 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -85,6 +85,7 @@ void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	unsigned long base;
 	int pages;
 	void *dst_cpy;
+	int ret;
 
 	mutex_lock(&exec_pool_list_mutex);
 	list_for_each_entry(p, &exec_pool_list, list) {
@@ -104,16 +105,28 @@ void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 
 	mutex_lock(&part->lock);
 
-	set_memory_nx((unsigned long)base, pages);
-	set_memory_rw((unsigned long)base, pages);
+	ret = set_memory_nx((unsigned long)base, pages);
+	if (ret)
+		goto error_out;
+	ret = set_memory_rw((unsigned long)base, pages);
+	if (ret)
+		goto error_out;
 
 	dst_cpy = fncpy(dst, src, size);
 
-	set_memory_ro((unsigned long)base, pages);
-	set_memory_x((unsigned long)base, pages);
+	ret = set_memory_ro((unsigned long)base, pages);
+	if (ret)
+		goto error_out;
+	ret = set_memory_x((unsigned long)base, pages);
+	if (ret)
+		goto error_out;
 
 	mutex_unlock(&part->lock);
 
 	return dst_cpy;
+
+error_out:
+	mutex_unlock(&part->lock);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(sram_exec_copy);
-- 
2.17.1

