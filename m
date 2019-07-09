Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B97AC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583BB2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ZpzLMaKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIFEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:04:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64154 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfGIFEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:04:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45jVcC5PPgz9txvr;
        Tue,  9 Jul 2019 07:04:43 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZpzLMaKe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NtE2ogjVIdW2; Tue,  9 Jul 2019 07:04:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45jVcC4Fgfz9txvj;
        Tue,  9 Jul 2019 07:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1562648683; bh=InD1pggxj7L0oiLqVKw9lp4Lo1SOo1AoAub535aBZZM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZpzLMaKeSsTH4l510UePhhSoJco41Adi8YKLtLj6kN1YJ3QaPifONfn9FoZgvJA5n
         nbn8J/K4v7W00iUT46j4RlPBFpK0PxwkA6vDPCtndy5SRTJj3OszjRUYDSJIOpVNZA
         S+XYnOoBUltwCHlbP6pHRMdQW0VRN4BCE1F1j9FY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 60CFC8B7C1;
        Tue,  9 Jul 2019 07:04:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LtvkpDjRKwoA; Tue,  9 Jul 2019 07:04:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 984448B756;
        Tue,  9 Jul 2019 07:04:43 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
 <45hnfp6SlLz9sP0@ozlabs.org> <20190708191416.GA21442@archlinux-threadripper>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
Date:   Tue, 9 Jul 2019 07:04:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708191416.GA21442@archlinux-threadripper>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/07/2019 à 21:14, Nathan Chancellor a écrit :
> On Mon, Jul 08, 2019 at 11:19:30AM +1000, Michael Ellerman wrote:
>> On Fri, 2019-05-10 at 09:24:48 UTC, Christophe Leroy wrote:
>>> Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
>>> that are summed to obtain the target address. Using 'Z' constraint
>>> and '%y0' argument gives GCC the opportunity to use both registers
>>> instead of only one with the second being forced to 0.
>>>
>>> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> Applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/6c5875843b87c3adea2beade9d1b8b3d4523900a
>>
>> cheers
> 
> This patch causes a regression with clang:

Is that a Clang bug ?

Do you have a disassembly of the code both with and without this patch 
in order to compare ?

Segher, any idea ?

Christophe

> 
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/213944668
> 
> I've attached my local bisect/build log.
> 
> Cheers,
> Nathan
> 
