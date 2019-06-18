Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7E4C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACAC2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfFRMbh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:31:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:31:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45SnWN5bq5z9s9y;
        Tue, 18 Jun 2019 22:31:28 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, erhard_f@mailbox.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix initial setup of segment registers on secondary CPU
In-Reply-To: <b60946f5-dc70-61ce-e266-af91890cb702@c-s.fr>
References: <be07403806abc56ec027f6d47468411876e18bb5.1560267983.git.christophe.leroy@c-s.fr> <b60946f5-dc70-61ce-e266-af91890cb702@c-s.fr>
Date:   Tue, 18 Jun 2019 22:31:26 +1000
Message-ID: <87h88noz1d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 11/06/2019 à 17:47, Christophe Leroy a écrit :
>> The patch referenced below moved the loading of segment registers
>> out of load_up_mmu() in order to do it earlier in the boot sequence.
>> However, the secondary CPU still needs it to be done when loading up
>> the MMU.
>> 
>> Reported-by: Erhard F. <erhard_f@mailbox.org>
>> Fixes: 215b823707ce ("powerpc/32s: set up an early static hash table for KASAN")
>
> Cc: stable@vger.kernel.org

Sorry patchwork didn't pick that up and I missed it. The AUTOSEL bot
will probably pick it up anyway though.

cheers

>> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
>> index 1d5f1bd0dacd..f255e22184b4 100644
>> --- a/arch/powerpc/kernel/head_32.S
>> +++ b/arch/powerpc/kernel/head_32.S
>> @@ -752,6 +752,7 @@ __secondary_start:
>>   	stw	r0,0(r3)
>>   
>>   	/* load up the MMU */
>> +	bl	load_segment_registers
>>   	bl	load_up_mmu
>>   
>>   	/* ptr to phys current thread */
>> 
