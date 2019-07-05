Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20998C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E836E2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paysDx96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfGEMNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:13:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38145 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGEMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:13:01 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so18702278ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjSi1phh9bs9cO7L1xnR1XrPIATfNuDiH5azONYl06E=;
        b=paysDx96hoCWePm5oMMcsaQJqv9GUq2HdAxau0cn7Ksk6cmgX/E/PlM5wdfq5dRaA0
         ZqfcyHQ2vyGLupa/17Bi628ZopXct62bX+iu86AaaOSDWPB/eCU7I4pgc0pcEAFbZsme
         9MaeRHSIqr4CSKAdIBG0a1ARSdeKfhKCMgejPLo7sfBYsywQ+OlqtkK3IbyRCI6hrcX1
         cQTHU7JFEA2LX6BzxxnD00D2n6KC6CuXMACz8oPaLF9i5f6vQAww+HkeYI/SosdEfErW
         Vv0CMPvxnRXwC8pMxyNZBRGISsqrOM2cgnoMEU8AQld0WjodU460hcpGJVlGx3fL+AR+
         QaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjSi1phh9bs9cO7L1xnR1XrPIATfNuDiH5azONYl06E=;
        b=erxijEf1FxYMvNeCKTPGCE7bT0/0OLm94i1BRRkFKpbWHjHI6gGHbkU24threoa50L
         A+EtUU9xLLVaI8qYkVDTXnoIbb675OnLYRnzzzgwIeWKjx2Zs/iL5W1A5XPOOvoTd+9W
         YwquzawOhe+2UAzYK1+BuIjaEQBW1XJfYpCktUQGoNFtISg1f87sjYQCidSgoKZyTOoT
         7VQioIJwUr2q+KVsE1QgzCC0U4p8wgIP1d6/1iATj2j8Bbg04ukRZOokedcO2wlBITfe
         tFC8scf7dPcZuC7peQLttW4KOfJSuzbhIAzk1MVKeICfbOC6ZZV6wgiXlasH2MTE3/Gb
         OrOw==
X-Gm-Message-State: APjAAAWwg/OH41x5yRlvcCDdOISJL5jD1qIdDLl+mvbYsKn/zgIjQk24
        Be8n7PxmfBLZ8nLYtWvDo9gr7ueidz1rB0Ag7QPrUQ==
X-Google-Smtp-Source: APXvYqz7ZT1v+Nqu10I2/ufgDaj6I6GvF4VP462R+l2op+FhKm5UWHNcYFV/bqFT/3p6G+nQ9qnf4pMo9wkiq6tiTNg=
X-Received: by 2002:a02:c7c9:: with SMTP id s9mr4012381jao.82.1562328780417;
 Fri, 05 Jul 2019 05:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c2416058c594b30@google.com> <24282.1562074644@warthog.procyon.org.uk>
In-Reply-To: <24282.1562074644@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 14:12:48 +0200
Message-ID: <CACT4Y+YjdV8CqX5=PzKsHnLsJOzsydqiq3igYDm_=nSdmFo2YQ@mail.gmail.com>
Subject: Re: kernel BUG at net/rxrpc/local_object.c:LINE!
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+1e0edc4b8b7494c28450@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        David Miller <davem@davemloft.net>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

,On Tue, Jul 2, 2019 at 3:37 PM David Howells <dhowells@redhat.com> wrote:
>
> syzbot <syzbot+1e0edc4b8b7494c28450@syzkaller.appspotmail.com> wrote:
>
> I *think* the reproducer boils down to the attached, but I can't get syzkaller
> to work and the attached sample does not cause the oops to occur.  Can you try
> it in your environment?
>
> > The bug was bisected to:
> >
> > commit 46894a13599a977ac35411b536fb3e0b2feefa95
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Thu Oct 4 08:32:28 2018 +0000
> >
> >     rxrpc: Use IPv4 addresses throught the IPv6
>
> This might not be the correct bisection point.  If you look at the attached
> sample, you're mixing AF_INET and AF_INET6.  If you try AF_INET throughout,
> that might get a different point.  On the other hand, since you've bound the
> socket, the AF_INET6 passed to socket() should be ignored.
>
> David
> ---
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <arpa/inet.h>
> #include <linux/rxrpc.h>
>
> static const unsigned char inet4_addr[4] = {
>         0xe0, 0x00, 0x00, 0x01
> };
>
> int main(void)
> {
>         struct sockaddr_rxrpc srx;
>         int fd;
>
>         memset(&srx, 0, sizeof(srx));
>         srx.srx_family                  = AF_RXRPC;
>         srx.srx_service                 = 0;
>         srx.transport_type              = AF_INET;
>         srx.transport_len               = sizeof(srx.transport.sin);
>         srx.transport.sin.sin_family    = AF_INET;
>         srx.transport.sin.sin_port      = htons(0x4e21);
>         memcpy(&srx.transport.sin.sin_addr, inet4_addr, 4);
>
>         fd = socket(AF_RXRPC, SOCK_DGRAM, AF_INET6);
>         if (fd == -1) {
>                 perror("socket");
>                 exit(1);
>         }
>
>         if (bind(fd, (struct sockaddr *)&srx, sizeof(srx)) == -1) {
>                 perror("bind");
>                 exit(1);
>         }
>
>         sleep(20);
>
>         // Whilst sleeping, hit with:
>         // echo -e '\0\0\0\0\0\0\0\0' | ncat -4u --send-only 224.0.0.1 20001
>
>         return 0;
> }

Hi David,

I can't re-reproduce it locally in qemu either. Though, syzbot managed
to re-reproduce it reliably during bisection (maybe there is some
difference in hardware and as the result the injected ethernet packet
would need some different values). Let's try to ask it again to make
sure:
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

Re bisection, I don't know if there are some more subtle things as
play (you are in the better position to judge that), but bisection log
looks good, it tracked the target crash throughout and wasn't
distracted by any unrelated bugs, etc. So I don't see any obvious
reasons to not trust it.
