Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCBBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A543A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3zQUyJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfH2Sga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:36:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34491 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfH2Sga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:36:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so2053930pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KbKypMZEMo628Sx98GbFT2Lyxp3a3o8vbOSGro2hqs8=;
        b=t3zQUyJMxStChnSzVBHngExmp8QsLonx59qyC0ffBqgubbjGeOyOFMOsHJf8uf6HkB
         CojAknqMdbyB8D+o/RuZItXS57kNsGGjly1qq2ZpZ9joOvjLQ5RVfWeJcCMLtQBpw/zH
         eepAT69hr+gc0hwxvBjbl90PN9iyk0QDzHp5MV7YLfKc5W0wOQ7zGHWbDhWf+GrfcdTh
         wPK7Sxg25ZX5mWRup3BIgWX38rdvTV+rGjVQfpKopTCfmhGLIoh5TTogX8eiT9lPG+F4
         t34bu1vWoK9BI1Ryd083tz1DsL+ZG6939oGqr1RuXw/GymWIu89dLRkNTx/6QIyGSRjj
         NN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KbKypMZEMo628Sx98GbFT2Lyxp3a3o8vbOSGro2hqs8=;
        b=o3S4lJxe/82Lu7LqHmIPl48nEe/yQBQ5pR3E4ov7a+sD6V+sEpj7WpQrUxeJh29lX0
         Dmh7jyvW/Ur0h9NPp96AS5m88zfEfy9icgtuP3ZSk4O2eqx56ksO46vOFiSVkWfYJFRr
         Tb9SfP15Bc5CJ8ljIOs0plNpN6ukGcO8HZJFgHa6bz8wHax+bedQzoIvh0Yx3jNLWIRN
         hwln/Ema95qGAQH2X63vGaK5g7+2aPOOzOzf6Us/F/D6W7CdlH0b/TH2z8SKTc1QCZ5q
         dqQGa5mNHGRJeDBTqThEfOwWfGMecWYv0SilofEG98ubTr5ZHB0EbJm2s9k8Z3VRK2by
         zVCg==
X-Gm-Message-State: APjAAAUXBlAc2iUfOAn2EEGiitwkOa8Ipdn+wAQNB0PR5d28/V0Lvjto
        95vxOO8Wa8vURuiQpIn0x6JV8w==
X-Google-Smtp-Source: APXvYqxpv+GziRN1zBpbr421YfeGoyK+5VQeDsDe4w/JmyFKe9EoDJcwIteI02M7WGql0t//MIrfew==
X-Received: by 2002:a62:5c5:: with SMTP id 188mr13311302pff.227.1567103789574;
        Thu, 29 Aug 2019 11:36:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id ay7sm2840574pjb.4.2019.08.29.11.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 11:36:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: glink-smem: Name the edge based on parent remoteproc
Date:   Thu, 29 Aug 2019 11:36:25 -0700
Message-Id: <20190829183625.32244-1-bjorn.andersson@linaro.org>
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

