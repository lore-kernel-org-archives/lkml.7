Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D011C5B578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCC820828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfF1TjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:39:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42613 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfF1TjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:39:02 -0400
Received: by mail-io1-f70.google.com with SMTP id f22so7738927ioj.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6MBa60ZEQW0KfIiP0tSSYs5YVeMvKCMq2VKhW00PUqk=;
        b=skpJIel+UUTIepuA3H/dTdFRbdfBhzd2NcJjQJgKU42T8X669S4Q0EStQ3KqLZHy6j
         Ymrj0Fkp9xgSXOnZsXYFWKehKy4PzPzL1Pq1Ga9P8zLxvwr3T+MNFdi/o0F5WDxkda1S
         o/d+khiuK1T9fyZV16pIWh4Aw/THnwDp00SfwaKvds/jCZMsiOaKWpl/fsOVqByr37Pm
         yVEdELqEwdh4xhsDxwrrFgIR7mDfF8TouM5Q9dXmj2RNHq7mXQd9SqizThOA3c0KNz4I
         dqDPN37QrQdTZGF8UmFtFPVZjSJblu1tbJgRuhX+NQmUI4if9bTn+leoorAiDFQx0B0e
         YADQ==
X-Gm-Message-State: APjAAAUboqIrxWzl+1OY1cjWdCvwG3liO+v+0+wX3RtXlESXss9T3Wr3
        F95ovB66ukS3Guh8mfD8aX3Wg6Az0ON8NvAeA7Y+HDgk8zfU
X-Google-Smtp-Source: APXvYqyG9FhR3Hf0uDF4YrYl41IirAkp07VFEYWJqDIdjxISRyPh+xrAnO1HB/EouuP8G7Ie0xNGvLv/dNZy32m373iQYOFow0fw
MIME-Version: 1.0
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr9240612ios.84.1561750741066;
 Fri, 28 Jun 2019 12:39:01 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:39:01 -0700
In-Reply-To: <0000000000001c03bf058baf488a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002628bf058c676e46@google.com>
Subject: Re: BUG: unable to handle kernel paging request in hrtimer_interrupt
From:   syzbot <syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        dvyukov@google.com, hdanton@sina.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14436833a00000
start commit:   29f785ff Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16436833a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12436833a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=037e18398ba8c655a652
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16da8cc9a00000

Reported-by: syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
