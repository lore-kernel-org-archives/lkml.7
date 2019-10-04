Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F87BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBFE222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWdi/ApP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfJDVns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:43:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46255 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731333AbfJDVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so4444738pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U687kcs42BoDsE/q/6DCWOZs4StRfj7ND2JiKRPjwLU=;
        b=cWdi/ApPfxI7Bo65buQpCZ4N3rNLjP83vRSk0AWnM/jnreA8jzFvvW9MLqK0XY2pPa
         0cy8ye3wi1DxCULqrnaJ/8zVot2CmrvzDewSixLDwg6+ip/B/Z7Pvk+RKPQZ9Lkp9O2s
         FBDrGVIk5nbcHdEoCwkPjuLc+/9mx2tZ/ujLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U687kcs42BoDsE/q/6DCWOZs4StRfj7ND2JiKRPjwLU=;
        b=eurc78MMv3wi1NIr7V58gLOYT6CfrwqMukBy7Wd4vacsvjMZEPUuSJ5P3RUN0z5Tu1
         GeIWDAPZLgjLxHnTFnQbttCSnB0mUM4a1AS7DxXv6v+9FShtVMvYTYsa2CqSapOJxelT
         DD/G4HdJd+3FGKnf7fTyy+u7u4Nc9vaZqtal0ttyUOuDY44vMM9IJor/3uNF4mbEueQA
         6uCgZ6/cm72/NjwQBNcOvB+6Apsbx2YYgdfIbasQkXIlDPmqLzFsjM7aUIKJ+7b1wvpG
         eEMhYl+CXeE3/s2yIoDEzn0rDDmfgft8QchCZ2YaIZp2QMVDOVP5odYK/TbxsxfxM02O
         /IAQ==
X-Gm-Message-State: APjAAAUlxAl8kdPDjotOmmZ6h2gg49T+uEixkTaZruF24hIQqD/lFrUQ
        HUYcuIbOQQDBe8RMXrA/etWNXjgvh1o=
X-Google-Smtp-Source: APXvYqz3Q4iZMi2/1NRaABshb8EYhS6zB/mSD/pg1wsvGQ7g6idpyOk9EJ3Z0PHwsxXWW1eDwBfcWA==
X-Received: by 2002:a63:ea16:: with SMTP id c22mr12828948pgi.162.1570225425617;
        Fri, 04 Oct 2019 14:43:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 10/10] of/device: Don't NULLify match table in of_match_device() with CONFIG_OF=n
Date:   Fri,  4 Oct 2019 14:43:34 -0700
Message-Id: <20191004214334.149976-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This effectively reverts 1db73ae39a97 ("of/device: Nullify match table
in of_match_device() for CONFIG_OF=n") because that commit makes it more
surprising to users of this API that the arguments may never be
referenced by any code. This is because the pre-processor will replace
the argument with NULL and then the match table will be left unreferenced
by any code but the compiler optimizer doesn't know to drop it. This can
lead to compilers warning that match tables are unused, when we really
want to pass the match table to the API but have the compiler see that
it's all inlined and not used and then drop the match table while
silencing the warning. We're being too smart here and not giving the
compiler the chance to do dead code elimination.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 include/linux/of_device.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8d31e39dd564..3f8ca55bc693 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -93,13 +93,11 @@ static inline int of_device_uevent_modalias(struct device *dev,
 
 static inline void of_device_node_put(struct device *dev) { }
 
-static inline const struct of_device_id *__of_match_device(
+static inline const struct of_device_id *of_match_device(
 		const struct of_device_id *matches, const struct device *dev)
 {
 	return NULL;
 }
-#define of_match_device(matches, dev)	\
-	__of_match_device(of_match_ptr(matches), (dev))
 
 static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
-- 
Sent by a computer through tubes

