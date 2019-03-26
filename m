Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9545C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="v/VOm10t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfCZTYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:24:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41916 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbfCZTYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:24:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id y5so2084994plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xe2cnKgj2u/5e350AhnUZqGhZDwjch2potbZGjEHUM=;
        b=v/VOm10tv19N25u4AXHbxwGBxHou9OBjaSYgwhqnd9yTlGqrc6cJ0pZyoTS1BIvrpJ
         r4fvbu/5qL9sC0M4MnERILS/2oPRyhlTlSjFPLbSOdYmZsmuF67L3ISWgQOtHavmn9SM
         H/DTQ/dbDqIiWwZd5Hi26iBq9B6ZYC65e3e2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xe2cnKgj2u/5e350AhnUZqGhZDwjch2potbZGjEHUM=;
        b=RC4QXBrJNMMOUpHyS1683B2MXo0FJbafQq4CoUfkkMCnOtbRREYYOCb3UXbJ5G5s5F
         wsriLPF2N6/6ls+f4GXplXCOJb4nQVWK3vqt2ns3li0oC60VjcQFfKQnWRzYsXkyEp6G
         c8+laJBMTYJx2u2fPNTnxlZlNQbthFAH56oc2xTxh3r+AWsYXGVfSnhU0oR/U7X/Jqx7
         popOGVZV+22z/JaRuiZpMtVShX/njlyuR6a7mn4FeHmP++bb8bXr8a+hYag5kyjHOY+T
         CgJhH9PhA61jdCRq9UtNVBuZF/tzeHjz4uvOvhjQN96GSmECd94OXOVuEMu5VlgUVbQi
         3eYw==
X-Gm-Message-State: APjAAAWu8L5PfJmHgF9EEgZYTiUgyNO87ZG7/ApFarIwT9UaElrHSJ/t
        3bnhZQ8yZ3RnbGCpvPHczMn5pk6YRVY=
X-Google-Smtp-Source: APXvYqwMJ3hs4xED/sxyQLZzrjezrjuatGt1jM2/TtrZQmpPXSsOJnh8yMCjdjiUOwVv9nMh0rSFxQ==
X-Received: by 2002:a17:902:2c01:: with SMTP id m1mr32840752plb.186.1553628278149;
        Tue, 26 Mar 2019 12:24:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l12sm36761889pgn.83.2019.03.26.12.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:24:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 4/4] rcutorture: Add cpu0 to the set of CPUs to add jitter
Date:   Tue, 26 Mar 2019 15:24:11 -0400
Message-Id: <20190326192411.198070-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190326192411.198070-1-joel@joelfernandes.org>
References: <20190326192411.198070-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jitter.sh currently does not add CPU0 to the list of CPUs for adding of
jitter. Let us add it to this list even when it is not hot-pluggable.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 47bd9829dc55..26faf5824a1f 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -49,8 +49,12 @@ do
 
 	# Set affinity to randomly selected online CPU
 	cpus=`grep 1 /sys/devices/system/cpu/*/online |
-		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
-		grep -v '^0*$'`
+		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
+
+	# Do not leave out poor old cpu0 which may not be hot-pluggable
+	if [ ! -f "/sys/devices/system/cpu/cpu0/online" ]; then
+		cpus="0 $cpus"
+	fi
 
 	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
 		srand(n + me + systime());
-- 
2.21.0.392.gf8f6787159e-goog

