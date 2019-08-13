Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C817EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1C22067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRwFbK/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfHMO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:28:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42564 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfHMO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:28:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so28402667ota.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGE30nOZT5K+NX+TVv0ZpoRS3fgZeiZCXeoj6PCI09w=;
        b=oRwFbK/akWqLZNnM9R9bFSlLh+siffUaqcsG4pH5e21Q74fI+o59X9+W3QVzXbqqAh
         t4C74Jk7AOEkwsTuEMalWAmpwhlv3Kd8myMl6V8aD0OKuEvHe09inEmWr8JFlvBIILAE
         bNIImCK2fdhneXH5pZ9E9l3bD3R7hniio4gGR0XPZb1fHHqJf/tkejhPP3Jfju8soQ0Q
         J1AazUIqqRL+AAZkYixSZn36PQCMsOhz6GGEeh5lErW5Y1gDvfC9+1mrKDIy7QFBxhjT
         w0xx6RVi1BDXbwuV7V6DXRoPZEQBiu+k/9ErKvNypx2C5voFhAdSBiJi8fe/kKJqC+Ru
         RE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGE30nOZT5K+NX+TVv0ZpoRS3fgZeiZCXeoj6PCI09w=;
        b=mUXr8ZSwwuCyxHd3ngbuew/ESCdB1Gj9ypDyrljWDKevQcdusKTScyZDOLiRuQfqV6
         N/fdilpzyKUPjV1Ns0w1XnM1jU9mhFDh58lCvwOodRoAi1YY4yBsItymlVOsUALu4yrM
         mYMzKqF5uhbQ8awlLbuQ8iJBW+4iz50Vg66HtHKdV9HArO+Homd+yzgRBH2iqLy4I8HU
         e+JGnlam8Yy/GTD9S6etrUsYPEleP5o/3K8HXtfvA2IJEih4pJzYyiYu9MVL6EIyftgT
         COHAw5nvqRTo45GAXJYq7visdrzH36YNzZPwOChchmGvTGRsZ7ue01zvc25yreVJv9iZ
         WnMA==
X-Gm-Message-State: APjAAAWYnWAArTuVOcrcLypyYgNFnhqyczYYcgwKMWMW8Bufu2uLmLvs
        vK06P8Pwl6F6ne8d7XSaw0G9T9FT2wntFkdxf2DlAQ==
X-Google-Smtp-Source: APXvYqwlq1LkEmHZGn0qkIw6FNb+sqMzHT6Uz+MVyhL1/eMC+7YxAyStCbIPQRImgvsV4ec37Zf3Vjv7m+yElymKlbg=
X-Received: by 2002:a02:ca0c:: with SMTP id i12mr25239794jak.82.1565706520008;
 Tue, 13 Aug 2019 07:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c2416058c594b30@google.com> <24282.1562074644@warthog.procyon.org.uk>
 <CACT4Y+YjdV8CqX5=PzKsHnLsJOzsydqiq3igYDm_=nSdmFo2YQ@mail.gmail.com>
 <20330.1564583454@warthog.procyon.org.uk> <CACT4Y+Y4cRgaRPJ_gz_53k85inDKq+X+bWmOTv1gPLo=Yod1=A@mail.gmail.com>
 <22318.1564586386@warthog.procyon.org.uk> <CACT4Y+bjLBwVK_6fz2H8fXm0baAVX+vRJ4UbVWG_7yNUO-SOUg@mail.gmail.com>
 <3135.1565706180@warthog.procyon.org.uk>
In-Reply-To: <3135.1565706180@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Aug 2019 16:28:26 +0200
Message-ID: <CACT4Y+YCB3o5Ps9RNq9KpMcmGCwBM4R9DeX67prQ9Q3UppGowQ@mail.gmail.com>
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

On Tue, Aug 13, 2019 at 4:23 PM David Howells <dhowells@redhat.com> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > > > Please send a patch for testing that enables this tracing
> > > > unconditionally. This should have the same effect. There is no way to
> > > > hook into a middle of the automated process and arbitrary tune things.
> > >
> > > I don't know how to do that off hand.  Do you have an example?
> >
> > Few messages above I asked it to test:
> > https://groups.google.com/d/msg/syzkaller-bugs/gEnZkmEWf1s/r2_X_KVQAQAJ
> >
> > Basically, git repo + branch + patch. Here are the docs:
> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>
> I meant that I don't know how to turn a tracepoint on from inside the kernel.

This /sys/kernel/debug/tracing/events/rxrpc/rxrpc_local/enable in:
        echo 1 > /sys/kernel/debug/tracing/events/rxrpc/rxrpc_local/enable
should map to some global variable, right? If so, it should be
possible to initialize that var to 1 statically. Or that won't work
for some reason?
