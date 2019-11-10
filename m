Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB1C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3136E21924
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355445;
	bh=D3c4QNkcyVqlFOZhnDcJ9OHruFT4RFcZq54k2LzNZLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0l/kYSU+TiMc+NRMygpb3uvDty7ILUr5948GGAeTFmNhN8A09sys7oN/Sgt7BcN2
	 SyMSwsWvIFIFSYh7G1O2997bEsSCU02A7xx8yQhiSH6562SLTx5HlPCieBym4VQ+oS
	 h+pjwps2FYQW58H+6I6pgjcD6/A+nVA9zhH+ANg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfKJCnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbfKJCno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F4021D7E;
        Sun, 10 Nov 2019 02:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353824;
        bh=D3c4QNkcyVqlFOZhnDcJ9OHruFT4RFcZq54k2LzNZLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBIlQZXBuIUO5Pci4K0+z1tBw7fDi8cFblj9iGn1QseKmTpfWgYNhCbI78AEp0xRW
         AlUxoQWFIBIztXxiUh1xkhmBQ6jjD03s+6PyU+PYxsJS71joZs7t13zkNabY7IIn0q
         UHcPCBP13TaOLnpFG8G/NoznpzxmLtoxMspOvTAM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 119/191] slimbus: ngd: return proper error code instead of zero
Date:   Sat,  9 Nov 2019 21:39:01 -0500
Message-Id: <20191110024013.29782-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 9652e6aa62a1836494ebb8dbd402587c083b568c ]

It looks like there is a typo in probe return. Fix it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index a9abde2f4088b..e587be9064e74 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1393,7 +1393,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	if (ctrl->mwq)
 		destroy_workqueue(ctrl->mwq);
 
-	return 0;
+	return ret;
 }
 
 static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
-- 
2.20.1

