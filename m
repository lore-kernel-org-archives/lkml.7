Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E03C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF862177B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGr5ZXAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFZSA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:00:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40656 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:00:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1561263pgj.7;
        Wed, 26 Jun 2019 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FTgn6r6fcSmHF8w98dfXXuAN9IuTef3VgDyLMVSYVPY=;
        b=VGr5ZXAJt+EIRsczuWIzhQbJHSaDJO4BnpDAA2L+zSr9WZQ67LAlB5Q7t8XI1Fe2CS
         O7lTk/jAw4mS/C69rYPzGuWh4IjkbRyjA5rcG0WAfbOgQRW/vLQLw8KBW8g3YHnjXYv0
         pQPmTeQyE4gRy8vXmpJ4JUWY0BRmmey+G61TPTyDU8qJSEUVuVQp08i3JOg7QTRPhMv9
         vqWbe2Q2A+TqXNrzKaUc8mPdBC8a1xE3/4n5zXNHNfMR1W3OhMUozMED4V29h2Eos7vU
         zI4/3w2G8mwYhx5MTg2bBL+wdBCXnbIbvhwnnW4Mz3cdPFEmW2FDep2Ee9TsjE+q5BAd
         JUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FTgn6r6fcSmHF8w98dfXXuAN9IuTef3VgDyLMVSYVPY=;
        b=n2V2ihHbiPl6rDNTO9qFlECR3mlFtgGIPT30ezfzTyUlQx3ECW7EfPj36bpgUu3PSt
         CbZC7TOhWusY80U2xb8MwxMLq6uKhxAefHfw7w7nrGUJqrdV1faAqWfcubJsxyQYgGnG
         QdQktPPAnr3PsYF5BMseRUiDFnuhneSJ0cXImUYJi8cd8euFJuyAaNkkmWNgl1gc7ejg
         kyppZmm26Zgdvzt8FOC3vTrsEqWb7Va4NgKtitUpM/Kn6oSPanPK+GpuzjuF1y0ivMp4
         d7GsvesnFh7CIIWka1m9a2GUC0ntCLle520bYR0qHASkQDadP2DCSlQPEk1Rp6SUuo18
         0wkw==
X-Gm-Message-State: APjAAAW04l70q/yXAh4tjF6fEtPh79LBlHHVfBuZ+ki/7UHqF+nel+KN
        QCqpR/ncpu56FjWFENpTH+c=
X-Google-Smtp-Source: APXvYqxblxs8elOmJc/hGTQslan92I5J9OvEgxlBKcw95tBWYgQr9RXJHq6hIrs4/GYP2+H0OBX3IQ==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr370826pjo.47.1561572024205;
        Wed, 26 Jun 2019 11:00:24 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id v4sm20106391pff.45.2019.06.26.11.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 11:00:23 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] drm: msm: Fix add_gpu_components
Date:   Wed, 26 Jun 2019 11:00:15 -0700
Message-Id: <20190626180015.45242-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add_gpu_components() adds found GPU nodes from the DT to the match list,
regardless of the status of the nodes.  This is a problem, because if the
nodes are disabled, they should not be on the match list because they will
not be matched.  This prevents display from initing if a GPU node is
defined, but it's status is disabled.

Fix this by checking the node's status before adding it to the match list.

Fixes: dc3ea265b856 ("drm/msm: Drop the gpu binding")
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ab64ab470de7..4aeb84f1d874 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1279,7 +1279,8 @@ static int add_gpu_components(struct device *dev,
 	if (!np)
 		return 0;
 
-	drm_of_component_match_add(dev, matchptr, compare_of, np);
+	if (of_device_is_available(np))
+		drm_of_component_match_add(dev, matchptr, compare_of, np);
 
 	of_node_put(np);
 
-- 
2.17.1

