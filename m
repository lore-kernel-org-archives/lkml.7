Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5C6C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4D320854
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvM6lg/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfDPBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:51:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45227 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfDPBvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:51:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id z76so11156567qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1oHXFqOI9KDRiprIDVKt7oBBW0AarM6k6RsLiI7IDnE=;
        b=SvM6lg/9tx/MReaB+ToGJNM6hA0y0L/AH+v16wX4ilVSsOWRwzbbQzsK/Isx98NoWP
         93tM46t6O9BtKldVvQfjaFecF0oofKyiYYrgK/TQcLd8+oHaO8zm+2GPQdoumwTiYZ7u
         KivyuB8wpOC7xKqoj281ByQ6DTkC9l3dBFNfNIJqiN2Z50wDh4sOGVEdinZjfvQw1qyz
         jySktoW3QjfY3XbcnACMV8dUWA3i1AcMtoZqn9ole4wrSYc7TukjnEWETr/SgunMiJIE
         RWVmw8o8acD+mHTVSI7cVGQcoz4GQm8JxGURRQ+JavEgxN5LNr/OBKKnR1AP3taNrbCm
         Xjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1oHXFqOI9KDRiprIDVKt7oBBW0AarM6k6RsLiI7IDnE=;
        b=mMgcLJSP4b5RSgORBpj5u8DcCRLBJQZlpQh6vIu6ym4IYwrgf4Ddx/1hrcyGk7xdHR
         gmkzdwv2fABs6IKt4kgTHu8MW4Ydc/4qyhGZKZzkcNe831mkVP+Nzu12L9YmFArdvkj2
         I2AwFaaijBAc1Pc717khovyknqoc3ZZRF5MhBo3oslWX3a0J54dPN2lH/gJ8o/x0ApUC
         MLOwyseI1IoIfwhVycmnJP89R6/vob92t+WV8TYp7mRJf79TvwY5+56R2wN28eY5UFTx
         L42voQXOo8WjHFJXaEPO4XXuS4N3CKPq0s7HKxouOcAGcPENhpUC7Y0hNOpTufmf/BFR
         0Nvg==
X-Gm-Message-State: APjAAAVZ6ahUpA4lbXXIol11Rfjetf9IQRaXsy0bICFLa8A5I/Xnj0WZ
        c/ukkb46ax9+WZCajGCPVv8=
X-Google-Smtp-Source: APXvYqwVuQN+m5c5Pbw1F+vlwb/PbgtUHVuwiE8mOjoWaPkBe0ODoaqFX3qE/bHZBxi1AWjvZ23wPg==
X-Received: by 2002:a05:620a:11:: with SMTP id j17mr60859083qki.111.1555379469477;
        Mon, 15 Apr 2019 18:51:09 -0700 (PDT)
Received: from debian (hlfxns017vw-142-68-56-253.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.56.253])
        by smtp.gmail.com with ESMTPSA id 194sm23092376qkd.72.2019.04.15.18.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 18:51:09 -0700 (PDT)
From:   Brian Yip <itsbriany@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, Jerry.Zhang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Brian Yip <itsbriany@gmail.com>
Subject: [PATCH v2 1/2] drm/ttm: Reset ttm_mem_global when initialized
Date:   Tue, 16 Apr 2019 01:50:34 +0000
Message-Id: <20190416015035.1435-2-itsbriany@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416015035.1435-1-itsbriany@gmail.com>
References: <20190416015035.1435-1-itsbriany@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain attributes such as num_zones and kobj in the
ttm_mem_global structure were never reset after calling
ttm_mem_global_release(). Consequently, when multiple GPU drivers
are loaded, and the first one fails to load its firmware, the second
driver will attempt to load its own firmware. Initializing the
second driver invokes ttm_mem_global_init where ttm_mem_global.num_zones
is eventually incremented beyond TTM_MEM_MAX_ZONES.
ttm_mem_global.num_zones is then used to dereference a ttm_mem_zone beyond
the amount of ttm_mem_zones allocated, resulting in a crash.

Zero initialize the ttm_mem_global structure such that its state will
be pristine and thus, ready to be re-initialized.

Signed-off-by: Brian Yip <itsbriany@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
index 699fed9e08ee..73b461d5a4c0 100644
--- a/drivers/gpu/drm/ttm/ttm_memory.c
+++ b/drivers/gpu/drm/ttm/ttm_memory.c
@@ -419,6 +419,8 @@ int ttm_mem_global_init(struct ttm_mem_global *glob)
 	int i;
 	struct ttm_mem_zone *zone;
 
+	memset(glob, 0, sizeof(struct ttm_mem_global));
+
 	spin_lock_init(&glob->lock);
 	glob->swap_queue = create_singlethread_workqueue("ttm_swap");
 	INIT_WORK(&glob->work, ttm_shrink_work);
-- 
2.20.1

