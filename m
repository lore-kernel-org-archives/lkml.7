Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B8218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8PTPF3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfDYG1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:27:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37486 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDYG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:27:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id w37so457523edw.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDp+b9LU8OTRCUXLqnc4r3oCSoAaP8pMwmufyd6e2IU=;
        b=X8PTPF3KdGUtYxvjY/Ui+xWTPfLAZmmoDhXHWzz9roAq6pL+fUGdP4+ulvrTbiAQPW
         HvN+rGj7J6KsxyoqQhCZHCt+DalnHKgWb/Rq40wrEPPUi2dfgRx833+ya7St9a+i+x3g
         jjZ3+ivjhKxkGs34dETj03v/oCsQGzCKn/vr5bcq5D3/VSBvdYITFWa0Yd5J1ozwjcUt
         kXEylHAjHPybPrZRKnPkbHdz3mGmpnyowCGVNA/0KfgNFJ/NNMqSV3V4RmpwHHZdcAKB
         YfyEOjxRlZ9iSciG1pHYx2BI/Z3/nAV5pdv9veEjw86vF59SKjrPkp2zf9bMobt3Z1+g
         RtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDp+b9LU8OTRCUXLqnc4r3oCSoAaP8pMwmufyd6e2IU=;
        b=ZBSiMepcDEjtcDe3fVvcbXesPQNQhqYZsrR6c+Y970RhxaDIkVUfoBYxx199jfhrnw
         cEY8dgxcEnnfwnQR1ByAxB8YWMFTEE6oWYD9mCgN3D8IepXWoNB+IhDFZfCNLc7HpdTo
         kAloNvRIphYexyRsQPe+O+k8ttUyDrWTpfyEwUVoCn3e9vkfBRWNZFBBo2CjP7i5aLvI
         EkWDNQ8D5+KeDwFJ8vZWd9RmLOuRFEERMWUz0svGNluVFf/+nlRN8yKbBmMy0prQKq0Z
         vqsJkSTAPL0MMtPRUvcEZ/yLVbrx/dyct6WIgHj9TsxCIo8hjW80j+y9p+Ryc/j9Vkp/
         H63Q==
X-Gm-Message-State: APjAAAUs5Bier5qbCHMbknoN4oDHaUACQy9NO0HLB6c2sN3qEtyvMo0S
        zxbXSSFMVzvvX2HxqZoB4hw=
X-Google-Smtp-Source: APXvYqyYC4n/FPJ/33z7Dn9+iLP+NoASddKBqqq3Sh617uZGlk+8ewLfuEVy3ZsWQd1Ph6I9EzbstQ==
X-Received: by 2002:a50:cb4d:: with SMTP id h13mr9174290edi.110.1556173669884;
        Wed, 24 Apr 2019 23:27:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id m3sm1977654ejc.5.2019.04.24.23.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 23:27:49 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>
Cc:     malidp@foss.arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/komeda: Use memset to initialize config_id
Date:   Wed, 24 Apr 2019 23:27:20 -0700
Message-Id: <20190425062720.26695-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/arm/display/komeda/komeda_dev.c:76:38: warning: suggest
braces around initialization of subobject [-Wmissing-braces]
        union komeda_config_id config_id = {0,};
                                            ^
                                            {}
1 warning generated.

One way to fix these warnings is to add additional braces like Clang
suggests; however, there has been a bit of push back from some
maintainers, who just prefer memset as it is unambiguous, doesn't
depend on a particular compiler version, and properly initializes all
subobjects [1][2]. Do that here so there are no more warnings.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Fixes: 4cc734cb79a8 ("drm/komeda: Add sysfs attribute: core_id and config_id")
Link: https://github.com/ClangBuiltLinux/linux/issues/457
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 9d6c31cca875..e605a518f59a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -73,9 +73,10 @@ config_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct komeda_dev *mdev = dev_to_mdev(dev);
 	struct komeda_pipeline *pipe = mdev->pipelines[0];
-	union komeda_config_id config_id = {0,};
+	union komeda_config_id config_id;
 	int i;
 
+	memset(&config_id, 0, sizeof(config_id));
 	config_id.max_line_sz = pipe->layers[0]->hsize_in.end;
 	config_id.n_pipelines = mdev->n_pipelines;
 	config_id.n_scalers = pipe->n_scalers;
-- 
2.21.0

