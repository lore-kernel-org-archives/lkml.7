Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A18C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofWNWZl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDLXfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:35:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfDLXfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Ie8IMlCBHl6YexMqcUcjA+Mwa9TNteGTWTgFNyIq+I=; b=ofWNWZl0k3jkrT/YYMFQ2M9jb2
        dTjq3V2vnbaMt/GbrB8qzg+wF4/hNEwgYL1ilMX4XlsiZumZZHJleTZwy2yPCWDEu93T7oJ8jGg8h
        ENafQM+LniuMmjYyLcsXYxUZwBA2PU55tb/PpI/+9wQ5jU3QxEaM0UgxY/agdsDMmoAm1rwUkCKPD
        tIoX+cem/Ihd3q+yx76ENW928PkLPE5Gt5Ok4Ezt/YM5CUBvhyLVDcyHfWd/9vvDfekiQqlKbBUqp
        PeaE9izRcnis5XBp2G+iliMQEbIJr5y/9Vm0x0jijsW16m+11uglbS6mt7uRcJJDhjrAY387ePg2K
        4g8H/AYQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF5h6-0004XY-Vk; Fri, 12 Apr 2019 23:34:53 +0000
Subject: Re: [PATCH v2 5/5] arm64/speculation: Support 'mitigations=' cmdline
 option
To:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
Date:   Fri, 12 Apr 2019 16:34:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 1:39 PM, Josh Poimboeuf wrote:
> Configure arm64 runtime CPU speculation bug mitigations in accordance
> with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
> v2, and Speculative Store Bypass.
> 
> The default behavior is unchanged.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> NOTE: This is based on top of Jeremy Linton's patches:
>       https://lkml.kernel.org/r/20190410231237.52506-1-jeremy.linton@arm.com
> 
>  Documentation/admin-guide/kernel-parameters.txt | 8 +++++---
>  arch/arm64/kernel/cpu_errata.c                  | 6 +++++-
>  arch/arm64/kernel/cpufeature.c                  | 8 +++++++-
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e84a01d90e92..79bfc755defe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2545,8 +2545,8 @@
>  			http://repo.or.cz/w/linux-2.6/mini2440.git
>  
>  	mitigations=
> -			[X86,PPC,S390] Control optional mitigations for CPU
> -			vulnerabilities.  This is a set of curated,
> +			[X86,PPC,S390,ARM64] Control optional mitigations for
> +			CPU vulnerabilities.  This is a set of curated,
>  			arch-independent options, each of which is an
>  			aggregation of existing arch-specific options.
>  
> @@ -2555,11 +2555,13 @@
>  				improves system performance, but it may also
>  				expose users to several CPU vulnerabilities.
>  				Equivalent to: nopti [X86,PPC]
> +					       kpti=0 [ARM64]
>  					       nospectre_v1 [PPC]
>  					       nobp=0 [S390]
> -					       nospectre_v2 [X86,PPC,S390]
> +					       nospectre_v2 [X86,PPC,S390,ARM64]
>  					       spectre_v2_user=off [X86]
>  					       spec_store_bypass_disable=off [X86,PPC]
> +					       ssbd=force-off [ARM64]
>  					       l1tf=off [X86]
>  
>  			auto (default)

Hi,
Do we need to add "ARM64" to Documentation/admin-guide/kernel-parameters.rst?


-- 
~Randy
