Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F388C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EED2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfB1Nlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfB1Nlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C05563247895;
        Thu, 28 Feb 2019 13:41:54 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F0EB1973E;
        Thu, 28 Feb 2019 13:41:51 +0000 (UTC)
Date:   Thu, 28 Feb 2019 21:41:46 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
Message-ID: <20190228134146.GA7528@dhcp-128-65.nay.redhat.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 28 Feb 2019 13:41:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,
 
Sorry for jumping in late, just noticed this kexec selftests, I think we
also need a kexec load test not only for ima, but for general kexec

On 01/31/19 at 01:55pm, Mimi Zohar wrote:
> Define and move get_secureboot_mode() to a common file for use by other
> tests.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  tools/testing/selftests/ima/common_lib.sh      | 20 ++++++++++++++++++++
>  tools/testing/selftests/ima/test_kexec_load.sh | 17 +++--------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>  create mode 100755 tools/testing/selftests/ima/common_lib.sh
> 
> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> new file mode 100755
> index 000000000000..ae097a634da5
> --- /dev/null
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +get_secureboot_mode()
> +{
> +	EFIVARFS="/sys/firmware/efi/efivars"
> +	# Make sure that efivars is mounted in the normal location
> +	if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
> +		echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
> +		exit $ksft_skip
> +	fi
> +
> +	# Get secureboot mode
> +	file="$EFIVARFS/SecureBoot-*"
> +	if [ ! -e $file ]; then
> +		echo "$TEST: unknown secureboot mode" >&2
> +		exit $ksft_skip
> +	fi
> +	return `hexdump $file | awk '{print substr($4,length($4),1)}'`
> +}

Do you want to get the Secureboot status here?
I got some advice from Peter Jones previously, thus we have below
in our kdump scripts:
https://src.fedoraproject.org/cgit/rpms/kexec-tools.git/tree/kdump-lib.sh
 
See the function is_secure_boot_enforced(), probably you can refer to
that function and check setup mode as well.

> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index 74423c4229e2..5e3566738888 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -5,7 +5,7 @@
>  # is booted in secureboot mode.
>  
>  TEST="$0"
> -EFIVARFS="/sys/firmware/efi/efivars"
> +. ./common_lib.sh
>  rc=0
>  
>  # Kselftest framework requirement - SKIP code is 4.
> @@ -17,19 +17,8 @@ if [ $(id -ru) != 0 ]; then
>  	exit $ksft_skip
>  fi
>  
> -# Make sure that efivars is mounted in the normal location
> -if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
> -	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
> -	exit $ksft_skip
> -fi
> -
> -# Get secureboot mode
> -file="$EFIVARFS/SecureBoot-*"
> -if [ ! -e $file ]; then
> -	echo "$TEST: unknown secureboot mode" >&2
> -	exit $ksft_skip
> -fi
> -secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
> +get_secureboot_mode
> +secureboot=$?
>  
>  # kexec_load should fail in secure boot mode
>  KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> -- 
> 2.7.5
> 
Thanks
Dave
