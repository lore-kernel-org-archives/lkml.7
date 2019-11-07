Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E636C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F012077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbfKGNmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:45654 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbfKGNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:05 -0500
Received: by mail-io1-f71.google.com with SMTP id c17so1839964ioh.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gvUkH9WtkGdbkvkGEgBQ+scD8gdIfAilVOE5agk0pc8=;
        b=MJYwU5cgD6Mz3GwfkpSp4LEBMObsYhNrCZcKn0dqJJX39K97MyaOaKSknxbgABrYCI
         HGYNBy7uRfCv0UjcDx+Bn5jaE8elkSXgfEnItryKuAi9E+NYi60mXpZtyMqTPrmzo43/
         A7dc2l4RPt8R071JYMC61PXqP9/bVZCWM5aChi8ksV1Evm77tvn6PshpNq2Yj0eHV+LV
         ygiiEr0uSeQPpa32MOf02+H7drWwUcV2OnCeH89koA0Pkj2oe5CEVJAQGRCnWl0uVJSd
         dd+jutHemAuJxLn0LpxJnsW9f5SnXwNLnzISmKour/CZsWiQpNGdO+A8cplun51FZxiT
         NHSg==
X-Gm-Message-State: APjAAAUZewpk/upzbHQN5sQB8A6fEJuHhxR6bPgIcjXy94BnnqAlH2oS
        Ol9xpt8ruhPN9B+hqWwuRLZKw70D4U3vFuwwEo+9yM9oxiln
X-Google-Smtp-Source: APXvYqyA7RhiUvzMWSWZWI0ZIzVE9r/zHAJ0MtS5719wr8hUNsn3YgfguE5aJGhDksrtNHgLkCcvbS9hR4ypG3I2APwuBGeGv9Ux
MIME-Version: 1.0
X-Received: by 2002:a5e:9617:: with SMTP id a23mr3354786ioq.191.1573134125143;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <000000000000d0429205723824d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6a0aa0596c1d4df@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in end_requests
From:   syzbot <syzbot+cd4b9b3648c78dbd7fca@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 45ff350bbd9d0f0977ff270a0d427c71520c0c37
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu Jul 26 14:13:11 2018 +0000

     fuse: fix unlocked access to processing queue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1494e3ec600000
start commit:   dd63bf22 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
dashboard link: https://syzkaller.appspot.com/bug?extid=cd4b9b3648c78dbd7fca
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b9732c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c469a4400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fuse: fix unlocked access to processing queue

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
