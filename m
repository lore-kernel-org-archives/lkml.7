Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54260C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34602218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfKGNo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:44:26 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:56918 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbfKGNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:05 -0500
Received: by mail-il1-f198.google.com with SMTP id e5so2592081ile.23
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ENxD+/fIw0mYa6vyCEJ9BP1QogAHJZe3kkohsrzQFAg=;
        b=oL4AYxtLXsRCDsksDzw6xN9HB1oTZGmK2fByoVIBvay0dD1JqfKpD2MtzU8C90QdHz
         74pA5q0EImVzZbvPRNc38V+94pD6KmJxmHqVJnPyiMcHKF4Ka0s0ei08gu2IYLZ7PxJg
         97yb5CaPtieNFtHv9oBPTSlLgjt7RNgyh2Fs88rFXZB1eJZpbTjeaZ0ETNW3oFkj6sDs
         3SDjOBCEinnkDFQRuz1jOipxm3VA0601npjGYdcMq/6XuCS8vDTqHCnmWbjgGVZn2VeK
         hR2JAint9nudKxMToMFwhgpkBPLvOI7m0Ra4ADgTMtFgevgIZFWArQB6JMU/yML5kElw
         LhKA==
X-Gm-Message-State: APjAAAVYW4wvBIhCe2JjElgMbOpjb09jK3V9PTuttw1CE45hkt/CgU4H
        oJJcq39JUN6+CWxkBFH2rDk2TUIPE2+8aSFNcNJ7/qPNa+/1
X-Google-Smtp-Source: APXvYqxgUiKUUpVf8mANbwuq5h5ETdkG1+2bc1EZcA3Iu8zgmeR5189VzsX5FO9eWFvmABYaiGgJH8JWUel87EI/ZKuu+fPSmejM
MIME-Version: 1.0
X-Received: by 2002:a6b:ee07:: with SMTP id i7mr3695643ioh.26.1573134125000;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:04 -0800
In-Reply-To: <000000000000ee4dab0570be896c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4731e0596c1d418@google.com>
Subject: Re: general protection fault in p9_conn_cancel
From:   syzbot <syzbot+4d29d76a0da7a8c4d86c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dominique.martinet@cea.fr, ericvh@gmail.com,
        jiangyiwen@huwei.com, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 9f476d7c540cb57556d3cc7e78704e6cd5100f5f
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Mon Jul 23 18:42:53 2018 +0000

     net/9p/trans_fd.c: fix race by holding the lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1150b430600000
start commit:   30c2c32d Merge tag 'drm-fixes-2018-07-10' of git://anongit..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=4d29d76a0da7a8c4d86c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e2c5b2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179415b2400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/9p/trans_fd.c: fix race by holding the lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
