Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E47CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0CB218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfB1WAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:00:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:48218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfB1WAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6584AF26;
        Thu, 28 Feb 2019 22:00:41 +0000 (UTC)
Date:   Thu, 28 Feb 2019 23:00:39 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] selftests/ima: kexec_file_load syscall test
Message-ID: <20190228220039.GC20335@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-5-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551223620-11586-5-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> The kernel can be configured to verify PE signed kernel images, IMA
> kernel image signatures, both types of signatures, or none.  This test
> verifies only properly signed kernel images are loaded into memory,
> based on the kernel configuration and runtime policies.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, minor comments below.
...
> +++ b/tools/testing/selftests/ima/common_lib.sh
...
> +# Look for config option in Kconfig file.
> +# Return 1 for found and 0 for not found.
> +kconfig_enabled()
> +{
> +	local config="$1"
> +	local msg="$2"
> +
Mixing tabs and spaces (spaces below).
> +        grep -E -q $config $IKCONFIG
> +        if [ $? -eq 0 ]; then
> +                log_info "$msg"
> +                return 1
> +        fi
> +        return 0
> +}
> +
> +# Attempt to get the kernel config first via proc, and then by
> +# extracting it from the kernel image or the configs.ko using
> +# scripts/extract-ikconfig.
> +# Return 1 for found and 0 for not found.
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
		log_fail "$SECURITYFS: securityfs is not mounted"
> +	fi
> +}
> +
> +# The policy rule format is an "action" followed by key-value pairs.  This
> +# function supports up to two key-value pairs, in any order.
> +# For example: action func=<keyword> [appraise_type=<type>]
> +# Return 1 for found and 0 for not found.
> +check_ima_policy()
> +{
> +	local action=$1
	local action="$1"
(sorry this is nitpicking, I'd be consistent)
> +	local keypair1="$2"
> +	local keypair2="$3"
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
> +	[ $? -eq 0 ] && ret=1 || ret=0
> +        return $ret
return $? is enough here (+ ret was not defined as local and mixing tabs with spaces)
> +}
> diff --git a/tools/testing/selftests/ima/test_kexec_file_load.sh b/tools/testing/selftests/ima/test_kexec_file_load.sh
> new file mode 100755
> index 000000000000..e08c7e6cf28c
> --- /dev/null
> +++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
...

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
> +	which pesign > /dev/null 2>&1
> +	if [ $?	-eq 1 ]; then
> +		log_skip "pesign not found"
> +	fi
Maybe just (matter of preference)
	which pesign > /dev/null 2>&1 || log_skip "pesign not found"
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

...
> +# kexec requires root privileges
> +if [ $(id -ru) -ne 0 ]; then
> +	log_skip "requires root privileges"
> +fi
This is repeated several times => good candidate for helper even here in IMA
specific library.

Kind regards,
Petr
