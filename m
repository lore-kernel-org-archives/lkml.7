Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF5C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B08C2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4z590x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfGEMPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:15:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36755 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbfGEMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:15:24 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so3103063iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wy7q/lSghMGgYWHueYARtusrEUxHAAv3+Vmwv4lPLPc=;
        b=Y4z590x8zZjU+nw79DHqFjYhZKANayNJIXz4wQb9+25F1kH3RJO2RBCpfGERgAZsAn
         ow2HKsxnsP1XGzDlaetFz86AnclIWeQxCeo3Oq1XylC9c3bhuRdEIY+A3pozwPPQ2gFm
         fAItExXm2FysS43TIjvUmCWMj6uF/QwUfqw/iobtpJWztRQ9fI8Nf/FdiMuBQrA9N/J2
         1Ddf9MJO9ZxoTDbUQnLef1m4aPO587Ce7W0qMy0q+buIjxarGoZCoZED/1KyktHkOEFT
         tLxBclUeZhEEetau9xtJQaDV99Hs9o+mXDylVSpCjyVxvsMbK7UGd/eEQjSz8hCzR2pI
         jHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wy7q/lSghMGgYWHueYARtusrEUxHAAv3+Vmwv4lPLPc=;
        b=fHKkj/CtAvnqAqu5Olzgd0tB8sP7aEtZ529yza65nBh9khbzP0VR4HdIjHBf/6MatY
         u34T+9XAU/KXGwbXmTTx/7Z+3w/E331xUrHUBgCn5I9TfI0NuLCjj5MIHTRLT8HDToVn
         /u/NEDAhfpeYetTJBm+a4CJtbmLV5c+l0tBHh+vDnaKNNKdTa0i1/+3UilZrLoYGPOuM
         nWPDaM+AxT1/NWjuuwSb+u0cfECaHjWDP85K2kpJNT2Mcqrcw/Ni1Xd55qyKALk89TrV
         A/TtSyiAIS5p0Y+xFe5z2/uk4pvTHomQ3KHDaUABoZ0US8hSPYb/uZZV9beLHSQXPrTS
         NNbg==
X-Gm-Message-State: APjAAAWR7+vTgUUArJawLUaM46Isy+pUqym8Y+bnx16sdjaFzzxuVQ49
        kla0BBSYo5HTFyxrLgdzmiacTOaivDFy5p/D4OzvOw==
X-Google-Smtp-Source: APXvYqyNXAq6nNsn9MmE6y5O/LjdJEBIfuNPjZaUyp9GKnMkhxnB7VfGHsToH8TlsqDqXKgSCIgDjZabfk2Ai7eg4Ms=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr3834536iog.266.1562328922761;
 Fri, 05 Jul 2019 05:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c2416058c594b30@google.com> <24282.1562074644@warthog.procyon.org.uk>
 <CACT4Y+YjdV8CqX5=PzKsHnLsJOzsydqiq3igYDm_=nSdmFo2YQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YjdV8CqX5=PzKsHnLsJOzsydqiq3igYDm_=nSdmFo2YQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 14:15:11 +0200
Message-ID: <CACT4Y+YOFjyYeKv1M8QL8fHF+zuGKRJrTs78hSTxZ1hPjNR5JA@mail.gmail.com>
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

On Fri, Jul 5, 2019 at 2:12 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > syzbot <syzbot+1e0edc4b8b7494c28450@syzkaller.appspotmail.com> wrote:
> >
> > I *think* the reproducer boils down to the attached, but I can't get syzkaller
> > to work and the attached sample does not cause the oops to occur.  Can you try
> > it in your environment?
> >
> > > The bug was bisected to:
> > >
> > > commit 46894a13599a977ac35411b536fb3e0b2feefa95
> > > Author: David Howells <dhowells@redhat.com>
> > > Date:   Thu Oct 4 08:32:28 2018 +0000
> > >
> > >     rxrpc: Use IPv4 addresses throught the IPv6
> >
> > This might not be the correct bisection point.  If you look at the attached
> > sample, you're mixing AF_INET and AF_INET6.  If you try AF_INET throughout,
> > that might get a different point.  On the other hand, since you've bound the
> > socket, the AF_INET6 passed to socket() should be ignored.
> >
> > David
> > ---
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <unistd.h>
> > #include <sys/socket.h>
> > #include <arpa/inet.h>
> > #include <linux/rxrpc.h>
> >
> > static const unsigned char inet4_addr[4] = {
> >         0xe0, 0x00, 0x00, 0x01
> > };
> >
> > int main(void)
> > {
> >         struct sockaddr_rxrpc srx;
> >         int fd;
> >
> >         memset(&srx, 0, sizeof(srx));
> >         srx.srx_family                  = AF_RXRPC;
> >         srx.srx_service                 = 0;
> >         srx.transport_type              = AF_INET;
> >         srx.transport_len               = sizeof(srx.transport.sin);
> >         srx.transport.sin.sin_family    = AF_INET;
> >         srx.transport.sin.sin_port      = htons(0x4e21);
> >         memcpy(&srx.transport.sin.sin_addr, inet4_addr, 4);
> >
> >         fd = socket(AF_RXRPC, SOCK_DGRAM, AF_INET6);
> >         if (fd == -1) {
> >                 perror("socket");
> >                 exit(1);
> >         }
> >
> >         if (bind(fd, (struct sockaddr *)&srx, sizeof(srx)) == -1) {
> >                 perror("bind");
> >                 exit(1);
> >         }
> >
> >         sleep(20);
> >
> >         // Whilst sleeping, hit with:
> >         // echo -e '\0\0\0\0\0\0\0\0' | ncat -4u --send-only 224.0.0.1 20001
> >
> >         return 0;
> > }
>
> Hi David,
>
> I can't re-reproduce it locally in qemu either. Though, syzbot managed
> to re-reproduce it reliably during bisection (maybe there is some
> difference in hardware and as the result the injected ethernet packet
> would need some different values). Let's try to ask it again to make
> sure:
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
>
> Re bisection, I don't know if there are some more subtle things as
> play (you are in the better position to judge that), but bisection log
> looks good, it tracked the target crash throughout and wasn't
> distracted by any unrelated bugs, etc. So I don't see any obvious
> reasons to not trust it.

FWIW here is a more complete translation of the syzkaller repro to C using:

$ syz-prog2c -prog /tmp/prog -threaded -collide -repeat=0 -procs=6
-sandbox=namespace -enable=tun,net_dev,net_reset,cgroups,close_fds
-tmpdir -segv

https://gist.githubusercontent.com/dvyukov/f712ca7c3a0d355ce63823d7882c2934/raw/7a72635b99e5a85599a6bcf9b7901fa9d8c494d4/repro.c

However, both syzbot and me won't able to repro with this C program,
so it is expected that it does not reproduce the crash for some
reason.
