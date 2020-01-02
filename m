Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AED4C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1173D217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgLF3vSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgABKCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:02:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43697 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgABKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:02:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so38680270wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 02:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=er9/v9hYbfqIgu2voF735eSDEeNVgwGUORwc3VQPHA8=;
        b=jgLF3vSim1KrWRJOj4EfWsQqcPwmV0YZhC9zhHKWrNIZw48tFMCHKbi94hebV0Mhkb
         OjFxxXO2mHT75XsQ6Edjl3la2rofkgQmByIZK6MbEU4CWfQ+5YVOE+BYP5DNAjnDTyR6
         WJwJjwzYj6vFm/2avoicIS2UYt/ahARybLBg6x0OgKtUxTUWQrcKvF8EUMhjqD8QvX14
         WFEzOROS17m4l1C4Nhx778xYd38VpS/eAicGEA9Udn++xI68g/9UfbnTpy2X5ieQY9uW
         lWoU983NrWn5s5Q4xER5m99DTNrr8HrbW/HLkt9/7BWmDWGrRqkjOxFoIIYinyDtzk8O
         cx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=er9/v9hYbfqIgu2voF735eSDEeNVgwGUORwc3VQPHA8=;
        b=Nck5ch2Oydv/6fhfQXRqQMYS+xC63U7KU4K4Ol00OS8woAVTS4GvUOYaGRDBXN8sNT
         FxoLXYvTCb0B4Bn5a4KW/+NDFZnEKHrw895hN6WqpyTYvpuY+c97cM26hQJhS4+yfCAY
         vC54bqyWaqEkVcuCzBn3W7hWFqY/vFdD6S1t9SzBfHIYw3ntqlkJ18Oge/C+h3B8snsv
         5GjPFZo6T8rZaxoVP0Q22n/mwuE1OtD0Fjiexl+eFd4A3BEFbFfgTJ/j+mRwueRcuUOY
         Y4HEZLeZman3WyCCTA1LgIlND3S1qMctLVAY3rTZidT1eCYi0PDor1fw20vtkqo+wYsZ
         +S8A==
X-Gm-Message-State: APjAAAUc8HGVz/d1AQlZa21jUvVTagJf9cByZ3MbcutBoNHP6fcZU9ie
        Iqcy3qOmsu/1EsNbxj8FqSt2o8tUL4k=
X-Google-Smtp-Source: APXvYqxBt6oHDq9LLKZN2xnzF2RUfaONzQj75vvMhHVT7sEcmHf2BmDO0H8AfCt2i0o6w7vlkaMvww==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr44281177wrs.169.1577959367619;
        Thu, 02 Jan 2020 02:02:47 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id r6sm55418683wrq.92.2020.01.02.02.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 02:02:46 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/6] drm/etnaviv: show identity information in debugfs
Date:   Thu,  2 Jan 2020 11:02:17 +0100
Message-Id: <20200102100230.420009-4-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102100230.420009-1-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 253301be9e95..cecef5034db1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -868,6 +868,18 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 
 	verify_dma(gpu, &debug);
 
+	seq_puts(m, "\tidentity\n");
+	seq_printf(m, "\t model: 0x%x\n",
+		   gpu->identity.model);
+	seq_printf(m, "\t revision: 0x%x\n",
+		   gpu->identity.revision);
+	seq_printf(m, "\t product_id: 0x%x\n",
+		   gpu->identity.product_id);
+	seq_printf(m, "\t customer_id: 0x%x\n",
+		   gpu->identity.customer_id);
+	seq_printf(m, "\t eco_id: 0x%x\n",
+		   gpu->identity.eco_id);
+
 	seq_puts(m, "\tfeatures\n");
 	seq_printf(m, "\t major_features: 0x%08x\n",
 		   gpu->identity.features);
-- 
2.24.1

