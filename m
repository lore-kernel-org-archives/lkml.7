Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC6CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBBC20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KyEn44Cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfKEGEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:04:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32010 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbfKEGEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:04:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 476fHm3bMCz9vBhW;
        Tue,  5 Nov 2019 07:04:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=KyEn44Cv; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bejW4i8ArN-f; Tue,  5 Nov 2019 07:04:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 476fHm0pfBz9vBhF;
        Tue,  5 Nov 2019 07:04:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572933844; bh=PeaCk2RM7ni/Qntm+XOM7dRGcnogK0Sbq44rYc/HpuU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KyEn44CvaCa8j0axto9vX0/fxpQkhypUIXYb4isqyYXIJ2G0IE6HS26IzquBC5WO+
         tzdya5ntaMhkh5qMI/o1gjvODTjcK/dVhqbcWGmQp3QJVK+pnmOrKEQHkkApnFCvEV
         DE+lfFywsNr7DDcwdwq7hfwnwQPqnrguP/LZA/bY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D98818B787;
        Tue,  5 Nov 2019 07:04:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id z_R164XR8XJY; Tue,  5 Nov 2019 07:04:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C1AD8B752;
        Tue,  5 Nov 2019 07:04:04 +0100 (CET)
Subject: Re: [PATCH v5 1/6] powerpc: Allow flush_icache_range to work across
 ranges >4GB
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Alastair D'Silva <alastair@au1.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>, alastair@d-silva.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
References: <20191104023305.9581-1-alastair@au1.ibm.com>
 <20191104023305.9581-2-alastair@au1.ibm.com>
 <20191104194357.GE16031@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <74435ba6-51dc-1dff-b55b-cdcf85e2e302@c-s.fr>
Date:   Tue, 5 Nov 2019 07:04:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104194357.GE16031@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/11/2019 à 20:43, Segher Boessenkool a écrit :
> On Mon, Nov 04, 2019 at 01:32:53PM +1100, Alastair D'Silva wrote:
>> When calling flush_icache_range with a size >4GB, we were masking
>> off the upper 32 bits, so we would incorrectly flush a range smaller
>> than intended.
>>
>> This patch replaces the 32 bit shifts with 64 bit ones, so that
>> the full size is accounted for.
> 
> Please send this separately, to be committed right now?  It is a bug fix,
> independent of the rest of the series.
> 

Patch 4/6 needs it, as it drops the function.

Or do you mean that the series should drop the assembly at once, and 
this patch should only go into stable ?

But I guess mpe can take this patch alone if he wants to ?

By the way, Patch 2/6 is also a bugfix.

Christophe
