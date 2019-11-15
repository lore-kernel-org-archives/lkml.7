Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9008DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A76820740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypkIu9Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKOWeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43972 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfKOWeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id a18so5616598plm.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HUM10/8Wh+ACpH8iy+zYVazM7/j5x9SwSLUXvaHdtoE=;
        b=ypkIu9LpYzuilaTSO1ddkj4eAfzXCWg5IShx48OXs6BvHNF3e7+rx/03wNN1tYaleh
         SnZM8RHGgSNVrsmiwniMNuQyH174+xgl/q4FEQxe7UVXDuVhTtT/3TIahPM8bt5ZmH3+
         ud8Eos51tOebTw0Y0mq1tqIEY0ssGv6FbVUe9ALZXTAWJPcnpmI7iUshmshcvm770Ayk
         jRwA1AXpceNmz1E6uqRFqcGSLc2lSSfvePTl8s/unV8Lzx+f9sx/TSGf3xflzHr4szxN
         BXuLl9NHzQ6cEOZbYvbeYcQ1U5te3v0DNBTnZ3Ab2FwTA3bfYQBRlEMA2uNi2PTy8N92
         PCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HUM10/8Wh+ACpH8iy+zYVazM7/j5x9SwSLUXvaHdtoE=;
        b=FbsaVQwDT5MgW+SH1whWg+ZhCOphNIa9kVvTQIU11YC3qn+Imq/oGryB3zi/VQpWYZ
         4ONj1aBZFlVvrOC0M2+nISjhPB6z3b7MYAt7PWTWGmkgh7g2maobB+beUSwHQ+R1SoyY
         xDz3S43E5xb22srIbCPvicRlAvhwO4Fd1C7giAANPi9UqerQ8Kh/lJqs+B3iprSbJpqJ
         DRcL6zEPKjxbFACADOhOqCxNdP2uL+l4l2+d1FkJsmRlpH23fVVDGObUsKRwqgc1XzjZ
         lq9xAu7p9U/yWzzj9ZEm07QDxHfBwuON1jGD0xloKDcrPqC+2IaLXyJyluMgvl7b3ILW
         wzQg==
X-Gm-Message-State: APjAAAVDBX/kT5D5RnyXgfSzg0MdHgICNxmsBFFEE0SqIIpSMQ3WwGX/
        Blfik74mOimfHjO3Y05ctVT96h7uBSk=
X-Google-Smtp-Source: APXvYqyMzfmiYdBbALgyJW/Yz44XD67/vMuUxQ8EgtUszaDCbgKhRiI6HNcF282zphiYMjPaFRLwFg==
X-Received: by 2002:a17:90a:256f:: with SMTP id j102mr22689164pje.124.1573857244238;
        Fri, 15 Nov 2019 14:34:04 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:03 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 08/20] remoteproc: fix rproc_da_to_va in case of unallocated carveout
Date:   Fri, 15 Nov 2019 15:33:44 -0700
Message-Id: <20191115223356.27675-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Pallardy <loic.pallardy@st.com>

commit 74457c40f97a98142bb13153395d304ad3c85cdd upstream

With introduction of rproc_alloc_registered_carveouts() which
delays carveout allocation just before the start of the remote
processor, rproc_da_to_va() could be called before all carveouts
are allocated.
This patch adds a check in rproc_da_to_va() to return NULL if
carveout is not allocated.

Fixes: d7c51706d095 ("remoteproc: add alloc ops in rproc_mem_entry struct")

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index aa6206706fe3..af9d443e7796 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -183,6 +183,10 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	list_for_each_entry(carveout, &rproc->carveouts, node) {
 		int offset = da - carveout->da;
 
+		/*  Verify that carveout is allocated */
+		if (!carveout->va)
+			continue;
+
 		/* try next carveout if da is too small */
 		if (offset < 0)
 			continue;
-- 
2.17.1

