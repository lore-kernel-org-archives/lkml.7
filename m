Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B346FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BECE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHDyIDVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfCUGQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:16:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38361 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfCUGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:16:48 -0400
Received: by mail-it1-f195.google.com with SMTP id m18so2597626ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 23:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cv9mS/i7Jb4Kn4RbuLkCyePTLzYeaAxsBm61fRP73/8=;
        b=RHDyIDVTzZQRFnZE4RITMCGvqJ7WEwNlupU3QWicxZDLauOniDEvgOnSYr48YtuaI2
         i9+3t1PXaZSrd7b0AUsR2DHm9BGfkB7WrWHs3VM2MhHdUbVRixtHZF7NZrAy2PWkOv2x
         I+y4MSM6dIDOyh+m0frgdLge+wXR96C3nKdBiMVqbuivruBqGrVbgmm3ft+AR4Dhvnu6
         0KJLYvEKZ+YZ19eJ6F8WEFeW01CqfsP4Ne2+GP2LYZIxsLs/Z8IfR/Iiu4Kk2NaazRpz
         vxqnp/SInMRoHPdy2oX5LWpNw8mV4waZP/2capvIERShYvy/3svn/+y9mobF04wu68e8
         o20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cv9mS/i7Jb4Kn4RbuLkCyePTLzYeaAxsBm61fRP73/8=;
        b=bbL7+0n7Qy3cxXgZOOXC8RWQrRphNSzJqI4x4uDhnEWbna6Jmt7KP+5cldlG4BKv2z
         CxBkieG18WkrnD9WY705jIHhG/i2iTRjA+se2658jJh2rCb1KubAPOQ8WYMXlLF/M8fM
         j2BpxKU83AbY/psAfnES6NLAwAAhbYBEXr7VRh3K4hzV5YQV2v/2e3gsEvoEKFBaVmFY
         9r/FW3HjpfXC3DG/38Ss0/ndtL/OKa9Cx20V+atBQnGSRhoAYQMvEyjNV2B2VMt1J6R6
         1GJiUr2RWurbH9ac3FC9wsgwdO6/RwaLv0cFDUbVVAYV6sw50geuOI7UeLcJeNnTsMN5
         o5pQ==
X-Gm-Message-State: APjAAAUEkgmziepXierHF7v4NGetCZmca2LwntvxScehsz7rvGBMZrC6
        1bWtETGDV7hgglUjgnES1DlTw8ViaEeg1VCJ9SFbjw==
X-Google-Smtp-Source: APXvYqxNXGlvsgTZkAjtMMZRnbRJhsmEzVY7hmuudTiQTaqvDTRmZUBm0/4mBx8ObqK/6hIysIMQtZ46ZtGW61YxRXY=
X-Received: by 2002:a02:84ab:: with SMTP id f40mr1410324jai.72.1553149006772;
 Wed, 20 Mar 2019 23:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b3976c0584940e6e@google.com> <87lg187oao.fsf@notabene.neil.brown.name>
In-Reply-To: <87lg187oao.fsf@notabene.neil.brown.name>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Mar 2019 07:16:35 +0100
Message-ID: <CACT4Y+ZwfyCjT_UBq4FwXd8SkmktBXqDFKM87x5fbstYJe4YuA@mail.gmail.com>
Subject: Re: general protection fault in __x86_indirect_thunk_rbx
To:     NeilBrown <neilb@suse.com>
Cc:     syzbot <syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 7:08 AM NeilBrown <neilb@suse.com> wrote:
>
> On Wed, Mar 20 2019, syzbot wrote:
>
> > syzbot has bisected this bug to:
> >
> > commit dee160df820de41ff2f59a715643680822a0ab06
> > Author: NeilBrown <neilb@suse.com>
> > Date:   Mon Nov 5 01:30:47 2018 +0000
> >
> >      locks: use properly initialized file_lock when unlocking.
>
> This commit did not make it to mainline.
> It was replaced by
>
> Commit d6367d624137 ("fs/locks: use properly initialized file_lock when unlocking.")
>
> which added a call to locks_init_lock() in flock_make_lock().
>
> NeilBrown

Hi Neil,

You are talking to robot. Robot does not understand English prose ;)
Here is info on how to talk to it:
> See https://goo.gl/tpsmEJ for more information about syzbot.

In this case I think we need to say:

#syz fix: fs/locks: use properly initialized file_lock when unlocking.

> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f39fd7200000
> > start commit:   dee160df locks: use properly initialized file_lock when un..
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=100b9fd7200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17f39fd7200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
> > dashboard link: https://syzkaller.appspot.com/bug?extid=83e12cf81d2c14842146
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd9447400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1121d82b400000
> >
> > Reported-by: syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com
> > Fixes: dee160df ("locks: use properly initialized file_lock when
> > unlocking.")
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/87lg187oao.fsf%40notabene.neil.brown.name.
> For more options, visit https://groups.google.com/d/optout.
