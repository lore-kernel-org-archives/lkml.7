Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB05C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C20F21655
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEn3BjDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfDYTxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45619 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfDYTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so298578pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SsYopIRysxpEbj7whdU4UQe3yKdQwJ8mx3qD/71IORY=;
        b=pEn3BjDJOEXyLev6ZwUAtTIE2ggQu6WhsuOZlgCBWHCzcm444oHRrNHykB2a0uEuXD
         mGhL1PGgQ7Wyft01lgQiRkebDk2xE8f1MwwtYbW/HkiutMRUo0D0R9+EmRY1urJcPiJa
         lwKUZ+LFmfthIxaDumaTtk/UIjSHm8pBCktzJMStrHyvSgXPodzvO9z0vlKPPVOYBUBY
         FdrDHnLbUCXXMRZ0FtQcUYvLnCaUOBFhbWIn1yChCv2Q+f2E//tjEFoddjpmqURNyf53
         iOpJcpPqD/7oLrDebM49FpkzxAVTgVYasYBu/rhvKfbHh79cD7V5zfHYjRM6dIgJSusx
         OCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SsYopIRysxpEbj7whdU4UQe3yKdQwJ8mx3qD/71IORY=;
        b=T/OgXXW1721CRms6z86F7dR3V6aS/Tvo5PsGY61tVpAVVy0VpPOTrwMAlnaJu/AmoS
         O5FOx5JMmSbwu4VevjWlfIWoH/jsr+ULAoYz1HJouZc6Fx5K2W2q0OJI/MSo66LjFvoZ
         8bWbwiS3+jngvyVCNMASrRMtube0aC0hy1sDBAYFJanE9xGg5o6NFrVr9yql1kNm460D
         +jkHvrvfPmfnwzYXbwr8+OOUADT5jjP2oAZgyR6LfSvBUXnjN6W39qIE1ZMk/23Gxkpu
         rviGAPI8sacJp6P7OUhAcQI6VLl8NPEY8vTvh+vwohFn8OQ7/bvZ7Aulp4hoMfztvPsC
         Nwdw==
X-Gm-Message-State: APjAAAXbjeX60ML9zuCXBlrkJoy3rR72hbRh0alVBW8jXlOfl3Kfsufo
        H8KRewytzsb7ktJfFbRcx4cQlA==
X-Google-Smtp-Source: APXvYqzHoYFEdIyUyqqmhGmHVThAU39t1ft6DuCQfLAOnem+WYNXUCFfRX1rDKv61tUwb5FRvkgUDQ==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr41298379plb.269.1556221995193;
        Thu, 25 Apr 2019 12:53:15 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:14 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/32] coresight: catu: Make catu_helper_ops and catu_ops static
Date:   Thu, 25 Apr 2019 13:52:40 -0600
Message-Id: <20190425195310.31562-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/hwtracing/coresight/coresight-catu.c:488:35: warning:
 symbol 'catu_helper_ops' was not declared. Should it be static?
drivers/hwtracing/coresight/coresight-catu.c:493:28: warning:
 symbol 'catu_ops' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 170fbb66bda2..057627a0753d 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -485,12 +485,12 @@ static int catu_disable(struct coresight_device *csdev, void *__unused)
 	return rc;
 }
 
-const struct coresight_ops_helper catu_helper_ops = {
+static const struct coresight_ops_helper catu_helper_ops = {
 	.enable = catu_enable,
 	.disable = catu_disable,
 };
 
-const struct coresight_ops catu_ops = {
+static const struct coresight_ops catu_ops = {
 	.helper_ops = &catu_helper_ops,
 };
 
-- 
2.17.1

