Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7284720854
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR45Wpc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCQSUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:20:21 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36002 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQSUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:20:20 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so17976614itl.1;
        Sun, 17 Mar 2019 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zb4FzRNw4owAvoYs6wTot/+cTIpL3kZjP5X58bEJKg=;
        b=lR45Wpc3F0oNwcjJARwrDMYmnLxCZeNJd6sBxiHQp0d3S1Gixah/Ufj9viSLhwiBrp
         1woxZ6HVs+2hdb0m8q00I94ec6S7I29XvRjT0Z5NONuLLSl9bV2uN08zMKZrs8hGoHwv
         gsWSXfkBo//4nJO+98+vbEQbREtEBMZ1iYu/rMr28l5yBA3DQIYwkI/poaqP0TNmq4s6
         YwhJKL7b9ckrTiixEwZcvegmYM1DfTgBlcHlmd6EZ2UKQkC9d7uv8J83YONGmBhmrsW+
         F0sKUTPCO+CN7OVtoOQnbQ498IQ+ZeSPHaLGpsJ2EtS8uFvWT3tlzyTtzZ2BEo0RU41H
         XdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zb4FzRNw4owAvoYs6wTot/+cTIpL3kZjP5X58bEJKg=;
        b=Uoqz/p+1jWnRwP9kzo3Euub5QGhLbcNgXR21h4hhcndy33cSQsCuE3gva6nXEjaU84
         HnIyXOLUeMEICX3qewzxZWUyhUunUQX3dKI6eh1iOn8W8wHoR2tngpZRCeiENyThR2Ba
         Y2IJuRKEfAtlS7JbbiJ6zKXr6mjsNdkGKyWNHEs6krZU6+fTFyXD19OHRG95ABc0SMF8
         qluhh1UfewpAAriXSWQmWrHfgkIw9DET0gu71/P05fMt2Af9oAKuIZ5MvIvd6TASKg9X
         oZ/L1szlzyTCewo96skWY6u5UdVgjpWnuj6s5906NEeQRbF+Ga42EfcmIspJNc5eMKSD
         aFbg==
X-Gm-Message-State: APjAAAU4f9/cbLsP6RuqdZxcPbslSvtpisU0bL1K7hBxMPe2hZ0Lo2NU
        M+XgBdnAGat0PDuMLucP54cdvYPBLehOkIqt3fk=
X-Google-Smtp-Source: APXvYqyR1dc6VNyWgtiH5TVXl25QO9yZ50EsBN3etHxAjg2pCY0EckA59XbwPyiI9RAjOALNoD6X6QU4VzMmSatwY7A=
X-Received: by 2002:a24:c206:: with SMTP id i6mr8608160itg.61.1552846819579;
 Sun, 17 Mar 2019 11:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190311153857.563743-1-arnd@arndb.de> <87k1h1fgkk.fsf@mid.deneb.enyo.de>
 <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com> <87a7hvded7.fsf@mid.deneb.enyo.de>
In-Reply-To: <87a7hvded7.fsf@mid.deneb.enyo.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 17 Mar 2019 11:20:06 -0700
Message-ID: <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
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

On Fri, Mar 15, 2019 at 2:20 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Arnd Bergmann:
>
> > On Thu, Mar 14, 2019 at 7:41 PM Florian Weimer <fw@deneb.enyo.de> wrote:
> >>
> >> * Arnd Bergmann:
> >>
> >> > diff --git a/arch/alpha/include/uapi/asm/socket.h
> >> > b/arch/alpha/include/uapi/asm/socket.h
> >> > index 0d0fddb7e738..976e89b116e5 100644
> >> > --- a/arch/alpha/include/uapi/asm/socket.h
> >> > +++ b/arch/alpha/include/uapi/asm/socket.h
> >> > @@ -2,8 +2,8 @@
> >> >  #ifndef _UAPI_ASM_SOCKET_H
> >> >  #define _UAPI_ASM_SOCKET_H
> >> >
> >> > +#include <linux/posix_types.h>
> >> >  #include <asm/sockios.h>
> >> > -#include <asm/bitsperlong.h>
> >>
> >> This breaks POSIX conformance in glibc because the
> >> <linux/posix_types.h> header is not namespace clean.  It contains the
> >> identifiers fds_bits and val:
> >>
> >>         unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
> >>
> >>         int     val[2];
> >
> > What is problematic about the struct members here? I had thought that
> > only the struct names have to be in a namespace to be usable here,
> > but not the members.
>
> According POSIX, a user can do this:
>
> #define fds_bits 1024
>
> before including the <sys/socket.h> header file.  Similarly for val.
>
> Since glibc pulls in <asm/socket.h> indirectly, the result is a parse
> error, even though the programmer did nothing wrong (fds_bits is not
> an identifier used by POSIX, nor is it in the implementation
> namespace, ans <sys/socket.h> is a POSIX header).
>
> > We could use asm/posix_types.h instead of linux/posix_types.h,
> > would that address your concern?
>
> It should fix the fds_bits case, I think.  But
> <asm-generic/posix_types.h> still uses val, so that part of the issue
> remains.

Would moving kernel namespace types(__kernel prefix) to a different
header file(kernel_types.h?) and then including this from
linux/posix_types.h.
And, for socket.h just including kernel_types.h make sense?

-Deepa
