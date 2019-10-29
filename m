Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FACACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D524821835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPsYUDh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbfJ2Lng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42533 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbfJ2Lnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id a15so993205wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7GmRR93JXMtsBPLgTPcSF+DdecbegkmwqCROqs/zCo=;
        b=SPsYUDh87ek/LEsl2pLRTOHXHTOSZkY1ug6v4kRxoySUvzA3QwbVsJ/DAZzx1BtS5O
         Q1kkghVx0x1HWl78TTh2NRTZdXRnPsmbZUOC6FO1Uhiu712tDOsDzvm9O3eA7jgcmLRp
         8XCSG8Zi6myBdXmlNfcGeroKgbk2Y0glD62yNYaaw6syFojWYLdURZQEDi02SteaOfyv
         4d0W6rb6b5VzSFNizVDQHe2JOmK4NC80ggBD3Ca3TLWZRzfqoJEyKAETUm5Xhg5aJxOQ
         biPjM06c77DsVi72WVTesbyY1+5N5MGyZqcZZRFq52aCIbA0zXKeOAglOsG1ILd61fwR
         e3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7GmRR93JXMtsBPLgTPcSF+DdecbegkmwqCROqs/zCo=;
        b=mrrUL0MHeSRss1Z2cla6sG7xi8JmBTnS+Jv2ZFDK2bqR+BFNfo/Gmk7L4G/9Q3EcOJ
         Oiff+QDJ8cmajyXEwbtjsQM7xydAH0WZhh+a37AupMMSlLkaUCxbQFK7rI4Nw4UoaJ1T
         txB6YBEAuQ1hZtf0ZjzULxPLUNn5nWlOHJ2r13J+FpF5lT/iXWao3tssXvyy9W2xezfP
         WM5lgnig4WCRR2cnPbeffEB3w+7gyEAc5zr4mrksXncHtN4If6VV9GmXb8rCk6rSNxGU
         6ljbMbRys/nPJBHfBfDFDPWIT388u8HmZMj3/v06ws4v9pV3bASjH1gJz1PLZDfbhHos
         BjBw==
X-Gm-Message-State: APjAAAWVanLWT3/Ke2xAwRrRyfzrOd0JbEOqkDK8Obu5gJW64dQ3khu0
        iT5xtHF0cjDaeIdVrVFUb5OM1g==
X-Google-Smtp-Source: APXvYqxU/K/9NUTB1xWWAWcFUiUXqgyLfoA1iwNSldsJd5+rfUjno13F1LdZiuhRMXAnl6t3t4pMNQ==
X-Received: by 2002:adf:f686:: with SMTP id v6mr20738489wrp.141.1572349412339;
        Tue, 29 Oct 2019 04:43:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kbuild test robot <lkp@intel.com>,
        Han Nandor <nandor.han@vaisala.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/10] nvmem: core: fix nvmem_cell_write inline function
Date:   Tue, 29 Oct 2019 11:42:31 +0000
Message-Id: <20191029114240.14905-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

nvmem_cell_write's buf argument uses different types based on
the configuration of CONFIG_NVMEM. The function prototype for
enabled NVMEM uses 'void *' type, but the static dummy function
for disabled NVMEM uses 'const char *' instead. Fix the different
behaviour by always expecting a 'void *' typed buf argument.

Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Han Nandor <nandor.han@vaisala.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-By: Han Nandor <nandor.han@vaisala.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/nvmem-consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 8f8be5b00060..5c17cb733224 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -118,7 +118,7 @@ static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 }
 
 static inline int nvmem_cell_write(struct nvmem_cell *cell,
-				    const char *buf, size_t len)
+				   void *buf, size_t len)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.21.0

