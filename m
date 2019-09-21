Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A808D217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrXvrJLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437571AbfIUAU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:20:28 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:57176 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437399AbfIUATo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:44 -0400
Received: by mail-pg1-f201.google.com with SMTP id 135so142246pgc.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XW6ObdsygoQczUzhnAeFOiZL9hvh/FcVMF1CQf4gGoM=;
        b=OrXvrJLBWdLqzisxoi8jU3vfGJHtOA49Qe2IxJF1qY85Ltuv1VwdewF86chLIvz32z
         KMzqrdOToNSByFyZ2dtSd+S58a3y8Le91vWVHXV2AEyg5za8+MXqqAFFaPeiqaKqP7ye
         QssFQ2Zoy4K12eci4z4lh64cJ4BKfaGDlV7ttPAI0Ar8tzBtuUXYfLFNDdVy5EMdOxlK
         vg/Mw8OTiExxDCqWdxhIB+EnyETMxIjBAUlIIgaPR5SRtnDhki+k5hLZxocHZJzUjMPg
         a/UwC9PNPe7ZNuJrR0x44aV53+HC8k8Dx6+Lv315/koAVawVj73NbIA5UjpREgfvE2/D
         9+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XW6ObdsygoQczUzhnAeFOiZL9hvh/FcVMF1CQf4gGoM=;
        b=ZGggh47WaRNOk6dtGU6+k7a5xosv3QpGc7DsuApy3X/1B/GxcBZ+uvxEFMOJRTQKna
         +dgp8S9YoR9QicbSSfYyMI7TXIGtBiO594pD011av8Pod1CAj9b7H/3aU8UJ5fTTa32b
         DQbucVvaawsYQ5pBzVVIteis+uYqaCD6D/LZ0b7dSe2gXy92FxPvcDR3qf2AdIE73Dkn
         TDqSdzI8GTG7+d4eNqXwbQsQ+8Et0bJp+FzjrW2fKAZ/f+LVaHo/FQdiuxPoOQOcVRek
         XBc5wF9cCELLyjpmbbbyixFQImjeKoKvulpGo+IDOjcVEHNhao7lMbU3Jm9vvN4yS448
         7pUg==
X-Gm-Message-State: APjAAAWGRTenuzJtpsSRLc8/BjhJ4bDXNzAeku2+dvbjeFhvsHhhl0Ag
        AJVgcX+RXvcisQjHKH1QmEurUvito+7l6ri0ilAFew==
X-Google-Smtp-Source: APXvYqyjc1DyyONzzE1r5kKElYjmc90nIgLhJ5fKoZYKnD+M18JEyoN80pnNSuYm0c4+CAQbqRnKvYHt4UI2u9+ac2GJaQ==
X-Received: by 2002:a63:4d4b:: with SMTP id n11mr4239710pgl.409.1569025183314;
 Fri, 20 Sep 2019 17:19:43 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:50 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 14/19] kunit: defconfig: add defconfigs for building KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defconfig for UML and a fragment that can be used to configure other
architectures for building KUnit tests. Add option to kunit_tool to use
a defconfig to create the kunitconfig.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/configs/kunit_defconfig              |  3 +++
 tools/testing/kunit/configs/all_tests.config |  3 +++
 tools/testing/kunit/kunit.py                 | 28 +++++++++++++++++---
 tools/testing/kunit/kunit_kernel.py          |  3 ++-
 4 files changed, 32 insertions(+), 5 deletions(-)
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/arch/um/configs/kunit_defconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index da11bd62a4b8..0944dea5c321 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -11,6 +11,7 @@ import argparse
 import sys
 import os
 import time
+import shutil
 
 from collections import namedtuple
 from enum import Enum, auto
@@ -21,7 +22,7 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -29,8 +30,16 @@ class KunitStatus(Enum):
 	BUILD_FAILURE = auto()
 	TEST_FAILURE = auto()
 
+def create_default_kunitconfig():
+	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+		shutil.copyfile('arch/um/configs/kunit_defconfig',
+				kunit_kernel.KUNITCONFIG_PATH)
+
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
+	if request.defconfig:
+		create_default_kunitconfig()
+
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
@@ -72,7 +81,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	else:
 		return KunitResult(KunitStatus.SUCCESS, test_result)
 
-def main(argv, linux):
+def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
@@ -99,13 +108,24 @@ def main(argv, linux):
 				'directory.',
 				type=str, default=None, metavar='build_dir')
 
+	run_parser.add_argument('--defconfig',
+				help='Uses a default kunitconfig.',
+				action='store_true')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.defconfig:
+			create_default_kunitconfig()
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
 				       cli_args.jobs,
-				       cli_args.build_dir)
+				       cli_args.build_dir,
+				       cli_args.defconfig)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
@@ -113,4 +133,4 @@ def main(argv, linux):
 		parser.print_help()
 
 if __name__ == '__main__':
-	main(sys.argv[1:], kunit_kernel.LinuxSourceTree())
+	main(sys.argv[1:])
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 07c0abf2f47d..bf3876835331 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,6 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
+KUNITCONFIG_PATH = 'kunitconfig'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -81,7 +82,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file('kunitconfig')
+		self._kconfig.read_from_file(KUNITCONFIG_PATH)
 		self._ops = LinuxSourceTreeOperations()
 
 	def clean(self):
-- 
2.23.0.351.gc4317032e6-goog

