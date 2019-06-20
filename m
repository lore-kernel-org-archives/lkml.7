Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929BEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6296C20656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZSadPCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFTSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:45:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33550 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfFTSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:45:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so1428435pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CanJNwThf8ELfY9fNk51EXnlSwekoumuBB46HW57fEw=;
        b=PZSadPCPR6eltmM8/aShVS9rd+YTu6zkA5luYU275a1bwiQuWPAEaVOfzkVho7QWG+
         qH2JVpJOqAaF/qKXZhfMXgZXDKmgOTvjIzYiLy9azhMx9k26zDvtPHEwB6i6rZnb07dV
         C+4YFdaMKZ5e7HyDzx0ufX3wPY+IsIbhlMF3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CanJNwThf8ELfY9fNk51EXnlSwekoumuBB46HW57fEw=;
        b=gHMa4kPg3MzmU3GSlroIPuktssKpEAJENcAhbyfSgpn5FEV2OCTvPXQFMB/jlweK8m
         O+RZ38kIM/V5ZIZX8G0Xv8BDF6Xvt+GLCJd8i5tUFqTqsxU5wLkjjjr+/kDs5u7Mubt+
         guXdD7KHmipQ02NLWud3IIWAhD7F5QBVFp7jsYBSxZSw8Jc0UrmLfDl+pyYqQBQzJWZe
         rpNPNunO2PuDdhXl/cN6aF15Zsf07iFvz1blnX9AcJDVDN21Id0JHEqhk9TfPeGRPCwk
         pygdS5E46MfCwe0qtqzUAzt9Q1F9jCbXJxW18iXSt9E+aEFCOXc24x47ODHOVq2czCUT
         +7/A==
X-Gm-Message-State: APjAAAWVNAj5ycdX3JZItL1ShoZfdVRwIUKajmDFad0t8l3mizCWoXeh
        0JqUw6FVrMV0jMWVRwrAWnmDKQ==
X-Google-Smtp-Source: APXvYqx0gdR4XpU7+jVaJ7URX0VOj5jGSqwBInHZa+/xWNQu78XLMBRzEwUg5iHT/Oc0U9UXmYO9bw==
X-Received: by 2002:a65:44c8:: with SMTP id g8mr14039151pgs.443.1561056336821;
        Thu, 20 Jun 2019 11:45:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s43sm472252pjb.10.2019.06.20.11.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 11:45:36 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] gen_compile_command: Add support for separate KBUILD_OUTPUT directory
Date:   Thu, 20 Jun 2019 11:45:23 -0700
Message-Id: <20190620184523.155756-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gen_compile_command.py currently assumes that the .cmd files and the
source code live in the same directory, which is not the case when
a separate KBUILD_OUTPUT directory is used.

Add a new option to specify the kbuild output directory. If the
option is not set the kernel source directory is used.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Feel free to bikeshed about the option names ;-)

 scripts/gen_compile_commands.py | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 7915823b92a5..5a738ec66cc7 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -31,15 +31,21 @@ def parse_arguments():
 
     Returns:
         log_level: A logging level to filter log output.
-        directory: The directory to search for .cmd files.
+        source_directory: The kernel source directory.
+        kbuild_output_directory: The directory to search for .cmd files.
         output: Where to write the compile-commands JSON file.
     """
     usage = 'Creates a compile_commands.json database from kernel .cmd files'
     parser = argparse.ArgumentParser(description=usage)
 
-    directory_help = ('Path to the kernel source directory to search '
+    directory_help = ('Path to the kernel source directory'
                       '(defaults to the working directory)')
     parser.add_argument('-d', '--directory', type=str, help=directory_help)
+    kbuild_output_directory_help = ('Path to the directory to search for '
+                                    '.cmd files'
+                      '(defaults to the kernel source directory)')
+    parser.add_argument('-k', '--kbuild-output-directory', type=str,
+                        help=kbuild_output_directory_help)
 
     output_help = ('The location to write compile_commands.json (defaults to '
                    'compile_commands.json in the search directory)')
@@ -58,11 +64,14 @@ def parse_arguments():
     if log_level not in _VALID_LOG_LEVELS:
         raise ValueError('%s is not a valid log level' % log_level)
 
-    directory = args.directory or os.getcwd()
-    output = args.output or os.path.join(directory, _DEFAULT_OUTPUT)
-    directory = os.path.abspath(directory)
+    source_directory = args.directory or os.getcwd()
+    output = args.output or os.path.join(source_directory, _DEFAULT_OUTPUT)
+    source_directory = os.path.abspath(source_directory)
 
-    return log_level, directory, output
+    kbuild_output_directory = args.kbuild_output_directory or source_directory
+    kbuild_output_directory = os.path.abspath(kbuild_output_directory)
+
+    return log_level, source_directory, kbuild_output_directory, output
 
 
 def process_line(root_directory, file_directory, command_prefix, relative_path):
@@ -109,7 +118,8 @@ def process_line(root_directory, file_directory, command_prefix, relative_path):
 
 def main():
     """Walks through the directory and finds and parses .cmd files."""
-    log_level, directory, output = parse_arguments()
+    log_level, source_directory, kbuild_output_directory, output = \
+        parse_arguments()
 
     level = getattr(logging, log_level)
     logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
@@ -118,7 +128,7 @@ def main():
     line_matcher = re.compile(_LINE_PATTERN)
 
     compile_commands = []
-    for dirpath, _, filenames in os.walk(directory):
+    for dirpath, _, filenames in os.walk(kbuild_output_directory):
         for filename in filenames:
             if not filename_matcher.match(filename):
                 continue
@@ -131,7 +141,7 @@ def main():
                         continue
 
                     try:
-                        entry = process_line(directory, dirpath,
+                        entry = process_line(source_directory, dirpath,
                                              result.group(1), result.group(2))
                         compile_commands.append(entry)
                     except ValueError as err:
-- 
2.22.0.410.gd8fdbe21b5-goog

