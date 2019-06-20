Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA595C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE322084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jCBF1b/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfFTHXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:23:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56882 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTHXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:23:31 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BC43652A;
        Thu, 20 Jun 2019 09:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1561015408;
        bh=VOoCwS8/tCN9P2CKJYt897YGXh2zL4FNArC5EdXXWRo=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jCBF1b/c8FZ158Q3zjR/fwGtA848AJo03QiPtxhk3DrA0b6KeWDpNPiVx/mhdB850
         u4MYY382MqXqB15+PV61W6iiLW+HYUgJJkAmpgQzAEa1NtG4Ud0AsuU6TtvrzyyhGI
         q3RaZuNIIgva8qIxSdwfPIzsSuvMEsUwlrLGlv10=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH] replace timeconst bc script with an sh script
To:     Ethan Sommer <e5ten.arch@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Corey Minyard <cminyard@mvista.com>,
        John Stultz <john.stultz@linaro.org>
References: <20190620062246.2665-1-e5ten.arch@gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <8a9ffb4b-791d-35d1-bb2a-7b6ad812bff1@ideasonboard.com>
Date:   Thu, 20 Jun 2019 08:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620062246.2665-1-e5ten.arch@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ethan,

Thank you for the patch,

On 20/06/2019 07:22, Ethan Sommer wrote:
> removes the bc build dependency introduced when timeconst.pl was
> replaced by timeconst.bc

Does this introduction of bc cause you problems when building?

Documentation/process/changes.rst states that "You will need bc to build
kernels 3.10 and higher"

Is bc used elsewhere in the kernel?

If this is the only use of BC and it is no longer a dependency - the
process document should be updated.


Though I see uses at:
   tools/testing/selftests/net/forwarding/lib.sh


There is a small issue with quotes highlighted below, and the only other
(really minor) comment is performance.

time (echo 1000 | bc -q ./kernel/time/timeconst.bc)
  real	0m0.006s
  user	0m0.006s
  sys	0m0.000s

vs
time /tmp/timeconst.sh 1000
  real	0m0.176s
  user	0m0.141s
  sys	0m0.050s


So that's 176 milliseconds vs 6. (on an i7 gen8 laptop) which probably
isn't going to affect things too much on the scale of building a kernel.
But I measured it so I thought it was worth posting the results.


--
Regards

Kieran


