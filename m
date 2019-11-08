Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542EDC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D2A222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RkUIYnXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfKHNCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44490 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfKHNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id v4so4391491lfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hiVnbA+aLQJgHhafT97yYdRXOf2rz2/qkrRHHeVl/y0=;
        b=RkUIYnXtYtHoaluers5poWFKyA9z83YZFiREEHR69eo9ytnTPqRk666oOcDh796rt5
         W1SjnIiqgz5KNK11xLTj256um9u/k4+/5+8GSUUNS1JotuxHOPV7fZbIa/ZjkUpQA3ac
         P0TDnhp2ooUva3vHkfByfLzAZyZAhhEcqhIuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiVnbA+aLQJgHhafT97yYdRXOf2rz2/qkrRHHeVl/y0=;
        b=hhIpKqQoYwxm+j496AJFTFVCWD6pVQ1idPpdyL8wIodmoQ7633HY12jlFRU7r3DpHt
         08NorO2Wczti6pRwLaW1j1DvAiBFXmIMol4yr8tR5IDr/lVy+ww70XrEFmKU1b1HslrY
         H8qJ6I9n0CXsJksR9rBtUKo0oa2AJXF5oexVkS5b5GQqtW8XQb9tYvTCrEYClRJduBdP
         MQOaLr+RDdilPsNQhKiCAksl1W7Cwfnx2heY9ELSjli/CH5Uf9YEHB48kVNsJ9Mge3ny
         rhsnNqBkspogOSDecqEmTsT4YEu38ggPQSvyJkj5toAJZyPSaGDi0orDt3OqcviQc2qq
         if7w==
X-Gm-Message-State: APjAAAV1WNF0t4ej5vRi5j2wlXIrEHMRJgPrL1BfoAw0ZFgvZwJ7oV9c
        EkfnBDsFcUEyb0MvGuYnoOPq7cJ3dK4ibMaZ
X-Google-Smtp-Source: APXvYqyY1XtYAXaxuUxr5OqGf/UpqCH4S0tKcnokVcpJWs4tNPMtCmYKxFMQ4t+72vh1UpmamXg+gA==
X-Received: by 2002:ac2:5635:: with SMTP id b21mr6601913lff.89.1573218133640;
        Fri, 08 Nov 2019 05:02:13 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:13 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 36/47] soc: fsl: qe: make cpm_muram_free() ignore a negative offset
Date:   Fri,  8 Nov 2019 14:01:12 +0100
Message-Id: <20191108130123.6839-37-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows one to simplify callers since they can store a negative
value as a sentinel to indicate "this was never allocated" (or store
the -ENOMEM from an allocation failure) and then call cpm_muram_free()
unconditionally.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index ea9bef1d2c77..4437f4e14d2c 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -176,6 +176,9 @@ void cpm_muram_free(s32 offset)
 	int size;
 	struct muram_block *tmp;
 
+	if (offset < 0)
+		return;
+
 	size = 0;
 	spin_lock_irqsave(&cpm_muram_lock, flags);
 	list_for_each_entry(tmp, &muram_block_list, head) {
-- 
2.23.0

