Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320BECA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ADB20717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FrK9GvB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfJ3TqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:46:12 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:46288 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3TqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:46:12 -0400
Received: by mail-pg1-f169.google.com with SMTP id f19so2146999pgn.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OIB8MUeepnBEqJHi5o92E72wbixYphv5GT0gK00OFSA=;
        b=FrK9GvB9O35lJy0vJxpqNu4eyXyMD3fGENafGrq/LWj4guwsvn+D+0JMnpTWUU5pWp
         HfvdTfPTR/GOmBKOVBvvVZV+/hAJxPQO0kQo8Mr/4kdJQpjrCwHezx1RgPwPqU5NuFHz
         svPpZ9dAAlxN2v8APQWt71P/tME8MxkwzELwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OIB8MUeepnBEqJHi5o92E72wbixYphv5GT0gK00OFSA=;
        b=iUU1vpAgfibTrVWC3gx349BeW+fjLumOhrK44XLoyIN2SjB/1Vyf9XP7NUDPCNVltf
         bHrknsB7YU8TXvPtsiJdVCY+YqRpj9fwc6QWkQUIGHRtN6iym6c/M9npuJ1valYSKDaz
         96I82Vus2DbfJZATxYThndJV7ziFJbljZdXYlsP3B5tfHqCbIav7vd7K6140uDjyCgrs
         9RQ/a40ESU4dqInxGdcB0gSN+katD92BvJxks/GoYa3CTattKbspuUcKJ6YU4z7L9ZAv
         36AzD021tt5UivdDBWkgXp8BF/ymyqu7YNNlHddy6heUTtWyafC/YwBo1t9R1wXXFqYO
         4+gg==
X-Gm-Message-State: APjAAAWE9/s1NZfcaLfrGKF2RNHz/X1+8Pb/jHdWTeIzB5LrascHbftU
        X6NI0zzMuYAYCLVTSN7M4X0FLQ==
X-Google-Smtp-Source: APXvYqxWrVluhWtAhBjxCK6osV9JUJjYhg3tBUoCXfJ6ylx8j+sWdxaFV+WOaWF8iEvY7Byt5/D0tA==
X-Received: by 2002:a63:f743:: with SMTP id f3mr1274786pgk.410.1572464770329;
        Wed, 30 Oct 2019 12:46:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o185sm705916pfg.136.2019.10.30.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:46:09 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:46:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: gen_kselftest_tar.sh: Do not clobber kselftest/
Message-ID: <201910301245.33CFECF216@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default installation location for gen_kselftest_tar.sh was still
"kselftest/" which collides with the existing directory. Instead, this
moves the installation target into "kselftest_install/kselftest/" and
adjusts the tar creation accordingly. This also adjusts indentation and
logic to be consistent.

Fixes: 42d46e57ec97 ("selftests: Extract single-test shell logic from lib.mk")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/gen_kselftest_tar.sh | 21 ++++++++++-------
 tools/testing/selftests/kselftest_install.sh | 24 ++++++++++----------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing/selftests/gen_kselftest_tar.sh
index a27e2eec3586..8b2b6088540d 100755
--- a/tools/testing/selftests/gen_kselftest_tar.sh
+++ b/tools/testing/selftests/gen_kselftest_tar.sh
@@ -38,16 +38,21 @@ main()
 	esac
 	fi
 
-	install_dir=./kselftest
+	# Create working directory.
+	dest=`pwd`
+	install_work="$dest"/kselftest_install
+	install_name=kselftest
+	install_dir="$install_work"/"$install_name"
+	mkdir -p "$install_dir"
 
-# Run install using INSTALL_KSFT_PATH override to generate install
-# directory
-./kselftest_install.sh
-tar $copts kselftest${ext} $install_dir
-echo "Kselftest archive kselftest${ext} created!"
+	# Run install using INSTALL_KSFT_PATH override to generate install
+	# directory
+	./kselftest_install.sh "$install_dir"
+	(cd "$install_work"; tar $copts "$dest"/kselftest${ext} $install_name)
+	echo "Kselftest archive kselftest${ext} created!"
 
-# clean up install directory
-rm -rf kselftest
+	# clean up top-level install work directory
+	rm -rf "$install_work"
 }
 
 main "$@"
diff --git a/tools/testing/selftests/kselftest_install.sh b/tools/testing/selftests/kselftest_install.sh
index e2e1911d62d5..407af7da7037 100755
--- a/tools/testing/selftests/kselftest_install.sh
+++ b/tools/testing/selftests/kselftest_install.sh
@@ -6,30 +6,30 @@
 # Author: Shuah Khan <shuahkh@osg.samsung.com>
 # Copyright (C) 2015 Samsung Electronics Co., Ltd.
 
-install_loc=`pwd`
-
 main()
 {
-	if [ $(basename $install_loc) !=  "selftests" ]; then
+	base_dir=`pwd`
+	install_dir="$base_dir"/kselftest_install
+
+	# Make sure we're in the selftests top-level directory.
+	if [ $(basename "$base_dir") !=  "selftests" ]; then
 		echo "$0: Please run it in selftests directory ..."
 		exit 1;
 	fi
+
+	# Only allow installation into an existing location.
 	if [ "$#" -eq 0 ]; then
-		echo "$0: Installing in default location - $install_loc ..."
+		echo "$0: Installing in default location - $install_dir ..."
 	elif [ ! -d "$1" ]; then
 		echo "$0: $1 doesn't exist!!"
 		exit 1;
 	else
-		install_loc=$1
-		echo "$0: Installing in specified location - $install_loc ..."
+		install_dir="$1"
+		echo "$0: Installing in specified location - $install_dir ..."
 	fi
 
-	install_dir=$install_loc/kselftest_install
-
-# Create install directory
-	mkdir -p $install_dir
-# Build tests
-	KSFT_INSTALL_PATH=$install_dir make install
+	# Build tests
+	KSFT_INSTALL_PATH="$install_dir" make install
 }
 
 main "$@"
-- 
2.17.1


-- 
Kees Cook
