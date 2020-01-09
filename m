Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4309C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B2F2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwgwaikH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgAIKcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:32:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39693 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbgAIKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:32:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so2211600wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjni1yUPgeoynRgPUWk+P0YDXuyIvqiTixESDz/Z+m0=;
        b=dwgwaikHX8ina6DBaaaKnL5D7dXdIc0l52Vuu0oDvMrC7uaNrYaiy8hcNEcL6gOeau
         79pzoshQQ1GQWwR/XT0ieDIxQXzKMHdprKreOSBduV8uii8xuzhUf7XRLRsu+Zfeyo88
         4xIj/u4bJ/lO6xHPo9HU6orB/WlrxP4595SNmwHYFI/txUtxWEKpiiM+sv0/dS8no5Xk
         LdRMAr5QORBqYTh4RBX3MXthIXt7HUumFltv4fiNbLBCwuYXBOATDqPyFRI0XTZC9/ey
         b0fc3J1tz8QdMUQpIAMVu/mZKA+Qs/vsXmmOJYl6tYl0/DdLCyFF84Of3FGYmDcaDzIa
         TNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjni1yUPgeoynRgPUWk+P0YDXuyIvqiTixESDz/Z+m0=;
        b=FWWQSNvS9A2gU84VFjWuF94+v52eb3fXY+FrloNcVbcNCu9qF3Hs2r0ZG6Frmh01//
         +f6vnUjq4u2yptBJr7gZljDfOxXvMT++ASUktj8JcV+y/xkzHnp/zgEYgvogwqEQZp8B
         LznVXWmUwWDzxytQY/emrJh+dFa4Y9FwyKT3VB1i5uzqa46eS9/BJXdupib3cIjFORqm
         GsjKWEeumXGTJdSvvN+a2lewFbzR76sOCLLff0GoODWxDcFBVr7y5KjIOsZyRObdxPuP
         3jD6J9lpy3FkVI0Fb8XJYtyXU1dXk99d8k7GbkeQa9XQeo5q2CbBPsOA2ha1WjhmmkK2
         qvjA==
X-Gm-Message-State: APjAAAUsawy+NPK1TEHk+PTBkyNEAezkjbd2IdZcsmnVYKZAFPq1cyES
        2nKEE1Z0Ny1Z84iwwZh7EqaV5Q==
X-Google-Smtp-Source: APXvYqwCJyu9rvfAH+A6MJIJLhKQsFFZrh5ee9wtGXcZLZ1I6bTHPNhzvfklSYq/RXswn6fcs5QvQA==
X-Received: by 2002:a05:600c:1050:: with SMTP id 16mr4222451wmx.20.1578565927694;
        Thu, 09 Jan 2020 02:32:07 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z83sm2473830wmg.2.2020.01.09.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:32:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: qcom: add missed clk_disable_unprepare in remove
Date:   Thu,  9 Jan 2020 10:31:48 +0000
Message-Id: <20200109103148.5612-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
References: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

The remove misses to disable and unprepare rclk and hclk.
Add calls to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index a444badd8df5..4aad2566f52d 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -641,6 +641,8 @@ static int qcom_slim_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	slim_unregister_controller(&ctrl->ctrl);
+	clk_disable_unprepare(ctrl->rclk);
+	clk_disable_unprepare(ctrl->hclk);
 	destroy_workqueue(ctrl->rxwq);
 	return 0;
 }
-- 
2.21.0

