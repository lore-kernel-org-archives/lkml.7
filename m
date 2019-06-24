Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D4BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534F220673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYS78e9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbfFXQbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:31:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33120 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfFXQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:31:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so7835757pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TOnU9AVWSLkG8jbZeJ4s1lTU9apIJrafSOUh1bs0Jw=;
        b=dYS78e9Q13HbWqEmYT+tE7IDr0sOteESZft4ytKYRUgRQKzjl+UL8HXX3k44MlaTjn
         5ZNlm+p5OxOa8N1t5mbBVgMuZPSNwz0Bz+GSza/T6s5TYJ/6+6f4ZScBneoqcNQhRsjw
         xAks6X1JTyy2ELTQ7OPX3N1zLEbPwd/blCS+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TOnU9AVWSLkG8jbZeJ4s1lTU9apIJrafSOUh1bs0Jw=;
        b=PbZOZ25Gl4M8cE1DOVCtzqDH/CAOSKIyphsSi76LGY684s1oSj2ggxvFk8Q1HdLKyk
         fML+RZFRhN8pFAJTaxWhwYTUKq6ktMAa7OceFJEcKMiSA2BnCFQGpkGzUDhOFIZ6/fJy
         TDdG9qTpmolz28Djbr1UTA8kKVqO+Vloc6VYoUukfdJKN3ky3ys0E+nhHtg8Q5zHSNPJ
         M0y9IAbYiVNOf/v0WTV/jkz6nel8VrYABndA/9rHWNXIIe4peKtWwpvPRK4CV1Y68qkW
         T/v9eMlX6bdR5aobWTLWD5KABwI/IqBj1VCuF4vmr0vdThme5uBgTDpi0P9bk305DU10
         iWRQ==
X-Gm-Message-State: APjAAAXwmRfGdTQw5eozE7PQGeqsnKVjJFK7cCppnxDdd73KvMj65q9b
        Cr1fZAH8NUYA4DlMDpG54dn5OQ==
X-Google-Smtp-Source: APXvYqyi3M9cexTZiqri1j5uENK/TLaXylZG6sJV0Njpxw8cDBF5o5v70/WLB1hGWb2hOgbhdGMKIw==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr32783369pgk.81.1561393877686;
        Mon, 24 Jun 2019 09:31:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z14sm11778757pgs.79.2019.06.24.09.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:31:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] gen_compile_command: Add support for separate KBUILD_OUTPUT directory
Date:   Mon, 24 Jun 2019 09:31:11 -0700
Message-Id: <20190624163111.171971-1-mka@chromium.org>
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

Add a new option to specify this the kbuild output directory. If the
option is not set the kernel source directory is used.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Tom Roeder <tmroeder@google.com>
Tested-by: Tom Roeder <tmroeder@google.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- added trailing space to help strings
- added tags from Tom and Nick
---
 scripts/gen_compile_commands.py | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 7915823b92a5..47f37db6bd3a 100755
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
+    directory_help = ('Path to the kernel source directory '
                       '(defaults to the working directory)')
     parser.add_argument('-d', '--directory', type=str, help=directory_help)
+    kbuild_output_directory_help = ('Path to the directory to search for '
+                                    '.cmd files '
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

