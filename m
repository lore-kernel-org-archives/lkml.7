Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A39C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3A420578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569278419;
	bh=YGDfXDTGSlMoD30C1NEESGljwAkosk6yJGT+3+tyP68=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=esh6OU3h9swQunRuTyqTCcecc2Ruasa2qha0hWpxebVcELXr94TW2hR96v64yCR+P
	 5BvUY2PzuiVSnA64Ky0z7Ox8z0OPFD1Ycb5dpK805e4t07UeI0CwIjKxOmHolY9GyS
	 8qOFYndkQzdsWNP3z/weNxXuYl+QHuLf+Wkk2QLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503434AbfIWWkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:40:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33059 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391723AbfIWWkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:40:18 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so15416478ior.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=wBvsJCew/juxa4FkdqrZ1jE3icFHhSqPKtev8ETjJDE=;
        b=RAzcrKu65XL0Hm0df0vxHgRREUpG6PPkTAHS6DTTIgpC+AfnAG7lyvtsuiKrQOJoAa
         Sg5Ce27HfS7Axm6eKRYHC5lGxqsuMOm3Osztla4P3CMvCKvXgj8CqiTT1odlMC92Waep
         /1/kXAz9syBf7lGUQ9BOIMODkiAd0+HUqWQv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=wBvsJCew/juxa4FkdqrZ1jE3icFHhSqPKtev8ETjJDE=;
        b=Ifst2L9Ez/XDn6GEkIbvCzspLJRMmu2sEJrLjTSkimT77rI2D00YE2t28pS5emaaaI
         DQwBrYTXDrEhqgjrFoteuOjTM2gsjZP6V2y1g8ZQTfZhgDxMbRLXYfAcZAFsU1Sgkz3E
         pYEZZohr4NvMNkhen886iS8fTuBC+Gvz3CaH3XndW6MBUJytIxyHkjj4nIGPXl6rpGYP
         waaemUIibBDQhs/XX9M0r19+8hZSNRE1+6WwA+x0qX5sjjz8yoOb7Ue5FUOoG+F+PZKS
         Pgp1WH2oCaf9HmZd+Tf5/T6x/5JCft67IpX+9kPUoO7e/Y943ynwlcd/iQGeh2lwi663
         UEIQ==
X-Gm-Message-State: APjAAAXqyN9qs4+g032Mvk39PuJO/HWe5bR5PY2Rk2mBs9amihFNwjWk
        9k/xsqx8/ueD96N7I2o/VFll8Q==
X-Google-Smtp-Source: APXvYqwW6Sz4DnNvx+q70hhi92gqXDEV4GSXDCi0Tm3wciyrGRlxdVLcVy/1HRlq2c2LFW1RRDPWNA==
X-Received: by 2002:a6b:2bc1:: with SMTP id r184mr2030230ior.146.1569278417060;
        Mon, 23 Sep 2019 15:40:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k2sm8040ios.19.2019.09.23.15.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 15:40:16 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <47009c0c-9b64-5824-0c1c-8cdc1a2265de@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 16:40:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------AF2964C81749270537BD7314"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AF2964C81749270537BD7314
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.4-rc1.

This Kselftest update for Linux 5.4-rc1 consists of several fixes to
existing tests.

diff is attached.

This pull has just the ksleftest patches I sent in my previous pull
request. I dropped the KUnit patches and rebased.

I will send another pull request for the KUnit work later on this
week.

Please note that there is conflict between

tools/testing/selftests/tpm2/Makefile

between commit:

   3fb2179b0f3553a ("selftests/tpm2: Add the missing TEST_FILES assignment")

from the tpmdd tree and commit:

   d04e26067d13f01 ("selftests: tpm2: install python files")

Please take the fix from kselftest tree which is the correct
version for this change.

d04e26067d13f01 ("selftests: tpm2: install python files")

Please let me know if you have any questions and/or concerns.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

   Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.4-rc1.1

for you to fetch changes up to 721cb3c8bc8890e824b7be53bf951960ff7811f9:

   selftests: tpm2: install python files (2019-09-23 08:33:16 -0600)

----------------------------------------------------------------
linux-kselftest-5.4-rc1.1

This Kselftest update for Linux 5.4-rc1 consists of fixes to existing
tests.

----------------------------------------------------------------
Anders Roxell (2):
       selftests: livepatch: add missing fragments to config
       selftests: tpm2: install python files

George G. Davis (2):
       selftests: watchdog: Add optional file argument
       selftests: watchdog: cleanup whitespace in usage options

Ilya Leoshkevich (1):
       selftests: use "$(MAKE)" instead of "make"

Masanari Iida (1):
       selftest/ftrace: Fix typo in trigger-snapshot.tc

Tycho Andersen (1):
       selftests/seccomp: fix build on older kernels

  tools/testing/selftests/Makefile                   | 22 ++++++------
  .../ftrace/test.d/trigger/trigger-snapshot.tc      |  2 +-
  tools/testing/selftests/livepatch/config           |  2 ++
  tools/testing/selftests/seccomp/seccomp_bpf.c      |  5 +++
  tools/testing/selftests/tpm2/Makefile              |  1 +
  tools/testing/selftests/watchdog/watchdog-test.c   | 41 
+++++++++++++++-------
  6 files changed, 48 insertions(+), 25 deletions(-)
