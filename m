Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D860C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C8B20659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjfmT0kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfGaOq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:46:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38109 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfGaOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:46:29 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so17034051ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVbM3ywHXnfaXLqBHLumDjTwvKiP2anaixILYvBn/ng=;
        b=pjfmT0kNj6Uqy/h+8/WX0HU1oAXn2oRKXIdhUHe4IZ2y9tFHrZED/lweo1b/cRpzAu
         idCTfvQdx0X4j4gAoaTIvdCkse0FKv2ZP/nMGpEvdjB4FCdpbtSCe7YbbbrA7NfG4kgB
         6tJs0JHORDFcqF9yUmWvwGlkVZTf7lFPuxi+OM100xLlwRDiOvY1zGtyXxJrNqMVKjTy
         Sh4mX2HBTdxSw3G64Fi/PnSesG7Yz22B9o3S2QcDXBAfMDAbKi3fjQPg1HKM266NKtz7
         DeKvT6dr4cOE1OkPu2qnqj8vl+krkBY8nCeb8pXZk+CMIp6EboJyNNksTUyTgnwSJOU3
         d+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVbM3ywHXnfaXLqBHLumDjTwvKiP2anaixILYvBn/ng=;
        b=AlyrD1vcmavKPPOXFADFHb5aTYbzY9KlJmPIeMvPb+hRFtsnImVa0g0YPQB8JmJYdM
         w6Hm/mqt7cCAMeyrwmAaVxbfrb2F5tKp36/DcRaAwA1qKAfGWSaUz0M1MjQDgiuzQOSS
         JYdAgdwftSITSMdq6AvOtkc6aa5el1KrKkTF1zpq1kuy8HAK0DN3LOMsNQjFi4KNfTfu
         9VgzbMBwZu08c2lHGRyZ1tEkNPCfT6aLxy2/PydWBOxx76vAqlrMBrl6ecDocUuXoF1a
         Jc0WZuQsRqYLgEwikxbwGZi8PhGSpoPba6b25wVksEUlp3CYiTYQekPM2Z/GhWvdrtX4
         o0rA==
X-Gm-Message-State: APjAAAV6aQ2FBNE406XH+KIZAXlrM6sRmrEA6IZTDYbwEOBK1SXRcqPY
        cL/7+LGR1PgC2y+htWJ7ECdWqWpUxgxi8F/NmMIMow==
X-Google-Smtp-Source: APXvYqxKYf0QIDVpvcoBYAjITw+kwzxhvEER2l33yz1T4bLAIqIHkcdAsy647W1OXK8CZ55vRav7zMW5fa7eD+/0o2c=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr87736036ioa.138.1564584387977;
 Wed, 31 Jul 2019 07:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c2416058c594b30@google.com> <24282.1562074644@warthog.procyon.org.uk>
 <CACT4Y+YjdV8CqX5=PzKsHnLsJOzsydqiq3igYDm_=nSdmFo2YQ@mail.gmail.com> <20330.1564583454@warthog.procyon.org.uk>
In-Reply-To: <20330.1564583454@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 31 Jul 2019 16:46:15 +0200
Message-ID: <CACT4Y+Y4cRgaRPJ_gz_53k85inDKq+X+bWmOTv1gPLo=Yod1=A@mail.gmail.com>
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

On Wed, Jul 31, 2019 at 4:30 PM David Howells <dhowells@redhat.com> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > Re bisection, I don't know if there are some more subtle things as
> > play (you are in the better position to judge that), but bisection log
> > looks good, it tracked the target crash throughout and wasn't
> > distracted by any unrelated bugs, etc. So I don't see any obvious
> > reasons to not trust it.
>
> Can you turn on:
>
>         echo 1 > /sys/kernel/debug/tracing/events/rxrpc/rxrpc_local/enable
>
> and capture the trace log at the point it crashes?

Please send a patch for testing that enables this tracing
unconditionally. This should have the same effect. There is no way to
hook into a middle of the automated process and arbitrary tune things.
