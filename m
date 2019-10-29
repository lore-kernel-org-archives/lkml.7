Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D21CCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509C721882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xdzu47+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfJ2Lns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46541 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbfJ2Lnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so13237606wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eit7XFw0W/bYi2TCI4JrcqCDUmHso2PStZ6TlpS2snM=;
        b=Xdzu47+on9tFUo1MZdJb9roeKuleuKl5Upwgm2H2tanU77pSCp+8HtaeXU8gp0f3o9
         QaCPNaSb70jEq5fI4z4GQTu1RVh+nefR/oGnuR/pkFcyrhhSTq03Ca/h1rqbvNnLUZw8
         WGxfWg1w0e64dov4/R7uffDCdaDmhwxJZSnHDSvGqwo2qPFusze1wvbSX0hDlhc/P0fS
         wFqenAo0r4PTab8iT77RCoI4yFfCH/SlmOPd+wZiNzV6v/j1xMJ+9+v/niw+qePQBBsA
         nohwv5XlHfiU0Hn1WBKBfEe72HzM2TxnusG/JT4IZdEIFk6QsB5WW8MQTtFUKZd36rPM
         zd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eit7XFw0W/bYi2TCI4JrcqCDUmHso2PStZ6TlpS2snM=;
        b=mDxQRHg9Pmh+uQJnTFmQJsXzR5rsLQoWXHVCXKKN93TQ9WpqEwSlvTGHwR4iwh0V3E
         LOQkPkkaiGH2Xufej4dGfFsBMjOWkhqDIoY3KZuHc4hfiUPxkqaLUpv0d3sVDOjfgUvj
         AUUkFCiGHsxTKVVaMDPKt9EoXWJJwN1G8foX3RL8MPmf2bEvzbnSrXBsv84csq8NMmGg
         0zDk/G/FHpHIeYji0/aMaKJxFoimuToSiCFbH7MFYyYwDEjTbZk9tRnRwF9hynoCZmmH
         tClWRM6GeS7DJxxTTHtNNXX1ePccWdNBEO/lK6JqU6jk76PhZGq1I6sUDZBjtY6VYX9h
         AamA==
X-Gm-Message-State: APjAAAXTJ+K3UZDC9cMBXyIXrkYqUmUNmbAe1sr9GfYjoXnRWEdWJ4ZK
        CuapfyXCV0EeUlZpDZ+blZlOQQ==
X-Google-Smtp-Source: APXvYqyLbbwbIW5GQtWUvzJOdU12ryKyOFRKWmoFPlNhGreR8UVFpdXWJo8nt1C1Gq8Z3/pnzM6fPA==
X-Received: by 2002:adf:d18b:: with SMTP id v11mr3140827wrc.308.1572349422413;
        Tue, 29 Oct 2019 04:43:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 08/10] nvmem: imx: scu: fix dependency in Kconfig
Date:   Tue, 29 Oct 2019 11:42:38 +0000
Message-Id: <20191029114240.14905-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below error by adding HAVE_ARM_SMCCC dependency in Kconfig
ERROR: "__arm_smccc_smc" [drivers/nvmem/nvmem-imx-ocotp-scu.ko] undefined!

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8fd425d38d97..fd0716818881 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -50,6 +50,7 @@ config NVMEM_IMX_OCOTP
 config NVMEM_IMX_OCOTP_SCU
 	tristate "i.MX8 SCU On-Chip OTP Controller support"
 	depends on IMX_SCU
+	depends on HAVE_ARM_SMCCC
 	help
 	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
 	  available on i.MX8 SoCs.
-- 
2.21.0

