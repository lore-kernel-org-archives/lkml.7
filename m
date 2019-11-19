Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5AEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197E722318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKSRtu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:49:50 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39729 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfKSRtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:49:49 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47HYHb6zBXz9tyMG;
        Tue, 19 Nov 2019 18:49:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XqvRI0tj-P3k; Tue, 19 Nov 2019 18:49:47 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47HYHb5ktBz9tyM0;
        Tue, 19 Nov 2019 18:49:47 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id AD0F387D; Tue, 19 Nov 2019 18:49:48 +0100 (CET)
Received: from 37-173-93-145.coucou-networks.fr
 (37-173-93-145.coucou-networks.fr [37.173.93.145]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 19 Nov 2019 18:49:48 +0100
Date:   Tue, 19 Nov 2019 18:49:48 +0100
Message-ID: <20191119184948.Horde.Roz3CrP_eBhY_YnNAgMQ7w1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: Fix permanently mapped IMMR region.
References: <ad9d45119a48a92bf122781d0c79c9407baa12d7.1566554026.git.christophe.leroy@c-s.fr>
 <87sgmlcu1x.fsf@mpe.ellerman.id.au>
In-Reply-To: <87sgmlcu1x.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> When not using large TLBs, the IMMR region is still
>> mapped as a whole block in the FIXMAP area.
>>
>> Do not remove pages mapped in the FIXMAP region when
>> initialising paging.
>>
>> Properly report that the IMMR region is block-mapped even
>> when not using large TLBs.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/mm/mem.c        |  8 --------
>>  arch/powerpc/mm/nohash/8xx.c | 13 +++++++------
>>  2 files changed, 7 insertions(+), 14 deletions(-)
>
> This blows up pmac32_defconfig + qemu mac99 for me with:

Ok, then there is still something I have not understood about fixmap.  
I'll look at it next week

Christophe

