Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8382AC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4DB207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrV6yqHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfIRRTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:19:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44239 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfIRRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:19:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so391604pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KEWAXnlLjNC2nv8CVNynnjfMbw9zNY+Gb9tPaivirx0=;
        b=DrV6yqHPlQC+6968RW8zY7OfYQOEud2XhRgMxa0V/FestL0ujwS6mS1ef4P3er4CFx
         YhWMA+vNLvjFQ9iRqdji403DJ31sUwHdAgCrOSEwodwZ4HEtgNUhTGAS9pYSYV8TsKK0
         jX0niNN4fqvKG5a5c7wA5iv3Rq7IZrPBSkH7hHwIDgTMEZwsx73F0rBhsKqD2l9BGt4u
         FkEKnZs3m6FFnr/MH8qGU1wYzvI7h3XeonN6pg0R7tlNWSm6AndB+HnUKy2bw6F9aVcH
         qUKstThFhTPriRymtDqCK5s7H8ajExcPNAf7kUcTRQEW/LOdA7Q/T0i7oD3tOd1TPXC1
         wDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KEWAXnlLjNC2nv8CVNynnjfMbw9zNY+Gb9tPaivirx0=;
        b=IJh72GVPzs1S/cos0xZwU5ww3HGAYIpy0PaNHKCjEecw/vmTSj2zzYbFxZl+R1YSTA
         htQCZ4QRrwl+7qBKzvsMEbafQhCJXnZ2bl4UK1V3ycZJXr5TUO+H/HRlzLq/sMNaOGyK
         rpf5J37Fntz0iAkc12Wxe5STPbOT/Hy/l8bmIyeTLmneaylCvSVvNEk9xpDVUeNZRto/
         XmxdvEjXNlOTSPPfu7gSLyS5XyMQM0p9mT2oKE0mAo37+PJw0ahdo/8s5Xjmm4PU4hLP
         NyYXfB94sf2esd6HIobIwkTVXCnOlnep5IlZ1/Cv8H5jLUeSH9QdIFO8ZZpNmXFkV2iw
         IHUA==
X-Gm-Message-State: APjAAAWjIqkS6z4ciWjjgU7txZ9MP+2k2Um+suEvVN9Azocychh4Iy59
        h9WqsxmtWR7rR2uTUatdPU+45w==
X-Google-Smtp-Source: APXvYqxp62gr99DDSE2MOj4Y2Ok56M4hOgsVDIdyiHw6ue4GqTbJWWYQL6fzuTiARGdgTA9+Pndcjg==
X-Received: by 2002:a62:2b4d:: with SMTP id r74mr5507565pfr.30.1568827161136;
        Wed, 18 Sep 2019 10:19:21 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y4sm2614981pjn.19.2019.09.18.10.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:19:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/6] rpmsg: glink: Fix reuse intents memory leak issue
Date:   Wed, 18 Sep 2019 10:19:11 -0700
Message-Id: <20190918171916.4039-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190918171916.4039-1-bjorn.andersson@linaro.org>
References: <20190918171916.4039-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

Memory allocated for re-usable intents are not freed during channel
cleanup which causes memory leak in system.

Check and free all re-usable memory to avoid memory leak.

Fixes: 933b45da5d1d ("rpmsg: glink: Add support for TX intents")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 621f1afd4d6b..9355ce26fd98 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -241,10 +241,19 @@ static void qcom_glink_channel_release(struct kref *ref)
 {
 	struct glink_channel *channel = container_of(ref, struct glink_channel,
 						     refcount);
+	struct glink_core_rx_intent *tmp;
 	unsigned long flags;
+	int iid;
 
 	spin_lock_irqsave(&channel->intent_lock, flags);
+	idr_for_each_entry(&channel->liids, tmp, iid) {
+		kfree(tmp->data);
+		kfree(tmp);
+	}
 	idr_destroy(&channel->liids);
+
+	idr_for_each_entry(&channel->riids, tmp, iid)
+		kfree(tmp);
 	idr_destroy(&channel->riids);
 	spin_unlock_irqrestore(&channel->intent_lock, flags);
 
-- 
2.18.0

