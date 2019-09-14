Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4320640
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 16:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="h6zRP2Ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfINQvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 12:51:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17011 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfINQvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 12:51:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Vz6T5ggMz9tycq;
        Sat, 14 Sep 2019 18:51:13 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=h6zRP2Ck; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XHDQc381JH2O; Sat, 14 Sep 2019 18:51:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Vz6T4ZRyz9tycp;
        Sat, 14 Sep 2019 18:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568479873; bh=LWujgpcYct92yuUDaXEeUAyD2wFvAtFvepKoZtQnzKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h6zRP2CkSx1dpu3chBbomnZh98BnpdMH1DKk++Q7zW7HWQxtVHU7WcR+u5U3s/e/w
         XlaFmz0dW+i+BoTxvHsUGm742A6pFuaZph4mjvWhYifQ6FCMt74XyUa824uaJEvpJM
         q0/sFYtJt/1a2PMh7xZGxnRjFtCvd4luYASDiVHQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 507C58B80B;
        Sat, 14 Sep 2019 18:51:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BOzyotLb7U4A; Sat, 14 Sep 2019 18:51:15 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 681C88B756;
        Sat, 14 Sep 2019 18:51:14 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc/83xx: map IMMR with a BAT.
To:     Scott Wood <oss@buserror.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b51b96090138aba1920d2cf7c0e0e348667f9a69.1566564560.git.christophe.leroy@c-s.fr>
 <331759c1bcba5797d30f8eace74afb16ac5f3c36.1566564560.git.christophe.leroy@c-s.fr>
 <b201df6242e7f6cebd525e0a301eef2afdb38f30.camel@buserror.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e9437d8c-564e-cc76-e8fd-54e4000c2349@c-s.fr>
Date:   Sat, 14 Sep 2019 18:51:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b201df6242e7f6cebd525e0a301eef2afdb38f30.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/09/2019 à 16:34, Scott Wood a écrit :
> On Fri, 2019-08-23 at 12:50 +0000, Christophe Leroy wrote:
>> On mpc83xx with a QE, IMMR is 2Mbytes.
>> On mpc83xx without a QE, IMMR is 1Mbytes.
>> Each driver will map a part of it to access the registers it needs.
>> Some driver will map the same part of IMMR as other drivers.
>>
>> In order to reduce TLB misses, map the full IMMR with a BAT.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/platforms/83xx/misc.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/83xx/misc.c
>> b/arch/powerpc/platforms/83xx/misc.c
>> index f46d7bf3b140..1e395b01c535 100644
>> --- a/arch/powerpc/platforms/83xx/misc.c
>> +++ b/arch/powerpc/platforms/83xx/misc.c
>> @@ -18,6 +18,8 @@
>>   #include <sysdev/fsl_soc.h>
>>   #include <sysdev/fsl_pci.h>
>>   
>> +#include <mm/mmu_decl.h>
>> +
>>   #include "mpc83xx.h"
>>   
>>   static __be32 __iomem *restart_reg_base;
>> @@ -145,6 +147,14 @@ void __init mpc83xx_setup_arch(void)
>>   	if (ppc_md.progress)
>>   		ppc_md.progress("mpc83xx_setup_arch()", 0);
>>   
>> +	if (!__map_without_bats) {
>> +		int immrsize = IS_ENABLED(CONFIG_QUICC_ENGINE) ? SZ_2M :
>> SZ_1M;
> 
> Any reason not to unconditionally make it 2M?  After all, the kernel being
> built with CONFIG_QUICC_ENGINE doesn't mean that the hardware you're running
> on has it...
> 

Euh .. ok. I didn't see it that way, but you are right.

Do you think it is not a problem to map 2M even when the quicc engine is 
not there ? Or should it check device tree instead ?

Christophe
