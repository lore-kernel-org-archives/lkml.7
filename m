Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432EFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1507F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfHpAExQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKJAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:00:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35916 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:00:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15so12904132lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6og0lVoCjT8EFtl94DdvmCL57HASZwqoUGY0yeY454E=;
        b=EfHpAExQ0Ws7cVdvaCFhiiBQ/hlsNJTdv/f6PI8HZnlNxH5SHPggqy+vJOUZB4Q2b1
         xp0KzS1WaFvwKMsTwPin0HYR81wM8NhcWZXjT7DvsEt8QlGJcDPtgxaYNBE3wefD7TxH
         1EO3yO9GI1ClTfsRhDgPKoJ4D0rKofvMk6Ut5sZu0qgmIGgkeAYTOiqffX3hlJ0JCLN1
         RSaWKKf1IrqbV0Cz5D/TzCIJhjqBWQAz1n8buIGSGzlwg1z0zZcMM0K8OHk+GijZcvf4
         Ww43+WkbhR1Mk5+/7KIM4EwSu++4hX+2suxdRD/YCB5OyThQYQTT7nJHJZ1Q/rEYj4/E
         Oj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6og0lVoCjT8EFtl94DdvmCL57HASZwqoUGY0yeY454E=;
        b=SwzVt4PN6GFf9qVfzjXE2p7CDWKmdCqFzDWaFsRFtlEE+DSjPdOYxDV+k7xWcUa7WH
         678EcyP3J4flpo/P57RQHu3PdkAsqVrqbMt2+MsYM2R/VdTtu6JPVzV+bT0jbioKs6/e
         WHq8O97riQiiDRQjVC6p+XuL2emM36Xa74R2P0tJeMEvcw/VCE53xj+H6ange/0dXHO+
         3uxPcKH8eZcsoS4AP5opt8QPA0uLsJFDtx5S0+DDAeCLuWAOpbh6HrmHLq/h+PuYTkHV
         BP37/WEvLE89gZ2xEjsXxGegeMZk4qYlzq7XqbEplmgmui7P3l/wSd61B8lqkrrrTfUC
         z6MA==
X-Gm-Message-State: APjAAAVF4I6DtuO5dzh+365Si4n105XyKdqJ9qz5e3OSkEyRCCw3LZmy
        GEpRAgV8ZSUUoUWBba3H252ElFPLHlFbfQ==
X-Google-Smtp-Source: APXvYqxBkK79S3AKofW4cmxq0Q5rJRhdzHYZ7ix0Zmt/6KPQoLSFLbxn8wPj2dbJAE7KFXCxBiN5DQ==
X-Received: by 2002:a2e:547:: with SMTP id 68mr15405763ljf.150.1573462803454;
        Mon, 11 Nov 2019 01:00:03 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id d26sm6272174ljo.54.2019.11.11.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:00:02 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: Kconfig: make CMDLINE_FORCE depend on CMDLINE
Date:   Mon, 11 Nov 2019 09:59:56 +0100
Message-Id: <20191111085956.6158-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
CONFIG_CMDLINE_FORCE gets enabled. Which forces the user to pass the
full cmdline to CONFIG_CMDLINE="...".

Rework so that CONFIG_CMDLINE_FORCE gets set only if CONFIG_CMDLINE is
set to something except an empty string.

Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 50df79d4aa3b..64764ca92fca 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1629,6 +1629,7 @@ config CMDLINE
 
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
+	depends on CMDLINE != ""
 	help
 	  Always use the default kernel command string, even if the boot
 	  loader passes other arguments to the kernel.
-- 
2.20.1