----------------------------------------------------------------

--------------AF2964C81749270537BD7314
Content-Type: text/x-patch;
 name="linux-kselftest-5.4-rc1.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.4-rc1.1.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 25b43a8c2b15..c3feccb99ff5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -126,9 +126,9 @@ endif
 # in the default INSTALL_HDR_PATH usr/include.
 khdr:
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
+	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
-	make --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
+	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 
@@ -136,35 +136,35 @@ all: khdr
 	@for TARGET in $(TARGETS); do		\
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
 	done;
 
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
 	done;
 
 hotplug:
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
 	done;
 
 run_hotplug: hotplug
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET run_full_test;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_full_test;\
 	done;
 
 clean_hotplug:
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
 run_pstore_crash:
-	make -C pstore run_crash
+	$(MAKE) -C pstore run_crash
 
 # Use $BUILD as the default install root. $BUILD points to the
 # right output location for the following cases:
@@ -184,7 +184,7 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
 	done;
 
 	@# Ask all targets to emit their test scripts
@@ -203,7 +203,7 @@ ifdef INSTALL_PATH
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
-		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
+		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "" >> $(ALL_SCRIPT);	    \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
 	done;
@@ -216,7 +216,7 @@ endif
 clean:
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
 .PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
index 7717c0a09686..ac738500d17f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
@@ -28,7 +28,7 @@ if [ -z "$FEATURE" ]; then
     exit_unsupported
 fi
 
-echo "Test snapshot tigger"
+echo "Test snapshot trigger"
 echo 0 > snapshot
 echo 1 > events/sched/sched_process_fork/enable
 ( echo "forked")
diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
index 0dd7700464a8..ad23100cb27c 100644
--- a/tools/testing/selftests/livepatch/config
+++ b/tools/testing/selftests/livepatch/config
@@ -1 +1,3 @@
+CONFIG_LIVEPATCH=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_TEST_LIVEPATCH=m
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6ef7f16c4cf5..7f8b5c8982e3 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -199,6 +199,11 @@ struct seccomp_notif_sizes {
 };
 #endif
 
+#ifndef PTRACE_EVENTMSG_SYSCALL_ENTRY
+#define PTRACE_EVENTMSG_SYSCALL_ENTRY	1
+#define PTRACE_EVENTMSG_SYSCALL_EXIT	2
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index 9dd848427a7b..1a5db1eb8ed5 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -2,3 +2,4 @@
 include ../lib.mk
 
 TEST_PROGS := test_smoke.sh test_space.sh
+TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index c2333c78cf04..afff120c7be6 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:Tn:NL";
+static const char sopts[] = "bdehp:t:Tn:NLf:";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -31,6 +31,7 @@ static const struct option lopts[] = {
 	{"pretimeout",    required_argument, NULL, 'n'},
 	{"getpretimeout",       no_argument, NULL, 'N'},
 	{"gettimeleft",		no_argument, NULL, 'L'},
+	{"file",          required_argument, NULL, 'f'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -69,16 +70,19 @@ static void term(int sig)
 static void usage(char *progname)
 {
 	printf("Usage: %s [options]\n", progname);
-	printf(" -b, --bootstatus    Get last boot status (Watchdog/POR)\n");
-	printf(" -d, --disable       Turn off the watchdog timer\n");
-	printf(" -e, --enable        Turn on the watchdog timer\n");
-	printf(" -h, --help          Print the help message\n");
-	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
-	printf(" -t, --timeout=T     Set timeout to T seconds\n");
-	printf(" -T, --gettimeout    Get the timeout\n");
-	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
-	printf(" -N, --getpretimeout Get the pretimeout\n");
-	printf(" -L, --gettimeleft   Get the time left until timer expires\n");
+	printf(" -f, --file\t\tOpen watchdog device file\n");
+	printf("\t\t\tDefault is /dev/watchdog\n");
+	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
+	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
+	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
+	printf(" -h, --help\t\tPrint the help message\n");
+	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
+	       DEFAULT_PING_RATE);
+	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
+	printf(" -T, --gettimeout\tGet the timeout\n");
+	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
+	printf(" -N, --getpretimeout\tGet the pretimeout\n");
+	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
 	printf("\n");
 	printf("Parameters are parsed left-to-right in real-time.\n");
 	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
@@ -92,14 +96,20 @@ int main(int argc, char *argv[])
 	int ret;
 	int c;
 	int oneshot = 0;
+	char *file = "/dev/watchdog";
 
 	setbuf(stdout, NULL);
 
-	fd = open("/dev/watchdog", O_WRONLY);
+	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
+		if (c == 'f')
+			file = optarg;
+	}
+
+	fd = open(file, O_WRONLY);
 
 	if (fd == -1) {
 		if (errno == ENOENT)
-			printf("Watchdog device not enabled.\n");
+			printf("Watchdog device (%s) not found.\n", file);
 		else if (errno == EACCES)
 			printf("Run watchdog as root.\n");
 		else
@@ -108,6 +118,8 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
+	optind = 0;
+
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
 		switch (c) {
 		case 'b':
@@ -190,6 +202,9 @@ int main(int argc, char *argv[])
 			else
 				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
 			break;
+		case 'f':
+			/* Handled above */
+			break;
 
 		default:
 			usage(argv[0]);

--------------AF2964C81749270537BD7314--
