Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF98C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6021775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLRDLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:11:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:44146 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLRDLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:11:02 -0500
Received: by mail-il1-f197.google.com with SMTP id h87so638973ild.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=B/UHccQy2GUPLjKClLjPB9mKSYRSTTFVhiFG9ktmLyQ=;
        b=AP7r5CujG0ibTQfzBD3gfQlfBycQRkfB6XMnFDdSwOF5Mdoftgb81kps6KbdgywzuQ
         sUDxl2BjN+vh1OC/NzqrzOP+VeUh5lzi/axYtNFTT/tTJom44k/OIMcs9BzkyHEcScp7
         qdvwZ/GtLkH+6BAqrYbba6/gXK8wewP9vjr1XWWCA9M2EJ7YMyLUvm4AAtSHDrXPfSMe
         a4nXCWQzomhDvdER5eQelfv4voluedqdjbCDfnCXlXtgkGMgup9mlupajgK7XhiPBcE2
         RCgEeVNNC2RRTrxnQ1QQ1jtJ9mTM4O0RSkj9EsQYAzzTjEXA7MqG03lqrSWKtG9YwBjR
         zTbQ==
X-Gm-Message-State: APjAAAVbLAiGw/0YiFgd5HS1P3h6RDcxH95pMa+HrR0SE0ppzlkIUJkK
        lhXopNeg/ve94GRIPVObyyH5+JwjO6nuTsqigg1TIjjU8aKk
X-Google-Smtp-Source: APXvYqyMCK4p3QJRNreOaLBgYJejAM1cYoWdGoPJ26FTPuaQyelg3Sjap478JDrBsEezCSHSp7yUtmv244NHO0fzr3UX5/+ddebT
MIME-Version: 1.0
X-Received: by 2002:a02:cdcb:: with SMTP id m11mr361306jap.125.1576638661887;
 Tue, 17 Dec 2019 19:11:01 -0800 (PST)
Date:   Tue, 17 Dec 2019 19:11:01 -0800
In-Reply-To: <000000000000b6b450059870d703@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000618d6a0599f1cb49@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in precalculate_color
From:   syzbot <syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        lucho@ionkov.net, mchehab@kernel.org, netdev@vger.kernel.org,
        rminnich@sandia.gov, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk,
        vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7594bf37ae9ffc434da425120c576909eb33b0bc
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Jul 17 02:53:08 2017 +0000

     9p: untangle ->poll() mess

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e323a6e00000
start commit:   d7688697 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e323a6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=121b4285bac421fe
dashboard link: https://syzkaller.appspot.com/bug?extid=02d9172bf4c43104cd70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119c517ae00000

Reported-by: syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com
Fixes: 7594bf37ae9f ("9p: untangle ->poll() mess")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