> Signed-off-by: Ethan Sommer <e5ten.arch@gmail.com>
> ---
>  Kbuild                   |   4 +-
>  kernel/time/timeconst.bc | 117 --------------------------------------
>  kernel/time/timeconst.sh | 118 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 119 deletions(-)
>  delete mode 100644 kernel/time/timeconst.bc
>  create mode 100755 kernel/time/timeconst.sh
> 
> diff --git a/Kbuild b/Kbuild
> index 8637fd14135f..2b5f2957cf04 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -20,9 +20,9 @@ timeconst-file := include/generated/timeconst.h
>  
>  targets += $(timeconst-file)
>  
> -filechk_gentimeconst = echo $(CONFIG_HZ) | bc -q $<
> +filechk_gentimeconst = $(CONFIG_SHELL) $< $(CONFIG_HZ)
>  
> -$(timeconst-file): kernel/time/timeconst.bc FORCE
> +$(timeconst-file): kernel/time/timeconst.sh FORCE
>  	$(call filechk,gentimeconst)
>  
>  #####
> diff --git a/kernel/time/timeconst.bc b/kernel/time/timeconst.bc
> deleted file mode 100644
> index 7ed0e0fb5831..000000000000
> --- a/kernel/time/timeconst.bc
> +++ /dev/null
> @@ -1,117 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -
> -scale=0
> -
> -define gcd(a,b) {
> -	auto t;
> -	while (b) {
> -		t = b;
> -		b = a % b;
> -		a = t;
> -	}
> -	return a;
> -}
> -
> -/* Division by reciprocal multiplication. */
> -define fmul(b,n,d) {
> -       return (2^b*n+d-1)/d;
> -}
> -
> -/* Adjustment factor when a ceiling value is used.  Use as:
> -   (imul * n) + (fmulxx * n + fadjxx) >> xx) */
> -define fadj(b,n,d) {
> -	auto v;
> -	d = d/gcd(n,d);
> -	v = 2^b*(d-1)/d;
> -	return v;
> -}
> -
> -/* Compute the appropriate mul/adj values as well as a shift count,
> -   which brings the mul value into the range 2^b-1 <= x < 2^b.  Such
> -   a shift value will be correct in the signed integer range and off
> -   by at most one in the upper half of the unsigned range. */
> -define fmuls(b,n,d) {
> -	auto s, m;
> -	for (s = 0; 1; s++) {
> -		m = fmul(s,n,d);
> -		if (m >= 2^(b-1))
> -			return s;
> -	}
> -	return 0;
> -}
> -
> -define timeconst(hz) {
> -	print "/* Automatically generated by kernel/time/timeconst.bc */\n"
> -	print "/* Time conversion constants for HZ == ", hz, " */\n"
> -	print "\n"
> -
> -	print "#ifndef KERNEL_TIMECONST_H\n"
> -	print "#define KERNEL_TIMECONST_H\n\n"
> -
> -	print "#include <linux/param.h>\n"
> -	print "#include <linux/types.h>\n\n"
> -
> -	print "#if HZ != ", hz, "\n"
> -	print "#error \qinclude/generated/timeconst.h has the wrong HZ value!\q\n"
> -	print "#endif\n\n"
> -
> -	if (hz < 2) {
> -		print "#error Totally bogus HZ value!\n"
> -	} else {
> -		s=fmuls(32,1000,hz)
> -		obase=16
> -		print "#define HZ_TO_MSEC_MUL32\tU64_C(0x", fmul(s,1000,hz), ")\n"
> -		print "#define HZ_TO_MSEC_ADJ32\tU64_C(0x", fadj(s,1000,hz), ")\n"
> -		obase=10
> -		print "#define HZ_TO_MSEC_SHR32\t", s, "\n"
> -
> -		s=fmuls(32,hz,1000)
> -		obase=16
> -		print "#define MSEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000), ")\n"
> -		print "#define MSEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000), ")\n"
> -		obase=10
> -		print "#define MSEC_TO_HZ_SHR32\t", s, "\n"
> -
> -		obase=10
> -		cd=gcd(hz,1000)
> -		print "#define HZ_TO_MSEC_NUM\t\t", 1000/cd, "\n"
> -		print "#define HZ_TO_MSEC_DEN\t\t", hz/cd, "\n"
> -		print "#define MSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
> -		print "#define MSEC_TO_HZ_DEN\t\t", 1000/cd, "\n"
> -		print "\n"
> -
> -		s=fmuls(32,1000000,hz)
> -		obase=16
> -		print "#define HZ_TO_USEC_MUL32\tU64_C(0x", fmul(s,1000000,hz), ")\n"
> -		print "#define HZ_TO_USEC_ADJ32\tU64_C(0x", fadj(s,1000000,hz), ")\n"
> -		obase=10
> -		print "#define HZ_TO_USEC_SHR32\t", s, "\n"
> -
> -		s=fmuls(32,hz,1000000)
> -		obase=16
> -		print "#define USEC_TO_HZ_MUL32\tU64_C(0x", fmul(s,hz,1000000), ")\n"
> -		print "#define USEC_TO_HZ_ADJ32\tU64_C(0x", fadj(s,hz,1000000), ")\n"
> -		obase=10
> -		print "#define USEC_TO_HZ_SHR32\t", s, "\n"
> -
> -		obase=10
> -		cd=gcd(hz,1000000)
> -		print "#define HZ_TO_USEC_NUM\t\t", 1000000/cd, "\n"
> -		print "#define HZ_TO_USEC_DEN\t\t", hz/cd, "\n"
> -		print "#define USEC_TO_HZ_NUM\t\t", hz/cd, "\n"
> -		print "#define USEC_TO_HZ_DEN\t\t", 1000000/cd, "\n"
> -
> -		cd=gcd(hz,1000000000)
> -		print "#define HZ_TO_NSEC_NUM\t\t", 1000000000/cd, "\n"
> -		print "#define HZ_TO_NSEC_DEN\t\t", hz/cd, "\n"
> -		print "#define NSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
> -		print "#define NSEC_TO_HZ_DEN\t\t", 1000000000/cd, "\n"
> -		print "\n"
> -
> -		print "#endif /* KERNEL_TIMECONST_H */\n"
> -	}
> -	halt
> -}
> -
> -hz = read();
> -timeconst(hz)
> diff --git a/kernel/time/timeconst.sh b/kernel/time/timeconst.sh
> new file mode 100755
> index 000000000000..df821988acbf
> --- /dev/null
> +++ b/kernel/time/timeconst.sh
> @@ -0,0 +1,118 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if [ -z "$1" ]; then
> +	printf '%s <HZ>\n' "$0"
> +	exit 1
> +else
> +	hz="$1"
> +fi
> +
> +# 2 to the power of n
> +pot() {
> +	local i=1
> +    local j=1
> +	while [ "${j}" -le "$1" ]; do
> +		i="$((i * 2))"
> +        j="$((j + 1))"
> +	done
> +	printf '%s\n' "${i}"
> +}
> +
> +# Greatest common denominator
> +gcd() {
> +	local i="$1"
> +	local j="$2"
> +	local k
> +	while [ "${j}" -ne 0 ]; do
> +		k="${j}"
> +		j="$((i % j))"
> +		i="${k}"
> +	done
> +	printf '%s\n' "${i}"
> +}
> +
> +# Division by reciprocal multiplication.
> +fmul() {
> +	printf '%s\n' "$((($(pot "$1") * $2 + $3 - 1) / $3))"
> +}
> +
> +# Adjustment factor when a ceiling value is used.
> +fadj() {
> +	local i="$(gcd "$2" "$3")"
> +	printf '%s\n' "$(($(pot "$1") * ($3 / i - 1) / ($3 / i)))"
> +}
> +
> +# Compute the appropriate mul/adj values as well as a shift count,
> +# which brings the mul value into the range 2^b-1 <= x < 2^b.  Such
> +# a shift value will be correct in the signed integer range and off
> +# by at most one in the upper half of the unsigned range.
> +fmuls() {
> +	local i=0
> +    local j
> +	while true; do
> +        j="$(fmul "${i}" "$2" "$3")"
> +		if [ "${j}" -ge "$(pot "$(($1 - 1))")" ]; then
> +			printf '%s\n' "${i}" && return
> +		fi
> +		i="$((i + 1))"
> +	done
> +}
> +
> +printf '/* Automatically generated by %s */\n' "$0"
> +printf '/* Time conversion constants for HZ == %s */\n\n' "$1"
> +
> +printf '#ifndef KERNEL_TIMECONST_H\n'
> +printf '#define KERNEL_TIMECONST_H\n\n'
> +
> +printf '#include <linux/param.h>\n'
> +printf '#include <linux/types.h>\n\n'
> +
> +printf '#if HZ != %s\n' "$1"
> +printf '#error \qinclude/generated/timeconst.h has the wrong HZ value!\q\n'

