Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E2DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BD6206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OeidzQts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLRSvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:51:15 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:47536 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:51:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47dPH60n2Wz9vZKK
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 18:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gLR4nof4-LQn for <linux-kernel@vger.kernel.org>;
        Wed, 18 Dec 2019 12:51:14 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47dPH56pMSz9vYy1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:51:13 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id f75so2079494ybg.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 10:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rd6UJcISaPgTLxWAEQqv3WsIVtgS/8v211iCZDbirks=;
        b=OeidzQtsDhPqS8rXFpiUUv+POzrIjF6I80/LtumbihVUO1dW/A0GVNTp2YD9Mvwfbl
         +2nhIhLtOaWSE5H0DuaWh9fHiNPdNmT++hhI7fuHIl9K+0tqjNawsXfmK1BGw/05SXd8
         jgWQpxpTQwHMnVjJc0DQmpFKE7mh6Vgsd6n5fJDns8mH4LPJSTw7MKRZWcwhPdzZ5kQR
         3CEaRrsye4tpRXSbg60TG3qpfLIUrNJhKGFM6n1viFEtE0CsaqYkh4sc/6MqF6PvpLbp
         OKlLq4poZKpOizq9iPMVrtQ0L01hf1Lae/gCeP9X4JreL/QwXZSoFJoB7XlOeU58nky1
         77kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rd6UJcISaPgTLxWAEQqv3WsIVtgS/8v211iCZDbirks=;
        b=mrbyF0ncOTM7HKrjY9+Zao6GMF0iGr1lDDrdRSAfetsb0wTsWj1wcTtrQCP7sXi5dr
         DoDlVlNsmRZTxJrQ2MXqF+8EWnn4p3k+awq8e4lm0jvFyThDXwAObb8OipgkCyg6+ib1
         5JzPqNbBiZCx29ZseOR8o3hlHMJRgwMTw4Rsph5wvUsTz1/JVzFaDIDaGCHDLQUzzl8j
         9bbblZ9UUkkfEJ1VoU4HBIFLeFrwuXwATkK/fGH94/4Cze233UD6yefL3E+T/r6tZ1x2
         xgY3yneFaMmWYTkMOB+qVCGOFmpqVTMcggnXAIg3TZyyTPxTVWTRarxmSU/PBHZDalBE
         YRVQ==
X-Gm-Message-State: APjAAAVq13teV4+aGRsDkccITgC4Svj/OV/EOv62WksGSfFAYlsCxhJx
        LGINKnmrPeqOD3Bd+1ouRWLtqBY7C6sEspa5BCXy2FX064zoGdqqRdBY4tYZ9ikF+9dKj41QjVx
        NHIUPkBEKOV7G5auPzjjkTdmUFnsn
X-Received: by 2002:a0d:d4d6:: with SMTP id w205mr3137291ywd.366.1576695072488;
        Wed, 18 Dec 2019 10:51:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsZKX/RL+tjcXAqAVDUPxweVVSpnSIWxCrF+ZgDct/WJffKYv83avuE0gaxi/NmW2sUHifJg==
X-Received: by 2002:a0d:d4d6:: with SMTP id w205mr3137281ywd.366.1576695072283;
        Wed, 18 Dec 2019 10:51:12 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g65sm1202882ywd.109.2019.12.18.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 10:51:11 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: remove unnecessary assertion in vmw_resource_alloc_id
Date:   Wed, 18 Dec 2019 12:51:09 -0600
Message-Id: <20191218185109.23671-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller of vmw_resource_alloc_id checks if id is not -1. The
assertion in the said function is thus redundant and can be removed.
The patch removes the check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index c8441030637a..50c8eb8012fd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -183,8 +183,6 @@ int vmw_resource_alloc_id(struct vmw_resource *res)
 	int ret;
 	struct idr *idr = &dev_priv->res_idr[res->func->res_type];
 
-	BUG_ON(res->id != -1);
-
 	idr_preload(GFP_KERNEL);
 	spin_lock(&dev_priv->resource_lock);
 
-- 
2.20.1

