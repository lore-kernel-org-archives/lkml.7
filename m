Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF17C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5C2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559753591;
	bh=0Sd/H0nT5RhQyJZw8c/wEhLQiA+ESTruVVaeB1tn4Gw=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=U1ADnrcfbfMNI7qKcly9GnA9UfREIqzzscXmGiyCB//k77LVzIypj6+aQE0owFgCQ
	 4dxCqo2Z60h8h+4tdaD9XPnbJ6fSjYtKizYVdrElKvITb3pyPWMSz8nXCYlodE13Ix
	 8+9ngXjjB6MpzMsbTBW/rwPWyIJL45kHdO8ZqnYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfFEQxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:53:10 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:34500 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfFEQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:53:10 -0400
Received: by mail-io1-f41.google.com with SMTP id k8so20787192iot.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=xX3e7ZfyNUwwoZ0CO9bSPTf+jZmLHIr/mEve4KG0ewE=;
        b=IZDwcpmqXMmyNu3yXncjbeJ1RqDSyP80Q51p2GGuHzRmpf7wp8mdUGlmqg3pJFroXV
         O/ahXkKH/U0yh6gkBsW2i+JZATz2/p1TT9ihWWMTG+1gBCtSu2Xb6dJCnVSn+ifpfbr5
         4M1M1LEJxH09A7q3swrwi8F8CLl3LF1K0Dpus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=xX3e7ZfyNUwwoZ0CO9bSPTf+jZmLHIr/mEve4KG0ewE=;
        b=r7C9DhWHWjmfrBllgwz+ESMsJZkTUXpt4MYZ8N6VDETetvQYSCKso0q/1n4zP4b9zz
         JLWhD2qcKwxALt6meUOnB9wV5SeDmenin+BMTdqn0K6j7HnmqinB8f0mhd/bhAa4JAEn
         vxJ4FoQeI5BExa4xkVwLFex275CHz5gwMPzOceqdlHKFxN7oQHRqqRMCaKJE08OcLRs8
         OUUPtUwXZqDEEOKlOBTCcjj23zuG/m5bhSTz2JKvZGRolfoHxh0qCRbFDHDa2lMCXOrV
         TQfKHQUPx0NrhPsK4nddmkqTjW3C9tD25PSyvuZPtAUOURNcArP1lOobUf+3kx7zvTsk
         YSHA==
X-Gm-Message-State: APjAAAXiZw011jJu93FVVfArhcb9EDIxU8rV+qnWgoiPPrAuRV0cpQ8b
        3xPB68Rx/60Zrqrby4nPBaevdg==
X-Google-Smtp-Source: APXvYqxxcSv26bY4ogKoEHC8jr1v8xcz1rLFJSAL7gHZaA2eEGaJ90c9NLu8AtTEMVQ3jJvKbH8IwA==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr25131184ion.239.1559753588725;
        Wed, 05 Jun 2019 09:53:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u187sm7290991iod.37.2019.06.05.09.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:53:07 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.2-rc4
Message-ID: <c5b4091c-b6bc-0eea-7f64-5334c80be8ed@linuxfoundation.org>
Date:   Wed, 5 Jun 2019 10:53:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2CE3A6454A5D7648C72F9997"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2CE3A6454A5D7648C72F9997
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.2-rc4.

This Kselftest update for Linux 5.2-rc4 consists of

- Alex Shi's fixes to cgroup tests
- Alakesh Haloi's fix to userfaultfd compiler warning
- Naresh Kamboju's fix to vm install to include test script to run
   the test.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit eff82a263b5cfa3427fd9dbfedd96da94fdc9f19:

   selftests: rtc: rtctest: specify timeouts (2019-05-24 13:39:58 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc4

for you to fetch changes up to bc2cce3f2ebcae02aa4bb29e3436bf75ee674c32:

   selftests: vm: install test_vmalloc.sh for run_vmtests (2019-05-30 
08:32:57 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc4

This Kselftest update for Linux 5.2-rc4 consists of

- Alex Shi's fixes to cgroup tests
- Alakesh Haloi's fix to userfaultfd compiler warning
- Naresh Kamboju's fix to vm install to include test script to run
   the test.

----------------------------------------------------------------
Alakesh Haloi (1):
       userfaultfd: selftest: fix compiler warning

Alex Shi (3):
       kselftest/cgroup: fix unexpected testing failure on test_memcontrol
       kselftest/cgroup: fix unexpected testing failure on test_core
       kselftest/cgroup: fix incorrect test_core skip

Naresh Kamboju (1):
       selftests: vm: install test_vmalloc.sh for run_vmtests

  tools/testing/selftests/cgroup/test_core.c       | 7 ++++++-
  tools/testing/selftests/cgroup/test_memcontrol.c | 4 ++++
  tools/testing/selftests/vm/Makefile              | 2 ++
  tools/testing/selftests/vm/userfaultfd.c         | 2 +-
  4 files changed, 13 insertions(+), 2 deletions(-)

----------------------------------------------------------------

--------------2CE3A6454A5D7648C72F9997
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc4.diff"

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index be59f9c34ea2..79053a4f4783 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -198,7 +198,7 @@ static int test_cgcore_no_internal_process_constraint_on_threads(const char *roo
 	char *parent = NULL, *child = NULL;
 
 	if (cg_read_strstr(root, "cgroup.controllers", "cpu") ||
-	    cg_read_strstr(root, "cgroup.subtree_control", "cpu")) {
+	    cg_write(root, "cgroup.subtree_control", "+cpu")) {
 		ret = KSFT_SKIP;
 		goto cleanup;
 	}
@@ -376,6 +376,11 @@ int main(int argc, char *argv[])
 
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 6f339882a6ca..c19a97dd02d4 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1205,6 +1205,10 @@ int main(int argc, char **argv)
 	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
 		ksft_exit_skip("memory controller isn't available\n");
 
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index e13eb6cc8901..05306c58ff9f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,6 +25,8 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+TEST_FILES := test_vmalloc.sh
+
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5d1db824f73a..b3e6497b080c 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -123,7 +123,7 @@ static void usage(void)
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
 	fprintf(stderr, "Examples:\n\n");
-	fprintf(stderr, examples);
+	fprintf(stderr, "%s", examples);
 	exit(1);
 }
 

--------------2CE3A6454A5D7648C72F9997--
