Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE24C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FF22464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/Xbx5SM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLFXPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:15:06 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44919 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfLFXO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:14:59 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so7668821iln.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+bCO0qSTsJpgnDH0NSYAfIQh9sSmAX/hx8vy7p3YEc=;
        b=Z/Xbx5SMGzkmTzlohmFaRjaKSG/233oQvFE0GoAG/NKcc14JXMPJXivMjqsc0SqKZk
         765ac0i7aKxsJGA4+Psdynz1zjogcjcALFhr3BRP9FYr1dm0+kY+TgU7/IfKZaSE1/Mf
         2aTR1awEqLKv/bIObkeI4DKvXPt4DiHt9C1X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+bCO0qSTsJpgnDH0NSYAfIQh9sSmAX/hx8vy7p3YEc=;
        b=RGLoNotBQ2NMMytr8Eav5/k/HWhO/pwrTzHBx12heTLOdsrBMFxYyFdJjJqylWW3Pq
         ghK3kruotRF+dpgGR0gudDpyakNjF+dAZbfEA5NQXEWgmOZARefL+MHMWUMX9aZER5mU
         RbXIpxbca1ZAnnHrPCgFIQDQPmAlwWhf1sK/J3lGBbug8MqS2H3stXsa+Ean9aLiBAOB
         2aWzr4+T6SSVMhxPEjC06l88cWFhqqdKCj9GDokXVIO6ReTj5Z/SLZrQn1fHyjBCSfuc
         hfwPfdZ0g8kiRW+AIJ3eXyjLokqju0RhGoc2STLAfeA8bTggdZVxMwtGkpTZnZ81RdSX
         QJog==
X-Gm-Message-State: APjAAAWmDNYs3onxzjKai/KcPodWPrHxZzMosRD1kmkD6pZipB2izC8g
        B3sbkANVxteZ4tz16U+Ri1LkbA==
X-Google-Smtp-Source: APXvYqyUb3p6TWF/5Y1tQt1qhDpYXT7+c9Ks6efvV7gYz+U+FZ8DrGd412XaRsB2HXJbl4Mm60rr3Q==
X-Received: by 2002:a92:3d49:: with SMTP id k70mr16067531ila.246.1575674098985;
        Fri, 06 Dec 2019 15:14:58 -0800 (PST)
Received: from ddavenport4.bld.corp.google.com ([2620:15c:183:0:92f:a80a:519d:f777])
        by smtp.gmail.com with ESMTPSA id b15sm4317946ilo.37.2019.12.06.15.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Dec 2019 15:14:58 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Drew Davenport <ddavenport@chromium.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        zhengbin <zhengbin13@huawei.com>,
        Bruce Wang <bzwang@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 5/6] drm/msm/dpu: Remove unreachable code
Date:   Fri,  6 Dec 2019 16:13:47 -0700
Message-Id: <20191206161137.5.I3259a95a1b16978f6b38c23597a9bbba4521cf67@changeid>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206161137.1.Ibb7612c1ebcebe3f560b3269150c0e0363f01e44@changeid>
References: <20191206161137.1.Ibb7612c1ebcebe3f560b3269150c0e0363f01e44@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return statement follows another return statement, so will never be
reached.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index cfd01b0ac7f1..cc2ecf327582 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -816,6 +816,4 @@ struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(
 	DPU_DEBUG_CMDENC(cmd_enc, "created\n");
 
 	return phys_enc;
-
-	return ERR_PTR(ret);
 }
-- 
2.21.0

