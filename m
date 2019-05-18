Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDAC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 12:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAE820872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 12:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMU/cnC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfERMKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 08:10:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38083 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfERMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 08:10:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so4564876pgl.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hsExk2EVE9qHmQv/hDpWARWS77nXTJQOdwcfYjT4HFc=;
        b=ZMU/cnC1wUwXTMw26G/cc/0dgk3svpNp1Lrliqm4RpGZsPEcBi9a0hcV6wCBnoCICZ
         EvXmTaI0pF3Mo2nsek14s77tXOC4VfC7U6LY4bM7J1x+b4nnK6ot7rnIgObqkZPb+J4C
         lYKwM+4GCWjt2voajVnXNS7gXEoP8dbVXW/Iv9356ZjJQmF+3hoitppYRzUIZo6O2zf3
         6RIfC/i2DiilYTaqHZU22VO+qH53GgOa7aItuY8zNJ/hNXj2GF6/XQVMXb4mNoY/yz7q
         kliDzc3LI+Ybmi2+HUCf5Bitq399OQcAo2dqpB8qstdUcAPfgfaVga04DtDW9At64rKW
         8jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hsExk2EVE9qHmQv/hDpWARWS77nXTJQOdwcfYjT4HFc=;
        b=mN6CcNEQT6aeh2BRuYzIJKaXigCsfbL+REdPwBiV96qXrXjU+Uf7b+XWeNeiJh+v3a
         jIgh97UZX0XTr6x2L99iGk1241qy9HB2vX/rQW261KiNPI7wEe+3qrHrEujDdIkUNogl
         cERIyRNwTkyvUibBNI0nkJ96aWR/MmmFZHVGnYOHmBO9UlshpBr+3DXeNvSQYV5mdmvH
         x9iTGWiypN+u6xxSrUboR0CDYLC2476+IAsGrKpu0ys9PJhzSUaFz0Y2TDlAAQpP7rgD
         szQsQFlf37x6MVYhan6HP+HhON1gTilW79Um83dJkymy/ibCO987ZuAtDg9r1wIY5Wbs
         qdAQ==
X-Gm-Message-State: APjAAAXwUNNSD/E9CnXSVTSZsvxLWSrmyMRpbxMChpvKF+a2tI8j/u0z
        IdXuxfYx9n/qzZrSMVPjf2U=
X-Google-Smtp-Source: APXvYqyrY4opcaZJV1zKzZpEJ1t6eh1ysuCOBwPaeSx2WLZGmuPHHNhMruzPwI+uksaW7iI69D1VzQ==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr165414pgr.202.1558181431523;
        Sat, 18 May 2019 05:10:31 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id 5sm13994078pfh.109.2019.05.18.05.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 05:10:30 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, niklas.cassel@linaro.org,
        yuehaibing@huawei.com, houweitaoo@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: fix typos in code comments
Date:   Sat, 18 May 2019 20:10:26 +0800
Message-Id: <20190518121026.19135-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix lenght to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 4f85cb19a309..e8141a33a55e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1194,7 +1194,7 @@ EXPORT_SYMBOL_GPL(q6asm_open_read);
  * q6asm_write_async() - non blocking write
  *
  * @ac: audio client pointer
- * @len: lenght in bytes
+ * @len: length in bytes
  * @msw_ts: timestamp msw
  * @lsw_ts: timestamp lsw
  * @wflags: flags associated with write
-- 
2.18.0

