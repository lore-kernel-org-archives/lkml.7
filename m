Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0BC00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A3A24649
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578109014;
	bh=SI/+LUsCkOv6mqjlDDK/Lkt8c1rVlXx+mAffa9wYcvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVyxOvOxQyZkz+XAzKkwHld7Nb5QyGGK3p6yFNPFi4YWXxaS414DBorlh9SYX1drn
	 thrdvZZ2Um7RtG1lY2JTh8/OLWHpmyEKFLAQ9OKg6v56+bHXU482dZ4eESF9CEInd1
	 6YWKpxxNGtgISAvbeTjVYJM5GY9U0gqsXAY8JowM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgADDgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 22:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgADDgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 22:36:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F57F24649;
        Sat,  4 Jan 2020 03:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578109009;
        bh=SI/+LUsCkOv6mqjlDDK/Lkt8c1rVlXx+mAffa9wYcvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMN7QDEb4OcwVHQ7rjSk36Tr2nJW9Ees89whVRIhILocTop+KPotpWbKx1Q3g/2xs
         mgudo4ieZuyXINKPpweVBTIF0mxYnqvKpiZv++5bB8V8kwt8dc8cak++ux21ezMOjE
         YTILNj3h6wRL/7s+S821wcyFnUDskR1oX4OUTyYU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/5] selftests: firmware: Fix it to do root uid check and skip
Date:   Fri,  3 Jan 2020 22:36:43 -0500
Message-Id: <20200104033644.11121-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200104033644.11121-1-sashal@kernel.org>
References: <20200104033644.11121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

[ Upstream commit c65e41538b04e0d64a673828745a00cb68a24371 ]

firmware attempts to load test modules that require root access
and fail. Fix it to check for root uid and exit with skip code
instead.

Before this fix:

selftests: firmware: fw_run_tests.sh
modprobe: ERROR: could not insert 'test_firmware': Operation not permitted
You must have the following enabled in your kernel:
CONFIG_TEST_FIRMWARE=y
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
not ok 1 selftests: firmware: fw_run_tests.sh # SKIP

With this fix:

selftests: firmware: fw_run_tests.sh
skip all tests: must be run as root
not ok 1 selftests: firmware: fw_run_tests.sh # SKIP

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Reviwed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/firmware/fw_lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 1cbb12e284a6..8a853ace55a2 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -28,6 +28,12 @@ test_modprobe()
 
 check_mods()
 {
+	local uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "skip all tests: must be run as root" >&2
+		exit $ksft_skip
+	fi
+
 	trap "test_modprobe" EXIT
 	if [ ! -d $DIR ]; then
 		modprobe test_firmware
-- 
2.20.1

