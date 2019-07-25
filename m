Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5F9C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D60C2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfGYQsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:48:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49888 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGYQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:48:01 -0400
Received: by mail-io1-f71.google.com with SMTP id x24so55505784ioh.16
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RIyoo7tX1yNs3TKOq4NKYW32kQ5qo7m0vsA24OoRalg=;
        b=sxfBIVEWb4uKu2Y0BHUiQjhZA5b6FwYye8fHIWDYHEe6MIR7jpjkfi5TBXvyDKOlNr
         bKoZJ7L18zwTH34L5554J+QJbPOX1+xo3KOY8iMz6OHSu4556RXtTdkm8Q4lq6AI+yNl
         8ojsXNEDDHxcsxWw2FpxFWgozk7yF36OcyK+Ie2AQegdMruRb144XJbOgEmIss7IdZNE
         BX7+vcdrPEmTkTn466fEihB0emhfSIB3swvqsQJi/zDOdPiLUFJOwQvSwjJjbViSDW7k
         SugbbBI4S7RvwfqI7M2zqHncTRByLGW0xT6Ow6gjD9tU+ssM2LY13x1VBU7HlMxrpeY4
         1ebA==
X-Gm-Message-State: APjAAAUNcy9rRMPvZKBmnHnqGt9ekPN6x+KU3OUtd1KodwzTDIYLM3Va
        gP+8sSUhldFmqzzYQ8xehlqsd4EPJsT19aKAJh1nCdDHVwki
X-Google-Smtp-Source: APXvYqz5TRtqk7NLmHZ9yCjKgr37hlCy64JGLcLrJPFsu5MG3DE1E7Gd++DbNYtHpzMzIfx8epvxltXfNlkPKaKIMMo/U8GbRTzt
MIME-Version: 1.0
X-Received: by 2002:a6b:641a:: with SMTP id t26mr37599516iog.3.1564073280346;
 Thu, 25 Jul 2019 09:48:00 -0700 (PDT)
Date:   Thu, 25 Jul 2019 09:48:00 -0700
In-Reply-To: <00000000000070c81a058e6c2917@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004761fd058e843049@google.com>
Subject: Re: memory leak in v9fs_session_init
From:   syzbot <syzbot+15b759334fd44cd9785a@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, catalin.marinas@arm.com,
        dvyukov@google.com, ericvh@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lucho@ionkov.net,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 16490980e396fac079248b23b1dd81e7d48bebf3
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue May 17 02:51:04 2016 +0000

     Merge tag 'device-properties-4.7-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115e94cc600000
start commit:   abdfd52a Merge tag 'armsoc-defconfig' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=135e94cc600000
console output: https://syzkaller.appspot.com/x/log.txt?x=155e94cc600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d31de3d88059b7fa
dashboard link: https://syzkaller.appspot.com/bug?extid=15b759334fd44cd9785a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1735466c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117e0cf0600000

Reported-by: syzbot+15b759334fd44cd9785a@syzkaller.appspotmail.com
Fixes: 16490980e396 ("Merge tag 'device-properties-4.7-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
