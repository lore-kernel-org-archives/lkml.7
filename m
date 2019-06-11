Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988A5C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E38D20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbfFKADC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:03:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:58155 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390762AbfFKADB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:03:01 -0400
Received: by mail-it1-f200.google.com with SMTP id s2so956476itl.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BGU/uwJcReQCv6nn+WhFGIGHksEiczAeWFNDRC68WZQ=;
        b=SViGZ65cc60/MjNR85cHxQZHfOhCKMkxxpoUWfsJMqIzLcJEa8MXkQsf7z9xA5c0nH
         f6B+Gxq75LBgzZM1blf5fvGtQbgTcrUWmaiQ9W0+CJZtnfHIWzDemdAYqTBhnmY6PfzT
         8c2zNmHj23KN0AS7WYW618ACCMEp61F0blIn/hEQazjEGKyRTsDivFyli95+rPsbzMHP
         CFK3zMJD2iAQYPuXGkAxU1lhYyOL9+azH+rwGNXNzYi1ENDAhAnLZxL/tI+p1ZsiwXdb
         HE/m2iYRIMmbi+aqqmp5zGsA2NSKqcO4fY1rbaHK2HaqLHtzWSwxn6FCIAouDtfZ9WfQ
         91ww==
X-Gm-Message-State: APjAAAVXcELnbXU8l4NTeJFFUmTUSsvRyYpTprzKMFTEkVvn/7tEg4bU
        qN5SN9c7htSn5tblWyT1YCKAB/2KuMRIgtVxxJKDmiiKrpaQ
X-Google-Smtp-Source: APXvYqzx9rj11bcg+7STaXdm9KktQ2r9Jg6Sj2EJYOft/TSvFh3KUQmHtzKOUCqSnnwXsGCuuE5sSmY8xInECwTtYZlI3FkBzuRU
MIME-Version: 1.0
X-Received: by 2002:a24:f6cb:: with SMTP id u194mr4207390ith.160.1560211381250;
 Mon, 10 Jun 2019 17:03:01 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:03:01 -0700
In-Reply-To: <0000000000002f9ef4058848f26d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000277785058b0105df@google.com>
Subject: Re: KASAN: use-after-free Read in kfree_skb (3)
From:   syzbot <syzbot+dcb1305dd05699c40640@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 5ec8c48a6235175f7ff59ed1acbe91d4d0398026
Author: Thierry Reding <thierry.reding@gmail.com>
Date:   Thu Jul 6 15:16:47 2017 +0000

     Merge branch 'for-4.13/drivers' into for-next

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef22daa00000
start commit:   d1fdb6d8 Linux 5.2-rc4
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ef22daa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ef22daa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=dcb1305dd05699c40640
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c787f2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e32801a00000

Reported-by: syzbot+dcb1305dd05699c40640@syzkaller.appspotmail.com
Fixes: 5ec8c48a6235 ("Merge branch 'for-4.13/drivers' into for-next")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
