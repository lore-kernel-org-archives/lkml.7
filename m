Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9913CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B638217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbfDRL5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:57:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37013 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbfDRL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:57:51 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hH5fp-0004ZL-Eo
        for linux-kernel@vger.kernel.org; Thu, 18 Apr 2019 11:57:49 +0000
Received: by mail-pg1-f197.google.com with SMTP id n5so1238565pgk.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=etpmiN+xcWyQHOYZT0YCvEMFjAgyXGH8FrUy6K2Kx3w=;
        b=qPrMNIm6c6LK+ZwWQKA1kQPXIod0HZFPGn7HaDRzq3PPO1iMAz1QaGMvWsHRhTAzM5
         BuA9OnhWGh9OPyTeNrG3bOQJRVfac9mUE8KJqsFc5vY83hsJVHxzmLieQdmL/V579oKY
         6jRmP9wI/xRVgPcafzw3ZvtjN7hzQdFNg97Zun6BjBa7tYr+5bKbK8cVGdNDC7xjiz0o
         IkzJ+QNVqTxFI6m37HlpCybeASLqEm5gDSiNJDIYQGVtmwkavxz7Nmvw0xjv831UdkYm
         +6EAEOjDVevfTjt9G+riQa77mQdWBqe21XDiGp5DsHwVxPsYJaDhB8zSA8k3AA970QBF
         bCaw==
X-Gm-Message-State: APjAAAVlAk/D4fBdoTlaUI8TmbaDDaWFmP9I5y3rPfEqOnFUVIve0w2F
        CCbOjtJ3XOjPuN5tkWYRSy2tZdtjpdyJQDlvd3FAPpfO+YrVUY8kIML6V2BwZFdhIWCL3u1RLSD
        bRrXJRUSIp1kS3jNTUzPqGPXOHROf2hvvFCF+hYds
X-Received: by 2002:a63:dd10:: with SMTP id t16mr5205604pgg.446.1555588667913;
        Thu, 18 Apr 2019 04:57:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCeCihKAZ3Cz74jx9FqsFyclFv67+Cd1vJpg1Rqha19b+iOYdufXpNs5femRBF2vGeLftk9g==
X-Received: by 2002:a63:dd10:: with SMTP id t16mr5205577pgg.446.1555588667511;
        Thu, 18 Apr 2019 04:57:47 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 8sm3321382pfs.50.2019.04.18.04.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:57:46 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     shuah@kernel.org, davem@davemloft.net
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: correct the return value for run_netsocktests
Date:   Thu, 18 Apr 2019 19:57:25 +0800
Message-Id: <20190418115725.6833-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The run_netsocktests will be marked as passed regardless the actual test
result from the ./socket:

    selftests: net: run_netsocktests
    ========================================
    --------------------
    running socket test
    --------------------
    [FAIL]
    ok 1..6 selftests: net: run_netsocktests [PASS]

This is because the test script itself has been successfully executed.
Fix this by exit 1 when the test failed.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/run_netsocktests | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/run_netsocktests b/tools/testing/selftests/net/run_netsocktests
index b093f39c2..14e41fa 100755
--- a/tools/testing/selftests/net/run_netsocktests
+++ b/tools/testing/selftests/net/run_netsocktests
@@ -7,7 +7,7 @@ echo "--------------------"
 ./socket
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	exit 1
 else
 	echo "[PASS]"
 fi
-
-- 
2.7.4

