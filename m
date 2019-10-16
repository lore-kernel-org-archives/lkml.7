Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74128FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572BF2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392476AbfJPKet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392462AbfJPKet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:34:49 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD53C81F0D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:34:48 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id m16so4660153lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SgWpfY5Xz4zDxp0MpMcVzJx2JBdy4PlhQXGqbdLqW1c=;
        b=cVz+kpyM9HHIUfT0r1LHMnzDSlZbmSdCsSTfzHYZG/0E4Oar2DFMd4kDb7rvc6ZC+C
         XPYvVtOL8qjcGsjQxqQiPTZ3wLtD+vw9ONKRBnZBH+iJtEJ/wbEuv732TXDnQEUk4FJX
         vliQNX6uIt2RJZDef3LG3CbkyUF8LAgoIatmIRw9RIe+9HP8gnrmT2cHV0QqCcOGhJgZ
         1c/O4y26oIHnjjq9NErcNC6TpeoBCL/TFyWti1pbSUI3wEBKdXrCGp5ZayqxU2WPgCnk
         kAeLvEv8cJTW3/kLX/aEvB2D1/5z3W/O5Oga+nycYkQhhLpA9SXS+vEjJZyTdcSadgiN
         UhhA==
X-Gm-Message-State: APjAAAWt6FTEXut3JllJ9SnSpbnrFaXXkz7qWcC8hwbJh4ydSgynr9L3
        7Q2jBbI22OQJwTnR2c5he3u27YJGkEcUkL5kJhTCbBez0oTETbUuA72i+rUM5v16wTEATtqnK2C
        cGkIGOsqtTAxZWELB731zu4Sb
X-Received: by 2002:a2e:8908:: with SMTP id d8mr25165972lji.197.1571222087232;
        Wed, 16 Oct 2019 03:34:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4XYHDPAfrBOTyCsdEH7wCjKz6XyRUDaC+zt/SS3g8SNH7/oIXHGkUSk//39pfT1paBIYsMQ==
X-Received: by 2002:a2e:8908:: with SMTP id d8mr25165952lji.197.1571222086968;
        Wed, 16 Oct 2019 03:34:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v1sm6234517lfq.89.2019.10.16.03.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 03:34:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 174401800F4; Wed, 16 Oct 2019 12:34:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
In-Reply-To: <CAADnVQJ7BZMVSt9on4updWrWsFWq6b5J1qEGwTdGYV+BLqH7tg@mail.gmail.com>
References: <00000000000056268e05737dcb95@google.com> <0000000000007d22100573d66078@google.com> <063a57ba-7723-6513-043e-ee99c5797271@I-love.SAKURA.ne.jp> <CAADnVQJ7BZMVSt9on4updWrWsFWq6b5J1qEGwTdGYV+BLqH7tg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Oct 2019 12:34:45 +0200
Message-ID: <87imopgere.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Oct 11, 2019 at 3:15 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Hello.
>>
>> I noticed that syzbot is reporting that refcount incremented by bpf(BPF_MAP_UPDATE_ELEM)
>> syscall is not decremented when unregister_netdevice() is called. Is this a BPF bug?
>
> Jesper, Toke,
> please take a look.

Yeah, that unregister notification handler definitely looks broken for
hashmaps; I'll send a patch :)

-Toke
