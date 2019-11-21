Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BAAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538672067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kHm2EwF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUSxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:53:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37176 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:53:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id b10so2067233pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zVJJ43+LVeOcEOi4EKyonFDdXiCAF/3n0Lx87I78pBc=;
        b=kHm2EwF0IVj9TsDgchy1m2gbT7WbyVlCZ8KSeFvK+X8eH8xN6reOLyWJOpAtdYNhhW
         IbGM95/F/jPpWbYwZRetuP+YAqkDGMz7G4cp6vtaBMUzyvU2+wTcf/p1LjBqCQD06rdN
         kx3m7nbnhizOVfYV+FnUzCnB/2kxJKyJHa08U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zVJJ43+LVeOcEOi4EKyonFDdXiCAF/3n0Lx87I78pBc=;
        b=kIDyvkIEBNio8zt8C/zX/ezUjSg2dxEHOG/0+NiE1Q1UynL5HuVLBGwV9xmVAHmEhP
         QR/vCjCi5mw38cKuqYM1d/7K7RBUZcfTXm9gp+EVP5DjsEyAOpUbIziw0LUgjmzq8/tr
         ur96xi2pmA1Gr9c1gJxLN/l+6nJsWA8bAjhxU+J5kuaZeiqFPTAsBO0SOI9l+ygANfLQ
         rvwQntQPby3hPN5s/YSKzpVdB5bmauQW2iBgjyJVDW1HPvmAW5VnJ+bRlf0j6NrayaUq
         5AhO44UQwgcKmbxzud013UB0nlF1zU+y6ggEZG46Ir99B/SinbKsFw2vh5prDkYuLD63
         jmzw==
X-Gm-Message-State: APjAAAX6h/DiC7UFOJVhlHtJ/cLyQObevdGNOHWSWxYL8RfwUTuVQ11q
        DjRTaNOh1Y32Ch7h0Ynix2x3ug==
X-Google-Smtp-Source: APXvYqxlVxs5vp7h+sN1bjmy5mjuEHtYDkWvwu3os6PX75tgFr/nee7TrFdF/nA2QIdKL5dXecSngQ==
X-Received: by 2002:a63:e216:: with SMTP id q22mr11135492pgh.362.1574362402194;
        Thu, 21 Nov 2019 10:53:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w5sm4548218pfd.31.2019.11.21.10.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:53:21 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:53:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Load settings from subdirs
Message-ID: <201911211052.90C65FD667@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If settings files are present in upper directories of a test directory,
load those first before the local settings. This allows a top-level
directory to define settings for subdirectories while still allowing the
subdirectories to override them on a per-directory basis.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Note that this depends on Matt's patch:
https://lore.kernel.org/lkml/20191022171223.27934-1-matthieu.baerts@tessares.net
---
 tools/testing/selftests/kselftest/runner.sh | 30 +++++++++++++++------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 84de7bc74f2c..666cfeaa8046 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -39,6 +39,27 @@ tap_timeout()
 	fi
 }
 
+load_settings()
+{
+	local fullpath="$1"
+	local upperpath=${fullpath%/*}
+
+	# Load upper path settings first.
+	if [ "$fullpath" != "$upperpath" ] ; then
+		load_settings "$upperpath"
+	fi
+
+	# Load per-test-directory kselftest "settings" file.
+	local settings="$BASE_DIR/$fullpath/settings"
+	if [ -r "$settings" ] ; then
+		while read line ; do
+			local field=$(echo "$line" | cut -d= -f1)
+			local value=$(echo "$line" | cut -d= -f2-)
+			eval "kselftest_$field"="$value"
+		done < "$settings"
+	fi
+}
+
 run_one()
 {
 	DIR="$1"
@@ -50,14 +71,7 @@ run_one()
 	# Reset any "settings"-file variables.
 	export kselftest_timeout="$kselftest_default_timeout"
 	# Load per-test-directory kselftest "settings" file.
-	settings="$BASE_DIR/$DIR/settings"
-	if [ -r "$settings" ] ; then
-		while read line ; do
-			field=$(echo "$line" | cut -d= -f1)
-			value=$(echo "$line" | cut -d= -f2-)
-			eval "kselftest_$field"="$value"
-		done < "$settings"
-	fi
+	load_settings "$DIR"
 
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
-- 
2.17.1


-- 
Kees Cook
