Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D31C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2A620700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfDEMry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:47:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfDEMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:47:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7E51AD2C;
        Fri,  5 Apr 2019 12:47:52 +0000 (UTC)
Date:   Fri, 5 Apr 2019 14:47:51 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] selftests/kexec: update get_secureboot_mode
Message-ID: <20190405124751.GA26595@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
 <1554300369.7309.59.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554300369.7309.59.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Some minor comments below.

...
> diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
...
>  # Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
> +# (Based on kdump-lib.sh)
> +get_efivarfs_secureboot_mode()
> +{
> +	local efivarfs="/sys/firmware/efi/efivars"
> +	local secure_boot_file=""
> +	local setup_mode_file=""
> +	local secureboot_mode=0
> +	local setup_mode=0
NOTE: variables does not need to be initialized (in both functions).
> +
> +	# Make sure that efivar_fs is mounted in the normal location
> +	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
> +		log_info "efivars is not mounted on $efivarfs"
> +		return 0;
> +	fi
> +	secure_boot_file=$(find "$efivarfs" -name SecureBoot-* 2>/dev/null)
> +	setup_mode_file=$(find "$efivarfs" -name SetupMode-* 2>/dev/null)
> +	if [ -f "$secure_boot_file" ] && [ -f "$setup_mode_file" ]; then
> +		secureboot_mode=$(hexdump -v -e '/1 "%d\ "' \
> +			"$secure_boot_file"|cut -d' ' -f 5)
> +		setup_mode=$(hexdump -v -e '/1 "%d\ "' \
> +			"$setup_mode_file"|cut -d' ' -f 5)
> +
> +		if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
> +			log_info "secure boot mode enabled (efivar_fs)"
Instead of efivar_fs maybe CONFIG_EFIVAR_FS or EFIVAR_FS?

> +			return 1;
> +		fi
> +	fi
> +	return 0;
> +}
> +
> +get_efi_var_secureboot_mode()
> +{
> +	local efi_vars="/sys/firmware/efi/vars"
> +	local secure_boot_file=""
> +	local setup_mode_file=""
> +	local secureboot_mode=0
> +	local setup_mode=0
> +
> +	if [ ! -d "$efi_vars" ]; then
> +		log_skip "efi_vars is not enabled\n"
> +		return 0;
Return is not needed (log_skip exits).
> +	fi
> +	secure_boot_file=$(find "$efi_vars" -name SecureBoot-* 2>/dev/null)
> +	setup_mode_file=$(find "$efi_vars" -name SetupMode-* 2>/dev/null)
> +	if [ -f "$secure_boot_file/data" ] && \
> +	   [ -f "$setup_mode_file/data" ]; then
> +		secureboot_mode=`od -An -t u1 "$secure_boot_file/data"`
> +		setup_mode=`od -An -t u1 "$setup_mode_file/data"`
> +
> +		if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
> +			log_info "secure boot mode enabled (efi_var)"
Instead of efi_var maybe CONFIG_EFI_VARS or EFI_VARS?

...

Kind regards,
Petr
