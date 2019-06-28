Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E25B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcVGYRR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfF1Kl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:41:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfF1Kly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:41:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so3891768wrl.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fn4SHUReevfi7LGNbp5/ZkuKJ+VkXuPKGZp9iPHBRQM=;
        b=FcVGYRR7L2QIhyB2lwKvcYoAwdEZDdkz2dYGOGl9QJJ0ctqjC9CJ1NECXQauijgNJC
         gsIx6qLOunnFDj1aF3VW/2AeIRIEgwooWkCrf7oBEP8OZ677GZqJlEFx5PgSMj/WqHiv
         4yJf0fA26OgX3xlz45arEnpuf+Mg+5TDXv09y3Fcp5OKRoF4EKpxF7pc+/PHxdftHAYZ
         zpYhdtBcHpZI04t9Y6nPUAatQYA+8YtDnG6Bu8LEefRtuMIsp4d8hjuDTTNF8lylo3YK
         TxVuPxoml6kyZo5T4JSTcDUhztUt8ciXSYZ0ZHPaP8zX0d3u5HA4rJCo95yekxcjPWJ3
         HqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fn4SHUReevfi7LGNbp5/ZkuKJ+VkXuPKGZp9iPHBRQM=;
        b=fu9ZPGEyiz3/XL1D1a+hyjPS+DOkfOg7XksvTl3yocICW612vqBUEv8Eos64Gdydv4
         lordOCExSmvMa/OTgjClWRd+GlWxrDXjXqrY32urSGP5+4ggwbDxgyhP8qSdYBgal392
         kHJ0K6rwAEJY/8ZEV66TbHvygkU5ZGnSIETVTrSPwScrFv92DAek7EfMBcouczHadehr
         DjpJUyUUlevh1RYX4cQ+tMkLQ4HRW+swr/j5HR3NVujVZdp7yZ/JqBA8cnWYpsV03Q5/
         zuAWesZO6/Rjgg9zqaV99IpckoMnToiCS01KwlyDnxof+4GHh9/rPg3rbHOnBcP4oFKM
         XfrA==
X-Gm-Message-State: APjAAAXP2MWaRHk1U0Hyrs0X7ZT12TkIY/Og2hlxFojE/9mfygjr8f8b
        j+TRzXCyg36MqBgmoDzmzY2To1AKrrc=
X-Google-Smtp-Source: APXvYqxU+O7Rz4jovQdk7zfCc7KuhQRK+1MN9MQ4NsrOWxTF9ULwMVt/VH0FS/xYrs2HcD4jWM4JvA==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr6913488wrn.303.1561718512837;
        Fri, 28 Jun 2019 03:41:52 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id y184sm1610627wmg.14.2019.06.28.03.41.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 03:41:51 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     murphyt7@tcd.ie, kraxel@redhat.com, daniel.vetter@ffwll.ch,
        laurent.pinchart@ideasonboard.com, tomeu.vizoso@collabora.com,
        airlied@linux.ie, shuah@kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: dma-buf: Adding kernel config fragment CONFIG_UDMABUF=y
Date:   Fri, 28 Jun 2019 11:41:48 +0100
Message-Id: <20190628104148.5314-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case drivers/dma-buf/udmabuf need this kernel config enabled

CONFIG_UDMABUF=y

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/drivers/dma-buf/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/drivers/dma-buf/config

diff --git a/tools/testing/selftests/drivers/dma-buf/config b/tools/testing/selftests/drivers/dma-buf/config
new file mode 100644
index 000000000000..d708515cff1b
--- /dev/null
+++ b/tools/testing/selftests/drivers/dma-buf/config
@@ -0,0 +1 @@
+CONFIG_UDMABUF=y
-- 
2.17.1

