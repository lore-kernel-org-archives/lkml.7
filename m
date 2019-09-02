Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CE8C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C182186A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfIBBtC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 21:49:02 -0400
Received: from ozlabs.org ([203.11.71.1]:37227 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfIBBtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 21:49:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46MCg01W0Lz9s7T;
        Mon,  2 Sep 2019 11:48:59 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alastair D'Silva <alastair@au1.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: RE: [RFC PATCH] powerpc: Convert ____flush_dcache_icache_phys() to C
In-Reply-To: <fcc94e7f347c3759a1698444239a7250b22cde7d.camel@au1.ibm.com>
References: <de7a813c71c4823797bb351bea8be15acae83be2.1565970465.git.christophe.leroy@c-s.fr> <9887dada07278cb39051941d1a47d50349d9fde0.camel@au1.ibm.com> <a0ad8dd8-2f5d-256d-9e88-e9c236335bb8@c-s.fr> <fcc94e7f347c3759a1698444239a7250b22cde7d.camel@au1.ibm.com>
Date:   Mon, 02 Sep 2019 11:48:59 +1000
Message-ID: <87imqbtqlw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Alastair D'Silva" <alastair@au1.ibm.com> writes:
> On Wed, 2019-08-21 at 22:27 +0200, Christophe Leroy wrote:
>> 
>> Le 20/08/2019 à 06:36, Alastair D'Silva a écrit :
>> > On Fri, 2019-08-16 at 15:52 +0000, Christophe Leroy wrote:
>> 
>> [...]
>> 
>> > 
>> > Thanks Christophe,
>> > 
>> > I'm trying a somewhat different approach that requires less
>> > knowledge
>> > of assembler. Handling of CPU_FTR_COHERENT_ICACHE is outside this
>> > function. The code below is not a patch as my tree is a bit messy,
>> > sorry:
>> 
>> Can we be 100% sure that GCC won't add any code accessing some
>> global data or stack while the Data MMU is OFF ?
>
> +mpe
>
> I'm not sure how we would go about making such a guarantee, but I've
> tied every variable used to a register and addr is passed in a
> register, so there is no stack usage, and every call in there only
> operates on it's operands.

That's not safe, I can believe it happens to work but the compiler
people will laugh at us if it ever breaks.

Let's leave it in asm.

cheers
