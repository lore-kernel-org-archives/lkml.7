Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7BBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B36720644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ80pFZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfHSXs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:48:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45681 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHSXsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:48:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so2130931pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jxj+2KZBWtI0JOpMk5ZJCeu1tAsbbFil+Y5lPkm52H0=;
        b=IQ80pFZQbJTfI6qmkgm+X+z7T8DmQFSexAjS798jPAeYmmSZvKqg06wlrUWHjTqetS
         pHe2HzyMwsb87YS2RnHuQkyNUaEAfCUbelgxXpsrVrA4jVavbmh5+RqRvrKSUL2gDSBq
         HNzka37Lk81sHpP1Y4riaLwTV71A38hbWVOZCBafoKC78lXSVf3bVUbYMOA6VZQ6LYA8
         rwcLSCBDQ2AeHiQpblEGOT+1ZHQuzRIDHmtEbrbzPypjmYgkvsqHYNRWlHow0JAT8DDm
         mokqDCa9u+jye8pLY5XmDAMyT0QgAhT4ezy4EmbVCCydamwAQ+lDBzjVIWGOgd4AYvla
         GRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jxj+2KZBWtI0JOpMk5ZJCeu1tAsbbFil+Y5lPkm52H0=;
        b=FoLbMnqzqPsTCDpzgs2WrKVjwrmIMDz5S1er4Yt0pNH9fwGqlxQtMevEM61H7rIB9h
         bzbphXLn2492ynO7lJt1MqWNAqETNhuYcGx+MD30aPzaIufxB0oo8aVtOJsECSeDq5QM
         cNMWfta16j2GGJRM/bsThUOHY+Cv8BJiergYLGypGR0EMz3jMmGBnGHfzTSjS9nPWg5p
         cdKjsm391MCuQ32tedQqEukrjZ6aJqifEIem3ABL0cC63d+wuJRwTmUvSVGGBrcoV+cA
         2soH0aRS+VOLcxrnH231kKTrgzFFcjSFedoJe1EaugB9Ur/+o8HqAmfqr1T+5aiWTHXa
         zyNw==
X-Gm-Message-State: APjAAAW2/fn8bXcxBg6alz2z3PGjKy2FK15OsqaYemgnm8HujDc9/RZE
        5L52KfMcL4cbmTrdVinCmMLmSdXdmeY=
X-Google-Smtp-Source: APXvYqxDZJWpa+rGG7aHYapq5x9JNeNVXRKzvW0GVlc0jWWCMSrxU1NQ4LMuf5Vx7sh6EKVz9sl47Q==
X-Received: by 2002:a65:68cd:: with SMTP id k13mr22123663pgt.411.1566258530724;
        Mon, 19 Aug 2019 16:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 185sm18769681pfa.170.2019.08.19.16.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:48:50 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/3] dt-bindings: reset: hisilicon: Add ao reset controller
Date:   Mon, 19 Aug 2019 23:48:40 +0000
Message-Id: <20190819234840.37786-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234840.37786-1-john.stultz@linaro.org>
References: <20190819234840.37786-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

This is required to bring Mali450 gpu out of reset.

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 include/dt-bindings/reset/hisi,hi6220-resets.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/reset/hisi,hi6220-resets.h b/include/dt-bindings/reset/hisi,hi6220-resets.h
index e7c362a81a97..63aff7d8aa45 100644
--- a/include/dt-bindings/reset/hisi,hi6220-resets.h
+++ b/include/dt-bindings/reset/hisi,hi6220-resets.h
@@ -73,4 +73,11 @@
 #define MEDIA_MMU                       6
 #define MEDIA_XG2RAM1                   7
 
+#define AO_G3D                          1
+#define AO_CODECISP                     2
+#define AO_MCPU                         4
+#define AO_BBPHARQMEM                   5
+#define AO_HIFI                         8
+#define AO_ACPUSCUL2C                   12
+
 #endif /*_DT_BINDINGS_RESET_CONTROLLER_HI6220*/
-- 
2.17.1

