Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2605CC32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039052075C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfJACgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 22:36:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32814 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726789AbfJACgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:36:49 -0400
X-UUID: 0f9e666b914a42c581ca67844efd6fc6-20191001
X-UUID: 0f9e666b914a42c581ca67844efd6fc6-20191001
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1273433479; Tue, 01 Oct 2019 10:36:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Oct 2019 10:36:39 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Oct 2019 10:36:39 +0800
Message-ID: <1569897400.17361.27.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 1 Oct 2019 10:36:40 +0800
In-Reply-To: <a3a5e118-e6da-8d6d-5073-931653fa2808@free.fr>
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
         <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
         <1569594142.9045.24.camel@mtksdccf07>
         <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
         <1569818173.17361.19.camel@mtksdccf07>
         <a3a5e118-e6da-8d6d-5073-931653fa2808@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 30DA4FADFE5493A2DA7970C7B5D1BB63117B8C3E403BB8DB2EA5B42E8CA9F7522000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-30 at 10:57 +0200, Marc Gonzalez wrote:
> On 30/09/2019 06:36, Walter Wu wrote:
> 
> >  bool check_memory_region(unsigned long addr, size_t size, bool write,
> >                                 unsigned long ret_ip)
> >  {
> > +       if (long(size) < 0) {
> > +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> > +               return false;
> > +       }
> > +
> >         return check_memory_region_inline(addr, size, write, ret_ip);
> >  }
> 
> Is it expected that memcpy/memmove may sometimes (incorrectly) be passed
> a negative value? (It would indeed turn up as a "large" size_t)
> 
> IMO, casting to long is suspicious.
> 
> There seem to be some two implicit assumptions.
> 
> 1) size >= ULONG_MAX/2 is invalid input
> 2) casting a size >= ULONG_MAX/2 to long yields a negative value
> 
> 1) seems reasonable because we can't copy more than half of memory to
> the other half of memory. I suppose the constraint could be even tighter,
> but it's not clear where to draw the line, especially when considering
> 32b vs 64b arches.
> 
> 2) is implementation-defined, and gcc works "as expected" (clang too
> probably) https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html
> 
> A comment might be warranted to explain the rationale.
> Regards.

Thanks for your suggestion.
Yes, It is passed a negative value issue in memcpy/memmove/memset.
Our current idea should be assumption 1 and only consider 64b arch,
because KASAN only supports 64b. In fact, we really can't use so much
memory in 64b arch. so assumption 1 make sense.



