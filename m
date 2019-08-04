Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D23C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B7E2070D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 16:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atCXWNlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfHDQUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 12:20:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfHDQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 12:20:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so38364074pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAhLVv+TDY5bQcYl+NXFjNhU9tR7BPyaRx/k/4DyyF8=;
        b=atCXWNlxav1dtL7F4U4MgGLdCrMFihKDTns2PoxBk8cXDIj8Ac6jRKBOZs5RH49KI3
         fll83PWrd1eFnpu+jLXwm6ya3gnVTjm8ohFDGJmPLRJQOY4rCiO4bavfyO9F+dokF1MX
         AdKriPl57Cj1cBCpOCgLzjfOHEEJRgQJgTIzrmTMhlnq/KlLTkRoa3EnwBjZcRz21g0V
         2i97pzX7JaM6ebRsy2T3Op+VUuVzO6/78Se6Jf7C8bKZejXa9wBOefXh/IuOIPBuYVcB
         6PVR9Cc6WK+GB2f7IVEeBGWTLyWDAJ6tFaroLNDLrAUFQ64hCYAJs7mnXv/o70fhKkYv
         HUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAhLVv+TDY5bQcYl+NXFjNhU9tR7BPyaRx/k/4DyyF8=;
        b=r9p00FCpb12vw4d8C/nOStX8DKKtyuLE5m0jA9Y/So0p+NCsURzUpJWX2fjbFLr/Ws
         DLQr80SQozUtJa3KR61lCSGR7VJgKksGFhfm9Mkwe3Ka5elzZCIeZiSIKNIt8WgWf/NW
         Tdj2/SFVETNfK0tdWS0zBUJDpZCUIKFnu4TouXBzycGVKvSMO4n6Wa2apY1haOvGp11v
         X+NYquUXYhP/RK9InoL+ypIpVkTO9gfq+o2yYH8+3IMxPSEPFA3c0d8/ihdK64MRb47A
         jMTrX/lWw9WKZbkh26VkxllMUPr79jVtCIhf3RTlvr9MjtLD4DoyAAQqnIf7XdDQ1bxP
         SzNA==
X-Gm-Message-State: APjAAAW5alJprfw/bUq/0cU9GynviMwFbtoeMVYjUFwbwY5k21M2ntvV
        rpoQNCPs7ICjjBH13hpOQfg=
X-Google-Smtp-Source: APXvYqy5fbEWIMIDi0oTzL495n1glQm2hXkBgQU6fG9eKX1MGBbXW1OmV6YioDl913AajynA6Oj0cA==
X-Received: by 2002:a62:f250:: with SMTP id y16mr68836412pfl.50.1564935635868;
        Sun, 04 Aug 2019 09:20:35 -0700 (PDT)
Received: from localhost.localdomain ([122.163.105.8])
        by smtp.gmail.com with ESMTPSA id h14sm106731763pfq.22.2019.08.04.09.20.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 09:20:35 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] regulator: core: Add of_node_put() before return
Date:   Sun,  4 Aug 2019 21:50:23 +0530
Message-Id: <20190804162023.5673-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_child_of_node puts the previous node, but in
the case of a return from the middle of the loop, there is no put, thus
causing a memory leak. Hence add an of_node_put before the return in
two places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/regulator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e0c0cf462004..7a5d52948703 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -380,9 +380,12 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 		if (!regnode) {
 			regnode = of_get_child_regulator(child, prop_name);
-			if (regnode)
+			if (regnode) {
+				of_node_put(child);
 				return regnode;
+			}
 		} else {
+			of_node_put(child);
 			return regnode;
 		}
 	}
-- 
2.19.1

