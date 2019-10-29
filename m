Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B30CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45342173E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfIXZHaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfJ2VDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:03:38 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39165 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfJ2VDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:03:37 -0400
Received: by mail-il1-f194.google.com with SMTP id i12so169675ils.6;
        Tue, 29 Oct 2019 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgP8JJObFWX9H7gjypcPoICzCMw18AP0HgG9/o9Q3kA=;
        b=GfIXZHaQQj4Txr3JKMm/Snu28Dj2GRT5N0SIStuoueixGCip9l1K8rJn4BdP89wSW0
         dFNaf/d4V2ta0gdqTiwIG5ZqHBdTajebRClogVZlvsdcLvMskHwVFdd/zfxX/qsNzKN5
         D+Ny7AJ5cz4Na4lOoFn2EAF1uJdeR6gRoHJtx1WqcRDc35N7TdAR6Jz34fJxieriJUKx
         Dv2zCTfKHuim8foKXSvkVpDhS2o2dLkXBDVj08PNLc8B1YFSgF7VtU5qkWx4ek5IVUq7
         DRUoLqYGjZ/4hqLMZE7AqwGto78bhNSgHA5ocT24PfZMmHrsAXG0LNjhhkRGicolwcWe
         m2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgP8JJObFWX9H7gjypcPoICzCMw18AP0HgG9/o9Q3kA=;
        b=saFYhNljbAVfaSOklb/Fu0oPHDGMs6q9iMIzWDo5aC22R7ABO/962wWXeYjvqCj6xJ
         1UIC2/Mp65kMp6So38zFREMlRmD34pmyc/ucBplylXR+oycZ+vLHFVW6vpew8LcJt4BQ
         WEPk8si1Crzp0TASepQKGCosIbJwrX1E6eqBg6TJog48jzRtnWCisNPBvXuO0XrBXrIo
         v9Rh2LY/mc6/IQj3sFGBnvcmhznXz40fT5WwOzvf87g7ow+RWjekJ0+vyq/KXVnoLQK2
         E/OG3ty3GiRLLjD575poxVB3Dz3DhwF3FsP9ISHoi1NM7Pr84am/FWLPq3S3LQ/QAeK6
         VzxQ==
X-Gm-Message-State: APjAAAXylLYhZE9rlfldmiIPzCE9CsInHEDNldqpts6y9PkvyH5d2rRU
        E6ulkmNMx8+1/qrYPY0DhcY=
X-Google-Smtp-Source: APXvYqwaOrJ2SgI89sIp39l1ED2mwjasJrmUqsKwrYVqX+iW1rqx4HATtKmjfKcy/H61sDOMTnswjg==
X-Received: by 2002:a92:5c15:: with SMTP id q21mr12179879ilb.239.1572383016477;
        Tue, 29 Oct 2019 14:03:36 -0700 (PDT)
Received: from dell.localdomain ([216.249.49.33])
        by smtp.googlemail.com with ESMTPSA id z20sm11810iof.78.2019.10.29.14.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:03:35 -0700 (PDT)
From:   Ethan Sommer <e5ten.arch@gmail.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Ethan Sommer <e5ten.arch@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] replace timeconst bc script with an sh script
Date:   Tue, 29 Oct 2019 17:02:44 -0400
Message-Id: <20191029210250.17007-1-e5ten.arch@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190620062246.2665-1-e5ten.arch@gmail.com>
References: <20190620062246.2665-1-e5ten.arch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

removes the bc build dependency introduced when timeconst.pl was
replaced by timeconst.bc:
commit 70730bca1331 ("kernel: Replace timeconst.pl with a bc script")

the reason for this change is that this is the only use of bc in the
actual compilation of the kernel, so by replacing it with a shell script
compiling the kernel no longer depends on bc.

Signed-off-by: Ethan Sommer <e5ten.arch@gmail.com>
---
 Documentation/process/changes.rst |   6 --
 Kbuild                            |   4 +-
 kernel/time/timeconst.bc          | 117 ------------------------------
 kernel/time/timeconst.sh          | 111 ++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 125 deletions(-)
 delete mode 100644 kernel/time/timeconst.bc
 create mode 100644 kernel/time/timeconst.sh

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 2284f2221f02..3ae168387109 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -105,12 +105,6 @@ Perl
 You will need perl 5 and the following modules: ``Getopt::Long``,
 ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
 
-BC
---
-
-You will need bc to build kernels 3.10 and higher
-
-
 OpenSSL
 -------
 
