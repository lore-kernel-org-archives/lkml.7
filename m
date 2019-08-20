Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29807C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26CB22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbMcDsfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfHTERB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 00:17:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43809 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:17:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so2047844pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KbKypMZEMo628Sx98GbFT2Lyxp3a3o8vbOSGro2hqs8=;
        b=BbMcDsfdhYJbYQOF4+aYA+FByqe1YzCp/GVmlI4KBpJik0CSaiyOMnbGH8m3TiqELX
         s4cEulkc1aWYVE0YqhE3Zgn8RO2mrIJ+vTMekI/vxsli4czBtUJA3lrnGfjK48ncRyBt
         5eOTSVG8tSarLdTZM/Mgld7VoxpN0p+9jb10g+l8q2JiGwBzB32Sdx16m3FUCg1i3UK2
         cUQRM6vLlhJbXk9WlqsISZah7xFjoLA1LLtMlpOCejDe85h3kOtM8xqxR//2Bh44v+3o
         dB/g1IRRMS9DwDLj9NIF/NaKw+Y3XfLNEPXYCd8rLtmOlUsym/69sM9Iouv3xzrrND4S
         WsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KbKypMZEMo628Sx98GbFT2Lyxp3a3o8vbOSGro2hqs8=;
        b=qu8T+4x2ogiNFp6XjjN2Hxfg7vQBH7AWkAIpXpoammCnMPjkniC8F0rR+0nGqHWZJ4
         yjshLwq/2csnW8REjLh0+PD1TmyhpN8S3/E0xL83o91iFlVcH1HdfxxRlmc2ahnEL6gc
         Pwuy96aC+N4JYOllZXqNm/QRqVEulRRtq8wd8XA8r3Wx+r5v9d40NFBtNLJSgN4h25V4
         g44+y8ACAFosVsY7wBnwZkqaa3FJmgerB4DzFUHVA4QSQM1R4IXy9hqupYCycShswN1p
         aArYm+1nuBYHvOMmDnmn3H6Hm/+BsyzH944MEYdp5Zm0Mt7Aw0qxc/H2GlzGnh8Y+M6o
         jrUg==
X-Gm-Message-State: APjAAAVNA612L1mxbdayBUOSQMb2YeTxp3iIeVmsqtYmOda4oOVEeEqO
        oldHZm6Cfl9AtZKgCyQlIf+5qA==
X-Google-Smtp-Source: APXvYqzpynUE9tTdOCXExz9bKNqsRxtU0Zbjd9lhUYl/ghqc72gIr293dR2Ts5fcabGAmXXs5bn+Eg==
X-Received: by 2002:a17:902:4401:: with SMTP id k1mr26180562pld.193.1566274620467;
        Mon, 19 Aug 2019 21:17:00 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j6sm35010849pje.11.2019.08.19.21.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 21:16:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] rpmsg: glink-smem: Name the edge based on parent remoteproc
Date:   Mon, 19 Aug 2019 21:16:56 -0700
Message-Id: <20190820041656.17197-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naming the glink edge device on the parent of_node short name causes
collisions when multiple remoteproc instances with only different unit
address are described on the platform_bus in DeviceTree.

Base the edge's name on the parent remoteproc's name instead, to ensure
that it's unique.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 64a5ce324c7f..4238383d8685 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -201,7 +201,7 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	dev->parent = parent;
 	dev->of_node = node;
 	dev->release = qcom_glink_smem_release;
-	dev_set_name(dev, "%pOFn:%pOFn", node->parent, node);
+	dev_set_name(dev, "%s:%pOFn", dev_name(parent->parent), node);
 	ret = device_register(dev);
 	if (ret) {
 		pr_err("failed to register glink edge\n");
-- 
2.18.0

