Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE30C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 03:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B10208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 03:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfL1DQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 22:16:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:54284 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL1DQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 22:16:02 -0500
Received: by mail-il1-f199.google.com with SMTP id t4so24364787ili.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 19:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tENWWAE27YTP2yqe1cfIcG9EDWGCKbHOtQOZmBsBGGY=;
        b=sRWUBIdLjfcZu3WJ+IMMYmCTZnOZMoAY1xid+wiKxUypX126CL2fOiXH9l+/kSt1Qi
         TQCOJ5WwWUemRuVoa1ZXEGDzr6zjjikvcWTPJk760fhKb3ftYuB0RtGjINTsAmhyHYyX
         zqJguzWwWlOIY1Cz9kc9vcdeEN9KdfHxTJ0SHH4RdndJ1BcIP9NoKdvbbOqEKgccrxXS
         12jLtOP0QunA5oA08+6Njdu6TsOKxVhkhXogktnrss/Adayf4hZuQ8NJgXgbfQ9/88rO
         788/1KQfrvwEs4BZYHqb+VZ0Bk7ZfFcgMqNSV1+WJ3lWBgNUsZob1+pMrjvm1EfkGJhI
         5G+Q==
X-Gm-Message-State: APjAAAUEUiZvozq76XEfZYghvtYwPWB9RU/CH/j4+3yK271l4BNeduBy
        fL2a/n37V58OldR0+4FAWL5YN/L9uERB5eC38uw/DZUApwd1
X-Google-Smtp-Source: APXvYqxY9e4ExCKBaEkRVOc0Gz/ijRbw/6DBPk1AZLfsryIA7+WPJ0/IOYZQU5ZmHPFx8KUtYJLK3dewq52wTtd7Gg6W58geGSRn
MIME-Version: 1.0
X-Received: by 2002:a92:89c2:: with SMTP id w63mr46971728ilk.252.1577502961862;
 Fri, 27 Dec 2019 19:16:01 -0800 (PST)
Date:   Fri, 27 Dec 2019 19:16:01 -0800
In-Reply-To: <089e0825d4a4d2cb2a0562e878f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac9246059abb072c@google.com>
Subject: Re: possible deadlock in sch_direct_xmit
From:   syzbot <syzbot+29cc278357da941e304e@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, davem@davemloft.net, ecree@solarflare.com,
        edumazet@google.com, jhs@mojatatu.com, jiri@mellanox.com,
        jiri@resnulli.us, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        mcroce@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 323ebb61e32b478e2432c5a3cbf9e2ca678a9609
Author: Edward Cree <ecree@solarflare.com>
Date:   Tue Aug 6 13:53:55 2019 +0000

     net: use listified RX for handling GRO_NORMAL skbs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14647ab9e00000
start commit:   c92a9a46
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=46986c099cb53bc6
dashboard link: https://syzkaller.appspot.com/bug?extid=29cc278357da941e304e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143636c9800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16856849800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net: use listified RX for handling GRO_NORMAL skbs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
