Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DBDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7173A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfFLGsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:48:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39925 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfFLGsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:48:04 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hax3C-0000VR-0E
        for linux-kernel@vger.kernel.org; Wed, 12 Jun 2019 06:48:02 +0000
Received: by mail-pf1-f197.google.com with SMTP id 5so11359778pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 23:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iQGtsCBn1c5Cv/4lGqwB4bSu8wIK/ZdJUuePfHlu3Os=;
        b=Yoi3nQIS7324HUGA4I9RhuAsW9pbWhWT+yNB/zNqilMzDkfRIF2T5G+puZNum8Sw5k
         rr9tVEHrXbQxdsPqZyO2ztyg6T6lXCznmf8rnSbwQotCoW5vUeXZq3ml4UrJD1nPMgEr
         DGYwMiOuQfYDfSRlMTXdLXg8K0UB76dXb2coSXOPDdkkrxlIkoIQe7IOJY+LC7VdZDQV
         +gn4Qr3HmHm0n7OLnw1bgRDJbO8n0/9L3SlXlM4U7qBdsPCbkpgFcrmvtJrF+v6z/G2u
         heA+jHAbuAX/TBCv49GQeOkNyWxg9Ul6QrZskSvGEHzO8qQ3GR5GYnA8VtB9dZBN+0aa
         SRqw==
X-Gm-Message-State: APjAAAWzV5kMmNozjM9RieELQ/M22w2QyGtwQDl9flF1q81zHL2/8Pho
        XfFLpNz0lIWKmB1gzS+gASRRT2v1DGMDoE4GMOJTngYzOn1hXXcO7KyDSjjd6yjpEA7QyqXevqv
        EN0x9C5ajyTun4knbG4Jl88PBLdyjyDTLgER2uHLk
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr34534392plb.269.1560322080598;
        Tue, 11 Jun 2019 23:48:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydXTegqwqULkVpf/E0LtN7OvqKB1CDRD/xCDPTfnA0oYlo/soUUvOX7voWPt0GmlHRFF0Cpg==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr34534368plb.269.1560322080271;
        Tue, 11 Jun 2019 23:48:00 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id p68sm9888878pfb.80.2019.06.11.23.47.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 23:47:59 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: skip psock_tpacket test if KALLSYMS was not enabled
Date:   Wed, 12 Jun 2019 14:47:52 +0800
Message-Id: <20190612064752.6701-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The psock_tpacket test will need to access /proc/kallsyms, this would
require the kernel config CONFIG_KALLSYMS to be enabled first.

Check the file existence to determine if we can run this test.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/run_afpackettests | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/run_afpackettests b/tools/testing/selftests/net/run_afpackettests
index ea5938e..8b42e8b 100755
--- a/tools/testing/selftests/net/run_afpackettests
+++ b/tools/testing/selftests/net/run_afpackettests
@@ -21,12 +21,16 @@ fi
 echo "--------------------"
 echo "running psock_tpacket test"
 echo "--------------------"
-./in_netns.sh ./psock_tpacket
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	ret=1
+if [ -f /proc/kallsyms ]; then
+	./in_netns.sh ./psock_tpacket
+	if [ $? -ne 0 ]; then
+		echo "[FAIL]"
+		ret=1
+	else
+		echo "[PASS]"
+	fi
 else
-	echo "[PASS]"
+	echo "[SKIP] CONFIG_KALLSYMS not enabled"
 fi
 
 echo "--------------------"
-- 
2.7.4

