Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46442C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266952080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfH0CNy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:13:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfH0CNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:13:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46HXVR3PjFz9s7T;
        Tue, 27 Aug 2019 12:13:51 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/time: use feature fixup in __USE_RTC() instead of cpu feature.
In-Reply-To: <ba2a7a1f-8dcc-ec44-81d4-ef11a9e29377@c-s.fr>
References: <55c267ac6e0cd289970accfafbf9dda11a324c2e.1566802736.git.christophe.leroy@c-s.fr> <87blwc40i4.fsf@concordia.ellerman.id.au> <ba2a7a1f-8dcc-ec44-81d4-ef11a9e29377@c-s.fr>
Date:   Tue, 27 Aug 2019 12:13:51 +1000
Message-ID: <87v9uj2w4g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 26/08/2019 à 13:41, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> sched_clock(), used by printk(), calls __USE_RTC() to know
>>> whether to use realtime clock or timebase.
>>>
>>> __USE_RTC() uses cpu_has_feature() which is initialised by
>>> machine_init(). Before machine_init(), __USE_RTC() returns true,
>>> leading to a program check exception on CPUs not having realtime
>>> clock.
>>>
>>> In order to be able to use printk() earlier, use feature fixup.
>>> Feature fixups are applies in early_init(), enabling the use of
>>> printk() earlier.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/include/asm/time.h | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> The other option would be just to make this a compile time decision, eg.
>> add CONFIG_PPC_601 and use that to gate whether we use RTC.
>
> Euh ... yes OK, why not. And that would help simplify many places in the 
> code. I can propose something in that direction, but it will be a bigger 
> change.

Thanks.

>> Given how many 601 users there are, maybe 1?, I think that would be a
>> simpler option and avoids complicating the code / binary for everyone
>> else.
>
> However this patch doesn't complicate things more than it was with 
> cpu_has_feature() which does exactly the same but using static keys, 
> does it ?

It's more complicated in that it's not using cpu_has_feature() it's
doing some custom thing that is not used anywhere else. But yeah I guess
it's not much extra complication.

cheers
