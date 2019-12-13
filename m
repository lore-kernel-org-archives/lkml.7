Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC5FC2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323D722527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576202171;
	bh=ZM6gv96Dv7my/juDicbQtwd6lHmLtjQAiKdk1tfL7Kw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rooY7myB1xv5AgZ6cAflcbFvkhXdVaHzc4kGOBsMirIphmZ8r9GiFu7n1aPRusqHo
	 45lz98Pqlz46O1HYH218BpOBZLoTsVdLwE6jJ4UGHN6fwPIFhmHGQlWuS+BETRVCZb
	 lG91Q3spNopm0OKque/I225CKkgfVeKpDvsG5XuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfLMB4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:56:10 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:35976 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfLMB4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:56:09 -0500
Received: by mail-io1-f41.google.com with SMTP id a22so789220ios.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 17:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jtyJn+jd2kldixpZrOSg8TBt8xCd0UBOBYu2Jdo4r4=;
        b=Asyyq5D68W25BKzSzKQUkjSn2xDNWbOl7NxBXvOaVRGASH+aZlLweLJ81c2dVUbVuX
         691irB/y5NxuVTJq1DFPC9N1qM0tunQjtKj3fF2PU7f8C21LLOa1WNPwqrpogyrCuzO0
         UjghPv2S5Hig88Zee8w9gDaniimKxyK2/YkQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jtyJn+jd2kldixpZrOSg8TBt8xCd0UBOBYu2Jdo4r4=;
        b=V3Q6aeA8m7tRzRrm8PQ7s9dk/qVTNjNPQBpZtdiCK8IB4MJaiyoOYE5lQ6WrR5n6B1
         cfO2l/KRFsKmpQFvVHbDbCqBqX46QJcN/SNEQNrTjUQ02h/Zv3oELPPnhM2MsyXEEq8W
         3/5UzzsMQRdJ5YO/aOYZ1e1umIwxgknBd0PKw46/8VaPlpW8IgE8Svw9B1DVQFvrFlwm
         SA3/C3UxB5eBAI1N7DkjV3A5OWycL6f4ENnQiVuZs2oDiLEwDZ9GJLOQxsRZXKti7Oqr
         tnD+U1W4Eg4yunX4TdS8tmjAAivgyk56wKanuaUNKZaDi9hO3jTNLikbavaDWzaWJHZm
         pokw==
X-Gm-Message-State: APjAAAUG3VaTFYGuvm5Vd879nAWrhp9zzVt1K1o0QVO/JcS5kNMB2QD+
        f+yG/wwF3Jf7OZEAZpNawcYUbg==
X-Google-Smtp-Source: APXvYqxBY8QCMBIOmrwYTxCxzMazQJTC3wK+Qsu5YVdlers+N/MkKK1lKh9v4m46m285ky2Sp8Jlqg==
X-Received: by 2002:a5d:9d4a:: with SMTP id k10mr5969938iok.134.1576202168931;
        Thu, 12 Dec 2019 17:56:08 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y11sm1684335iot.19.2019.12.12.17.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 17:56:08 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        scott.branden@broadcom.com, tiwai@suse.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: firmware: Fix it to do root uid check and skip
Date:   Thu, 12 Dec 2019 18:56:06 -0700
Message-Id: <20191213015606.23058-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/testing/selftests/firmware/fw_lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index b879305a766d..5b8c0fedee76 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -34,6 +34,12 @@ test_modprobe()
 
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

