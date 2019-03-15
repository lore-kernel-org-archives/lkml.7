Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C1C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECD8218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCOVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:20:12 -0400
Received: from albireo.enyo.de ([5.158.152.32]:58866 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfCOVUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:20:11 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1h4uFI-0001AG-95; Fri, 15 Mar 2019 21:20:04 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1h4uFI-0001RH-2d; Fri, 15 Mar 2019 22:20:04 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
References: <20190311153857.563743-1-arnd@arndb.de>
        <87k1h1fgkk.fsf@mid.deneb.enyo.de>
        <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
Date:   Fri, 15 Mar 2019 22:20:04 +0100
In-Reply-To: <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 15 Mar 2019 21:30:25 +0100")
Message-ID: <87a7hvded7.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann:

> On Thu, Mar 14, 2019 at 7:41 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>>
>> * Arnd Bergmann:
>>
>> > diff --git a/arch/alpha/include/uapi/asm/socket.h
>> > b/arch/alpha/include/uapi/asm/socket.h
>> > index 0d0fddb7e738..976e89b116e5 100644
>> > --- a/arch/alpha/include/uapi/asm/socket.h
>> > +++ b/arch/alpha/include/uapi/asm/socket.h
>> > @@ -2,8 +2,8 @@
>> >  #ifndef _UAPI_ASM_SOCKET_H
>> >  #define _UAPI_ASM_SOCKET_H
>> >
>> > +#include <linux/posix_types.h>
>> >  #include <asm/sockios.h>
>> > -#include <asm/bitsperlong.h>
>>
>> This breaks POSIX conformance in glibc because the
>> <linux/posix_types.h> header is not namespace clean.  It contains the
>> identifiers fds_bits and val:
>>
>>         unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
>>
>>         int     val[2];
>
> What is problematic about the struct members here? I had thought that
> only the struct names have to be in a namespace to be usable here,
> but not the members.

According POSIX, a user can do this:

#define fds_bits 1024

before including the <sys/socket.h> header file.  Similarly for val.

Since glibc pulls in <asm/socket.h> indirectly, the result is a parse
error, even though the programmer did nothing wrong (fds_bits is not
an identifier used by POSIX, nor is it in the implementation
namespace, ans <sys/socket.h> is a POSIX header).

> We could use asm/posix_types.h instead of linux/posix_types.h,
> would that address your concern?

It should fix the fds_bits case, I think.  But
<asm-generic/posix_types.h> still uses val, so that part of the issue
remains.
