Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423F921925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="DxDL2E1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504492AbfJRGqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:46:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4012 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729874AbfJRGqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:46:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46vc575gL6z9tx5X;
        Fri, 18 Oct 2019 08:46:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=DxDL2E1z; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5bIBQRCKtIeI; Fri, 18 Oct 2019 08:46:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46vc573HzLz9tx5W;
        Fri, 18 Oct 2019 08:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1571381195; bh=WX90bdaoMzCs8xgA6+HCzypTGmxEze3UiLIKlr3SbAk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DxDL2E1zMxM1TWOEpFPlwlooaWacpBagZemhaeBhio5n+GGv9qMDxq16uNOQE26PL
         k00ZABQ6t1TiRuJiRhsa7L7IE+eV7lgtxBHM9F6YiFJXEXvavOCVzL0sC3179JXwYh
         l6Sm893qB4b4UcnvtyU7FL31sfNHktTKQ3JuikHA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68C658B7E5;
        Fri, 18 Oct 2019 08:46:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hZxqJFrAxSt1; Fri, 18 Oct 2019 08:46:36 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A888B8B7DE;
        Fri, 18 Oct 2019 08:46:35 +0200 (CEST)
Subject: Re: [PATCH v3 06/15] powerpc/32: prepare for CONFIG_VMAP_STACK
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
References: <cover.1568106758.git.christophe.leroy@c-s.fr>
 <7e9771a56539c58dcd8a871c3dfbe7a932e427b0.1568106758.git.christophe.leroy@c-s.fr>
 <d181b762-3e7b-7a0a-2505-54ead241456d@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <baff8ef3-a3c6-c6e2-732f-4d521d92140b@c-s.fr>
Date:   Fri, 18 Oct 2019 08:46:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d181b762-3e7b-7a0a-2505-54ead241456d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/10/2019 à 09:36, Andrew Donnellan a écrit :
> On 10/9/19 7:16 pm, Christophe Leroy wrote:
>> +#if defined(CONFIG_VMAP_STACK) && CONFIG_THREAD_SHIFT < PAGE_SHIFT
>> +#define THREAD_SHIFT        PAGE_SHIFT
>> +#else
>>   #define THREAD_SHIFT        CONFIG_THREAD_SHIFT
>> +#endif
>>
>>   #define THREAD_SIZE        (1 << THREAD_SHIFT)
>>
> 
> Looking at 64-bit book3s: with 64K pages, this results in a THREAD_SIZE 
> that's too large for immediate mode arithmetic operations, which is 
> annoying. Hmm.
> 

Which operation are you thinking about ?

For instance, 'addi' can't be used anymore, but 'addis' can.

Christophe
