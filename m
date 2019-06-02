Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C047C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BA72797D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/GiEXl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFBQft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:35:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55865 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfFBQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:35:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 16so4534357wmg.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPqNziqN3jwSyP9jBiLarbBjFW7IRf4d6KG+ehEQH8I=;
        b=i/GiEXl3PBCQeCimNLpYhU4zywZjhwiXRNfQ3cpTZcTQxDmQSWyACTwX2HXvQBeysq
         oxRGLsVqO1D2udN0vLI8C3R05npvkHO2cAInkULu5L/MK0i04zXRRk8cRAZhJNBvk/9l
         mz1F/ZFBurdBA5k4o3udZ+WvTuLxxVcSr2xAbu9aWeiNUnhOCv2/Piz8JTThQ91RWA6L
         PF5iip+gG8OaY8tRu9bnbxOLfkKqZ+GO+DATgkn+D5FqQOaB04RYr9EyCKys7PGaFQ8i
         +Rv6/6k+dN+nebejHRvb4f93IuPXOO39AXM5YF+5gI3HQfCbfHYj7nTxzyEokjbBZBaN
         +ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPqNziqN3jwSyP9jBiLarbBjFW7IRf4d6KG+ehEQH8I=;
        b=LHyrAONchYIGCEcvGTdy3kiAy2okEfAprnbgQ83jY8S0UMxtqnZa5SzhvOeplKswbr
         dCMXZpMEyOmt4nu/xS5HS0Kosybp/ZttEU9r1zzTkNBPXo3GyxhJMgVzfbrr8oT2LCxM
         FXJmo80JFjTpfAUzoBgIJAMRuqsj600rlb6h6LtBWtWlklY9KbB76oPlnM9ps7LOhwM+
         BZt/jgkhXT9qn7lxjIpzmMGg27sxhSaoAKf4Hbwdd9uAdj2ARf33W14B3J3vCEhHQUir
         fANZpyb+px4mlM68I295KFPBEjFe8on5GX1IIK4IJx9iurFnUdT0Kg7N+0mkbJHBIOh1
         zWkQ==
X-Gm-Message-State: APjAAAUkPXygfp0lJEMEmC3GpyYrhTewSGbx9xzGK20WjaRtR2ZbZoDB
        QqAylss/rQOGIQhK9xzIw2Y=
X-Google-Smtp-Source: APXvYqxA0qvxMUvIHbPuyM/mUzR6nerSvsGDgs42I8IrUoZjKBqn/jV19eLqdUpRR1hmQOS+IFWrPA==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr11801235wma.48.1559493344522;
        Sun, 02 Jun 2019 09:35:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id c5sm6639273wma.19.2019.06.02.09.35.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 09:35:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove redundant definition of ETH_ALEN
Date:   Sun,  2 Jun 2019 18:35:27 +0200
Message-Id: <20190602163528.28495-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETH_ALEN is defined in linux/if_ether.h which is included by
osdep_service.h, so remove the redundant definition from ieee80211.h.

osdep_service.h:33:#include <linux/etherdevice.h>
etherdevice.h:25:#include <linux/if_ether.h>

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/ieee80211.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index c60b833ca110..d43aa4304ca5 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -14,7 +14,6 @@
 
 #define MGMT_QUEUE_NUM 5
 
-#define ETH_ALEN	6
 #define ETH_TYPE_LEN		2
 #define PAYLOAD_TYPE_LEN	1
 
-- 
2.21.0

