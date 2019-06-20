Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A25C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51568208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5gcOxIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfFTGXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:23:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40970 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfFTGXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:23:31 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so2527667ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGxJqWHzBtVAufrcpH15UeEnrpGS8Lgc4maMfenhjlU=;
        b=a5gcOxIJN6f5wqag0KzbRYrT7Tz07eVuBdXbY2FV8bfmq7Z4lORpuYHqTrKMaQ3t/D
         4ciXbysqECYbgKy+D3Jm5KKmX/0AnznZ59SZbsOlVZi08iHONzD+iQHGwv+wKyGbbxDW
         rDlxR6870yT5Y5wjGzrz7HxSuKXX6sDZrZG+XGhSQIJLSdBbGHtgmMdxopnjf5zpsbqq
         Ip/mZjHJZDwoXVF7JDdgjWQmkJiv/xlb6hE4xU7R7Vgj05i3I2hHCV6CJXta6/1Mtho8
         KSQB1885vQrLBA755tFAChvO/qC21kqvYf5SY1TTBQ0SAyNH4FfPCrMBxBfaq/Y9YlwQ
         U0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGxJqWHzBtVAufrcpH15UeEnrpGS8Lgc4maMfenhjlU=;
        b=cGFszJNZ0bgwDRA+AXVIlaoLmCcsK7ZRAvCgz5wxtE4w+rD4OoGPoai5BcgFx9+XhS
         EZl6icFIWbcKQoXCOtYVNPuOqriu6CP7CmpUu3ovUFlKN4c/xvBR8hPwTufQaaYXYvOF
         8BifA5Jgcs268BflfCAhPBhOCUQFGtrScB/BfHr1hzDD4veMJjxXu4eIcg+lnFh5MmVf
         JlbZC4pN88hfVuMu1MdmCzsbt3303OavXpdT0yQ9h8mBjpdFERpEeMi52ZBy4wW++QmX
         maJHVbIXnmq3loVYOcf2mfPljudakjCCCSomFA0Yh2vadaw1HvFRnndDW5e9cKGDeq+2
         Blng==
X-Gm-Message-State: APjAAAWDC9UjZ9Qah/hutIjA9MAJH4f822bfnuFv56fzgRtzbWcnqTis
        e7i71fjM1RAFADy/JtmrSis=
X-Google-Smtp-Source: APXvYqzswvSvxp3FlbYzR2ldVgQYpKNlSqJxfb9S5+61GWVih/EIRuHBCq498GtiDeSv0oZF6k0+rQ==
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr11971163ioh.70.1561011809763;
        Wed, 19 Jun 2019 23:23:29 -0700 (PDT)
Received: from clevo.lan (CPE883d24a52a78-CMf0f2495c7700.cpe.net.fido.ca. [72.141.129.116])
        by smtp.googlemail.com with ESMTPSA id t5sm14813602iol.55.2019.06.19.23.23.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 23:23:29 -0700 (PDT)
From:   Ethan Sommer <e5ten.arch@gmail.com>
Cc:     e5ten.arch@gmail.com, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Corey Minyard <cminyard@mvista.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] replace timeconst bc script with an sh script
Date:   Thu, 20 Jun 2019 02:22:40 -0400
Message-Id: <20190620062246.2665-1-e5ten.arch@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

removes the bc build dependency introduced when timeconst.pl was
replaced by timeconst.bc

Signed-off-by: Ethan Sommer <e5ten.arch@gmail.com>
---
 Kbuild                   |   4 +-
 kernel/time/timeconst.bc | 117 --------------------------------------
 kernel/time/timeconst.sh | 118 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 119 deletions(-)
 delete mode 100644 kernel/time/timeconst.bc
 create mode 100755 kernel/time/timeconst.sh

diff --git a/Kbuild b/Kbuild
index 8637fd14135f..2b5f2957cf04 100644
--- a/Kbuild
+++ b/Kbuild
@@ -20,9 +20,9 @@ timeconst-file := include/generated/timeconst.h
 
 targets += $(timeconst-file)
 
-filechk_gentimeconst = echo $(CONFIG_HZ) | bc -q $<
+filechk_gentimeconst = $(CONFIG_SHELL) $< $(CONFIG_HZ)
 
-$(timeconst-file): kernel/time/timeconst.bc FORCE
+$(timeconst-file): kernel/time/timeconst.sh FORCE
 	$(call filechk,gentimeconst)
 
 #####
