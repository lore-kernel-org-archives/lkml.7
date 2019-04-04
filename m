Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E28C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714B7217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fb8e+v1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfDDWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:11:09 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47163 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbfDDWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:10:34 -0400
Received: by mail-pf1-f201.google.com with SMTP id n63so2697304pfb.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oW4PDVaJxDnrY6BBc/BAHq/Hfgozzw2Xp2Gy+1ZhIC8=;
        b=fb8e+v1Z/Vhw8iTIo0CwD5Vx1AmUlpqbB3aiVwU0233WvzFboxwLQMGvesF9ZZX5sX
         9JkP4aYiS7YkV/Z9hCpYMVK+jg/ZOxeZi51Jwc7cNQjLdxiqRwdlZHUD4qO0/jFJi1rC
         AF5KeZIRmUIMVJUXV+gqpCZu0z++hIeqYkYXSPMaWW+MGWB0q1yLWS0sH6QElHUZcYMz
         sdMJwxyA6SEn+iPtpCgA/U059V0MLpHndFv0eezfjXtcoOhtXiM0qeBn64kGrh17t5hh
         Ze71xEwtP0paAg9lzOGxi/3QYBJI8ljeo9IHsd9sbq3bfj1p/XNnCO1YjnBJaRA/13IF
         E+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oW4PDVaJxDnrY6BBc/BAHq/Hfgozzw2Xp2Gy+1ZhIC8=;
        b=csgIr5Q3ykdUC2GJ4bdy4VYQb3aJJRrP1WbWUuLG5e6ZLJHYN2muQItZV6bJRPHQYi
         /QeMJqnlBqdzc6sHbyY1AYGQgm3VaW3goCuTceLyECF2SMa8tdEZJyYJzmvCd7ADDdn4
         /Dt1X2qgJaP1HEBWutxX8kZckprfktjNizzGmN+uiM1aAlF+S02LVw0RYGrhzYJYH/ig
         SSSdtnrSkyR6C51or+uHavfaL2Bx+68xV4TZZxUrkCbyOOEu7TqkvwI++8k9u7bN/2tc
         UBxvlbjq+edQ7MP9KggG4TkOiMeT1imlXzNTg71vfmorCm7G3ZJg5b6GogyjfqXcgG8u
         +OwQ==
X-Gm-Message-State: APjAAAVuWxSRRbb5zmRQdGqrhccEsweu2jgRKaAjLHo++Yk4oMrdqhTE
        RlAsQWf/FePfELUrw/hYdORGNII2pkG8bPGoYknKqA==
X-Google-Smtp-Source: APXvYqySlZeZhmHUzbaLxG3cwraMDL8UwYyYOhgsZAcby/Biv7RGMnF/AKvHBa7ap73rPVPaHw4JDtLbjtHNYJgqLR8yTQ==
X-Received: by 2002:a65:46c8:: with SMTP id n8mr227144pgr.65.1554415833550;
 Thu, 04 Apr 2019 15:10:33 -0700 (PDT)
Date:   Thu,  4 Apr 2019 15:06:48 -0700
In-Reply-To: <20190404220652.19765-1-brendanhiggins@google.com>
Message-Id: <20190404220652.19765-14-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v1 13/17] kunit: defconfig: add defconfigs for building KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     corbet@lwn.net, frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch,
        gregkh@linuxfoundation.org, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rostedt@goodmis.org, wfg@linux.intel.com,
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
---
 arch/um/configs/kunit_defconfig              |  8 ++++++++
 tools/testing/kunit/configs/all_tests.config |  8 ++++++++
 tools/testing/kunit/kunit.py                 | 17 +++++++++++++++--
 tools/testing/kunit/kunit_kernel.py          |  3 ++-
 4 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
new file mode 100644
index 0000000000000..bfe49689038f1
--- /dev/null
+++ b/arch/um/configs/kunit_defconfig
@@ -0,0 +1,8 @@
+CONFIG_OF=y
+CONFIG_OF_UNITTEST=y
+CONFIG_OF_OVERLAY=y
+CONFIG_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
new file mode 100644
index 0000000000000..bfe49689038f1
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -0,0 +1,8 @@
+CONFIG_OF=y
+CONFIG_OF_UNITTEST=y
+CONFIG_OF_OVERLAY=y
+CONFIG_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7413ec7351a20..63e9fb3b60200 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -11,6 +11,7 @@ import argparse
 import sys
 import os
 import time
+import shutil
 
 import kunit_config
 import kunit_kernel
@@ -36,14 +37,26 @@ parser.add_argument('--build_dir',
 		    'directory.',
 		    type=str, default=None, metavar='build_dir')
 
-cli_args = parser.parse_args()
+parser.add_argument('--defconfig',
+		    help='Uses a default kunitconfig.',
+		    action='store_true')
 
-linux = kunit_kernel.LinuxSourceTree()
+def create_default_kunitconfig():
+	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+		shutil.copyfile('arch/um/configs/kunit_defconfig',
+				kunit_kernel.KUNITCONFIG_PATH)
+
+cli_args = parser.parse_args()
 
 build_dir = None
 if cli_args.build_dir:
 	build_dir = cli_args.build_dir
 
+if cli_args.defconfig:
+	create_default_kunitconfig()
+
+linux = kunit_kernel.LinuxSourceTree()
+
 config_start = time.time()
 success = linux.build_reconfig(build_dir)
 config_end = time.time()
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 07c0abf2f47df..bf38768353313 100644
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
2.21.0.392.gf8f6787159e-goog

