Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230AC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E2520B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfGAEkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 00:40:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAEkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 00:40:47 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hho7Q-0001hj-Ta
        for linux-kernel@vger.kernel.org; Mon, 01 Jul 2019 04:40:45 +0000
Received: by mail-pl1-f200.google.com with SMTP id r7so6636450plo.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 21:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9vifoJSKcoFZv9bK756pSy0guphf7tbgTB5siI2JqwU=;
        b=LLlX+NKPGSlYZj92a5IRhovfcmEfTNfjY7DR6nL+10/P4CTehhis3G/4xpw3er14BO
         yqbFuwY8+UHaIvaxnRXPf+mpPwYRHyCRYuibaB1j5d5dpaCvLJiQNTSdV1EhsgTzgdxw
         9GxzaqYMbIk+EW2LiGYpEm/GdYLZ+wNKjN4som8LPaBLPvfKfy/ugYH+v8Bf609pr3O2
         5xQHFAIKgfXV0zC0qGWCtOP78MTTEaaQ9HeuSE3LXV1MjyZfx6buWYN7k9UyBn9XnmdC
         RNK8dWAr8mGCPNxSGYI7KT+lxhC9lhIfWw5F8HE6pTej+sbVPM1IWidtnNrVfW/r04ov
         Tv8A==
X-Gm-Message-State: APjAAAVGe4HgKCXOrct5BHXvZ6D3ty7Imjpqlwo8SWobD8CpRxD2px/+
        xhlhDNdQVuDL0aN7FD6geoT7MUuT1UBdSfExL+4ReEsvhpq20RLNOue1IG2PEBO138VaGSzL2sE
        f5TwkLTUJw0AUDuRRC2j/VJZuuXCTzZYpBHDgTqI3
X-Received: by 2002:a17:902:324:: with SMTP id 33mr370877pld.340.1561956043685;
        Sun, 30 Jun 2019 21:40:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrjpjZ50ynx/B04ND0r1L7o7s7teiIgeCRvr0C5WzfvIZjiG3+mRjQfq4G+knSH+kt+kLTVA==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr370862pld.340.1561956043442;
        Sun, 30 Jun 2019 21:40:43 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id h1sm7823505pgv.93.2019.06.30.21.40.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 21:40:42 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] selftests/net: skip psock_tpacket test if KALLSYMS was not enabled
Date:   Mon,  1 Jul 2019 12:40:31 +0800
Message-Id: <20190701044031.19451-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The psock_tpacket test will need to access /proc/kallsyms, this would
require the kernel config CONFIG_KALLSYMS to be enabled first.

Apart from adding CONFIG_KALLSYMS to the net/config file here, check the
file existence to determine if we can run this test will be helpful to
avoid a false-positive test result when testing it directly with the
following commad against a kernel that have CONFIG_KALLSYMS disabled:
    make -C tools/testing/selftests TARGETS=net run_tests

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/config            |  1 +
 tools/testing/selftests/net/run_afpackettests | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 4740404..3dea2cb 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -25,3 +25,4 @@ CONFIG_NF_TABLES_IPV6=y
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV4=m
+CONFIG_KALLSYMS=y
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

