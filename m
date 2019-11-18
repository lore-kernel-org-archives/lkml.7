Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3E82068E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk0Q7PQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKRIJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:09:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33849 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:09:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so10014034pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96Jv+F63R6aum6CI5bKoo8dntfo3syH700hNBAldzf8=;
        b=fk0Q7PQR6sggjT/MeuTdZYxZ6Ho5mFEHEsfpIFfbwrORvP5xp1sKbzGN0mqVIRxjUo
         Ylmn38Z8xUjdm6k+SHZMU8oGxbOezNxX1Rw5GgGfPybr2XxoklQ1ss8ikQUo8YIyX/Tz
         K7eOgI7fQB7f/VLgZ4R3UfCbiimRq2Vw9l3uJK7nesK6Kw9Ina461d/Q2wYMKcj24GXr
         wYOkJUoN/lnVXgtw7zJ4JADXtKPIVFxU4u0ofka17np5TXluHMajPWgYqymhOgaphNDW
         vgYRbGKlEPgeKQh+H5y8916JAZ15mqK6OzUdJyuJRauX9nRDe604D0Qyucq26NTGygyp
         fQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96Jv+F63R6aum6CI5bKoo8dntfo3syH700hNBAldzf8=;
        b=M71DjsyQ3rqJv6tpomy70jBYLPI2LN0bGHY9LAIXPz4J6hYbAEjGk8wShDfyZuo1aK
         dO7d7MW4niNoWfAD1tRER3XZCcJHS8px6d3yWAvgek6ZT1h+WtyaixBRxTUWVyf2/MT7
         K2XyjV1LIrvnAS9taRwUpAP3zgLMdMgK10gvH3PQ52LWR4qAlwxXy174+jiIqUa6zK5l
         D2d0Fw/jwOLsQSdqvlF4s39nPq3o/fGdYqF76ZcBi0Quin6jQlu46FCX1/5dvDJwrDo8
         Va5WgLgS9HUp4iosB0zZcFcmTuUkiAtIPr2jEKxEjps2ENH6UX3guJsQNCGUQMQeusIR
         tEMg==
X-Gm-Message-State: APjAAAUun5d4Tu4KvVmo6N9i5UIhVer867k3fD8WvV3o6KcygJ80ERDh
        iqNai5K5woIbwX+P0zuARb4=
X-Google-Smtp-Source: APXvYqzjFt0/x4mB7FohRQ9b9vlwzOtiZh/8bPuVRz3hqRm7Lt9yGKIuzG2iC5DYctLdX+LitE5B9w==
X-Received: by 2002:aa7:9ad0:: with SMTP id x16mr32892615pfp.51.1574064564418;
        Mon, 18 Nov 2019 00:09:24 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id c184sm21006699pfc.159.2019.11.18.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:09:23 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] gpu: ipu-v3: prg: add missed operations in remove
Date:   Mon, 18 Nov 2019 16:09:14 +0800
Message-Id: <20191118080914.30691-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver forgets to call pm_runtime_disable and clk_disable_unprepare
in remove.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Add the missed pm_runtime_disable.

 drivers/gpu/ipu-v3/ipu-prg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 196797c1b4b3..897da605da55 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -430,6 +430,9 @@ static int ipu_prg_remove(struct platform_device *pdev)
 	list_del(&prg->list);
 	mutex_unlock(&ipu_prg_list_mutex);
 
+	pm_runtime_disable(&pdev->dev);
+	clk_disable_unprepare(prg->clk_axi);
+	clk_disable_unprepare(prg->clk_ipg);
 	return 0;
 }
 
-- 
2.24.0

