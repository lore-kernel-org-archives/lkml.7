Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24ACCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 20:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3FB214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AS0C9S5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKBUzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 16:55:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53675 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfKBUzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 16:55:32 -0400
Received: from [IPv6:2607:fb90:9e97:64e0:fc64:2a26:117f:8387] ([IPv6:2607:fb90:9e97:64e0:fc64:2a26:117f:8387])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA2Ksi4g3897602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 2 Nov 2019 13:54:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA2Ksi4g3897602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1572728093;
        bh=w/B0L6r/ajvJrsIjTZM6hTkY8tIkcO4sCCt8NYzyHhY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=AS0C9S5CryBnIL/FLM/PD7ukzaTnwlYNVoY8rbLF9kD5SNNUqeBOqVBxqtHeQLH74
         EDG9wVbg6nQ6EMiQj1VO1t/Et0//ZeJpNcW8f4/dvRobej7TquSy2SUJ/bVYXl9gkX
         JT6tAz0NK1E5qq81nfvgapieWTbnF2QNUWsvurloFTfw90ZXz64w0Lc+wArL1BmW6X
         z9jG9P98kGoV9W8rvY8L+iNBrrzqMeVX8cW45ot7XQN0trwR3GXV6CWcx62adpnUKS
         WnXgT7AfGLAMtsfekXqar7QoBes42WIZ2TUR4vcI+a+j8Z0PkTHcLagPDkP1jKlIEI
         a/xum4MeH1PQg==
Date:   Sat, 02 Nov 2019 13:54:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20191029210250.17007-1-e5ten.arch@gmail.com>
References: <20190620062246.2665-1-e5ten.arch@gmail.com> <20191029210250.17007-1-e5ten.arch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] replace timeconst bc script with an sh script
To:     Ethan Sommer <e5ten.arch@gmail.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
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
From:   hpa@zytor.com
Message-ID: <CBCA4048-A9C1-42E6-A821-1EE36AE8CDC7@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 29, 2019 2:02:44 PM PDT, Ethan Sommer <e5ten=2Earch@gmail=2Ecom>=
 wrote:
