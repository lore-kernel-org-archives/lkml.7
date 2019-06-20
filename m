Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A172C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA852083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFTOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:39:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34995 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:39:02 -0400
Received: by mail-io1-f71.google.com with SMTP id w17so5528335iom.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pcMSWZKNicDpxHahzslAEA1Gd+yI94665La65rLMOto=;
        b=f/nc4bWR9hRx3+ZM6vxEHoXeHbRkfwqdUBISUHvFfYk2h3GHq8T05Ub1V/EzeCqTYO
         vOd8+OXiD8Bw9gkxQhExlWsy+thp24tOL1BmRp0Ik3/sp2MyMn+ySAbghdvlwcD7gOfS
         K+pbaQ5k2Rum0+Qs+0w53Ftrx5XalWixVMpX90v5KhiCLvhCD0OGWrdtL7z9XW1aZTID
         CIErh75Q1yDc1g0O3eIJsmxOhF7qm9f0UK9KMwogOjHuH33nyST1Lzf7YnrPD5fMZIo6
         4CVSWUXlanpvAtnn5u6bVwkPepyECghFfsb1iKcPFD+N6PrmQAY9lZq8tMKfABbA/Z62
         gDSg==
X-Gm-Message-State: APjAAAXqfHQkTU946xQUJQO3ZLT7siqkL55R5yT+FKNLmvwIRQOL3Gvg
        NxZMeSioU9fL+BZBaH+dyapK47gpz3YiG5XxlE3BIzEkH2gh
X-Google-Smtp-Source: APXvYqx+TYIh2vUv0uFyzxELBI4G5xYxTzkRj8btxI6/Q81qlMHz++HJM+3ytmsKnLPIC+Zek+ch3AjsBD++T5mDMbdR5vtbxIMl
MIME-Version: 1.0
X-Received: by 2002:a5d:8c87:: with SMTP id g7mr20051791ion.85.1561041541089;
 Thu, 20 Jun 2019 07:39:01 -0700 (PDT)
Date:   Thu, 20 Jun 2019 07:39:01 -0700
In-Reply-To: <000000000000946842058bc1291d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000894e8f058bc24e2b@google.com>
Subject: Re: WARNING in add_event_to_ctx
From:   syzbot <syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        jbacik@fb.com, jolsa@redhat.com, kafai@fb.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 33ea4b24277b06dbc55d7f5772a46f029600255e
Author: Song Liu <songliubraving@fb.com>
Date:   Wed Dec 6 22:45:16 2017 +0000

     perf/core: Implement the 'perf_uprobe' PMU

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17561aa1a00000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14d61aa1a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d61aa1a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=704bfe2c7d156640ad7a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d8b732a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f7a5e6a00000

Reported-by: syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
