Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26544FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED74C2067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573245058;
	bh=R4qR/CmKmGkUGo4tjEOSWZDPr3xsan2w3EfW5S5HOME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sWLdS6QK30W5fXSoq9ChXd8gwoqgiSVxz3ml8eMW0MD0/2g5MTmaAz90IrLJGt6cG
	 KSk1NhM4rrtgOC22K8O62iVd1sBbHajGTj51pHWvF2jiYLmkYq4VRRLSD7D4H4o8cE
	 KfZp6jsjlibiPxFq9q+AVqYFEOzj/5JRHEFebubw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfKHUa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:30:57 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:37688 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:30:56 -0500
Received: by mail-lf1-f48.google.com with SMTP id b20so5435632lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4G9LhNu511cUTzzUCbonTskDej2Ys9dbnlHdssKk4WQ=;
        b=HHey9ElQaNeZFkqKeSFK/EfPMq6vbK2Lm2dr3sIzCNHajSxBJDn4nfeJC674ARMqAO
         R5Ops4OPDogoeOgHpHESom8BR5x8/Q+cM6RqG6iYH0DFbaImijW3x06QX7os2TCHiDT2
         MGulyXH2fLc6SW6VRGS2Cy1Xz3yb2hE39NIfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4G9LhNu511cUTzzUCbonTskDej2Ys9dbnlHdssKk4WQ=;
        b=eXOi/QzxZFyY0PuNkV+vlg0sDS48+YI6eF1EXkMXELq9Si0EHSLtcEGD6I8mKe73PM
         ZSwQiBya8Xlbi8F1dqX3c9mpB0Eekh7OpDVGNEWPBmw7Hpu0h83Fe27KU9FlUiO7hUXU
         MTrbuaR8ghMjzpUYY0SNraTPeJvqnIgna6AoHh/q4+4uvxPIMIWtiKFCMW/VCNCFT1Qz
         RXYjIv9IyuRxrCd3phlvv9Vwc+Na8ESiq882XRhmHin/mgFsUtA/xVCvt3ofIvJrRzsV
         /TjO2w5sqkgU98yjO+K77iJLdri+4OuNWgUnIXcFoH4YIYESUFE/Z8U5ASsPl0HhCp1L
         gnHA==
X-Gm-Message-State: APjAAAUi3eVGOIcX7e5q3kuP6bHNZW1Es4L/YuzP1sPU/W0TxRKL/FEQ
        Uw7HZX8faponm2ffB7VBex6XfDOMjcc=
X-Google-Smtp-Source: APXvYqx8rYRGSFhZ7RR8QbjGT47zuKSL9m0m191i7F97Xh4AmvdggJ3hZeC84N0BQSqW1+LiRE3f4w==
X-Received: by 2002:ac2:4822:: with SMTP id 2mr7958691lft.115.1573245052803;
        Fri, 08 Nov 2019 12:30:52 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id g25sm3411019ljk.36.2019.11.08.12.30.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:30:51 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id g3so7524409ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:30:51 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8195764ljp.133.1573245051344;
 Fri, 08 Nov 2019 12:30:51 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com> <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
In-Reply-To: <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 12:30:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com>
Message-ID: <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:56 AM Eric Dumazet <edumazet@google.com> wrote:
>
> BTW, I would love an efficient ADD_ONCE(variable, value)
>
> Using WRITE_ONCE(variable, variable + value) is not good, since it can
> not use the optimized instructions operating directly on memory.

So I'm having a hard time seeing how this could possibly ever be valid.

Is this a "writer is locked, readers are unlocked" case or something?

Because we don't really have any sane way to do that any more
efficiently, unless we'd have to add new architecture-specific
functions for it (like we do have fo the percpu ops).

Anyway, if you have a really hot case you care about, maybe you could
convince the gcc people to just add it as a peephole optimization?
Right now, gcc ends up doing some strange things with volatiles, and
basically disables a lot of stuff over them. But with a test-case,
maybe you can convince somebody that certain optimizations are still
fine. A "read+add+write" really does the exact same accesses as an
add-to-memory instruction, but gcc has some logic to disable that
instruction fusion.

          Linus
