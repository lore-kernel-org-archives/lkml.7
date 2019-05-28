Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FEE2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cISi5D/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfE1MSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:18:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfE1MSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:18:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so19982998wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=StOKsWACByKGqHzXp4FwgPPs4TBih3Hh4Otp9dEioXQ=;
        b=cISi5D/BDT6QEd3pB7cEByl5UMKich5g0dhMV5zp+S1wRvW/9/hXT5QU+C7GlvJ57B
         xWDvf24PPceOpiPr7cRaSVU/q+oape2q8uZWOqpGEuo/R8KjGgdOwyBIaq/3kLzrKGGQ
         whNzHxCKgpw3k9Bh7KWqFXFTuqDxAXd4+SWB3g8dCSuqhSOwtrGWVPzkV+7cEGDk/ZZx
         Qf5A4jM5i2czqnw+/DcXANeWnegExr2C3sL3q8YXaaIYTnXTT3jJkIB4iQSlHqYbgJW5
         JyXosmF0woChkEomP+Xq/caATuzuSHa/K9EglxCdWdUK/tA62Nl0RV+nmX3u1KqzRy1f
         2ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=StOKsWACByKGqHzXp4FwgPPs4TBih3Hh4Otp9dEioXQ=;
        b=TbNOnBDazu317AdZbIJR0r/zSPs6LVUelzvyqCKQi0zYPdGMX2VsTeKpc/UzojC4Sy
         ukAwN6X9/udbd/7VaXHdkFFLwjcCurDUeCfYd0fEnxU3k+t/OoLMplDnSjSvLnSCHu9h
         UdeNDsJisGsfVQ7qe9uLkD9YTda4wvX/a1nEZ70h+iByRGnoL3uGKLnlwQcDbjI50fJJ
         sGj7ORbEZmghed/GS+J+9haV2z4S67rzFIcfebFLHK3p1jaXmVGMLpfaFcZifycVl8od
         GBOiscDTL+ERzYMrV8DbGJzqBjdtSDMRgMnB/UjLFna0dYZQon83IydUePGgUTn/a6WB
         2oaw==
X-Gm-Message-State: APjAAAUlKsivCVEt35fcttbVnM7MAJgAmb3oaKXxGYrdU0ErBSSnrK1a
        Qjl6FjeyEcy8q9o/ZGvnfFKGuQ==
X-Google-Smtp-Source: APXvYqw4D2nRhr/GsOd9BVIb+ZRg2p/b0ikisyJ/0WIX5FS1GpmYbiNUYamB1tw39uHeQqUu2AYMoQ==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr4775760wrj.103.1559045902189;
        Tue, 28 May 2019 05:18:22 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id f65sm2969853wmg.45.2019.05.28.05.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:18:21 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     linux-kselftest@vger.kernel.org
Cc:     urezki@gmail.com, shuah@kernel.org, keescook@chromium.org,
        willy@infradead.org, mhocko@suse.com,
        oleksiy.avramchenko@sonymobile.com, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: vm: install test_vmalloc.sh for run_vmtests
Date:   Tue, 28 May 2019 13:18:09 +0100
Message-Id: <20190528121809.29389-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test_vmalloc.sh to TEST_FILES to make sure it gets installed for
run_vmtests.

Fixed below error:
./run_vmtests: line 217: ./test_vmalloc.sh: No such file or directory

Tested with: make TARGETS=vm install INSTALL_PATH=$PWD/x

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/vm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index e13eb6cc8901..05306c58ff9f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,6 +25,8 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+TEST_FILES := test_vmalloc.sh
+
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-- 
2.17.1