diff --git a/Kbuild b/Kbuild
index 3109ac786e76..7eba24cbdb78 100644
--- a/Kbuild
+++ b/Kbuild
@@ -18,9 +18,9 @@ $(bounds-file): kernel/bounds.s FORCE
 
 timeconst-file := include/generated/timeconst.h
 
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
new file mode 100644
index 000000000000..d1aa25f46be8
--- /dev/null
+++ b/kernel/time/timeconst.sh
@@ -0,0 +1,111 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+if [ -z "$1" ]; then
+	printf '%s <HZ>\n' "$0" >&2
+	exit 1
+fi
+
+# 2 to the power of n
+pot() {
+	local i=1 j=0
+	while [ "$((j += 1))" -le "$1" ]; do
+		: "$((i *= 2))"
+	done
+	printf '%u' "${i}"
+}
+
+# Greatest common denominator
+gcd() {
+	local i="$1" j="$2" k
+	while [ "${j}" -ne 0 ]; do
+		k="${j}" j="$((i % j))" i="${k}"
+	done
+	printf '%u' "${i}"
+}
+
+# Division by reciprocal multiplication.
+fmul() {
+	printf '%u' "$((($(pot "$1") * $2 + $3 - 1) / $3))"
+}
+
+# Adjustment factor when a ceiling value is used.
+fadj() {
+	local i
+	i="$(gcd "$2" "$3")"
+	printf '%u' "$(($(pot "$1") * ($3 / i - 1) / ($3 / i)))"
+}
+
+# Compute the appropriate mul/adj values as well as a shift count,
+# which brings the mul value into the range 2^b-1 <= x < 2^b.  Such
+# a shift value will be correct in the signed integer range and off
+# by at most one in the upper half of the unsigned range.
+fmuls() {
+	local i=0 j
+	while true; do
+		j="$(fmul "${i}" "$2" "$3")"
+		if [ "${j}" -ge "$(pot "$(($1 - 1))")" ]; then
+			printf '%u' "${i}"
+			return
+		fi
+		: "$((i += 1))"
+	done
+}
+
+printf '/* Automatically generated by kernel/time/timeconst.sh */\n'
+printf '/* Time conversion constants for HZ == %u */\n\n' "$1"
+
+printf '#ifndef KERNEL_TIMECONST_H\n'
+printf '#define KERNEL_TIMECONST_H\n\n'
+
+printf '#include <linux/param.h>\n'
+printf '#include <linux/types.h>\n\n'
+
+printf '#if HZ != %u\n' "$1"
+printf '#error "include/generated/timeconst.h has the wrong HZ value!"\n'
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
+printf '#define HZ_TO_MSEC_SHR32\t%u\n' "${s}"
+
+s="$(fmuls 32 "$1" 1000)"
+printf '#define MSEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1" 1000)"
+printf '#define MSEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1" 1000)"
+printf '#define MSEC_TO_HZ_SHR32\t%u\n' "${s}"
+
+cd="$(gcd "$1" 1000)"
+printf '#define HZ_TO_MSEC_NUM\t\t%u\n' "$((1000 / cd))"
+printf '#define HZ_TO_MSEC_DEN\t\t%u\n' "$(($1 / cd))"
+printf '#define MSEC_TO_HZ_NUM\t\t%u\n' "$(($1 / cd))"
+printf '#define MSEC_TO_HZ_DEN\t\t%u\n\n' "$((1000 / cd))"
+
+s="$(fmuls 32 1000000 "$1")"
+printf '#define HZ_TO_USEC_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" 1000000 "$1")"
+printf '#define HZ_TO_USEC_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" 1000000 "$1")"
+printf '#define HZ_TO_USEC_SHR32\t%u\n' "${s}"
+
+s="$(fmuls 32 "$1" 1000000)"
+printf '#define USEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1" 1000000)"
+printf '#define USEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1" 1000000)"
+printf '#define USEC_TO_HZ_SHR32\t%u\n' "${s}"
+
+cd="$(gcd "$1" 1000000)"
+printf '#define HZ_TO_USEC_NUM\t\t%u\n' "$((1000000 / cd))"
+printf '#define HZ_TO_USEC_DEN\t\t%u\n' "$(($1 / cd))"
+printf '#define USEC_TO_HZ_NUM\t\t%u\n' "$(($1 / cd))"
+printf '#define USEC_TO_HZ_DEN\t\t%u\n' "$((1000000 / cd))"
+
+cd="$(gcd "$1" 1000000000)"
+printf '#define HZ_TO_NSEC_NUM\t\t%u\n' "$((1000000000 / cd))"
+printf '#define HZ_TO_NSEC_DEN\t\t%u\n' "$(($1 / cd))"
+printf '#define NSEC_TO_HZ_NUM\t\t%u\n' "$(($1 / cd))"
+printf '#define NSEC_TO_HZ_DEN\t\t%u\n' "$((1000000000 / cd))"
+
+printf '\n#endif /* KERNEL_TIMECONST_H */\n'
-- 
2.23.0

