Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F73DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC942084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCLMKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:10:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:10:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EB303082E55;
        Tue, 12 Mar 2019 12:10:09 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4228272AE;
        Tue, 12 Mar 2019 12:10:05 +0000 (UTC)
Date:   Tue, 12 Mar 2019 20:10:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v3 5/7] selftests/ima: kexec_file_load syscall test
Message-ID: <20190312121001.GA18510@dhcp-128-65.nay.redhat.com>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
 <1552304473-3966-6-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552304473-3966-6-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 12 Mar 2019 12:10:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,
On 03/11/19 at 07:41am, Mimi Zohar wrote:
> The kernel can be configured to verify PE signed kernel images, IMA
> kernel image signatures, both types of signatures, or none.  This test
> verifies only properly signed kernel images are loaded into memory,
> based on the kernel configuration and runtime policies.

I understand this is for IMA testing only, but I still wonder if this
can be expanded to common kexec tests, like
tools/testing/selftests/kexec/kexec_load.sh
tools/testing/selftests/kexec/kexec_file_load.sh

Is it possible for ima/test_kexec_load.sh to call the
../kexec/kexec_load.sh, probably add extra argument eg "ima"?

Frankly I did not read and followup much about the testing code changes,
not sure if it is doable or not.  The code sharing under testing folder
seems not very good.  For example the basic check_root is needed by
different parts, but all have its own implementation.  Anyway this is
not the duty of this patch set.
Also the selftests/lib/ is not a folder for sharing code for different
tests, it looks a standalone test instead.

So if split kexec tests to another folder is not doable please just
ignore the comment.

BTW, does CONFIG_KEXEC* is checked?  in case a kernel without KEXEC or
KEXEC_FILE compiled in then the tests can just return directly.

> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  tools/testing/selftests/ima/Makefile               |   2 +-
>  tools/testing/selftests/ima/ima_common_lib.sh      |  99 +++++++++++
>  .../testing/selftests/ima/test_kexec_file_load.sh  | 190 +++++++++++++++++++++
>  tools/testing/selftests/ima/test_kexec_load.sh     |   1 -
>  4 files changed, 290 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh
> 
> diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
> index 04501516831b..00270de0b637 100644
> --- a/tools/testing/selftests/ima/Makefile
> +++ b/tools/testing/selftests/ima/Makefile
> @@ -4,7 +4,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
>  ifeq ($(ARCH),x86)
> -TEST_PROGS := test_kexec_load.sh
> +TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
>  TEST_FILES := ima_common_lib.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/ima/ima_common_lib.sh b/tools/testing/selftests/ima/ima_common_lib.sh
> index 8ab7fcc0b221..d5ed28f9170c 100755
> --- a/tools/testing/selftests/ima/ima_common_lib.sh
> +++ b/tools/testing/selftests/ima/ima_common_lib.sh
> @@ -4,6 +4,9 @@
>  # Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
>  
>  VERBOSE="${VERBOSE:-1}"
> +IKCONFIG="/tmp/config-`uname -r`"
> +KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> +SECURITYFS=$(grep "securityfs" /proc/mounts | awk '{print $2}')
>  
>  log_info()
>  {
> @@ -72,3 +75,99 @@ require_root_privileges()
>  		log_skip "requires root privileges"
>  	fi
>  }
> +
> +# Look for config option in Kconfig file.
> +# Return 1 for found and 0 for not found.
> +kconfig_enabled()
> +{
> +	local config="$1"
> +	local msg="$2"
> +
> +	grep -E -q $config $IKCONFIG
> +	if [ $? -eq 0 ]; then
> +		log_info "$msg"
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +# Attempt to get the kernel config first via proc, and then by
> +# extracting it from the kernel image or the configs.ko using
> +# scripts/extract-ikconfig.
> +# Return 1 for found.
> +get_kconfig()
> +{
> +	local proc_config="/proc/config.gz"
> +	local module_dir="/lib/modules/`uname -r`"
> +	local configs_module="$module_dir/kernel/kernel/configs.ko"
> +
> +	if [ ! -f $proc_config ]; then
> +		modprobe configs > /dev/null 2>&1
> +	fi
> +	if [ -f $proc_config ]; then
> +		cat $proc_config | gunzip > $IKCONFIG 2>/dev/null
> +		if [ $? -eq 0 ]; then
> +			return 1
> +		fi
> +	fi
> +
> +	local extract_ikconfig="$module_dir/source/scripts/extract-ikconfig"
> +	if [ ! -f $extract_ikconfig ]; then
> +		log_skip "extract-ikconfig not found"
> +	fi
> +
> +	$extract_ikconfig $KERNEL_IMAGE > $IKCONFIG 2>/dev/null
> +	if [ $? -eq 1 ]; then
> +		if [ ! -f $configs_module ]; then
> +			log_skip "CONFIG_IKCONFIG not enabled"
> +		fi
> +		$extract_ikconfig $configs_module > $IKCONFIG
> +		if [ $? -eq 1 ]; then
> +			log_skip "CONFIG_IKCONFIG not enabled"
> +		fi
> +	fi
> +	return 1
> +}
> +
> +# Make sure that securityfs is mounted
> +mount_securityfs()
> +{
> +	if [ -z $SECURITYFS ]; then
> +		SECURITYFS=/sys/kernel/security
> +		mount -t securityfs security $SECURITYFS
> +	fi
> +
> +	if [ ! -d "$SECURITYFS" ]; then
> +		log_fail "$SECURITYFS :securityfs is not mounted"
> +	fi
> +}
> +
> +# The policy rule format is an "action" followed by key-value pairs.  This
> +# function supports up to two key-value pairs, in any order.
> +# For example: action func=<keyword> [appraise_type=<type>]
> +# Return 1 for found and 0 for not found.
> +check_ima_policy()
> +{
> +	local action="$1"
> +	local keypair1="$2"
> +	local keypair2="$3"
> +	local ret=0
> +
> +	mount_securityfs
> +
> +	local ima_policy=$SECURITYFS/ima/policy
> +	if [ ! -e $ima_policy ]; then
> +		log_fail "$ima_policy not found"
> +	fi
> +
> +	if [ -n $keypair2 ]; then
> +		grep -e "^$action.*$keypair1" "$ima_policy" | \
> +			grep -q -e "$keypair2"
> +	else
> +		grep -q -e "^$action.*$keypair1" "$ima_policy"
> +	fi
> +
> +	# invert "grep -q" result, returning 1 for found.
> +	[ $? -eq 0 ] && ret=1
> +	return $ret
> +}
> diff --git a/tools/testing/selftests/ima/test_kexec_file_load.sh b/tools/testing/selftests/ima/test_kexec_file_load.sh
> new file mode 100755
> index 000000000000..dbccfb109c68
> --- /dev/null
> +++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
> @@ -0,0 +1,190 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Loading a kernel image via the kexec_file_load syscall can verify either
> +# the IMA signature stored in the security.ima xattr or the PE signature,
> +# both signatures depending on the IMA policy, or none.
> +#
> +# To determine whether the kernel image is signed, this test depends
> +# on pesign and getfattr.  This test also requires the kernel to be
> +# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
> +# enabled or access to the extract-ikconfig script.
> +
> +TEST="KEXEC_FILE_LOAD"
> +. ./ima_common_lib.sh
> +
> +trap "{ rm -f $IKCONFIG ; }" EXIT
> +
> +# Some of the IMA builtin policies may require the kexec kernel image to
> +# be signed, but these policy rules may be replaced with a custom
> +# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS persists after
> +# loading a custom policy.  Check if it is enabled, before reading the
> +# IMA runtime sysfs policy file.
> +# Return 1 for IMA signature required and 0 for not required.
> +is_ima_sig_required()
> +{
> +	local ret=0
> +
> +	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
> +		"IMA kernel image signature required"
> +	if [ $? -eq 1 ]; then
> +		log_info "IMA signature required"
> +		return 1
> +	fi
> +
> +	# The architecture specific or a custom policy may require the
> +	# kexec kernel image be signed.  Policy rules are walked
> +	# sequentially.  As a result, a policy rule may be defined, but
> +	# might not necessarily be used.  This test assumes if a policy
> +	# rule is specified, that is the intent.
> +	if [ $ima_read_policy -eq 1 ]; then
> +		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
> +			"appraise_type=imasig"
> +		ret=$?
> +		[ $ret -eq 1 ] && log_info "IMA signature required";
> +	fi
> +	return $ret
> +}
> +
> +# The kexec_file_load_test() is complicated enough, require pesign.
> +# Return 1 for PE signature found and 0 for not found.
> +check_for_pesig()
> +{
> +	which pesign > /dev/null 2>&1 || log_skip "pesign not found"
> +
> +	pesign -i $KERNEL_IMAGE --show-signature | grep -q "No signatures"
> +	local ret=$?
> +	if [ $ret -eq 1 ]; then
> +		log_info "kexec kernel image PE signed"
> +	else
> +		log_info "kexec kernel image not PE signed"
> +	fi
> +	return $ret
> +}
> +
> +# The kexec_file_load_test() is complicated enough, require getfattr.
> +# Return 1 for IMA signature found and 0 for not found.
> +check_for_imasig()
> +{
> +	local ret=0
> +
> +	which getfattr > /dev/null 2>&1
> +	if [ $?	-eq 1 ]; then
> +		log_skip "getfattr not found"
> +	fi
> +
> +	line=$(getfattr -n security.ima -e hex --absolute-names $KERNEL_IMAGE 2>&1)
> +	echo $line | grep -q "security.ima=0x03"
> +	if [ $? -eq 0 ]; then
> +		ret=1
> +		log_info "kexec kernel image IMA signed"
> +	else
> +		log_info "kexec kernel image not IMA signed"
> +	fi
> +	return $ret
> +}
> +
> +kexec_file_load_test()
> +{
> +	local succeed_msg="kexec_file_load succeeded"
> +	local failed_msg="kexec_file_load failed"
> +	local key_msg="try enabling the CONFIG_INTEGRITY_PLATFORM_KEYRING"
> +
> +	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
> +
> +	if [ $? -eq 0 ]; then
> +		kexec --unload --kexec-file-syscall
> +
> +		# In secureboot mode with an architecture  specific
> +		# policy, make sure either an IMA or PE signature exists.
> +		if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] && \
> +			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ]; then
> +			log_fail "$succeed_msg (missing sig)"
> +		fi
> +
> +		if [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
> +			log_fail "$succeed_msg (missing PE sig)"
> +		fi
> +
> +		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
> +			log_fail "$succeed_msg (missing IMA sig)"
> +		fi
> +
> +		if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
> +		    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
> +			log_fail "$succeed_msg (possibly missing IMA sig)"
> +		fi
> +
> +		log_pass "$succeed_msg"
> +	fi
> +
> +	# Check the reason for the kexec_file_load failure
> +	echo $line | grep -q "Required key not available"
> +	if [ $? -eq 0 ]; then
> +		if [ $platform_keyring -eq 0 ]; then
> +			log_pass "$failed_msg (-ENOKEY), $key_msg"
> +		else
> +			log_pass "$failed_msg (-ENOKEY)"
> +		fi
> +	fi
> +
> +	if [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
> +		log_pass "$failed_msg (missing PE sig)"
> +	fi
> +
> +	if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
> +		log_pass "$failed_msg (missing IMA sig)"
> +	fi
> +
> +	if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
> +	    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
> +		log_pass "$failed_msg (possibly missing IMA sig)"
> +	fi
> +
> +	log_pass "$failed_msg"
> +	return 0
> +}
> +
> +# kexec requires root privileges
> +require_root_privileges
> +
> +# get the kernel config
> +get_kconfig
> +
> +# Determine which kernel config options are enabled
> +kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
> +	"architecture specific policy enabled"
> +arch_policy=$?
> +
> +kconfig_enabled "CONFIG_INTEGRITY_PLATFORM_KEYRING=y" \
> +	"platform keyring enabled"
> +platform_keyring=$?
> +
> +kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
> +ima_read_policy=$?
> +
> +kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
> +	"PE signed kernel image required"
> +pe_sig_required=$?
> +
> +is_ima_sig_required
> +ima_sig_required=$?
> +
> +get_secureboot_mode
> +secureboot=$?
> +
> +if [ $secureboot -eq 0 ] && [ $arch_policy -eq 0 ] && \
> +   [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] && \
> +   [ $ima_read_policy -eq 1 ]; then
> +	log_skip "No signature verification required"
> +fi
> +
> +# Are there pe and ima signatures
> +check_for_pesig
> +pe_signed=$?
> +
> +check_for_imasig
> +ima_signed=$?
> +
> +# Test loading the kernel image via kexec_file_load syscall
> +kexec_file_load_test
> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index b2ecd196b382..c6f7e0957c58 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -14,7 +14,6 @@ get_secureboot_mode
>  secureboot=$?
>  
>  # kexec_load should fail in secure boot mode
> -KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
>  kexec --load $KERNEL_IMAGE 2>&1 > /dev/null
>  if [ $? -eq 0 ]; then
>  	kexec --unload
> -- 
> 2.7.5
> 

Thanks
Dave