>removes the bc build dependency introduced when timeconst=2Epl was
>replaced by timeconst=2Ebc:
>commit 70730bca1331 ("kernel: Replace timeconst=2Epl with a bc script")
>
>the reason for this change is that this is the only use of bc in the
>actual compilation of the kernel, so by replacing it with a shell
>script
>compiling the kernel no longer depends on bc=2E
>
>Signed-off-by: Ethan Sommer <e5ten=2Earch@gmail=2Ecom>
>---
> Documentation/process/changes=2Erst |   6 --
> Kbuild                            |   4 +-
> kernel/time/timeconst=2Ebc          | 117 ------------------------------
> kernel/time/timeconst=2Esh          | 111 ++++++++++++++++++++++++++++
> 4 files changed, 113 insertions(+), 125 deletions(-)
> delete mode 100644 kernel/time/timeconst=2Ebc
> create mode 100644 kernel/time/timeconst=2Esh
>
>diff --git a/Documentation/process/changes=2Erst
>b/Documentation/process/changes=2Erst
>index 2284f2221f02=2E=2E3ae168387109 100644
>--- a/Documentation/process/changes=2Erst
>+++ b/Documentation/process/changes=2Erst
>@@ -105,12 +105,6 @@ Perl
> You will need perl 5 and the following modules: ``Getopt::Long``,
>``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the
>kernel=2E
>=20
>-BC
>---
>-
>-You will need bc to build kernels 3=2E10 and higher
>-
>-
> OpenSSL
> -------
>=20
>diff --git a/Kbuild b/Kbuild
>index 3109ac786e76=2E=2E7eba24cbdb78 100644
>--- a/Kbuild
>+++ b/Kbuild
>@@ -18,9 +18,9 @@ $(bounds-file): kernel/bounds=2Es FORCE
>=20
> timeconst-file :=3D include/generated/timeconst=2Eh
>=20
>-filechk_gentimeconst =3D echo $(CONFIG_HZ) | bc -q $<
>+filechk_gentimeconst =3D $(CONFIG_SHELL) $< $(CONFIG_HZ)
>=20
>-$(timeconst-file): kernel/time/timeconst=2Ebc FORCE
>+$(timeconst-file): kernel/time/timeconst=2Esh FORCE
> 	$(call filechk,gentimeconst)
>=20
> #####
>diff --git a/kernel/time/timeconst=2Ebc b/kernel/time/timeconst=2Ebc
>deleted file mode 100644
>index 7ed0e0fb5831=2E=2E000000000000
>--- a/kernel/time/timeconst=2Ebc
>+++ /dev/null
>@@ -1,117 +0,0 @@
>-/* SPDX-License-Identifier: GPL-2=2E0 */
>-
>-scale=3D0
>-
>-define gcd(a,b) {
>-	auto t;
>-	while (b) {
>-		t =3D b;
>-		b =3D a % b;
>-		a =3D t;
>-	}
>-	return a;
>-}
>-
>-/* Division by reciprocal multiplication=2E */
>-define fmul(b,n,d) {
>-       return (2^b*n+d-1)/d;
>-}
>-
>-/* Adjustment factor when a ceiling value is used=2E  Use as:
>-   (imul * n) + (fmulxx * n + fadjxx) >> xx) */
>-define fadj(b,n,d) {
>-	auto v;
>-	d =3D d/gcd(n,d);
>-	v =3D 2^b*(d-1)/d;
>-	return v;
>-}
>-
>-/* Compute the appropriate mul/adj values as well as a shift count,
>-   which brings the mul value into the range 2^b-1 <=3D x < 2^b=2E  Such
>-   a shift value will be correct in the signed integer range and off
>-   by at most one in the upper half of the unsigned range=2E */
>-define fmuls(b,n,d) {
>-	auto s, m;
>-	for (s =3D 0; 1; s++) {
>-		m =3D fmul(s,n,d);
>-		if (m >=3D 2^(b-1))
>-			return s;
>-	}
>-	return 0;
>-}
>-
>-define timeconst(hz) {
>-	print "/* Automatically generated by kernel/time/timeconst=2Ebc */\n"
>-	print "/* Time conversion constants for HZ =3D=3D ", hz, " */\n"
>-	print "\n"
>-
>-	print "#ifndef KERNEL_TIMECONST_H\n"
>-	print "#define KERNEL_TIMECONST_H\n\n"
>-
>-	print "#include <linux/param=2Eh>\n"
>-	print "#include <linux/types=2Eh>\n\n"
>-
>-	print "#if HZ !=3D ", hz, "\n"
>-	print "#error \qinclude/generated/timeconst=2Eh has the wrong HZ
>value!\q\n"
>-	print "#endif\n\n"
>-
>-	if (hz < 2) {
>-		print "#error Totally bogus HZ value!\n"
>-	} else {
>-		s=3Dfmuls(32,1000,hz)
>-		obase=3D16
>-		print "#define HZ_TO_MSEC_MUL32\tU64_C(0x", fmul(s,1000,hz), ")\n"
>-		print "#define HZ_TO_MSEC_ADJ32\tU64_C(0x", fadj(s,1000,hz), ")\n"
>-		obase=3D10
>-		print "#define HZ_TO_MSEC_SHR32\t", s, "\n"
>-
>-		s=3Dfmuls(32,hz,1000)
>-		obase=3D16
>-		print "#define MSEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000), ")\n"
>-		print "#define MSEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000), ")\n"
>-		obase=3D10
>-		print "#define MSEC_TO_HZ_SHR32\t", s, "\n"
>-
>-		obase=3D10
>-		cd=3Dgcd(hz,1000)
>-		print "#define HZ_TO_MSEC_NUM\t\t", 1000/cd, "\n"
>-		print "#define HZ_TO_MSEC_DEN\t\t", hz/cd, "\n"
>-		print "#define MSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
>-		print "#define MSEC_TO_HZ_DEN\t\t", 1000/cd, "\n"
>-		print "\n"
>-
>-		s=3Dfmuls(32,1000000,hz)
>-		obase=3D16
>-		print "#define HZ_TO_USEC_MUL32\tU64_C(0x", fmul(s,1000000,hz),
>")\n"
>-		print "#define HZ_TO_USEC_ADJ32\tU64_C(0x", fadj(s,1000000,hz),
>")\n"
>-		obase=3D10
>-		print "#define HZ_TO_USEC_SHR32\t", s, "\n"
>-
>-		s=3Dfmuls(32,hz,1000000)
>-		obase=3D16
>-		print "#define USEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000000),
>")\n"
>-		print "#define USEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000000),
>")\n"
>-		obase=3D10
>-		print "#define USEC_TO_HZ_SHR32\t", s, "\n"
>-
>-		obase=3D10
>-		cd=3Dgcd(hz,1000000)
>-		print "#define HZ_TO_USEC_NUM\t\t", 1000000/cd, "\n"
>-		print "#define HZ_TO_USEC_DEN\t\t", hz/cd, "\n"
>-		print "#define USEC_TO_HZ_NUM\t\t", hz/cd, "\n"
>-		print "#define USEC_TO_HZ_DEN\t\t", 1000000/cd, "\n"
>-
>-		cd=3Dgcd(hz,1000000000)
>-		print "#define HZ_TO_NSEC_NUM\t\t", 1000000000/cd, "\n"
>-		print "#define HZ_TO_NSEC_DEN\t\t", hz/cd, "\n"
>-		print "#define NSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
>-		print "#define NSEC_TO_HZ_DEN\t\t", 1000000000/cd, "\n"
>-		print "\n"
>-
>-		print "#endif /* KERNEL_TIMECONST_H */\n"
>-	}
>-	halt
>-}
>-
>-hz =3D read();
>-timeconst(hz)
>diff --git a/kernel/time/timeconst=2Esh b/kernel/time/timeconst=2Esh
>new file mode 100644
>index 000000000000=2E=2Ed1aa25f46be8
>--- /dev/null
>+++ b/kernel/time/timeconst=2Esh
>@@ -0,0 +1,111 @@
>+#!/bin/sh
>+# SPDX-License-Identifier: GPL-2=2E0
>+
>+if [ -z "$1" ]; then
>+	printf '%s <HZ>\n' "$0" >&2
>+	exit 1
>+fi
>+
>+# 2 to the power of n
>+pot() {
>+	local i=3D1 j=3D0
>+	while [ "$((j +=3D 1))" -le "$1" ]; do
>+		: "$((i *=3D 2))"
>+	done
>+	printf '%u' "${i}"
>+}
>+
>+# Greatest common denominator
>+gcd() {
>+	local i=3D"$1" j=3D"$2" k
>+	while [ "${j}" -ne 0 ]; do
>+		k=3D"${j}" j=3D"$((i % j))" i=3D"${k}"
>+	done
>+	printf '%u' "${i}"
>+}
>+
>+# Division by reciprocal multiplication=2E
>+fmul() {
>+	printf '%u' "$((($(pot "$1") * $2 + $3 - 1) / $3))"
>+}
>+
>+# Adjustment factor when a ceiling value is used=2E
>+fadj() {
>+	local i
>+	i=3D"$(gcd "$2" "$3")"
>+	printf '%u' "$(($(pot "$1") * ($3 / i - 1) / ($3 / i)))"
>+}
>+
>+# Compute the appropriate mul/adj values as well as a shift count,
>+# which brings the mul value into the range 2^b-1 <=3D x < 2^b=2E  Such
>+# a shift value will be correct in the signed integer range and off
>+# by at most one in the upper half of the unsigned range=2E
>+fmuls() {
>+	local i=3D0 j
>+	while true; do
>+		j=3D"$(fmul "${i}" "$2" "$3")"
>+		if [ "${j}" -ge "$(pot "$(($1 - 1))")" ]; then
>+			printf '%u' "${i}"
>+			return
>+		fi
>+		: "$((i +=3D 1))"
>+	done
>+}
>+
>+printf '/* Automatically generated by kernel/time/timeconst=2Esh */\n'
>+printf '/* Time conversion constants for HZ =3D=3D %u */\n\n' "$1"
>+
>+printf '#ifndef KERNEL_TIMECONST_H\n'
>+printf '#define KERNEL_TIMECONST_H\n\n'
>+
>+printf '#include <linux/param=2Eh>\n'
>+printf '#include <linux/types=2Eh>\n\n'
>+
>+printf '#if HZ !=3D %u\n' "$1"
>+printf '#error "include/generated/timeconst=2Eh has the wrong HZ
>value!"\n'
>+printf '#endif\n\n'
>+
>+if [ "$1" -lt 2 ]; then
>+	printf '#error Totally bogus HZ value!\n'
>+	exit 1
>+fi
>+
>+s=3D"$(fmuls 32 1000 "$1")"
>+printf '#define HZ_TO_MSEC_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" 1000
>"$1")"
>+printf '#define HZ_TO_MSEC_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" 1000
>"$1")"
>+printf '#define HZ_TO_MSEC_SHR32\t%u\n' "${s}"
>+
>+s=3D"$(fmuls 32 "$1" 1000)"
>+printf '#define MSEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1"
>1000)"
>+printf '#define MSEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1"
>1000)"
>+printf '#define MSEC_TO_HZ_SHR32\t%u\n' "${s}"
>+
>+cd=3D"$(gcd "$1" 1000)"
>+printf '#define HZ_TO_MSEC_NUM\t\t%u\n' "$((1000 / cd))"
>+printf '#define HZ_TO_MSEC_DEN\t\t%u\n' "$(($1 / cd))"
>+printf '#define MSEC_TO_HZ_NUM\t\t%u\n' "$(($1 / cd))"
>+printf '#define MSEC_TO_HZ_DEN\t\t%u\n\n' "$((1000 / cd))"
>+
>+s=3D"$(fmuls 32 1000000 "$1")"
>+printf '#define HZ_TO_USEC_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}"
>1000000 "$1")"
>+printf '#define HZ_TO_USEC_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}"
>1000000 "$1")"
>+printf '#define HZ_TO_USEC_SHR32\t%u\n' "${s}"
>+
>+s=3D"$(fmuls 32 "$1" 1000000)"
>+printf '#define USEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1"
>1000000)"
>+printf '#define USEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1"
>1000000)"
>+printf '#define USEC_TO_HZ_SHR32\t%u\n' "${s}"
>+
>+cd=3D"$(gcd "$1" 1000000)"
>+printf '#define HZ_TO_USEC_NUM\t\t%u\n' "$((1000000 / cd))"
>+printf '#define HZ_TO_USEC_DEN\t\t%u\n' "$(($1 / cd))"
>+printf '#define USEC_TO_HZ_NUM\t\t%u\n' "$(($1 / cd))"
>+printf '#define USEC_TO_HZ_DEN\t\t%u\n' "$((1000000 / cd))"
>+
>+cd=3D"$(gcd "$1" 1000000000)"
>+printf '#define HZ_TO_NSEC_NUM\t\t%u\n' "$((1000000000 / cd))"
>+printf '#define HZ_TO_NSEC_DEN\t\t%u\n' "$(($1 / cd))"
>+printf '#define NSEC_TO_HZ_NUM\t\t%u\n' "$(($1 / cd))"
>+printf '#define NSEC_TO_HZ_DEN\t\t%u\n' "$((1000000000 / cd))"
>+
>+printf '\n#endif /* KERNEL_TIMECONST_H */\n'

Please let me point out, again, that bc *is* part of the basic POSIX tools=
et, and the only tool in that toolset that allows for arbitrary-precision a=
rithmetic=2E That being said, GNU as, which we also depends on, also contai=
ns bigint arithmetic, so it might be possible to coax as into outputting AS=
CII output without manually implementing bigints manually=2E

Another option would be to use a C program linked with gmp=2E Binutils req=
uires gmp, so it doesn't inherently add dependencies, but running it though=
 as would probably be easier at least for the LLVM guys=2E

I also have written a small, portable C bigint library, but that is a lot =
of code to add to the tree=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