This generates an incorrect output:

diff /tmp/bc.timed /tmp/sh.timed
1c1
< /* Automatically generated by kernel/time/timeconst.bc */
---
> /* Automatically generated by /tmp/timeconst.sh */
11c11
< #error "include/generated/timeconst.h has the wrong HZ value!"
---
> #error \qinclude/generated/timeconst.h has the wrong HZ value!\q
    here  ^                                             and here ^



> +printf '#endif\n\n'
> +
> +if [ "$1" -lt 2 ]; then
> +	printf '#error Totally bogus HZ value!\n'
> +	exit 1
> +fi
> +
> +s="$(fmuls 32 1000 "$1")"
> +printf '#define HZ_TO_MSEC_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" 1000 "$1")"
> +printf '#define HZ_TO_MSEC_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" 1000 "$1")"
> +printf '#define HZ_TO_MSEC_SHR32\t%s\n' "${s}"
> +
> +s="$(fmuls 32 "$1" 1000)"
> +printf '#define MSEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1" 1000)"
> +printf '#define MSEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1" 1000)"
> +printf '#define MSEC_TO_HZ_SHR32\t%s\n' "${s}"
> +
> +cd="$(gcd "$1" 1000)"
> +printf '#define HZ_TO_MSEC_NUM\t\t%s\n' "$((1000 / cd))"
> +printf '#define HZ_TO_MSEC_DEN\t\t%s\n' "$((hz / cd))"
> +printf '#define MSEC_TO_HZ_NUM\t\t%s\n' "$((hz / cd))"
> +printf '#define MSEC_TO_HZ_DEN\t\t%s\n\n' "$((1000 / cd))"
> +
> +s="$(fmuls 32 1000000 "$1")"
> +printf '#define HZ_TO_USEC_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" 1000000 "$1")"
> +printf '#define HZ_TO_USEC_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" 1000000 "$1")"
> +printf '#define HZ_TO_USEC_SHR32\t%s\n' "${s}"
> +
> +s="$(fmuls 32 "$1" 1000000)"
> +printf '#define USEC_TO_HZ_MUL32\tU64_C(0x%X)\n' "$(fmul "${s}" "$1" 1000000)"
> +printf '#define USEC_TO_HZ_ADJ32\tU64_C(0x%X)\n' "$(fadj "${s}" "$1" 1000000)"
> +printf '#define USEC_TO_HZ_SHR32\t%s\n' "${s}"
> +
> +cd="$(gcd "$1" 1000000)"
> +printf '#define HZ_TO_USEC_NUM\t\t%s\n' "$((1000000 / cd))"
> +printf '#define HZ_TO_USEC_DEN\t\t%s\n' "$((hz / cd))"
> +printf '#define USEC_TO_HZ_NUM\t\t%s\n' "$((hz / cd))"
> +printf '#define USEC_TO_HZ_DEN\t\t%s\n' "$((1000000 / cd))"
> +
> +cd="$(gcd "$1" 1000000000)"
> +printf '#define HZ_TO_NSEC_NUM\t\t%s\n' "$((1000000000 / cd))"
> +printf '#define HZ_TO_NSEC_DEN\t\t%s\n' "$((hz / cd))"
> +printf '#define NSEC_TO_HZ_NUM\t\t%s\n' "$((hz / cd))"
> +printf '#define NSEC_TO_HZ_DEN\t\t%s\n' "$((1000000000 / cd))"
> +
> +printf '\n#endif /* KERNEL_TIMECONST_H */\n'
> 

-- 
Regards
--
Kieran
