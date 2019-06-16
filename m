Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B2C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462E921473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JAcmLDvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFPIVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:21:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3414 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfFPIVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:21:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45RS3P5Wz2z9v19q;
        Sun, 16 Jun 2019 10:21:05 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JAcmLDvt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OfUt7G1n3Fr2; Sun, 16 Jun 2019 10:21:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45RS3P4GXPz9v19n;
        Sun, 16 Jun 2019 10:21:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560673265; bh=1SrBWoXlclcq/cUIT3RSqtbhC9U/JqjMj1hkhPdAGfc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JAcmLDvtikWnCc0qk3wwmvIx5s+X1XIF3kGGVFj05NirrMOD5XA/MYyYSbNlfoGkr
         6setvLyqHSqLbKLJdMkmifsiBDAQYBwqJtD8swRfT5kOQecmmbVNmbytPdUREIeK6q
         e7IQHnpQGcOtYO4QD28PAut5cm1wUmo38t6SuhZE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 72E808B7D1;
        Sun, 16 Jun 2019 10:21:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QnD6C3CT-bfe; Sun, 16 Jun 2019 10:21:08 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9A958B7CD;
        Sun, 16 Jun 2019 10:21:07 +0200 (CEST)
Subject: Re: [PATCH] powerpc/mm/32s: only use MMU to mark initmem NX if
 STRICT_KERNEL_RWX
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 <8736kb9fry.fsf_-_@igel.home>
 <20190615152559.Horde.0lTFIZALxZ-RI75z94G3jA8@messagerie.si.c-s.fr>
 <87pnne9aqo.fsf@igel.home>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <7dd94b1c-08cb-c6ac-83c1-5b67a3dad2d8@c-s.fr>
Date:   Sun, 16 Jun 2019 10:06:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <87pnne9aqo.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190616-0, 16/06/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/06/2019 à 16:36, Andreas Schwab a écrit :
> On Jun 15 2019, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> Andreas Schwab <schwab@linux-m68k.org> a écrit :
>>
>>> If STRICT_KERNEL_RWX is disabled, never use the MMU to mark initmen
>>> nonexecutable.
>>
>> I dont understand, can you elaborate ?
> 
> It breaks suspend.

Ok, but we need to explain why it breaks suspend, and again your patch 
is wrong anyway because that area of memory is mapped with BATs so you 
can't use change_page_attr()

> 
>> This area is mapped with BATs so using change_page_attr() is pointless.
> 
> There must be a reason STRICT_KERNEL_RWX is not available with
> HIBERNATE.

Yes but HIBERNATE and suspend are not the same thing. I guess HIBERNATE 
is not available with STRICT_KERNEL_RWX because HIBERNATE have to write 
back saved state into read-only memory as well.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

