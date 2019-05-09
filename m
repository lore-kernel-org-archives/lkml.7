Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0487EC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC398214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEICqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 22:46:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48429 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfEICqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 22:46:01 -0400
Received: by mail-io1-f71.google.com with SMTP id l6so652313ioc.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 19:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t+LnHVTlAHrwSUZToYSE0usv9aUEGmgN35Wv7GBtso0=;
        b=bKNV5uH/H/uUI+nK2dUo5DPjjkcU8JEyRj7CDnrgVcLLBJHrJWWPd9tFbv3jbCjh0M
         TnqZNovlgsMJxEKgEdHw22b58NU9ajKKePIyww3t68NVQNUqJcXx8lbScDQvkf932DRJ
         gVih6W7TP5S8aPxHROLDd76Ro6Wh84y+A4YxQQ25pphykvHboXWZDheYSF+Ross6IKJF
         6TsRaWgVC3AJ6DcPzxSch4+Qi2mcl3bm6N7J5zCZhergpMlWZF2R3D2ERrkNUT924L1Z
         IDwd08IhVPS6xkNHycg49C0xNog2+i4T+M7VnSakoD2ZR/ObhKy8TP4VGesf/Uy5I40R
         S1/Q==
X-Gm-Message-State: APjAAAWF+N0j6zGu9WwhrHCZp/fSoT5LIsZam02dIsML7eY8exjbXzWn
        6ElCNmgAQdu9xbDNNe73jyp+7wt0qumRU0CrtvHEanG0DT3x
X-Google-Smtp-Source: APXvYqwPDePWWmUVjjlYHBlu+L9U/cbg7vrQRey6SZG7pdn+3I3dif76UNV96Al+d/pDP6Q+cln4wd8CUO1OkuzLR5URUAXhuLE3
MIME-Version: 1.0
X-Received: by 2002:a5d:914e:: with SMTP id y14mr1045110ioq.77.1557369960910;
 Wed, 08 May 2019 19:46:00 -0700 (PDT)
Date:   Wed, 08 May 2019 19:46:00 -0700
In-Reply-To: <000000000000c3e9dc0588695e22@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dd97205886b7337@google.com>
Subject: Re: WARNING: locking bug in nfs_get_client
From:   syzbot <syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com>
To:     anna.schumaker@netapp.com, bcodding@redhat.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        rbergant@redhat.com, syzkaller-bugs@googlegroups.com,
        trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 950a578c6128c2886e295b9c7ecb0b6b22fcc92b
Author: Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Thu Apr 25 13:36:51 2019 +0000

     NFS: make nfs_match_client killable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e40aaca00000
start commit:   31ccad9b Add linux-next specific files for 20190508
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13e40aaca00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15e40aaca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63cd766601c6c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=228a82b263b5da91883d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140fdce8a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134dce02a00000

Reported-by: syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com
Fixes: 950a578c6128 ("NFS: make nfs_match_client killable")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
