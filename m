Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F7C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1442D206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hVMA8BWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391281AbfIPUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:18:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30184 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbfIPUSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:18:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46XHcG4XQtz9v0sm;
        Mon, 16 Sep 2019 22:18:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hVMA8BWM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PiOu49LYUBUM; Mon, 16 Sep 2019 22:18:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46XHcG3Kwbz9v0sl;
        Mon, 16 Sep 2019 22:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568665086; bh=Oc7QqPHRv6G+INGV1Il1EHOkAwSu+426AB7PrqORGOw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hVMA8BWMLx4Af6rO3TbEdlG8FAACNgino3PlfsJ6UbnnHqfodpDS47p3L0wv3bzdJ
         tWtTahLLvFF6DpMJ83xBvrK5i+bBzzrw5R41KVE6wA4+HCKiDHnmJzGq9SUIkd5x4A
         76snh5V+b6gSdxZ9XPoYKfvLqkGwS1tQfaUSxlYU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 768C28B847;
        Mon, 16 Sep 2019 22:18:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id t6Ds54bdJKMc; Mon, 16 Sep 2019 22:18:06 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E00FE8B841;
        Mon, 16 Sep 2019 22:18:05 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] powerpc/83xx: map IMMR with a BAT.
To:     Scott Wood <oss@buserror.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <966e6d6a226f9786098d296239a6c65064e73a41.1568616151.git.christophe.leroy@c-s.fr>
 <7f8f9747ef1ab2e1261cf83b03c1da321d47f7b7.1568616151.git.christophe.leroy@c-s.fr>
 <71490f3b94b851106eb48c8909239f401d0018d1.camel@buserror.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <faa12987-1c3d-b554-de03-cb1be34112ad@c-s.fr>
Date:   Mon, 16 Sep 2019 22:18:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <71490f3b94b851106eb48c8909239f401d0018d1.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/09/2019 à 17:04, Scott Wood a écrit :
> On Mon, 2019-09-16 at 06:42 +0000, Christophe Leroy wrote:
>> @@ -145,6 +147,15 @@ void __init mpc83xx_setup_arch(void)
>>   	if (ppc_md.progress)
>>   		ppc_md.progress("mpc83xx_setup_arch()", 0);
>>   
>> +	if (!__map_without_bats) {
>> +		phys_addr_t immrbase = get_immrbase();
>> +		int immrsize = IS_ALIGNED(immrbase, SZ_2M) ? SZ_2M : SZ_1M;
>> +		unsigned long va = __fix_to_virt(FIX_IMMR_BASE);
> 
> Why __fix_to_virt() and not fix_to_virt()?
> 

Euh ... because I copy/pasted it from 
/arch/powerpc/include/asm/nohash/32/mmu-8xx.h

But yes I can do fix_to_virt() instead.

Christophe
