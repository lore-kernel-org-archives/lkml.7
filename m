Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD60C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303C321924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO9i/cqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbfIRRTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:19:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33896 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732109AbfIRRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:19:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so237774pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VwSAewYHioEBjS31iqIfRjVrZyDonRdWcj1Y+TfsqH4=;
        b=rO9i/cqLekYgyKdKCnFYjAL4R/QkPCECSyUyb7g2A+JKQKpKGHGHs2JQa91AMbG/2w
         1lED6OUbgkoFnKNsS8sAuVKoGcJ/HX7iMbXflFVJP+G0Eoh2jir2EAjBir/87kMiVIbH
         TGN86ho4VviITmkJju5fHnGtLVyX20eLopp2OR9zx/XrG+lbFUgF9ho8nWFvUVmMOosg
         ztCiiJk0oz5dDSW0jP1/X7SxOt1poyhGRX1OYbu824rVveyFMp8Afqmdm2rA7sVRW6qe
         yIIF8ArmWEbZl7z3D7gYV6yBb+uq9Yj6DuuVk/BKO+JoxTbwTZEfgolB3XIWu87dAOFJ
         5AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VwSAewYHioEBjS31iqIfRjVrZyDonRdWcj1Y+TfsqH4=;
        b=eikHSN8MsE8eR4KcBZMwegpe3Svwd2CkqzzjvkkT1TVyy7Ma1vdoqO+1E7vuML2mcJ
         BvdS1HILjktLFDOiSyFwovsZ0X7MOLtZfOQAEMh8oAGddVI9MkDaBeZoBXqn57gi/nm+
         SkvDzLqKfc4Rq/Z9842mqy9b1MPvlMqrb4BmDjX1ENz17GnMrekJx9kOu8ITBIFDWFlj
         2KF91n6SUkSAB7xgzpz2wCbP+VQBnz5DROu0XhLW4ecs6H6ecRajUdhgR4AXpJ8xc63c
         J2ubEsWH6kw7/gfPxeHVCGs8de8NWC9pqKfYQ0Ua5zvjOtHQHI3WPYHcbDq38KySlyuf
         KCbQ==
X-Gm-Message-State: APjAAAWpr12ViqBD/MFrwuK/RHUdiDZpBHffd2dW1LuqMTlig0lBwEr7
        cEzxpsyVfA87wABUVs6CNa/PoA==
X-Google-Smtp-Source: APXvYqz6KBiLBnvTbiv1tlhJ561p18GEHMN8vVjD8bUsFTROEBscCpnd0MazHXczVzILrhpz3xg50g==
X-Received: by 2002:a65:6557:: with SMTP id a23mr4976164pgw.439.1568827163712;
        Wed, 18 Sep 2019 10:19:23 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y4sm2614981pjn.19.2019.09.18.10.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:19:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3/6] rpmsg: glink: Put an extra reference during cleanup
Date:   Wed, 18 Sep 2019 10:19:13 -0700
Message-Id: <20190918171916.4039-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190918171916.4039-1-bjorn.andersson@linaro.org>
References: <20190918171916.4039-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

In a remote processor crash scenario, there is no guarantee the remote
processor sent close requests before it went into a bad state. Remove
the reference that is normally handled by the close command in the
so channel resources can be released.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Lew <clew@codeaurora.org>
Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 72ed671f5dcd..21fd2ae5f7f1 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1641,6 +1641,10 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
 	idr_for_each_entry(&glink->lcids, channel, cid)
 		kref_put(&channel->refcount, qcom_glink_channel_release);
 
+	/* Release any defunct local channels, waiting for close-req */
+	idr_for_each_entry(&glink->rcids, channel, cid)
+		kref_put(&channel->refcount, qcom_glink_channel_release);
+
 	idr_destroy(&glink->lcids);
 	idr_destroy(&glink->rcids);
 	spin_unlock_irqrestore(&glink->idr_lock, flags);
-- 
2.18.0

