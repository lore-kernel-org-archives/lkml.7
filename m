Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAAC206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8qEun+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfDDOrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:47:14 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37303 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfDDOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:47:13 -0400
Received: by mail-vk1-f194.google.com with SMTP id o187so684269vkg.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ta2RvN4wePGlNokewK6TDhJiHr5vI+uy2KtuMR77OUA=;
        b=h8qEun+7IXgcs5rxuFQKR0vf6mXbu2eWiFZx1783Ow/nbqm7FglwnZxOehBfoUCOHb
         SCUdy0Ac3nZl4jJbTHTZ1IpkOcXwHZnatFINHbRktOhCZb6SSZ6rbaoTKoqxvdqG7m+C
         yVb+dNdd63khbqLcJOUs7OW+UgZQrQ0nIoxp9GOlrSMwkPk6tHu8tmblS6RZo7UL1TEi
         tlzi6izkVc6fJMs7YHQ5FO2MjwPPToAPxnalnAyVTT9e+MpRrgYIQz6pHXWUh8C6TQiC
         x2/IbeOXFyv4Xv/kOQxVIBPwqhJC0v/tw2ggEXnDdHknMA+3T/2c8RtiKK+jJLCk1cTc
         QmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ta2RvN4wePGlNokewK6TDhJiHr5vI+uy2KtuMR77OUA=;
        b=aaaawNiY1v/PUWuL69csN30nQeSy97O1JJ1aXsUqhDJI0rABktq/6p69ZKmZJAA2I/
         mNqY9BW3uM8UnGzfvytMwR8bg63TGRRcm+bfVKfAedHjKXMpp+jZ7Nb1MqaUYvSD605V
         Me7i7BGhnQwIp31S3J42mrubPqA4Nu4IvRFJ12V0jWJZea0xhWokjhw4m/oyOkHmzvkC
         EkN42rz+gZ9UFA9icTEZXJd81JWplD9BZY2czoTyth7odIEYLq4Na/BtL0C69VkU9wDn
         mbUD6yM7LoDpLjfQZO5A0PWtRnlgrcR0kfsWKjtJGbAezvVEpo6LFVo1JqdvUboyeJVC
         uZVA==
X-Gm-Message-State: APjAAAXFHTCbX4Oi1Y7jrFuaUgnNoiPv9AsbLjMvRE38VF/srLrOSLe/
        yRmvar1weH4RrKCs+25kPJ7hjMC2WOcAKWv4uzfN6A==
X-Google-Smtp-Source: APXvYqzdQgpoGiCnUbBQbr90bn/HC3BmR5wZgpRhzvE7Tqy2dqPBoKpglAu8RWyDqaBnCusRh85NHJg21dNsAUL9mNk=
X-Received: by 2002:a1f:4c3:: with SMTP id 186mr4234902vke.26.1554389232463;
 Thu, 04 Apr 2019 07:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001c2b95057ad0935b@google.com> <000000000000462a4105848c8e12@google.com>
In-Reply-To: <000000000000462a4105848c8e12@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 4 Apr 2019 16:47:00 +0200
Message-ID: <CAG_fn=VnXmDSc_QNqyEv7f7iwHXC6taBq1t55fHWZpLZ0EdiNw@mail.gmail.com>
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (2)
To:     syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>, hverkuil@xs4all.nl,
        linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        mchehab@s-opensource.com, mkl@pengutronix.de,
        Networking <netdev@vger.kernel.org>, socketcan@hartkopp.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:35 PM syzbot
<syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 6d469a202ee73196d0df76025af80bd6a379e658
> Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Date:   Sun May 14 17:07:21 2017 +0000
>
>      Merge tag 'v4.12-rc1' into patchwork
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12639fd720=
0000
> start commit:   6d469a20 Merge tag 'v4.12-rc1' into patchwork
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D15639fd720=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11639fd720000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd86f24333880b=
605
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D6c0effb5877f6b0=
344e2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1312062b400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D131bd09340000=
0
>
> Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
> Fixes: 6d469a20 ("Merge tag 'v4.12-rc1' into patchwork")
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000462a4105848c8e12%40google.com.
> For more options, visit https://groups.google.com/d/optout.

I believe this bug is caused by vivid_vid_cap_s_selection() calling
kfree(dev->bitmap_cap).
This makes little sense, as dev->bitmap_cap seems to be allocated
using vzalloc().

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
