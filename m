Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E25C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9B92087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyYpd+dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfEPNUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:20:01 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45168 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfEPNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:20:01 -0400
Received: by mail-vk1-f193.google.com with SMTP id r23so999286vkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Mom9MODQ5/QqS+RDXttev2mPfjd0+NlE9IuL/dY7r0=;
        b=NyYpd+dkEe2YZFx36BzlohQJ+8JNYLj3zvAZeOi8NXLBd9Cfc1WAr4LKDFtfqnGpad
         StU7H7B3CNs4PTRtMPNyu48VG0OZOTZup0nt++JNMt27PlrD0ZmxJV1bfN72QLCfNuf6
         w7gdkwYzuTZZNUyNWLDDFcEpc+Yt/Koj5aaJMPvc1MnekJnzFPwg/6VOt0JMkZ3JCPck
         x3J0yX/c5zszJjTgdOGbi0c8d6dY2RpB2WP5V1wutc4hZGvz37FMXRudGdXPGb3adGS4
         HMQw1aG9pYnoANuDja2STHdq5iiD076Y53phnswgHQxYlemD+OLxg7fnU/di1ZVQ146z
         ojdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Mom9MODQ5/QqS+RDXttev2mPfjd0+NlE9IuL/dY7r0=;
        b=O4YC1sQv5B5iidEW/wMgseNT3DBCG+c86QLmgGQNPZrsoTLxrOBif+z9HocI9NMuQJ
         n6OSgVqz25xdy8OsFfHUqcdHA9fVMjLDZjUs8WuDpWrPAUQgfT8IO82VJFYdI+OAMGJy
         jaE0FxQtx44zUBBcR3fJ9k8Oc8B4BFIBnkCs9wk4/nYtLEFcb7Zo8Sp7/tQmCClbSaMx
         XNakb8DTtjGKTgauYF5XBC7ND3g72g5S0Ua8wOkqiaUr9i19U93rXjUGUfl7pMZ0UgGs
         w/UiD+56ujcKOTrdJ2Ug8zqOiWAmgUnxDBIqaigUwZroSqrPty4GIFOiG7QIQoyzunNR
         2XjQ==
X-Gm-Message-State: APjAAAUKPdSFf5cUgiLiLZBYYNZmJAAYdwSeBJOBG5IbJvSjjrjhY35U
        FCEqSnM2sJlIoATqHpzAWcdKKf215MBZbD/Zk9UlPsQE9fc=
X-Google-Smtp-Source: APXvYqwHkWIjT82JQxz+Mhj+wFekyLzeKbvlA3oD6vV2Dm+OkWUy416z1duYLdzrQPrdKwcvwPtwQgxdzG09+lz8BzY=
X-Received: by 2002:a1f:3492:: with SMTP id b140mr22269628vka.8.1558012799699;
 Thu, 16 May 2019 06:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000032685a058900d170@google.com> <2b0b9d18-6773-f2dc-ecb2-9f8782d0962a@i-love.sakura.ne.jp>
In-Reply-To: <2b0b9d18-6773-f2dc-ecb2-9f8782d0962a@i-love.sakura.ne.jp>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 May 2019 15:19:48 +0200
Message-ID: <CAG_fn=UHjDv=Jc_nEKKknVGrr9CC4rZ+a+hw_yAL-j4y4=89cg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in tomoyo_check_inet_address
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+1018d578c410f9f37261@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, May 16, 2019 at 3:13 PM
To: syzbot
Cc: <glider@google.com>, <jmorris@namei.org>,
<linux-kernel@vger.kernel.org>,
<linux-security-module@vger.kernel.org>, <serge@hallyn.com>,
<syzkaller-bugs@googlegroups.com>, <takedakn@nttdata.co.jp>

> On 2019/05/16 21:58, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    3b955a40 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       kmsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1027e608a00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D602468164cc=
dc30a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1018d578c410f=
9f37261
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang 06d00afa61=
eef8f7f501ebdb4e8612ea43ec2d78)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> This should be already fixed in linux.git.
>
> #syz fix: tomoyo: Check address length before reading address family
>
> commit e6193f78bb689f3f424559bb45f4a091c8b314df
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Fri Apr 12 19:59:36 2019 +0900
>
>     tomoyo: Check address length before reading address family
>
>     KMSAN will complain if valid address length passed to bind()/connect(=
)/
>     sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.
>
>     Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>     Signed-off-by: James Morris <jamorris@linux.microsoft.com>
Apparently the fix didn't make it to 5.1, I'll cherry-pick it to KMSAN tree=
.
OOC, how did you know about this bug?
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/2b0b9d18-6773-f2dc-ecb2-9f8782d0962a%40i-love.sakura.ne.jp=
.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
