Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF57C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfCKVjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:39:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfCKVjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:39:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEC5AABC3;
        Mon, 11 Mar 2019 21:39:30 +0000 (UTC)
Date:   Mon, 11 Mar 2019 22:39:29 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v3 2/7] selftests/ima: define a set of common functions
Message-ID: <20190311213929.GA13024@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
 <1552304473-3966-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552304473-3966-3-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> Define, update and move get_secureboot_mode() to a common file for use
> by other tests.

> Updated to check both the efivar SecureBoot-$(UUID) and
> SetupMode-$(UUID), based on Dave Young's review.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Cc: Dave Young <dyoung@redhat.com>

Minor comment below.

...
> +++ b/tools/testing/selftests/ima/ima_common_lib.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
> +# The secure boot mode can be accessed either as the last integer
> +# of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
> +# "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".  The efi
> +# SetupMode can be similarly accessed.
> +# Return 1 for SecureBoot mode enabled and SetupMode mode disabled.
> +get_secureboot_mode()
> +{
> +	local efivarfs="/sys/firmware/efi/efivars"
> +	local secure_boot_file=$efivarfs/../vars/SecureBoot-*/data
> +	local setup_mode_file=$efivarfs/../vars/SetupMode-*/data
Sorry for nitpicking, but also quote variables these two variables
containing string:
	local secure_boot_file="$efivarfs/../vars/SecureBoot-*/data"
	local setup_mode_file="$efivarfs/../vars/SetupMode-*/data"

> +	local secureboot_mode=0
> +	local setup_mode=0
> +
> +	# Make sure that efivars is mounted in the normal location
> +	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
> +		log_skip "efivars is not mounted on $efivarfs"
> +	fi
> +
> +	if [ ! -e $secure_boot_file ] || [ ! -e $setup_mode_file ]; then
I prefer to quote every variable in [ ] (at least for -f -e -z -n,
to prevent shell behavior on empty (I know it's not necessary here):

f=; [ -e $f ]; echo $?
0
vs.
f=; [ -e "$f" ]; echo $?
1


Kind regards,
Petr
