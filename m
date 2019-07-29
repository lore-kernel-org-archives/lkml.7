Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C8FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C1E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfG2AiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 20:38:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45441 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfG2AiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:38:01 -0400
Received: by mail-io1-f70.google.com with SMTP id e20so65394761ioe.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 17:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P/bfC/9DYsjpqYrAz/GLNeevsKIsGM5ry8dJO/L9Ihk=;
        b=fwGbijWyk21hktHDVCfeslAZSHjhNnooeoq1S4kUCSY5eQ6V4ZuzHmbAJ1xXpApsD8
         tYmwVWBoE5/fIGTihbC4CVG0FL5xHD1Fdhi/NPmdUgbGLi+OOivwNiCjWeDrSm4H8zip
         YoFNEg78WcG3kyRFsaUhAPNm4Sx3++ZT3B9F+ydYsG30D2Hl9fYGLElQoGettTpsjIJx
         947a6i5rs8NSA9NQfj+SIv3AK6qpkLIWCPKrfOfmHQ8lbUI875b2vRvPscQITdQ8oTjy
         3Syj3oYNQ9DrgYjdAE6GmhisqerMV6JR9NGA1a4XOh+9UuB2yoK4mvu97ofx4x1QkNTS
         y1pw==
X-Gm-Message-State: APjAAAWJWwP/GziXj5nqPgPFbyf7QBsje00ur451ynuG3lKvG3DIOyHt
        o8AV3byAs6JELnC6owdDcwhPqqsVBkgsiTHmd0K5URGGTIUZ
X-Google-Smtp-Source: APXvYqwVilF5qTRSsaLkhL6POlQdbplmHCUtbsaCjcw6sv9rHxSg5wY2IEL+f/ULWS/npxF51AhFcSpVnuGNfy6+mXTXpQgpNXm3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40c:: with SMTP id q12mr81494815jap.17.1564360680847;
 Sun, 28 Jul 2019 17:38:00 -0700 (PDT)
Date:   Sun, 28 Jul 2019 17:38:00 -0700
In-Reply-To: <000000000000c75fb7058ba0c0e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aec4ec058ec71a3d@google.com>
Subject: Re: memory leak in bio_copy_user_iov
From:   syzbot <syzbot+03e5c8ebd22cc6c3a8cb@syzkaller.appspotmail.com>
To:     agk@redhat.com, axboe@kernel.dk, coreteam@netfilter.org,
        davem@davemloft.net, dm-devel@redhat.com, hdanton@sina.com,
        kaber@trash.net, kadlec@blackhole.kfki.hu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        shli@kernel.org, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 664820265d70a759dceca87b6eb200cd2b93cda8
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Thu Feb 18 20:44:39 2016 +0000

     dm: do not return target from dm_get_live_table_for_ioctl()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f4eb64600000
start commit:   0011572c Merge branch 'for-5.2-fixes' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=100ceb64600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f4eb64600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
dashboard link: https://syzkaller.appspot.com/bug?extid=03e5c8ebd22cc6c3a8cb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13244221a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117b2432a00000

Reported-by: syzbot+03e5c8ebd22cc6c3a8cb@syzkaller.appspotmail.com
Fixes: 664820265d70 ("dm: do not return target from  
dm_get_live_table_for_ioctl()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
