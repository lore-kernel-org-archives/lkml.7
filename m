Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62941C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329CE2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKWC1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:27:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50363 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfKWC1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:27:01 -0500
Received: by mail-il1-f197.google.com with SMTP id l63so7898502ili.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 18:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AXD7gA5IclP9MlEfBt3hOECjOVr1z7Xrb3xxCpv2mBI=;
        b=M4XNTskJo6V3kiz+P15Mp2jz1DkIQqjd55R7GNWsMzio9wDeK4hvTWjP0/ehESTiXK
         50HhKHreyh0ojS0+XYZJYpOfrCSW+jcg0sk2TyinmVeyN1aNS8e2Z+akRiRYFXtnRMgK
         +13vaZiLs4fd2AZdbCT8oMGu41gq2JhKPrSkdDoo0NnM3tZfMYF0o0y7NjUZ1P7jl1eW
         n8cgreJgAx7klhnang5zco2zFXAjvCr6XRBYDG2Jt3XrqgL3DNZVSCODR3A5sxWJPbnX
         TTRCLkghCrKNlz6LKVuxXbSXIGhtCsfgd+eaS7fNORcTP319mXOclBbUW5/uiMwQuBol
         h4Aw==
X-Gm-Message-State: APjAAAV95rFPNplDCiGooGzCEXJmInBAFoMGh7rGWbLMouok6SVy63VW
        vZSxvecmMcYHz2Arfb3ftgJOOj6lDTrwkdeqx/zzCjCzqjbm
X-Google-Smtp-Source: APXvYqw+zwi8wEAChrZq2ZVReXjmVskvTdckaXjZ2KbBA0nnhxgLvaWwwG2piW1E9CjkkowM30p50xw7NE0F2nHtTiaknnYm/gUD
MIME-Version: 1.0
X-Received: by 2002:a92:bb95:: with SMTP id x21mr20040816ilk.128.1574476020687;
 Fri, 22 Nov 2019 18:27:00 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:27:00 -0800
In-Reply-To: <000000000000d03eea0571adfe83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebac4d0597fa4340@google.com>
Subject: Re: possible deadlock in mnt_want_write
From:   syzbot <syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, ast@kernel.org, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        mszeredi@redhat.com, rgoldwyn@suse.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8e54cadab447dae779f80f79c87cbeaea9594f60
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Nov 27 01:05:42 2016 +0000

     fix default_file_splice_read()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15147a36e00000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17147a36e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13147a36e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111767b7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1611ab2d200000

Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com
Fixes: 8e54cadab447 ("fix default_file_splice_read()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
