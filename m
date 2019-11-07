Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B40DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1170D21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmmzf0QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKGTO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:14:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45433 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:14:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id h3so4286227wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iDZTDTB/jyv7kJZIFy/sxyc2ykTNZvGAaBQLa/ShJE=;
        b=hmmzf0QTwtpe2i5ndui9xmcE4mczzuy5JeE681EqwEXWharEzvJC8ljbnwjXTWxP+a
         FUkgdOxZzjG0W6LIHNaqh/ayb4XDl8lQ/XHQq+u/4GHRR0nHuH9GO0MrsYViGwXs7O3V
         wmTFl8a+syYCvVdXMOrdDEnlawVSJdOISlnSkv9+Xd1R97IUXXtob2qdEUBtAngik3S7
         tzM8HJNtKIAwDhfKd75aj604t0IkcCgomoiW3xfNTj66exQT9nyWH/2JqXZ6xw+2ruC/
         c9H3vBFefkDE+LhSelSsMRFv9ZHv5+/9ovi+1UxqKEtvKE1jzPeFouspJ0NWnHbq7/Tv
         VqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iDZTDTB/jyv7kJZIFy/sxyc2ykTNZvGAaBQLa/ShJE=;
        b=fKZ4Ux4AC0EjJfKY7tNO4q720nrZEb37bWtAV93AKxFNDsT5CvK+rY3WVHyIvp2f3/
         Nn+Ywx6U6CyPcxBauaSsGZJfp+AlQ88+BS9OHyWGQbBF77k/v9tNMfvhuqZRhuGePLCf
         khqjXg6EZUuYM8/LE9RsErKei+G7XMJe4PviDLp554Syt89JEUtw3gbSYOoJPbpjKtmZ
         wJWjQgKJFyK9wOBAe3dJwnTgB9dUqE174zhaOWnPprrzp19R8DIfmrewXTn1orVNM2ft
         VeuATmPMJhBfOEEZfRM/MBcYBlUQYK0O+34krqbElWTNNZlgj7m1PEoXuUriZVX4pknt
         TaVQ==
X-Gm-Message-State: APjAAAVUV4POq81rGrG6JvqZvGg0oHecy9Fk0bWpYrcoBE5TZpkyabTt
        kZ7RsEePFKwpZJ2FlaRkR6iGNal1qwdGTIkKQxI=
X-Google-Smtp-Source: APXvYqzbdQBW9opffq0zg7HWYbYUFxMKvNrEsJjtM79hTz/V2OSCylPz0xB5qNPyg8vyqW40/gLlvTRtsD+CACuUt/8=
X-Received: by 2002:adf:9185:: with SMTP id 5mr4708559wri.389.1573154064309;
 Thu, 07 Nov 2019 11:14:24 -0800 (PST)
MIME-Version: 1.0
References: <001a113ed49eb535d20568bb75ba@google.com> <000000000000b207e60596c1d413@google.com>
In-Reply-To: <000000000000b207e60596c1d413@google.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Thu, 7 Nov 2019 19:14:12 +0000
Message-ID: <CAK+_RLnEQQ-Ba2DGFXXT+pf7VT_4W0WoSomDW3hHBo8UP7SeYg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in find_first_zero_bit
To:     syzbot <syzbot+a88c8270030dc5d71e4f@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>, pombredanne@nexb.com,
        Eric Sesterhenn <snakebyte@gmx.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        torvalds@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: bfs: extra sanity checking and static inode bitmap

On Thu, 7 Nov 2019 at 13:42, syzbot
<syzbot+a88c8270030dc5d71e4f@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit d1877155891020cb26ad4fba45bfee52d8da9951
> Author: Tigran Aivazian <aivazian.tigran@gmail.com>
> Date:   Thu Jan 3 23:28:14 2019 +0000
>
>      bfs: extra sanity checking and static inode bitmap
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16634ee8600000
> start commit:   b5dbc287 Merge tag 'kbuild-fixes-v4.16-3' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d9b0d91297e224bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=a88c8270030dc5d71e4f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cf65d3800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d99ab3800000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: bfs: extra sanity checking and static inode bitmap
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
