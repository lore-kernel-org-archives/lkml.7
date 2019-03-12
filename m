Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4E5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2A42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413317;
	bh=TxnnQZfTSx5BZvnlSEtpeXMEyQx3hDnLinTJrF7ayO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRzhNb3i9ZOMTpMMxyYZcyOJfO7TdeKTdHIJilg5bKzh7TrohBgeoSygDBaNUkcdi
	 0I5X4wr6JRi81pszLeh1EZDHNpxI1udgRIdOeCAj7QO1njUx2ZqFGynpXXsaOu5quh
	 7bBE3FpRWGpO5M5HwcXc5HhwbYKZ8hHATSZPpsTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfCLRzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbfCLROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:05 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1967D21850;
        Tue, 12 Mar 2019 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410845;
        bh=TxnnQZfTSx5BZvnlSEtpeXMEyQx3hDnLinTJrF7ayO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yg9D7zFyRTjc0fFxTMZ+IZ9pnyxXK+2mejDCpCcYBsE0mtnRcXPzSqmdDFNa2RA73
         pBW9D5VQsAwwAxgaPhROH59knv7tf/w3p3buk5Aifye2SsFYgOBM/mOWAZOAONW5gv
         W4O0brxgzQM887uWznbzAMafS7xvkI1DioKroKVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/149] selftests: cpu-hotplug: fix case where CPUs offline > CPUs present
Date:   Tue, 12 Mar 2019 10:07:16 -0700
Message-Id: <20190312170351.138105612@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index bab13dd025a6..0d26b5e3f966 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -37,6 +37,10 @@ prerequisite()
 		exit $ksft_skip
 	fi
 
+	present_cpus=`cat $SYSFS/devices/system/cpu/present`
+	present_max=${present_cpus##*-}
+	echo "present_cpus = $present_cpus present_max = $present_max"
+
 	echo -e "\t Cpus in online state: $online_cpus"
 
 	offline_cpus=`cat $SYSFS/devices/system/cpu/offline`
@@ -151,6 +155,8 @@ online_cpus=0
 online_max=0
 offline_cpus=0
 offline_max=0
+present_cpus=0
+present_max=0
 
 while getopts e:ahp: opt; do
 	case $opt in
@@ -190,9 +196,10 @@ if [ $allcpus -eq 0 ]; then
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



