Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8890AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4E62186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCOUap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:30:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41392 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:30:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so6292138qta.8;
        Fri, 15 Mar 2019 13:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E01ZHiStugNQMrF3OV/SFEpK2XRL7GY4vW5Ux0dTJZI=;
        b=Qj1vxWZaRXyzGkoT1yRnVTTVSflSyc3fYlocQrOSllDpzs+RAjMGziQYkg7wBwlDbC
         g5LB3954HGUMT0shq6wP3QvPUzt6YJS+G6z1vCoI5r9UVmnsJa8sdRB/3RaXYCs1kDcd
         H0i2SP58cS0dZ1aiUN2rJY6JNqoCLcqGiLhuiY3brg2vJBFDl9fNMP25Kgf7Q/BeqkxS
         QCCc7dJlZhi6UhK+y1kzg/68aqprFIDMX4KjcxdBP+12hOpNKXVxoqdIPhLiDEAsILzQ
         4Ql4BtDjywO525BrjljUeuwFwBnyH9gV7G9YYl8arfIq/ErIPfQ/5qUH8Sqd6I1a511V
         1kiw==
X-Gm-Message-State: APjAAAU3A4feKKzynsw49LFzu+1+RwoAZgqJ3I/E1x1prS56E2YIyBUe
        bjHt9AAby3bhvtOKuljtxvvINDYih9I82Iqzooo=
X-Google-Smtp-Source: APXvYqxy9ZiHNNYOdzCh8yPmvgI4FCeg3UYYGDkifYESCkLX6rd3eHEa85cIrLRbAoQtESitWr31sD8AvNvlfq0dnK8=
X-Received: by 2002:a0c:c781:: with SMTP id k1mr3935043qvj.180.1552681843409;
 Fri, 15 Mar 2019 13:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190311153857.563743-1-arnd@arndb.de> <87k1h1fgkk.fsf@mid.deneb.enyo.de>
In-Reply-To: <87k1h1fgkk.fsf@mid.deneb.enyo.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Mar 2019 21:30:25 +0100
Message-ID: <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
To:     Florian Weimer <fw@deneb.enyo.de>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 7:41 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Arnd Bergmann:
>
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > index 0d0fddb7e738..976e89b116e5 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -2,8 +2,8 @@
> >  #ifndef _UAPI_ASM_SOCKET_H
> >  #define _UAPI_ASM_SOCKET_H
> >
> > +#include <linux/posix_types.h>
> >  #include <asm/sockios.h>
> > -#include <asm/bitsperlong.h>
>
> This breaks POSIX conformance in glibc because the
> <linux/posix_types.h> header is not namespace clean.  It contains the
> identifiers fds_bits and val:
>
>         unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
>
>         int     val[2];

What is problematic about the struct members here? I had thought that
only the struct names have to be in a namespace to be usable here,
but not the members.

The only part that might be problematic is

#undef __FD_SETSIZE
#define __FD_SETSIZE    1024

but we already get that from a number of other inclusions of
linux/posix_types.h. Is this what you mean?

> We could duplicate some of the SO_* constants for POSIX mode in glibc,
> but it would be nice to avoid that.
>
> Is there a different way of fixing this on the kernel side that avoids
> including <linux/posix_types.h>?

We could use asm/posix_types.h instead of linux/posix_types.h,
would that address your concern?

       Arnd
