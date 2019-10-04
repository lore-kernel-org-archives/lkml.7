Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8021AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51245222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHrs101s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfJDW1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:27:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46325 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbfJDW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:27:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so4698898pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tgp/FeB2xBiOrdWqd66mmTH1EYf2q2e7GgKZ4PEeOIY=;
        b=FHrs101ssw/11oKSgeFbq+imwHggSoDWpMnD0XoJoGXLDG/DMQVKPS1SAt/7Dlb+jH
         JR4tbGd6OB7SxAvznNvOb94ShM/oM0QF5d8qI5f2T/sYyJsjAE4B4XDsXOPQ6sonOp9D
         U9zOwol2bbZakyvNAhVndhWwvqwwSPukMSDkCYis8Q3vdYKsMCjl/1pH8gI6VAzTyu5o
         NNMJaAGpMm1l5ySndZHzAySTeHWF+t2r2lzOfNybRl5Nm/Ltnl3oDjYSpMtPf5tfDbdP
         sT/kZkxgMZjvR1ShM9y5mC3EjNH5OJ8AZWS7D0ypKcEWw8VsvrIr3K2Snxpyyh2Crwn7
         GQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tgp/FeB2xBiOrdWqd66mmTH1EYf2q2e7GgKZ4PEeOIY=;
        b=E1vNVoK2Tzos+uAiM65AqGtUdlAZ0FkoAcXMgKeUrGf2WoDUgo6hTfITvb32tWvUQP
         TxSPkzhQKpKl9OQrBPK4h7zBFeGb8dfV2n/vd5eU87Oe+6Vz+lOJvqwdPecWzGAkbm0t
         Cn01nRUa3vz/qwaCiepYTg3hfYULKCkgQz2R/+eAbWoMDZ+z588iK9koqUkQvCSSBsGr
         18Ljs9HUT8IzGNMCpIgZBaA2BEyK2RyJNKzNEY58CViyDD6pKwseRBkY5tDIxjNL9YsI
         XdwaXcu0/xVA629OPNDdKK/hTqiD9DWOaLRWO0QXVxGQ2K/XxwqIFSABGSS7yiL3BbKc
         gFPA==
X-Gm-Message-State: APjAAAVrMmADi3dvU1Go+Te0E6Mot0C6iq+DgNjzkHWZSpJJyekHFRgs
        331Az9HsBySOkmmEK7M0hYGDjA==
X-Google-Smtp-Source: APXvYqyl4USr2pI1tvW9hNGMGl74FlDuzskNacHLv+8mdd57yjumXhsLj97i5VBCiJe7su2dKbiBeg==
X-Received: by 2002:aa7:9210:: with SMTP id 16mr19733167pfo.19.1570228032393;
        Fri, 04 Oct 2019 15:27:12 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x37sm6328136pgl.18.2019.10.04.15.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 15:27:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 3/6] rpmsg: glink: Put an extra reference during cleanup
Date:   Fri,  4 Oct 2019 15:26:59 -0700
Message-Id: <20191004222702.8632-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191004222702.8632-1-bjorn.andersson@linaro.org>
References: <20191004222702.8632-1-bjorn.andersson@linaro.org>
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
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Chris Lew <clew@codeaurora.org>
Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

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

