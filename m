Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20C8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7B220868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfEVVtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:49:03 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:42149 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfEVVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:49:01 -0400
Received: by mail-it1-f198.google.com with SMTP id s18so3303734itl.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TIQGF/z6Uv9dk4W4KZtT8M62kZhnd/SllJeeMECtlHs=;
        b=hTkuL1HEI9To9+6oPSZGaGg65+qCzffUCMLTqT1ZVR9YMN7zHZZwcieCQgU8ACkuG5
         nXn2RI676YbLVe+MJetpeamujkcA2MA7p373QIhZ89+OLdQR0awB8ajZMoX8+WXZ5Mql
         nvAfAbb5Ir0hRERkaBjEWHTKZ0RtvNzihS0eF+nRW56AieultcDMjWi4tOgts6/zci0P
         adFlEgp8SySkGGGnOPfO3IpooKVsUL4gLiSyR/kuwVJgM7SMuG6wlZ+MgICwMtzUzOlv
         casskPpSEyardXxyciKtAmAxWK0UXWX1mPYA7+yRhltUdKYjjVEuus/mxppm+ECHdHFJ
         QhgQ==
X-Gm-Message-State: APjAAAXKsNbQQEH74GczBRcgwL8LEwwVRJakDQQeb5dmLr27tiLhDiXM
        rmo5BQvtSiIZyJsSYqZS1yO/4DkpMZfxMb+NIU5hHt/R14EC
X-Google-Smtp-Source: APXvYqx3pKlCIWImXjwTHYPQ2q7elS7eFooEn3z9joINI2kGSb5fVGpbdl7LNLXsN/Yjq2bq1zV8ffOmpetSZX7ITiCgllSz/ztC
MIME-Version: 1.0
X-Received: by 2002:a24:6292:: with SMTP id d140mr10402926itc.132.1558561740544;
 Wed, 22 May 2019 14:49:00 -0700 (PDT)
Date:   Wed, 22 May 2019 14:49:00 -0700
In-Reply-To: <000000000000fd342e05791cc86f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7e3a5058980ee7b@google.com>
Subject: Re: KASAN: use-after-free Read in sk_psock_unlink
From:   syzbot <syzbot+3acd9f67a6a15766686e@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 48a3c64b4649b5b23a4ca756af93b4ee820ff883
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jun 29 14:11:03 2018 +0000

     Merge tag 'drm-fixes-2018-06-29' of  
git://anongit.freedesktop.org/drm/drm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f92d6ca00000
start commit:   f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13f92d6ca00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f92d6ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=3acd9f67a6a15766686e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13adf56ca00000

Reported-by: syzbot+3acd9f67a6a15766686e@syzkaller.appspotmail.com
Fixes: 48a3c64b4649 ("Merge tag 'drm-fixes-2018-06-29' of  
git://anongit.freedesktop.org/drm/drm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
