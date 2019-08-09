Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B14AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2485120C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfHIUCl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:02:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51731 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfHIUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:02:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 464x3z4F4Tz9vBnX;
        Fri,  9 Aug 2019 22:02:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YXoWW-H0Xvcu; Fri,  9 Aug 2019 22:02:39 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 464x3z37Mgz9vBnS;
        Fri,  9 Aug 2019 22:02:39 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 855AB98C; Fri,  9 Aug 2019 22:03:01 +0200 (CEST)
Received: from mry91-4-88-160-8-182.fbx.proxad.net
 (mry91-4-88-160-8-182.fbx.proxad.net [88.160.8.182]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 09 Aug 2019 22:03:01 +0200
Date:   Fri, 09 Aug 2019 22:03:01 +0200
Message-ID: <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kbuild test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
References: <87h873zs88.fsf@concordia.ellerman.id.au>
 <20190809182106.62130-1-ndesaulniers@google.com>
 <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com>
In-Reply-To: <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> a écrit :

> On Fri, Aug 9, 2019 at 8:21 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
>
>>  static inline void dcbz(void *addr)
>>  {
>> -       __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
>> +       __asm__ __volatile__ ("dcbz %y0" : "=Z"(*(u8 *)addr) :: "memory");
>>  }
>>
>>  static inline void dcbi(void *addr)
>>  {
>> -       __asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
>> +       __asm__ __volatile__ ("dcbi %y0" : "=Z"(*(u8 *)addr) :: "memory");
>>  }
>
> I think the result of the discussion was that an output argument only kind-of
> makes sense for dcbz, but for the others it's really an input, and clang is
> wrong in the way it handles the "Z" constraint by making a copy, which it
> doesn't do for "m".
>
> I'm not sure whether it's correct to use "m" instead of "Z" here, which
> would be a better workaround if that works. More importantly though,
> clang really needs to be fixed to handle "Z" correctly.

As the benefit is null, I think the best is probably to reverse my  
original commit until at least CLang is fixed, as initialy suggested  
by mpe

Christophe



