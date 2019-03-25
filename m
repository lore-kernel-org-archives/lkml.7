Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F33B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfCYIJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:09:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729874AbfCYIJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC3CC64459;
        Mon, 25 Mar 2019 08:09:42 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-119.pek2.redhat.com [10.72.12.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE1795D9D5;
        Mon, 25 Mar 2019 08:09:39 +0000 (UTC)
Date:   Mon, 25 Mar 2019 16:09:35 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA
 being enabled
Message-ID: <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
References: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 25 Mar 2019 08:09:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi
On 03/22/19 at 03:35pm, Mimi Zohar wrote:
> Verify IMA is enabled before failing tests or emitting irrelevant
> messages.  Also, don't skip the test if signatures are not required.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Dave, if this patch resolves the outstanding issues, I can fold these
> changes into the original patches. (Reminder, these patches will need to
> be updated to support the "lockdown" patch set.)

They looks good to me, thanks for the update

Feel free to add my reviewed-by, I did some tests although not cover all
ima cases.

Thanks
Dave

> 
>  .../selftests/kexec/test_kexec_file_load.sh        | 27 ++++++++++++++--------
>  tools/testing/selftests/kexec/test_kexec_load.sh   | 24 ++++++++++++-------
>  2 files changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
> index 1d2e5e799523..57b636792086 100755
> --- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
> +++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
> @@ -110,11 +110,20 @@ kexec_file_load_test()
>  			log_fail "$succeed_msg (missing IMA sig)"
>  		fi
>  
> -		if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
> -		    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
> +		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
> +		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
> +	            && [ $ima_read_policy -eq 0 ]; then
>  			log_fail "$succeed_msg (possibly missing IMA sig)"
>  		fi
>  
> +		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 0 ]; then
> +			log_info "No signature verification required"
> +		elif [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
> +		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
> +	            && [ $ima_read_policy -eq 1 ]; then
> +			log_info "No signature verification required"
> +		fi
> +
>  		log_pass "$succeed_msg"
>  	fi
>  
> @@ -136,8 +145,9 @@ kexec_file_load_test()
>  		log_pass "$failed_msg (missing IMA sig)"
>  	fi
>  
> -	if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
> -	    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
> +	if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
> +	    && [ $ima_sig_required -eq 0 ] && [ $ima_read_policy -eq 0 ] \
> +	    && [ $ima_signed -eq 0 ]; then
>  		log_pass "$failed_msg (possibly missing IMA sig)"
>  	fi
>  
> @@ -157,6 +167,9 @@ if [ $? -eq 0 ]; then
>  fi
>  
>  # Determine which kernel config options are enabled
> +kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
> +ima_appraise=$?
> +
>  kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
>  	"architecture specific policy enabled"
>  arch_policy=$?
> @@ -178,12 +191,6 @@ ima_sig_required=$?
>  get_secureboot_mode
>  secureboot=$?
>  
> -if [ $secureboot -eq 0 ] && [ $arch_policy -eq 0 ] && \
> -   [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] && \
> -   [ $ima_read_policy -eq 1 ]; then
> -	log_skip "No signature verification required"
> -fi
> -
>  # Are there pe and ima signatures
>  check_for_pesig
>  pe_signed=$?
> diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
> index 2a66c8897f55..49c6aa929137 100755
> --- a/tools/testing/selftests/kexec/test_kexec_load.sh
> +++ b/tools/testing/selftests/kexec/test_kexec_load.sh
> @@ -1,8 +1,8 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> -# Loading a kernel image via the kexec_load syscall should fail
> -# when the kernel is CONFIG_KEXEC_VERIFY_SIG enabled and the system
> -# is booted in secureboot mode.
> +#
> +# Prevent loading a kernel image via the kexec_load syscall when
> +# signatures are required.  (Dependent on CONFIG_IMA_ARCH_POLICY.)
>  
>  TEST="$0"
>  . ./kexec_common_lib.sh
> @@ -18,20 +18,28 @@ if [ $? -eq 0 ]; then
>  	log_skip "kexec_load is not enabled"
>  fi
>  
> +kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
> +ima_appraise=$?
> +
> +kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
> +	"IMA architecture specific policy enabled"
> +arch_policy=$?
> +
>  get_secureboot_mode
>  secureboot=$?
>  
> -# kexec_load should fail in secure boot mode
> +# kexec_load should fail in secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
>  kexec --load $KERNEL_IMAGE > /dev/null 2>&1
>  if [ $? -eq 0 ]; then
>  	kexec --unload
> -	if [ $secureboot -eq 1 ]; then
> +	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
>  		log_fail "kexec_load succeeded"
> -	else
> -		log_pass "kexec_load succeeded"
> +	elif [ $ima_appraise -eq 0 -o $arch_policy -eq 0 ]; then
> +		log_info "Either IMA or the IMA arch policy is not enabled"
>  	fi
> +	log_pass "kexec_load succeeded"
>  else
> -	if [ $secureboot -eq 1 ]; then
> +	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] ; then
>  		log_pass "kexec_load failed"
>  	else
>  		log_fail "kexec_load failed"
> -- 
> 2.7.5
> 
