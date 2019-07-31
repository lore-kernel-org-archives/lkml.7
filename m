Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F778C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66A9206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lz/OoRSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfGaPb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:31:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44578 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfGaPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:31:59 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so137029417iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUN1pvMl8svBUjCaR0OxnSiYPVvf6+NNwTE7JqyHeGo=;
        b=Lz/OoRSBQngNq7qk2Ls23OczsyfF+YccBluCPWG7IS7H2uuPnlh1HSGyfgXfwgGlES
         cVL2dXXA7Fhc4epnBjF0cO1zMIQ5f3Pn6flq9z88B6QJPH6EbMIx9wTNvpq5yRvjWqyc
         wpgsnb5DDxaigNDWgbA/vmbkhmMOF4JBZU/4Bk11OUt1nDfwbNY7SsZF72Nc5/nmMCwE
         yGTwQfUViPaZ0//I4K21aNpX+U9cFpehlX+JN5PI558d9qtExMGTbAv2ZgVVWRAmkWt8
         YF0aPFQ5DNHkEGfwmEvmJanvVR26ZoEuPjy7iKpYk84Ya/KQh+EsPapOIbwr+r7TguNI
         uNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUN1pvMl8svBUjCaR0OxnSiYPVvf6+NNwTE7JqyHeGo=;
        b=eCG/2yZ1Ct6qMpD9JEFRfT6gluhXgsDH4ECixZ7Sn7yXahpzFreil+72nR/D0zKNyh
         ut+haCLNVZm6RJ0+Qeu+ur8JSkEJrIZguZYmEUCDut4Xz0h50jiFzLs2Acsw1XJNFyc6
         /rizqvFwjIV7foBPWcf1Z+RHgLJ/aQdU6Dr2rx4pdl+Hd17EuGmfwNVvwR6rMzyYRsSm
         pCB0OCSA/XDEu6C9SQvl0C8eRJtYe/GhW8Uoy0ye+pjblEZnInn+2RtMh4zcvGw51BXz
         4ffBLfmQ7oqDlN4nneD+qaMZV+JPHuo/jksNclnYG+gOum3sUVruH2rVHSZN1UOtaOxK
         yK9w==
X-Gm-Message-State: APjAAAUQ+xDNSJm5CNnRiqV8hdPqKntw3V9hg83LTw0a50D9a4TTDCgV
        dbm+RErloIuUJ1Dn+MtEpJGYzSmykglxuj2FvEiKCg==
X-Google-Smtp-Source: APXvYqw2UXK6ZDLM4RK1EtyppjWajVOjmU7VeSiTcfg7vyOElSybY1Vr7ei0QqNz3/vdV59RExuEHrI8732XCga8lek=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr106076388iop.58.1564587118129;
 Wed, 31 Jul 2019 08:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c2416058c594b30@google.com> <24282.1562074644@warthog.procyon.org.uk>
 <CACT4Y+YjdV8CqX5=PzKsHnLsJOzsydqiq3igYDm_=nSdmFo2YQ@mail.gmail.com>
 <20330.1564583454@warthog.procyon.org.uk> <CACT4Y+Y4cRgaRPJ_gz_53k85inDKq+X+bWmOTv1gPLo=Yod1=A@mail.gmail.com>
 <22318.1564586386@warthog.procyon.org.uk>
In-Reply-To: <22318.1564586386@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 31 Jul 2019 17:31:45 +0200
Message-ID: <CACT4Y+bjLBwVK_6fz2H8fXm0baAVX+vRJ4UbVWG_7yNUO-SOUg@mail.gmail.com>
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

On Wed, Jul 31, 2019 at 5:19 PM David Howells <dhowells@redhat.com> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > Please send a patch for testing that enables this tracing
> > unconditionally. This should have the same effect. There is no way to
> > hook into a middle of the automated process and arbitrary tune things.
>
> I don't know how to do that off hand.  Do you have an example?

Few messages above I asked it to test:
https://groups.google.com/d/msg/syzkaller-bugs/gEnZkmEWf1s/r2_X_KVQAQAJ

Basically, git repo + branch + patch. Here are the docs:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches


> Anyway, I think rxrpc_local_processor() is broken with respect to refcounting
> as it gets scheduled when usage==0, but that doesn't stop it being rescheduled
> again by a network packet before it manages to close the UDP socket.
>
> David
