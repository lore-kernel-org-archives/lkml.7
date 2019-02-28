Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E4DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E92420C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbfB1VB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:01:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbfB1VB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:01:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44579B152;
        Thu, 28 Feb 2019 21:01:56 +0000 (UTC)
Date:   Thu, 28 Feb 2019 22:01:54 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] selftests/ima: define common logging functions
Message-ID: <20190228210154.GA28402@dell5510>
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  tools/testing/selftests/ima/common_lib.sh      | 43 +++++++++++++++++++++++---
>  tools/testing/selftests/ima/test_kexec_load.sh | 19 +++---------
>  2 files changed, 43 insertions(+), 19 deletions(-)

...
> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> index 5583ea74c14e..c6d04006281d 100755
> --- a/tools/testing/selftests/ima/common_lib.sh
...
>  	# Get secureboot mode
>  	local file="$efivarfs/../vars/SecureBoot-*/data"
>  	if [ ! -e $file ]; then
> -		echo "$TEST: unknown secureboot mode" >&2
> -		exit $ksft_skip
> +		log_skip "unknown secureboot mode"
>  	fi
> -	return `od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data`
> +	ret=`od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data`
Missing local. Usually it's good to put all locals at the top.

> +	[ $ret -eq 1 ] && log_info "secure boot mode enabled"
> +
> +	return $ret
>  }
...

Kind regards,
Petr
