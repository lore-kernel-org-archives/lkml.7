Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B33206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hh3nrgum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNRqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:46:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33888 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfKNRp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:45:59 -0500
Received: from zn.tnic (p200300EC2F15E200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:e200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B6D681EC0D02;
        Thu, 14 Nov 2019 18:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573753558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dMxWFL2TbjZLb7rXJaLl+G5u+L/Mktmd+xyqmeN1QDI=;
        b=hh3nrgumBd6Zps1jzwBAbHYn6oSLPikrA+QGDX/EM5j+YJKseYBCXFXkphjB0oh+087X7j
        A1oaBDrVRH8BYWBLS47stClt8Ig9XrUM9Om1oeusvj/nS734PwbI+dQY3P+j0//HW0znxa
        alyVLQII55cp9kinyuAiNMPBNOrVB2A=
Date:   Thu, 14 Nov 2019 18:45:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
Message-ID: <20191114174553.GC7222@zn.tnic>
References: <20191113193350.24511-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191113193350.24511-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:33:50PM -0500, Waiman Long wrote:
> For MDS vulnerable processors with TSX support, enabling either MDS
> or TAA mitigations will enable the use of VERW to flush internal
> processor buffers at the right code path. IOW, they are either both
> mitigated or both not mitigated. However, if the command line options
> are inconsistent, the vulnerabilites sysfs files may not report the
> mitigation status correctly.
> 
> For example, with only the "mds=off" option:
> 
>   vulnerabilities/mds:Vulnerable; SMT vulnerable
>   vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT vulnerable
> 
> The mds vulnerabilities file has wrong status in this case.
> 
> Change taa_select_mitigation() to sync up the two mitigation status
> and have them turned off if both "mds=off" and "tsx_async_abort=off"
> are present.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 4c7b0fa15a19..418d41c1fd0d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -304,8 +304,12 @@ static void __init taa_select_mitigation(void)
>  		return;
>  	}
>  
> -	/* TAA mitigation is turned off on the cmdline (tsx_async_abort=off) */
> -	if (taa_mitigation == TAA_MITIGATION_OFF)
> +	/*
> +	 * TAA mitigation via VERW is turned off if both
> +	 * tsx_async_abort=off and mds=off are specified.
> +	 */

So this changes the dependency of switches so if anything, it should be
properly documented first in all three:

Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
Documentation/x86/tsx_async_abort.rst
Documentation/admin-guide/kernel-parameters.txt

However, before we do that, we need to agree on functionality:

Will the mitigations be disabled only with *both* =off supplied on the
command line or should the mitigations be disabled when *any* of the two
=off is supplied?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
