Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C41C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17324207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrhU2dyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfI0HLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:11:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39825 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfI0HLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:11:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so1015968pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FgzSnruuv7XNqxxD65EJ+AwZlRv0x29REgnPuXxLMeA=;
        b=WrhU2dyi93gFs4D+GbFw4lzLCuOSkkO5QsvfwR5+n6nP+AgAFlLabONZlVnlh1PNPC
         mlSiTWo6NZ3rzLkqubEFhiB4qFhzx8hgYOTuEZRdzwD2Ssoq3jCc9rh5J4d0pUs/Vojo
         ra6knN+QFYpr9LsbcUhNaKwIRm1IbfziceIPS1qk7Yt8QG+Y444uD5EHoCQGZFifG0N7
         61Y3F6doxu0gP+/SdEt1H9nHBf6LgoXt7jST1l1qRRfdXeyF6hcovCr7P12UbN3CUrsf
         injvUaBQp/zFbHxOnKMsh+tA8Vtsnwo5902kanTSvzDu05x+7MVABKWjkYwgAyQS3eJU
         bfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FgzSnruuv7XNqxxD65EJ+AwZlRv0x29REgnPuXxLMeA=;
        b=pn4ZsEYe1oIcpa8J/rtXAhMtriJUHlisqdmDIf2diE0NK3tofAajb7Bo0UEltcAb96
         J/Dq78yUtb24S7AHMwwceRnic8LxVZwvWBSjUDevmUCh+XXknJ03QyqhUlZOG/2YD6yy
         KeEGRivjBxcndoIThPNJbfojluZWd7vV+SuBBnQAFgSXNGjTDWsI/cNbREOkt4aUymNP
         M7zEGV3axLp7Rq9qFbxguWt1b9yZApoMreyMYmr+YaOLD0Sy6Fq8s3v4bzxPHyG3S7vd
         AmN5g0h0bPVv1lfE1mQVY8IXU2TRUFkSkgagjGDsb8nIYKs/gZ1/jtCJFTE1PPp2hJAE
         QXoA==
X-Gm-Message-State: APjAAAVJRC5utC9KXaT6/66nK8dhAGC4IEi7+gXRebUAayAKVcnn1Zi6
        AOhZf66+4E3puuNAKgWRDZLs+Xk3yo8oTg==
X-Google-Smtp-Source: APXvYqygS3OJTk4wBdVnOAShliAz6Ul346kFPpJ2oIYnl7YI5A5H+4Emlxq37Jj3K8vN/npKoMV6pw==
X-Received: by 2002:a63:461e:: with SMTP id t30mr7741315pga.141.1569568277748;
        Fri, 27 Sep 2019 00:11:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f74sm1733288pfa.34.2019.09.27.00.11.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 00:11:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwspinlock: sprd: Check the return value of clk_prepare_enable()
Date:   Fri, 27 Sep 2019 15:10:45 +0800
Message-Id: <b944d4a60b392fd9c72421a798281bf0134388ca.1569567749.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must check the return value of clk_prepare_enable() to make sure the
hardware spinlock controller can be enabled successfully, otherwise we
should return error.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index 7a8534f..d210424 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -105,7 +105,9 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 		return PTR_ERR(sprd_hwlock->clk);
 	}
 
-	clk_prepare_enable(sprd_hwlock->clk);
+	ret = clk_prepare_enable(sprd_hwlock->clk);
+	if (ret)
+		return ret;
 
 	/* set the hwspinlock to record user id to identify subsystems */
 	writel(HWSPINLOCK_USER_BITS, sprd_hwlock->base + HWSPINLOCK_RECCTRL);
-- 
1.7.9.5

