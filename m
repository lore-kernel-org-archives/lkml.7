Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDF3C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C1320838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLZWGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:06:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36090 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:06:02 -0500
Received: by mail-io1-f72.google.com with SMTP id 144so17791032iou.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 14:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gzUrg7S5MS19Le8XOVi5kKaSwBX6RM9XMQ6La+L8Ojw=;
        b=ZT8XTH7CTDP13w/xsrqfgOb0NfcfoY3G75qDZj8Bsp4BKDzsOInZDK/oF+pI4jZmOP
         V27B3svhpHh58bPigGlVKk/UPVQlGwA9jx4f1wlW0o695MqFeDUIGAcVYpswoPbzS2NI
         /dqYDMI73T7Gt7aQJ6GCsOB4TYHP/br7aDEzTxrq97oZByyyELIV0XEa1crr4HvPEdFd
         xmn6osNuZsQwyeUbJiUPMjmFrjYYfnAMlC94TV89UnT8oP4iaBcILu8+GP1sNfHkm/wi
         PdrVSAdvaw5L7kvIrgQmJDvHzkGARk4oblqOB2GwkuW3LZ0BwNc9qsTz6JoDbRn82oR0
         5BZw==
X-Gm-Message-State: APjAAAUfIlqi8Qs/8H5r3Nqjg1mzzQ3BAB599QbSY3fy38W1JRpH9B3R
        l0ThpEu9yH7BZZAZtsZO9/XE7UqU9vX0m23KLpZLmmKHarZG
X-Google-Smtp-Source: APXvYqyMZv3kpon40+DQrGh+yfCnK8mSm9toK+x/iErfeVKIKwnfL/LxGdCfc0MoETQHENDEpuke1u/6VGg2emJes+rvcYK8a8Om
MIME-Version: 1.0
X-Received: by 2002:a5d:964e:: with SMTP id d14mr31633862ios.193.1577397961566;
 Thu, 26 Dec 2019 14:06:01 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:06:01 -0800
In-Reply-To: <000000000000016d8b059aa2030e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b326d059aa295e9@google.com>
Subject: Re: INFO: task hung in sync_inodes_sb (3)
From:   syzbot <syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dave@stgolabs.net,
        hch@lst.de, hughd@google.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        ming.lei@redhat.com, osandov@fb.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6dc4f100c175dd0511ae8674786e7c9006cdfbfa
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Feb 15 11:13:19 2019 +0000

     block: allow bio_for_each_segment_all() to iterate over multi-page bvec

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1674423ee00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1574423ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1174423ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=2b9e54155c8c25d8d165
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152bdc56e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c489ee00000

Reported-by: syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
Fixes: 6dc4f100c175 ("block: allow bio_for_each_segment_all() to iterate  
over multi-page bvec")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
