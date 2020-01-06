Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1CBC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BF22072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NKdUNnZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAFG0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:26:01 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40939 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgAFG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:26:01 -0500
Received: by mail-pf1-f176.google.com with SMTP id q8so26489807pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 22:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evzD0JK8LSn0ZimlzI9kK570jZJqixSLv6BagHOwVBY=;
        b=NKdUNnZTSI9nymd83D47gfZpXWe0OOhfLyoruQtT/TMSayYi32ZuRc7G6doc5Ls/sX
         NTQ1A8In7Jl31DVwmbpH2ODw1YUy9qw5TeCv9rqPDUqTQ+48vrIM6q2OA4fEIIrO8KYF
         5g3o4E9Lsdo+pktOokLErqtxctb2jO6OrcE6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evzD0JK8LSn0ZimlzI9kK570jZJqixSLv6BagHOwVBY=;
        b=AIifeBtwnvtimxe0s2dvfhkOWXZe5sCE/Y0TTc4qkG6GoKgVkaSFa80DfcVeIwgVZg
         HR1WYvZzCqGa7gRgLKhrwABve+c+S/x0DqKh7wwRdbU40O59u4mUzxfWkNzDPL4fQr0n
         1o50uAOxq+aOMOLhB9a0wtguTUfN1U5HUijKCAy2bOHXOA45viYliMw2cDzYiyHLXtGg
         Bs6cbHhC+X+MwK18LuJ7DvgBzzI3fZV/NaxWma2DHGEArOzAENVoe4m/OybHArQyRYPA
         0fC9dT8bZ1Oj3TZhaK+9F1ivnNXyBQ2cScyKXspzh0OxSD/dVMO1VvEu2zavPSGbtVEP
         arhQ==
X-Gm-Message-State: APjAAAU2/mfBZr97aM8Pl0KSf4M9G/y3DkVGXItUwU/SslW/CZicBwB8
        FOuYo1uqnNvhZBNJmCsDnuH/Zw==
X-Google-Smtp-Source: APXvYqyejuh87pzgwbSyfPS008rp+nddy4t59iTYRlyINoAQuexuQLkOxbUHjDxUEazEW7m0lfLpIA==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr113351949pgg.239.1578291960493;
        Sun, 05 Jan 2020 22:26:00 -0800 (PST)
Received: from Ninja.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o16sm70704250pgl.58.2020.01.05.22.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 22:25:59 -0800 (PST)
From:   Vikas Gupta <vikas.gupta@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Cc:     vikram.prakash@broadcom.com, vasundhara-v.volam@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH v1] firmware: tee_bnxt: Fix multiple call to tee_client_close_context
Date:   Mon,  6 Jan 2020 11:54:02 +0530
Message-Id: <1578291843-27613-1-git-send-email-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix calling multiple tee_client_close_context in case of shm allocation
fails.

Fixes: 246880958ac9 (“firmware: broadcom: add OP-TEE based BNXT f/w manager”)
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index 5b7ef89..ed10da5 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -215,7 +215,6 @@ static int tee_bnxt_fw_probe(struct device *dev)
 	fw_shm_pool = tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
 				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
 	if (IS_ERR(fw_shm_pool)) {
-		tee_client_close_context(pvt_data.ctx);
 		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
 		err = PTR_ERR(fw_shm_pool);
 		goto out_sess;
-- 
2.7.4