diff --git a/kernel/time/timeconst.bc b/kernel/time/timeconst.bc
deleted file mode 100644
index 7ed0e0fb5831..000000000000
--- a/kernel/time/timeconst.bc
+++ /dev/null
@@ -1,117 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-scale=0
-
-define gcd(a,b) {
-	auto t;
-	while (b) {
-		t = b;
-		b = a % b;
-		a = t;
-	}
-	return a;
-}
-
-/* Division by reciprocal multiplication. */
-define fmul(b,n,d) {
-       return (2^b*n+d-1)/d;
-}
-
-/* Adjustment factor when a ceiling value is used.  Use as:
-   (imul * n) + (fmulxx * n + fadjxx) >> xx) */
-define fadj(b,n,d) {
-	auto v;
-	d = d/gcd(n,d);
-	v = 2^b*(d-1)/d;
-	return v;
-}
-
-/* Compute the appropriate mul/adj values as well as a shift count,
-   which brings the mul value into the range 2^b-1 <= x < 2^b.  Such
-   a shift value will be correct in the signed integer range and off
-   by at most one in the upper half of the unsigned range. */
-define fmuls(b,n,d) {
-	auto s, m;
-	for (s = 0; 1; s++) {
-		m = fmul(s,n,d);
-		if (m >= 2^(b-1))
-			return s;
-	}
-	return 0;
-}
-
-define timeconst(hz) {
-	print "/* Automatically generated by kernel/time/timeconst.bc */\n"
-	print "/* Time conversion constants for HZ == ", hz, " */\n"
-	print "\n"
-
-	print "#ifndef KERNEL_TIMECONST_H\n"
-	print "#define KERNEL_TIMECONST_H\n\n"
-
-	print "#include <linux/param.h>\n"
-	print "#include <linux/types.h>\n\n"
-
-	print "#if HZ != ", hz, "\n"
-	print "#error \qinclude/generated/timeconst.h has the wrong HZ value!\q\n"
-	print "#endif\n\n"
-
-	if (hz < 2) {
-		print "#error Totally bogus HZ value!\n"
-	} else {
-		s=fmuls(32,1000,hz)
-		obase=16
-		print "#define HZ_TO_MSEC_MUL32\tU64_C(0x", fmul(s,1000,hz), ")\n"
-		print "#define HZ_TO_MSEC_ADJ32\tU64_C(0x", fadj(s,1000,hz), ")\n"
-		obase=10
-		print "#define HZ_TO_MSEC_SHR32\t", s, "\n"
-
-		s=fmuls(32,hz,1000)
-		obase=16
-		print "#define MSEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000), ")\n"
-		print "#define MSEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000), ")\n"
-		obase=10
-		print "#define MSEC_TO_HZ_SHR32\t", s, "\n"
-
-		obase=10
-		cd=gcd(hz,1000)
-		print "#define HZ_TO_MSEC_NUM\t\t", 1000/cd, "\n"
-		print "#define HZ_TO_MSEC_DEN\t\t", hz/cd, "\n"
-		print "#define MSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
-		print "#define MSEC_TO_HZ_DEN\t\t", 1000/cd, "\n"
-		print "\n"
-
-		s=fmuls(32,1000000,hz)
-		obase=16
-		print "#define HZ_TO_USEC_MUL32\tU64_C(0x", fmul(s,1000000,hz), ")\n"
-		print "#define HZ_TO_USEC_ADJ32\tU64_C(0x", fadj(s,1000000,hz), ")\n"
-		obase=10
-		print "#define HZ_TO_USEC_SHR32\t", s, "\n"
-
-		s=fmuls(32,hz,1000000)
-		obase=16
-		print "#define USEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000000), ")\n"
-		print "#define USEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000000), ")\n"
-		obase=10
-		print "#define USEC_TO_HZ_SHR32\t", s, "\n"
-
-		obase=10
-		cd=gcd(hz,1000000)
-		print "#define HZ_TO_USEC_NUM\t\t", 1000000/cd, "\n"
-		print "#define HZ_TO_USEC_DEN\t\t", hz/cd, "\n"
-		print "#define USEC_TO_HZ_NUM\t\t", hz/cd, "\n"
-		print "#define USEC_TO_HZ_DEN\t\t", 1000000/cd, "\n"
-
-		cd=gcd(hz,1000000000)
-		print "#define HZ_TO_NSEC_NUM\t\t", 1000000000/cd, "\n"
-		print "#define HZ_TO_NSEC_DEN\t\t", hz/cd, "\n"
-		print "#define NSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
-		print "#define NSEC_TO_HZ_DEN\t\t", 1000000000/cd, "\n"
-		print "\n"
-
-		print "#endif /* KERNEL_TIMECONST_H */\n"
-	}
-	halt
-}
-
-hz = read();
-timeconst(hz)
diff --git a/kernel/time/timeconst.sh b/kernel/time/timeconst.sh
new file mode 100755
index 000000000000..df821988acbf
--- /dev/null
+++ b/kernel/time/timeconst.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+if [ -z "$1" ]; then
+	printf '%s <HZ>\n' "$0"
+	exit 1
+else
+	hz="$1"
+fi
+
+# 2 to the power of n
+pot() {
+	local i=1
+    local j=1
+	while [ "${j}" -le "$1" ]; do
+		i="$((i * 2))"
+        j="$((j + 1))"
+	done
+	printf '%s\n' "${i}"
+}
+
+# Greatest common denominator
+gcd() {
+	local i="$1"
+	local j="$2"
+	local k
+	while [ "${j}" -ne 0 ]; do
+		k="${j}"
+		j="$((i % j))"
+		i="${k}"
+	done
+	printf '%s\n' "${i}"
+}
+
+# Division by reciprocal multiplication.
+fmul() {
+	printf '%s\n' "$((($(pot "$1") * $2 + $3 - 1) / $3))"
+}
+
+# Adjustment factor when a ceiling value is used.
+fadj() {
+	local i="$(gcd "$2" "$3")"
+	printf '%s\n' "$(($(pot "$1") * ($3 / i - 1) / ($3 / i)))"
+}
+
+# Compute the appropriate mul/adj values as well as a shift count,
+# which brings the mul value into the range 2^b-1 <= x < 2^b.  Such
+# a shift value will be correct in the signed integer range and off
+# by at most one in the upper half of the unsigned range.
+fmuls() {
+	local i=0
+    local j
+	while true; do
+        j="$(fmul "${i}" "$2" "$3")"
+		if [ "${j}" -ge "$(pot "$(($1 - 1))")" ]; then
+			printf '%s\n' "${i}" && return
+		fi
+		i="$((i + 1))"
+	done
+}
+
+printf '/* Automatically generated by %s */\n' "$0"
+printf '/* Time conversion constants for HZ == %s */\n\n' "$1"
+
+printf '#ifndef KERNEL_TIMECONST_H\n'
+printf '#define KERNEL_TIMECONST_H\n\n'
+
+printf '#include <linux/param.h>\n'
+printf '#include <linux/types.h>\n\n'
+
+printf '#if HZ != %s\n' "$1"
+printf '#error \qinclude/generated/timeconst.h has the wrong HZ value!\q\n'
+printf '#endif\n\n'
+
+if [ "$1" -lt 2 ]; then
+	printf '#error Totally bogus HZ value!\n'
+	exit 1
+fi
+
+s="$(fmuls 32 1000 "$1")"
+printf '#define HZ_TO_MSEC_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" 1000 "$1")"
+printf '#define HZ_TO_MSEC_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" 1000 "$1")"
+printf '#define HZ_TO_MSEC_SHR32\t%s\n' "${s}"
+
+s="$(fmuls 32 "$1" 1000)"
+printf '#define MSEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1" 1000)"
+printf '#define MSEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1" 1000)"
+printf '#define MSEC_TO_HZ_SHR32\t%s\n' "${s}"
+
+cd="$(gcd "$1" 1000)"
+printf '#define HZ_TO_MSEC_NUM\t\t%s\n' "$((1000 / cd))"
+printf '#define HZ_TO_MSEC_DEN\t\t%s\n' "$((hz / cd))"
+printf '#define MSEC_TO_HZ_NUM\t\t%s\n' "$((hz / cd))"
+printf '#define MSEC_TO_HZ_DEN\t\t%s\n\n' "$((1000 / cd))"
+
+s="$(fmuls 32 1000000 "$1")"
+printf '#define HZ_TO_USEC_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" 1000000 "$1")"
+printf '#define HZ_TO_USEC_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" 1000000 "$1")"
+printf '#define HZ_TO_USEC_SHR32\t%s\n' "${s}"
+
+s="$(fmuls 32 "$1" 1000000)"
+printf '#define USEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1" 1000000)"
+printf '#define USEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1" 1000000)"
+printf '#define USEC_TO_HZ_SHR32\t%s\n' "${s}"
+
+cd="$(gcd "$1" 1000000)"
+printf '#define HZ_TO_USEC_NUM\t\t%s\n' "$((1000000 / cd))"
+printf '#define HZ_TO_USEC_DEN\t\t%s\n' "$((hz / cd))"
+printf '#define USEC_TO_HZ_NUM\t\t%s\n' "$((hz / cd))"
+printf '#define USEC_TO_HZ_DEN\t\t%s\n' "$((1000000 / cd))"
+
+cd="$(gcd "$1" 1000000000)"
+printf '#define HZ_TO_NSEC_NUM\t\t%s\n' "$((1000000000 / cd))"
+printf '#define HZ_TO_NSEC_DEN\t\t%s\n' "$((hz / cd))"
+printf '#define NSEC_TO_HZ_NUM\t\t%s\n' "$((hz / cd))"
+printf '#define NSEC_TO_HZ_DEN\t\t%s\n' "$((1000000000 / cd))"
+
+printf '\n#endif /* KERNEL_TIMECONST_H */\n'
-- 
2.22.0

