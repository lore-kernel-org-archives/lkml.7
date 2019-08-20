Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255B0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA3422CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfHTMmw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:42:52 -0400
Received: from ozlabs.org ([203.11.71.1]:43487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTMmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:42:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46CVnP0JhKz9s3Z;
        Tue, 20 Aug 2019 22:42:48 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 1/2] powerpc/time: Only set CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC64
In-Reply-To: <26969bb5-c01b-0674-5773-027f1851bd44@c-s.fr>
References: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr> <20180607114304.327c4ab5@roar.ozlabs.ibm.com> <26969bb5-c01b-0674-5773-027f1851bd44@c-s.fr>
Date:   Tue, 20 Aug 2019 22:42:39 +1000
Message-ID: <87imqs57pc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Hi Nick,
>
>
> Le 07/06/2018 à 03:43, Nicholas Piggin a écrit :
>> On Wed,  6 Jun 2018 14:21:08 +0000 (UTC)
>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>> 
>>> scaled cputime is only meaningfull when the processor has
>>> SPURR and/or PURR, which means only on PPC64.
>>>
>
> [...]
>
>> 
>> I wonder if we could make this depend on PPC_PSERIES or even
>> PPC_SPLPAR as well? (That would be for a later patch)
>
> Can we go further on this ?
>
> Do we know exactly which configuration support scaled cputime, in 
> extenso have SPRN_SPURR and/or SPRN_PURR ?

PURR is Power5/6/7/8/9 and PA6T (pasemi). SPURR is Power6/7/8/9.

So we could easily flip PPC64 for PPC_BOOK3S_64, which would mean 64-bit
Book3E CPUs don't get that overhead.

Beyond that is not so simple. We probably don't need that selected for
bare metal kernels (powernv). But in practice all the distros build a
multi platform kernel with powernv+pseries anyway.

We could turn it off on G5s (PPC970), by making it depend on POWERNV ||
PSERIES || PPC_PASEMI, but I'm not sure if it's worth the trouble.

cheers
