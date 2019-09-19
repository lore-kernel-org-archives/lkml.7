Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F8D21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJ3anWqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfISKF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:05:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbfISKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:05:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so796602wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qCMMPkPMs7VBfcvx3JaPL0V56C94XiExPoi5TYfUdo=;
        b=YJ3anWqkz3yfMdDXZlWvfwd2aRSX1GEWmuiEvzP4HnRI/QUu14biCE0o0kKjREXsCf
         KuW4986tQaHaCZuqMpurrkj8rK6Txizw1DhqQIJ4AWTDSZ9yeaLNKdWapvPAu+a1e0Wy
         0NKhkRAFN1BL+Fro8CrV82lsXppSNdtTsQJBE1IVuxoJfBHtHV0Ve6IKj8vqag92lSBl
         6fHu8EODi8AyrZZvYOiJJa6KyqEiyjkvyJH8Hg6zgKhSxat7GGzDkPtc1y9q0pGjD6ZO
         JZI34ycmL8mzIKssv01a5fULUS5KbRJnJUBPhdgzDG+SPSdDnQJYtuJplCrc7J5SExLd
         xijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qCMMPkPMs7VBfcvx3JaPL0V56C94XiExPoi5TYfUdo=;
        b=uUI7NEsCD7f2JntRKn6nyVcVGdWFy7ikLKCG/mT89v10z7nhbGcygEFw5WZHmSTeHx
         oLcULkJq+4ULYnPz/tzQK/fzfqQBDAttqZ6dWvBVgL0tgKJEmcjN9WU+YeCXA9J+/+fv
         SFJ4jql00pueihNC0EtTzaYeCn0dQwgMtlqdxDMrSkcWg3K3oLU9y4pcgkEquLx7CLzp
         vTE+g4SsJRrzwtrWmZrEOBSDL0dEM53pxNkl8nqrMm0L3wGDz2RPxTTPQcMSQ7iabrW+
         cWYxSwg5UyiKTA5FpjYPrkmUNF6erC5n6F5dC7WKardvdiuBTlUis4Wm/RJ5lVk8tdi/
         aARg==
X-Gm-Message-State: APjAAAVHmVfM2VSj9JNcbpPaj0hJWsHuQK+uIUpRUrDe4WgkTaSsh4m1
        07qtyj7PieeWwudkDFSJjX6nrw==
X-Google-Smtp-Source: APXvYqxgniKjpSqUKCq3LuuJ49giEyIk2zZbAqW994p+uQN2HoctohFog3xIGNP6T7hvGty7R9NUXQ==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr2081077wmk.21.1568887556601;
        Thu, 19 Sep 2019 03:05:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s10sm8590175wmf.48.2019.09.19.03.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 03:05:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] rpmsg: glink: Fix channel memory leak
Date:   Thu, 19 Sep 2019 11:05:40 +0100
Message-Id: <20190919100540.28159-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we stop and start the dsp while channel is open then there is a leak
in the driver as the refcount is not accounted for the open.

This patch checks if the channel is open while running cleanup code
and does an extra kref_put to account for open which would ensure
that channel does not leak.

Originally detected by kmemleak:
  backtrace:
    [<ffffff80088b74d8>] kmemleak_alloc+0x50/0x84
    [<ffffff80081ddbc8>] kmem_cache_alloc_trace+0xd4/0x178
    [<ffffff80086b8bd0>] qcom_glink_alloc_channel+0x34/0x148
    [<ffffff80086b8038>] qcom_glink_work+0x3b0/0x664
    [<ffffff80080c3da8>] process_one_work+0x160/0x2f8
    [<ffffff80080c4198>] worker_thread+0x1e8/0x2d4
    [<ffffff80080c8b24>] kthread+0x128/0x138
    [<ffffff80080845b4>] ret_from_fork+0x10/0x18
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffffffc02cf5ed80 (size 128):

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index dc7d3d098fd3..38a10dcc2029 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1660,8 +1660,13 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
 
 	spin_lock_irqsave(&glink->idr_lock, flags);
 	/* Release any defunct local channels, waiting for close-ack */
-	idr_for_each_entry(&glink->lcids, channel, cid)
+	idr_for_each_entry(&glink->lcids, channel, cid) {
+		if (channel->rcid)
+			kref_put(&channel->refcount,
+				 qcom_glink_channel_release);
+
 		kref_put(&channel->refcount, qcom_glink_channel_release);
+	}
 
 	/* Release any defunct local channels, waiting for close-req */
 	idr_for_each_entry(&glink->rcids, channel, cid)
-- 
2.21.0

