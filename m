Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DEBC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E21217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDSWpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:45:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:45:31 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hHRGv-0007gJ-J2
        for linux-kernel@vger.kernel.org; Fri, 19 Apr 2019 11:01:33 +0000
Received: by mail-pf1-f198.google.com with SMTP id e20so3306588pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 04:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4zumaoHX4/zdp5RahruJBE+aNHMM3t7aIPQU+OcoHVU=;
        b=IKO1PGbxeGSFT0NppGGv194Q37HH/kHenQbMCoun7JkhCxFMxJs+Cw8l+CtRPYexAD
         XvJvhdWCbqMAujVvBanvd+IPP7/54+6YdnyGOzFhc+13B++QhQHMK+n9Qsq/Li/jC9Pj
         WDAq1M5GUfh+qhPK7/euPU9X2IHylwEhvAqeg0uoBfWJ09KwYm8vaNWrXg14ZmYYIe8P
         wfqPE5bokdKxSLfCt4ciP65egzWbLMvbkA+2qNioGlmY0kH5huSvdogBvXVAqE7A13qS
         WTKCY9UEEI8jiP72js4R6uFQguJBlXQZbqSPJNpuMRM8vXH5xJx0dBu46TGRllZqu/MV
         rZpA==
X-Gm-Message-State: APjAAAWxZiYSdgivGZIYwVqOHoa/exqj/9v0MZe+ECMDC2Xkj99S2PRR
        2MNZK9btTBY7AE1QivUqnnHb6J3+id69hZaUffcSoE+FtIsnHzBsrGYDpmhPMugixMCjzTkPD9M
        ObGR57EvgR5BftSew6w4w0RVyI16noeiqiLpcA1li
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr3125968plb.153.1555671692389;
        Fri, 19 Apr 2019 04:01:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/umxfLgneWYgiIPHMQ/V3HSAR433aTxgXGkSxHXmeyy5mTvECAO/hjxqKWm4KV3QtQrUl1g==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr3125908plb.153.1555671691786;
        Fri, 19 Apr 2019 04:01:31 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id r87sm8044020pfa.71.2019.04.19.04.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 04:01:30 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     shuah@kernel.org, davem@davemloft.net
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: correct the return value for run_afpackettests
Date:   Fri, 19 Apr 2019 19:01:13 +0800
Message-Id: <20190419110113.21883-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The run_afpackettests will be marked as passed regardless the return
value of those sub-tests in the script:
    --------------------
    running psock_tpacket test
    --------------------
    [FAIL]
    selftests: run_afpackettests [PASS]

Fix this by changing the return value for each tests.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/run_afpackettests | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/run_afpackettests b/tools/testing/selftests/net/run_afpackettests
index 2dc95fd..ea5938e 100755
--- a/tools/testing/selftests/net/run_afpackettests
+++ b/tools/testing/selftests/net/run_afpackettests
@@ -6,12 +6,14 @@ if [ $(id -u) != 0 ]; then
 	exit 0
 fi
 
+ret=0
 echo "--------------------"
 echo "running psock_fanout test"
 echo "--------------------"
 ./in_netns.sh ./psock_fanout
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	ret=1
 else
 	echo "[PASS]"
 fi
@@ -22,6 +24,7 @@ echo "--------------------"
 ./in_netns.sh ./psock_tpacket
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	ret=1
 else
 	echo "[PASS]"
 fi
@@ -32,6 +35,8 @@ echo "--------------------"
 ./in_netns.sh ./txring_overwrite
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	ret=1
 else
 	echo "[PASS]"
 fi
+exit $ret
-- 
2.7.4
