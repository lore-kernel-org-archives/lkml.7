Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C85C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CE120693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfG3LRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:17:54 -0400
Received: from ozlabs.org ([203.11.71.1]:53757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfG3LRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:17:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yYv11BhNz9s8m;
        Tue, 30 Jul 2019 21:17:48 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
In-Reply-To: <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com>
References: <20190729202542.205309-1-ndesaulniers@google.com> <20190729203246.GA117371@archlinux-threadripper> <20190729215200.GN31406@gate.crashing.org> <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com>
Date:   Tue, 30 Jul 2019 21:17:43 +1000
Message-ID: <87h873zs88.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Mon, Jul 29, 2019 at 11:52 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
>> On Mon, Jul 29, 2019 at 01:32:46PM -0700, Nathan Chancellor wrote:
>> > For the record:
>> >
>> > https://godbolt.org/z/z57VU7
>> >
>> > This seems consistent with what Michael found so I don't think a revert
>> > is entirely unreasonable.
>>
>> Try this:
>>
>>   https://godbolt.org/z/6_ZfVi
>>
>> This matters in non-trivial loops, for example.  But all current cases
>> where such non-trivial loops are done with cache block instructions are
>> actually written in real assembler already, using two registers.
>> Because performance matters.  Not that I recommend writing code as
>> critical as memset in C with inline asm :-)
>
> Upon a second look, I think the issue is that the "Z" is an input argument
> when it should be an output. clang decides that it can make a copy of the
> input and pass that into the inline asm. This is not the most efficient
> way, but it seems entirely correct according to the constraints.
>
> Changing it to an output "=Z" constraint seems to make it work:
>
> https://godbolt.org/z/FwEqHf
>
> Clang still doesn't use the optimum form, but it passes the correct pointer.

Thanks Arnd. This seems like a better solution.

I'll drop the revert I have staged.

Segher does this look OK to you?

Nathan/Nick, are one of you able to test this with your clang CI?

cheers
