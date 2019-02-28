Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC70AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61FC218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfB1USM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:18:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:52430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfB1USL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:18:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4278DAFBD;
        Thu, 28 Feb 2019 20:18:09 +0000 (UTC)
Date:   Thu, 28 Feb 2019 21:18:07 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] selftests/ima: define common logging functions
Message-ID: <20190228201807.GB20335@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-4-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551223620-11586-4-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> Define log_info, log_pass, log_fail, and log_skip functions.

> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  tools/testing/selftests/ima/common_lib.sh      | 43 +++++++++++++++++++++++---
>  tools/testing/selftests/ima/test_kexec_load.sh | 19 +++---------
>  2 files changed, 43 insertions(+), 19 deletions(-)

> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> index 5583ea74c14e..c6d04006281d 100755
> --- a/tools/testing/selftests/ima/common_lib.sh
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -1,5 +1,36 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
> +
> +VERBOSE="${VERBOSE:-1}"
> +
> +log_info()
> +{
> +	[ $VERBOSE -ne 0 ] && echo "[INFO] $1"
> +}
> +
> +# The ksefltest framework requirement returns 0 for PASS.
> +log_pass()
> +{
> +
> +	[ $VERBOSE -ne 0 ] && echo "$1 [PASS]"
> +	exit 0
> +}
> +
> +# The ksefltest framework requirement returns 1 for FAIL.
> +log_fail()
> +{
> +	[ $VERBOSE -ne 0 ] && echo "$1 [FAIL]"
> +	exit 1
> +}
> +
> +# The ksefltest framework requirement returns 4 for SKIP.
> +log_skip()
> +{
> +	[ $VERBOSE -ne 0 ] && echo "$1"
> +	exit 4
> +}
These might be good candidates for moving to selftest specific shell helper
library (for somebody who wants to do this work).

>  # The secure boot mode can be accessed either as the last integer
>  # of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
> @@ -8,17 +39,19 @@
>  get_secureboot_mode()
>  {
>  	local efivarfs="/sys/firmware/efi/efivars"
> +
>  	# Make sure that efivars is mounted in the normal location
>  	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
> -		echo "$TEST: efivars is not mounted on $efivarfs" >&2
> -		exit $ksft_skip
> +		log_skip "efivars is not mounted on $efivarfs"
>  	fi

>  	# Get secureboot mode
>  	local file="$efivarfs/../vars/SecureBoot-*/data"
>  	if [ ! -e $file ]; then
> -		echo "$TEST: unknown secureboot mode" >&2
> -		exit $ksft_skip
> +		log_skip "unknown secureboot mode"
>  	fi
> -	return `od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data`
> +	ret=`od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data`
> +	[ $ret -eq 1 ] && log_info "secure boot mode enabled"
> +
> +	return $ret
>  }
> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index 35934e0665f1..8b99017538ba 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -6,15 +6,10 @@

>  TEST="$0"
>  . ./common_lib.sh
> -rc=0
> -
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4

>  # kexec requires root privileges
>  if [ $(id -ru) -ne 0 ]; then
> -	echo "$TEST: requires root privileges" >&2
> -	exit $ksft_skip
> +	log_skip "requires root privileges" >&2
You left here redirection to stderr.
+ again requiring root could be in helper library.
>  fi

>  get_secureboot_mode
> @@ -26,18 +21,14 @@ kexec --load $KERNEL_IMAGE 2>&1 > /dev/null
>  if [ $? -eq 0 ]; then
>  	kexec --unload
>  	if [ $secureboot -eq 1 ]; then
> -		echo "$TEST: kexec_load succeeded [FAIL]"
> -		rc=1
> +		log_fail "kexec_load succeeded"
>  	else
> -		echo "$TEST: kexec_load succeeded [PASS]"
> +		log_pass "kexec_load succeeded"
>  	fi
>  else
>  	if [ $secureboot -eq 1 ]; then
> -		echo "$TEST: kexec_load failed [PASS]"
> +		log_pass "kexec_load failed"
>  	else
> -		echo "$TEST: kexec_load failed [FAIL]"
> -		rc=1
> +		log_fail "kexec_load failed"
>  	fi
>  fi
> -
> -exit $rc


Kind regards,
Petr
