Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368FF2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412392;
	bh=rcgj4uFqzecp/VfI3X3sGGN8roB1SMjVWPrNfOob1QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDJJXSWTI/mzu8tJIu9j3HqrPy13R0+ZfKy2eWWGi44H7CEjso39CMPH/CiZqR2sH
	 yc1i81TKyuTbF7zxUcoi7gj27Mojr+lhMpSfDigScKNyhaS8J4xN9kdc1UB67dAu5I
	 9b35WiQ0JHpOXlWKj5YiezIEvRzoqdZiZRh8XGZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfCLRjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729067AbfCLRQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:18 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B155E2183F;
        Tue, 12 Mar 2019 17:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410977;
        bh=rcgj4uFqzecp/VfI3X3sGGN8roB1SMjVWPrNfOob1QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdqBFiuQs1QkHPMBUiv5ur7zQQPcc70Zr5GJ/XrNZdnHw7fqUe/Qc6BkbKYlTFsXS
         c9qSFUVx4xB+Bt3DSEt3u/5X27jz9T5Jia+VQmbk7w7vG3PSxMqIKNXksdccHSJQ0P
         22MOA88UtXLo1mXHJAi2qaUH5t7pJZCF6PWSsKME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/135] selftests: cpu-hotplug: fix case where CPUs offline > CPUs present
Date:   Tue, 12 Mar 2019 10:08:20 -0700
Message-Id: <20190312170346.068561418@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2b531b6137834a55857a337ac17510d6436b6fbb ]

The cpu-hotplug test assumes that we can offline the maximum CPU as
described by /sys/devices/system/cpu/offline.  However, in the case
where the number of CPUs exceeds like kernel configuration then
the offline count can be greater than the present count and we end
up trying to test the offlining of a CPU that is not available to
offline.  Fix this by testing the maximum present CPU instead.

Also, the test currently offlines the CPU and does not online it,
so fix this by onlining the CPU after the test.

Fixes: d89dffa976bc ("fault-injection: add selftests for cpu and memory hotplug")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/cpu-hotplug/cpu-on-off-test.sh        | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index f3a8933c1275..49ccd2293343 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -35,6 +35,10 @@ prerequisite()
 		exit 0
 	fi
 
+	present_cpus=`cat $SYSFS/devices/system/cpu/present`
+	present_max=${present_cpus##*-}
+	echo "present_cpus = $present_cpus present_max = $present_max"
+
 	echo -e "\t Cpus in online state: $online_cpus"
 
 	offline_cpus=`cat $SYSFS/devices/system/cpu/offline`
@@ -149,6 +153,8 @@ online_cpus=0
 online_max=0
 offline_cpus=0
 offline_max=0
+present_cpus=0
+present_max=0
 
 while getopts e:ahp: opt; do
 	case $opt in
@@ -188,9 +194,10 @@ if [ $allcpus -eq 0 ]; then
 	online_cpu_expect_success $online_max
 
 	if [[ $offline_cpus -gt 0 ]]; then
-		echo -e "\t offline to online to offline: cpu $offline_max"
-		online_cpu_expect_success $offline_max
-		offline_cpu_expect_success $offline_max
+		echo -e "\t offline to online to offline: cpu $present_max"
+		online_cpu_expect_success $present_max
+		offline_cpu_expect_success $present_max
+		online_cpu $present_max
 	fi
 	exit 0
 else
-- 
2.19.1



