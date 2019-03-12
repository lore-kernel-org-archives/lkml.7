Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06D214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCLJ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:59:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfCLJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:59:24 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1h3eBt-0003kp-RV
        for linux-kernel@vger.kernel.org; Tue, 12 Mar 2019 09:59:22 +0000
Received: by mail-pg1-f200.google.com with SMTP id y1so2127458pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jusRkWJSy8oqkA4FSVnA9QAWyZ3aU9dHEMXjZIwG3MU=;
        b=DtLBENwcc6jyboMvcIz//yspCUVCvW03Rm4V2sqgP846sUiAzIph0POJTeUIdrj8/t
         qqBH/zavexah3ZvgmFeUR3liALPjUe0CVQ74q41s1RcIRENAteLSqhFb2p32YHzYZPTi
         1hJCKjdoAzlYOJ6RatpUlvi6kQIUBAKaJ9YGS7QK2ZLvNacQuca5hRRWLhx+zB6J1jQy
         +0RdAujnOQC5zsKKmtK/nTMsdlb1cd7atUVOPb7S+kVTzhW9E1dgQS9Ref+dUxhw5UjY
         bB7nQ/UJ/okIxMJn2YN1Ay/+0ldqzRro4qoLBizVnTnODl6ph2VJAAsKXzabBHDod49+
         fXZg==
X-Gm-Message-State: APjAAAXnFzW52WPYVE0ZBL5l58+gLgMqaUaYqoMhvXkrdQ6UA1Cpc9C0
        +jVy72NKY5cKS6HHd2O7cegmtHcDJ8CgUjynT6u52J3BcmTXUDVaSVMdeUTMVvrzdWjwchbazlb
        XBMQFgvpWedejR3uzRNwMQ9SkcQICNhOkYMuj67Je
X-Received: by 2002:aa7:8157:: with SMTP id d23mr37751306pfn.67.1552384760434;
        Tue, 12 Mar 2019 02:59:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwN3x9ZJxiP8V2pxD6rdUNTwubW7lCxJqbN4eDQvc8yB6u5cwM6lJNS/NBUyna+yGb/T8nyLQ==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr37751286pfn.67.1552384760189;
        Tue, 12 Mar 2019 02:59:20 -0700 (PDT)
Received: from localhost.localdomain (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id g71sm18328045pfg.157.2019.03.12.02.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:59:19 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: cpu-hotplug: check hotplug dir for the CONFIG_HOTPLUG_CPU
Date:   Tue, 12 Mar 2019 17:58:45 +0800
Message-Id: <20190312095845.17541-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CONFIG_HOTPLUG_CPU is not set, there won't be a "hotplug"
directory in /sys/devices/system/cpu/. Make use of this fact to check
if we need to skip this test.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index 0d26b5e..27275a1 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -23,6 +23,11 @@ prerequisite()
 		exit $ksft_skip
 	fi
 
+	if [ ! -d $SYSFS/devices/system/cpu/hotplug/ ]; then
+		echo $msg CONFIG_HOTPLUG_CPU needs to be enabled >&2
+		exit $ksft_skip
+	fi
+
 	if ! ls $SYSFS/devices/system/cpu/cpu* > /dev/null 2>&1; then
 		echo $msg cpu hotplug is not supported >&2
 		exit $ksft_skip
-- 
2.7.4

