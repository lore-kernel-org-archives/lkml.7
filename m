Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BC920823
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="L2Kvmy9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCWDqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:46:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38015 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCWDqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:46:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so768179pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7urVVlGfP+Dr6qybUiwWY4XqrDZhKCkR15U/6No/2w=;
        b=L2Kvmy9bFB3fiCk6xnItiq1AKYagpWpHBkKLBRgMB0Vefj122+OTKGSsifJBhOF0TL
         HZxhW7Fe1uh0yZV7ZNLmB8bOtl+KnJJSuBUdECFhtp/FlqMkz1FMbotK0TfmCb525wvl
         99poxvRcZB5xpVDsbnHAt/0JN4TPHgff6cf6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7urVVlGfP+Dr6qybUiwWY4XqrDZhKCkR15U/6No/2w=;
        b=lHd/z+lz3Ir5IgipYUEIZEa7dmuUtbhsND6i3knooQvjslmedIE/MHxLImCkfhfEGV
         332jChTq6sdznQRXF6Dd46zow5DUHB7k9LJsXRX7dBWzfs2hT1A5hxDgdydd5/VzLBuz
         7JYZHfO73uO++xJcPrRYakwBne6h9jUg/gpQ7yQVsVyiLuCxj5CaVEtvr8miWWFSqBXA
         xLUOIvlOnhxlwcPypn0t/nVOdQjwRjDahHdO70YENBtH1SBoV+M5Qe4VLl32YgknN/Pd
         Mi5PiKHcXtMMkLaNr/k/ynFI36G88ZbhzY7M76O0C2G+GOtqW/QUKrXtmJ4Hp3qEOVp7
         wqlA==
X-Gm-Message-State: APjAAAXfybVt4pJJCJwFpIqncuNSiKYtojG9CJYuo5THSbuXqtJwFXvD
        BdK8ZH5DG72/Csurg+EQ6CzBYrKA9u8=
X-Google-Smtp-Source: APXvYqxXcHoKOQx3nBzz0qkbJRXzzRFTfB9hxQ/A1WzjfDfrEpvfaZAZ921lWk2gcRp/kA2JPAPShw==
X-Received: by 2002:a17:902:8489:: with SMTP id c9mr69606plo.311.1553312801137;
        Fri, 22 Mar 2019 20:46:41 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m7sm18061559pgg.62.2019.03.22.20.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:46:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rcutorture: Select from only online CPUs
Date:   Fri, 22 Mar 2019 23:46:19 -0400
Message-Id: <20190323034619.15792-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcutorture jitter.sh script selects a random CPU but does not check
if it is offline or online. This leads to taskset errors many times. On
my machine, hyper threading is disabled so half the cores are offline
causing taskset errors a lot of times. Let us fix this by checking from
only the online CPUs on the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 3633828375e3..53bf9d99b5cd 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -47,10 +47,19 @@ do
 		exit 0;
 	fi
 
-	# Set affinity to randomly selected CPU
+	# Set affinity to randomly selected online CPU
 	cpus=`ls /sys/devices/system/cpu/*/online |
 		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
 		grep -v '^0*$'`
+
+	for c in $cpus; do
+		if [ "$(cat /sys/devices/system/cpu/cpu$c/online)" == "1" ];
+		then
+			cpus_tmp="$cpus_tmp $c"
+		fi
+	done
+	cpus=$cpus_tmp
+
 	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
 		srand(n + me + systime());
 		ncpus = split(cpus, ca);
-- 
2.21.0.392.gf8f6787159e-goog

