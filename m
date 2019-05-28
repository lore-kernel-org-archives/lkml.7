Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9F5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0890920883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="nHz6brCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfE1Sr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:47:28 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:40747 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfE1SrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:47:25 -0400
Received: by mail-pg1-f172.google.com with SMTP id d30so11504440pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEQ1n/oEBDlyMtci6j+nHwcG1xlJk5jGvn6FttMMa9I=;
        b=nHz6brCdXv1SBf9KOaNq4ai8ItEU7CXjscWf/3mCEp9Or8drqkwYVLi3XGHxegLHs7
         PaQMR6YE4AcPTwMGpxM0fqHz/LABU8osUQ0+t1eYJ/OiOqhjkpk40sdQrqwMHJUuXamr
         DEwARfif1xO0sT52llKEg7onOa/HooMFn0z2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEQ1n/oEBDlyMtci6j+nHwcG1xlJk5jGvn6FttMMa9I=;
        b=KljpfrZQcN1sqWKgrumlacwUoXos1M1q3GdS2zdTaJA7iXLTr70FaaXEzAgRDPZYTU
         Bxh9sLIMc5OiqwrdlQU5Zcx8iqHRafdRxkVRWymRcrJtaUVDFY31d3EVEBOXPrbhqILu
         ODs8HwM+NfnF/1bNM7vnCR5CgyaWiZJwUVk25w2x8SKz53by0NhVZc1nGKq2wMIkEOq7
         3kN0hRP6jl46/GuFGz2tSUqhmPe0RH/O2aydHfZD0RT+IRlNogIbc70/kiEMg+dq9duA
         /m1P1/yuzIqXfiixhaL4kSpNZULdnj613NbLAMdE58bcJutcXVbXQWonlhfcfNZ6qMNd
         lngw==
X-Gm-Message-State: APjAAAU+dNDrTrg6yvNzt4+5bYvZNfgZuugm0O0FTlxV8ovdNlLeryYR
        PJmljr+i4mDlWwA3GfWOh12yRmK242ICag==
X-Google-Smtp-Source: APXvYqwpEQ4jyPsyWGKKc/+WwpmgAnxiutsae8V7JtWRZWdcxcAezFCLp8r5bP3IT9KQQQVPleqdOw==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr7372750pjc.3.1559069244681;
        Tue, 28 May 2019 11:47:24 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id m6sm3323766pjl.18.2019.05.28.11.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:47:24 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v2 3/3] net/udpgso_bench.sh test fails on error
Date:   Tue, 28 May 2019 11:47:08 -0700
Message-Id: <20190528184708.16516-4-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190528184708.16516-1-fklassen@appneta.com>
References: <20190528184708.16516-1-fklassen@appneta.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that failure on any individual test results in an overall
failure of the test script.

Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 tools/testing/selftests/net/udpgso_bench.sh | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
index 89c7de97b832..3a8543b14d3f 100755
--- a/tools/testing/selftests/net/udpgso_bench.sh
+++ b/tools/testing/selftests/net/udpgso_bench.sh
@@ -3,6 +3,10 @@
 #
 # Run a series of udpgso benchmarks
 
+GREEN='\033[0;92m'
+RED='\033[0;31m'
+NC='\033[0m' # No Color
+
 wake_children() {
 	local -r jobs="$(jobs -p)"
 
@@ -29,59 +33,88 @@ run_in_netns() {
 
 run_udp() {
 	local -r args=$@
+	local errors=0
 
 	echo "udp"
 	run_in_netns ${args}
+	errors=$(( $errors + $? ))
 
 	echo "udp gso"
 	run_in_netns ${args} -S 0
+	errors=$(( $errors + $? ))
 
 	echo "udp gso zerocopy"
 	run_in_netns ${args} -S 0 -z
+	errors=$(( $errors + $? ))
 
 	echo "udp gso timestamp"
 	run_in_netns ${args} -S 0 -T
+	errors=$(( $errors + $? ))
 
 	echo "udp gso zerocopy audit"
 	run_in_netns ${args} -S 0 -z -a
+	errors=$(( $errors + $? ))
 
 	echo "udp gso timestamp audit"
 	run_in_netns ${args} -S 0 -T -a
+	errors=$(( $errors + $? ))
 
 	echo "udp gso zerocopy timestamp audit"
 	run_in_netns ${args} -S 0 -T -z -a
+	errors=$(( $errors + $? ))
+
+	return $errors
 }
 
 run_tcp() {
 	local -r args=$@
+	local errors=0
 
 	echo "tcp"
 	run_in_netns ${args} -t
+	errors=$(( $errors + $? ))
 
 	echo "tcp zerocopy"
 	run_in_netns ${args} -t -z
+	errors=$(( $errors + $? ))
 
 	# excluding for now because test fails intermittently
 	#echo "tcp zerocopy audit"
 	#run_in_netns ${args} -t -z -P -a
+	#errors=$(( $errors + $? ))
+
+	return $errors
 }
 
 run_all() {
 	local -r core_args="-l 3"
 	local -r ipv4_args="${core_args} -4 -D 127.0.0.1"
 	local -r ipv6_args="${core_args} -6 -D ::1"
+	local errors=0
 
 	echo "ipv4"
 	run_tcp "${ipv4_args}"
+	errors=$(( $errors + $? ))
 	run_udp "${ipv4_args}"
+	errors=$(( $errors + $? ))
 
 	echo "ipv6"
 	run_tcp "${ipv4_args}"
+	errors=$(( $errors + $? ))
 	run_udp "${ipv6_args}"
+	errors=$(( $errors + $? ))
+
+	return $errors
 }
 
 if [[ $# -eq 0 ]]; then
 	run_all
+	if [ $? -ne 0 ]; then
+		echo -e "$(basename $0): ${RED}FAIL${NC}"
+		exit 1
+	fi
+
+	echo -e "$(basename $0): ${GREEN}PASS${NC}"
 elif [[ $1 == "__subprocess" ]]; then
 	shift
 	run_one $@
-- 
2.11.0

