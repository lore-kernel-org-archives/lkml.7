Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9815CC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625612133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfB1Wc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:32:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:54060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfB1Wc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:32:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B884B618;
        Thu, 28 Feb 2019 22:32:57 +0000 (UTC)
Date:   Thu, 28 Feb 2019 23:32:55 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] selftests/ima: loading kernel modules
Message-ID: <20190228223255.GE20335@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> While the appended kernel module signature can be verified, when loading
> a kernel module via either the init_module or the finit_module syscall,
> verifying the IMA signature requires access to the file descriptor,
> which is only available via the finit_module syscall.  As "modprobe"
> does not provide a flag allowing the syscall - init_module or
> finit_module - to be specified, this patch does not load a kernel
> module.

> This test simply verifies that on secure boot enabled systems with
> "CONFIG_IMA_ARCH_POLICY" configured, that at least an appended kernel
> module signature or an IMA signature is required based on the Kconfig
> and the runtime IMA policy.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> diff --git a/tools/testing/selftests/ima/test_kernel_module.sh b/tools/testing/selftests/ima/test_kernel_module.sh
...
> +# Are appended signatures required?
> +if [ -e /sys/module/module/parameters/sig_enforce ]; then
> +	sig_enforce=$(cat /sys/module/module/parameters/sig_enforce)
> +	if [ $sig_enforce = "Y" ]; then
> +		log_pass "appended kernel module signature required"
> +	fi
> +fi
Another possible helper [1]:
is_enabled() # or sysfs_enabled
{
	[ -f "$1" ] && [ "$(cat $1)" = "Y" -o "$(cat $1)" = "1" ]
}

is_enabled /sys/module/module/parameters/sig_enforce && \
	log_pass "appended kernel module signature required"

...


Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/ver_linux#L30
