Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF850C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D4A2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rwK+j9I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgAGLMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:12:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23057 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGLMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:12:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47sV8H0JFYz9txx7;
        Tue,  7 Jan 2020 12:12:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rwK+j9I7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jCejGDAUkE0B; Tue,  7 Jan 2020 12:12:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47sV8G6Gjxz9txwm;
        Tue,  7 Jan 2020 12:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1578395534; bh=la0IG0BtQexKSwezgArYwc5K8/b99Z1L+VnSv47ODLc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rwK+j9I7XkNWaOylEDE2KCxzXfqZgvT/A2AS/1e+wRBliIYY4p6PRjUta5+jxCPC2
         upYSQEeHEyqygFWNb0lC0WgWSgfdKBI+1y2NnIQQkE0wSwU/Dc6EdNZv2y78nVis4y
         4QTWTdh3H6XXi+0JW5kN3GtO0rVLYH9KkXykx6KE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 166578B7CF;
        Tue,  7 Jan 2020 12:12:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6iGsHtuS3ShE; Tue,  7 Jan 2020 12:12:16 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D9678B7BF;
        Tue,  7 Jan 2020 12:12:15 +0100 (CET)
Subject: Re: [PATCH] powerpc: add support for folded p4d page tables
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20191209150908.6207-1-rppt@kernel.org>
 <20200102081059.GA12063@rapoport-lnx>
 <20200102174231.Horde.vA_c3sSHB1vhx2H9Ce-i9Q1@messagerie.si.c-s.fr>
 <20200105070236.GA7261@rapoport-lnx>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <64856046-97d5-bb10-b5d1-e9fb857c6123@c-s.fr>
Date:   Tue, 7 Jan 2020 12:12:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200105070236.GA7261@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/01/2020 à 08:02, Mike Rapoport a écrit :
> On Thu, Jan 02, 2020 at 05:42:31PM +0100, Christophe Leroy wrote:
>> Mike Rapoport <rppt@kernel.org> a écrit :
>>
>>> Any updates on this?
>>
>> Checkpatch reported several points, see
>> https://patchwork.ozlabs.org/patch/1206344/
> 
> Well, for the most part checkpatch is unhappy because I've tried to keep
> the changes consistent with the old code. And, there are some lines over 90
> characters that do no seem worth breaking.
> 

Yes I see, many places we have stuff like:

pmd = pmd_offset(pud_offset(pgd_offset(mm, start), start), start);

I sent a patch to refactor that. This should help fixing that long line 
issue and reducing the number of lines impacted by your patch.

Christophe
