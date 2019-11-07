Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32F8C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782AB2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHlivEuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbfKGO7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:59:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34325 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfKGO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:59:36 -0500
Received: by mail-yw1-f66.google.com with SMTP id y18so685220ywk.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+v9ae4WyOkoGg0fa11vDq0Xg6/DkGJA+dIZ2hjJXDk=;
        b=CHlivEuwOpKEuSHcvUr2fEq2ZW6fzeYLjAhYLVIAJ9gx9qhQCVzL9lEtp60VWJ5zui
         OYZI94fIHFHCD+7NETlCsMhgK99mDpEai1R95P99gY2lvi5T3JNliKpv4sd4a3ELZWbf
         TWr3Ahlsu2qJWIBq6n043wem+cmoGEunuJKWN479l/opx6aDe22ZRTwm+bi5gQ8Id5yj
         3SKH6oXjd+0zvvdnkmFdqTJS4wlq2A3D9oEI49H45TgK1q03Df34oTFN9o/jGYXKRJ63
         xmKdlQYRwasFHyUyNUNntxIN62+HSXzgKgcm71OP8CxTeMYWjqkWjSEdobHp8bfws4zT
         4bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+v9ae4WyOkoGg0fa11vDq0Xg6/DkGJA+dIZ2hjJXDk=;
        b=K65Blco35E/uQfvPFT1cMXGhQShIES1S3IXGamWWiq4lqftlq/oWElRrmZLC6AQ5uh
         ydtdsXWKixrvQ9QtEJEmm6KhgYvkln6TDTGdkPYJg3kRugvSaqXtteV43vD3JyUuudv5
         ISeRksr6hWj3x7mNtM7OYG+PcKhk1B008Od42m8ptB4H7tHg9eHaxze2e8LeoVho/7x6
         8xkJwpd55lOFhMuzijIFMxHlTMOIacYXb84lkIx/q6vw4H7ndINdztPBWZXkUpPx11C+
         /fQ+suPoP5W+HZSjgtpFZtmyRQNXxGPjyFRArg2jGPYzA+2HmkA4swII8btOplJbYoQl
         IwOQ==
X-Gm-Message-State: APjAAAVYPMaU53GeN9RP5LA0C1Hxf5XKxvhN9yvLNzEr0u4HVD1J2vT1
        3KAmIll9yAqLtUxlIl71puqQ1Vy+
X-Google-Smtp-Source: APXvYqzuwkPbiN7GzpY/CuKIyI5VpQgAjaS9IVTnFJfhiS5/RKFPCZ6XCYi+XTgDt6H+2UGxdP73YQ==
X-Received: by 2002:a0d:fdc4:: with SMTP id n187mr2727021ywf.132.1573138774362;
        Thu, 07 Nov 2019 06:59:34 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id 124sm951116ywo.98.2019.11.07.06.59.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 06:59:33 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id j190so670965ywf.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:59:32 -0800 (PST)
X-Received: by 2002:a81:53d5:: with SMTP id h204mr1071614ywb.411.1573138772305;
 Thu, 07 Nov 2019 06:59:32 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008c6be40570d8a9d8@google.com> <000000000000f5a6620596c1d43e@google.com>
In-Reply-To: <000000000000f5a6620596c1d43e@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 7 Nov 2019 09:58:56 -0500
X-Gmail-Original-Message-ID: <CA+FuTScESZAhoyDvD3uNq3SRC1=5dvnkONW53tZ0vj0tLnbF-A@mail.gmail.com>
Message-ID: <CA+FuTScESZAhoyDvD3uNq3SRC1=5dvnkONW53tZ0vj0tLnbF-A@mail.gmail.com>
Subject: Re: general protection fault in propagate_entity_cfs_rq
To:     syzbot <syzbot+2e37f794f31be5667a88@syzkaller.appspotmail.com>
Cc:     allison@lohutok.net, andy.shevchenko@gmail.com,
        David Miller <davem@davemloft.net>, douly.fnst@cn.fujitsu.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        HPA <hpa@zytor.com>, info@metux.net,
        Jiri Benc <jbenc@redhat.com>, jgross@suse.com,
        kstewart@linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        ville.syrjala@linux.intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:42 AM syzbot
<syzbot+2e37f794f31be5667a88@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit bab2c80e5a6c855657482eac9e97f5f3eedb509a
> Author: Willem de Bruijn <willemb@google.com>
> Date:   Wed Jul 11 16:00:44 2018 +0000
>
>      nsh: set mac len based on inner packet
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170cc89c600000
> start commit:   6fd06660 Merge branch 'bpf-arm-jit-improvements'
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e37f794f31be5667a88
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014db94400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f81e78400000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: nsh: set mac len based on inner packet

#syz fix: nsh: set mac len based on inner packet
