Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0485CC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64D62146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="PSm6iIH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfDEQbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:31:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35456 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfDEQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:31:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so3316669plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZdohzeVgbbKHEv1a2YghmfxHtlO8ojKInm2nc2fqSSY=;
        b=PSm6iIH22bQjfVX/OFyc5tTFBWUXyzBN+/3D4gzjbY2XeSlwLc3ji4ewsAi9wiqGNc
         BJ6eFGaZdSWdG3bxdlaMtP1+Yx0urJTT/EQLkj9ttSX3tTEWUadUCTD3HpGkkdw8ESAX
         wTg8KU20g0YH1fbygh7ykj6NYU4Sp1PiiH6s+TexA+eavAu2BWyOZx/Hukn1QN+m20Qf
         IGQ6Y/2XhVv98mY0f7ofzj4tsLP+7cb3iN/CtuNAKyOemiHH0dVs+KyaGvT3/0MwYXoV
         MuLjxgU1/FZSFB/ExwfCoNDo7d0Spti9KqAPqBPFqD3oF4oPC8FUk0yEz47h9/4qYIaL
         7pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZdohzeVgbbKHEv1a2YghmfxHtlO8ojKInm2nc2fqSSY=;
        b=Xu3hXQp4FC5DTBQ3pj0qc2McApx4lv86JKVh8mWuurN2sbNpkHtfXyy2korytOjhqV
         sV3vClF3mv4rS0XQQ8xHPnReCUrhC54s8ryhGlS+MABHxyqUtjg5Q3s7yJfWJI5FJCb2
         U/1+epL1y3bd7nySEk1PyPtuq2ne/zyX2DMXDc5rmebG7HtxBqIBhvV9f6AWzZiXZAko
         FPT1tJb5E+eSeRp3F8qx5brRClCEFEv9CmuJZP4jWw5vis+N3ROWEVQh2diUu2SDdt0g
         eW31pD6iK0ZdpHnTaLnA+RNbrWVUdRgB0E25e6Iuepv0yc6YTfztAe0cGdXRbg353YhK
         nOkg==
X-Gm-Message-State: APjAAAUyw6i7byrKibGBHQNZTxzi6TAju+KBEld7cu7b2slB3U0Rk16Q
        KBZOJ4kO7ShepONcAbSsWXdWtLwlxv0=
X-Google-Smtp-Source: APXvYqwEpSlZFAZvqwQbB7KeNqfibcq5bMj4YAIsL37WQ/Kf37hWyXJOe/0y+uRUA35VogthoY2caw==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr14037373plo.32.1554481912318;
        Fri, 05 Apr 2019 09:31:52 -0700 (PDT)
Received: from localhost.localdomain ([27.57.24.62])
        by smtp.gmail.com with ESMTPSA id x128sm7061857pfx.103.2019.04.05.09.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 09:31:51 -0700 (PDT)
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     fw@strlen.de
Cc:     shuah@kernel.org, pablo@netfilter.org,
        linu-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftests : netfilter: Wrote a error and exit code for a command which needed veth kernel module.
Date:   Fri,  5 Apr 2019 22:01:26 +0530
Message-Id: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test for  the basic NAT functionality uses ip command which
needs veth device.There is a condition where the kernel support
for veth is not compiled into the kernel and the test script
breaks.This patch contains code for reasonable error display
and correct code exit.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/netfilter/nft_nat.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/nft_nat.sh b/tools/testing/selftests/netfilter/nft_nat.sh
index 8ec76681605c..f25f72a75cf3 100755
--- a/tools/testing/selftests/netfilter/nft_nat.sh
+++ b/tools/testing/selftests/netfilter/nft_nat.sh
@@ -23,7 +23,11 @@ ip netns add ns0
 ip netns add ns1
 ip netns add ns2
 
-ip link add veth0 netns ns0 type veth peer name eth0 netns ns1
+ip link add veth0 netns ns0 type veth peer name eth0 netns ns1 > /dev/null 2>&1
+if [ $? -ne 0 ];then
+    echo "SKIP: No virtual ethernet pair device support in kernel"
+    exit $ksft_skip
+fi
 ip link add veth1 netns ns0 type veth peer name eth0 netns ns2
 
 ip -net ns0 link set lo up
-- 
2.20.1

