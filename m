Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7BFC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33CE222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1pFmJEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbfJDW1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:27:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33527 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfJDW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:27:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so4769272pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QoZQF1YbSGqv09dK0KDHECoZ26zQGdAXMaDDkqK/sak=;
        b=N1pFmJEh2KW227rJpCbD4242buzzbOIiY6ERrMQ9gsicebzcXfJT8NECywRZ0N5/si
         Tgj4n3z6k0mSjwaGIY0Sb9m/zLKF/BcICGuTagr4Zg+Au/njphRbjvNov33jKsA/Vf7Q
         WJF7/x1LoGppiW4Sq9F1hFhlPoIgmJwkPdEhKkhquJh7jCC02RvlcZ/+T+2suX+sWsQ8
         0Q8AeMHZ0ScKasmjlFy/MbZh+z5Sjc/tD3uKcmfU+yPdrkHQHmMgRhn7Z+AutgO8kms7
         M657x4K//+keOT+lxrB83va5DmkQtIz+fN8gUJr1lTqf+wsnRlzemkuwmS866ClQ9M6O
         2XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QoZQF1YbSGqv09dK0KDHECoZ26zQGdAXMaDDkqK/sak=;
        b=PvWv2WAJK7JWYjilN66uY7bmCRi8BDRk9JvuJlwZ63gZVEhDRX2TeTzr8OqWDfDAN0
         n1iBtEaAr1zc+5oLAGN5EyQVbeTks1rfDHc3TwZED0yeEpqd86ZIXxjlj7WVG8rWqWlw
         3l+hO01I+qfW7lGeeUmWjwgRZLnDpym77KX+Dddhn6gFwMVb9M4KvJZPqy0UTcN64tBI
         Z3Jbad4I8090qCZjrsabX/GtoWA8ZCORRpTrysBgjSR+TEx4H0D3q5VMIKYpxyH6Cme6
         qWFMkmDcKTCOrcfYd1X9lKXsMH2jeloQLE4KiP89sEcYg/0vZRYQg0A7pfE2zj1lO5P0
         SzGw==
X-Gm-Message-State: APjAAAWTwxNa8WsnXXVv3SbxHRBu2DdiSUL2Zod89OT5tqEFS81gFYRc
        1FTH7380/U8W//XbcHhJn5Sncw==
X-Google-Smtp-Source: APXvYqx4xJ8Wtupkhwv6dK4c8+ZLjIxa9GbmQKmw3sJuGnsohr/0eA2ZNw37OxsBRy7204cKjdQ11w==
X-Received: by 2002:a63:1420:: with SMTP id u32mr2589745pgl.62.1570228031137;
        Fri, 04 Oct 2019 15:27:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x37sm6328136pgl.18.2019.10.04.15.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 15:27:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/6] rpmsg: glink: Fix use after free in open_ack TIMEOUT case
Date:   Fri,  4 Oct 2019 15:26:58 -0700
Message-Id: <20191004222702.8632-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191004222702.8632-1-bjorn.andersson@linaro.org>
References: <20191004222702.8632-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

Extra channel reference put when remote sending OPEN_ACK after timeout
causes use-after-free while handling next remote CLOSE command.

Remove extra reference put in timeout case to avoid use-after-free.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Cc: stable@vger.kernel.org
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/rpmsg/qcom_glink_native.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 9355ce26fd98..72ed671f5dcd 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1103,13 +1103,12 @@ static int qcom_glink_create_remote(struct qcom_glink *glink,
 close_link:
 	/*
 	 * Send a close request to "undo" our open-ack. The close-ack will
-	 * release the last reference.
+	 * release qcom_glink_send_open_req() reference and the last reference
+	 * will be relesed after receiving remote_close or transport unregister
+	 * by calling qcom_glink_native_remove().
 	 */
 	qcom_glink_send_close_req(glink, channel);
 
-	/* Release qcom_glink_send_open_req() reference */
-	kref_put(&channel->refcount, qcom_glink_channel_release);
-
 	return ret;
 }
 
-- 
2.18.0

