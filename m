Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5FBCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200BD2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TpSeXOFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbfJ2QKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:10:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17867 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390165AbfJ2QK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:10:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 472c4g1g6lz9v10P;
        Tue, 29 Oct 2019 17:10:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TpSeXOFU; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UpHV0XhQAQYQ; Tue, 29 Oct 2019 17:10:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 472c4g0Tzcz9v10L;
        Tue, 29 Oct 2019 17:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572365427; bh=tYE4s7/uuajXlCR0ChE0EZH9O5AUjNkXcOLUIcjs8NY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TpSeXOFUE6NM+JYOdlv64UW/+4WUPFrGoh6k/O+xW8QDuERdgv/D7VGAmufQO+FN1
         fIXCp5L6bMBYoYiAfV/u7tcK2KH038p2p1K3CJmCtNvTTH7ywxZIjUCdosgqOj4iTS
         MwKfe1IXwrU0ed97mqGh403IgJyyisv4QNCd1O+s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96B7E8B86F;
        Tue, 29 Oct 2019 17:10:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7udaYobtxUaO; Tue, 29 Oct 2019 17:10:28 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 35F7F8B86A;
        Tue, 29 Oct 2019 17:10:28 +0100 (CET)
Subject: Re: [PATCH v2 1/8] powerpc/32: Add VDSO version of getcpu
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1566491310.git.christophe.leroy@c-s.fr>
 <27d699092118ee8d21741c08a6ff7e4c65effdf2.1566491310.git.christophe.leroy@c-s.fr>
 <87h85aw3r9.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5088c94c-3c80-0799-08a2-f1d53b95380b@c-s.fr>
Date:   Tue, 29 Oct 2019 17:10:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87h85aw3r9.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/09/2019 à 07:51, Michael Ellerman a écrit :
> 
> We are still in the middle of the years long process of removing the
> "magic" syscall on 64-bit:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/exceptions-64s.S?commit=4d856f72c10ecb060868ed10ff1b1453943fc6c8#n1578
>   
> 
> Can we not add another one on 32-bit?
> 
> Is it really such a fast path that it's worth putting a wart in the
> syscall entry like that?
> 
> Is there some other method? On s390 they have a per-cpu VDSO page, that
> would be a nice option. How we do that would be specific to a particular
> MMU, and maybe not even possible with some MMUs. So maybe that's not
> feasible.

Ok, for now I remove the fast syscall and only keep the VDSO getcpu() 
for non SMP.

I think we may in the future implement a per-cpu VDSO page that will be 
mapped to the process based on the CPU it is running on. I need to look 
at that in more details.

Christophe

