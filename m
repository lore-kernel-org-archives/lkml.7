Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C628C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB432075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfCZMKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:10:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39108 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZMKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:10:01 -0400
Received: by mail-io1-f72.google.com with SMTP id c17so4977448iot.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yfnk9m/Qgl0Rhk4i8Zh0YuJ7pzI3QzJfont0Y+wlR2I=;
        b=gyTx3qTcRbP0FLoX8PBrjuvTlWLppqTwO6xXml+7i+SOQlYceMyamnzeNCbNpY+ZX4
         qaUGE+quhoL+ct8I1oHXCUrttdtVMxzsTTCxrT/cRtK78bu5uzU4p/zKilEju3tTjVoT
         WXXE5IaMjPTvGRhfcoAJyXRiiDyxI6HaWo2/ERGuVon/coEZ7CJ4F2Gb1PGd0cORdVbS
         j4WZ6vv36tDA+em84sx5Ps56mGh+gnUlg1pKnqn5x6TqPxeJ1TvWyr+rEycJapJ9Mswo
         dbUpWVChNdpnEdqUdHF8y7B1ThbK6w1yYB7Cj7AUbJFTYJ1ixqNqX73IWAUAjaHRaOHG
         eAQw==
X-Gm-Message-State: APjAAAWqWOsm9cXYoY/NCbboP3b47+1KqjikjFeT+BZ39aIz5VR8CnjN
        WEXrMzhkfrNeOOvww5his9FEKuk6luyAnp4Ksb/802Xbo4xw
X-Google-Smtp-Source: APXvYqyAVslzxXvDhlS6F8DH0CubFDvED0CWKxcmtDV97wqtCti4D45kIYCUvqR9ZXDTv69NuFV+S6OimwvhJJM2bMJCzk6sLSia
MIME-Version: 1.0
X-Received: by 2002:a5d:9152:: with SMTP id y18mr6734643ioq.165.1553602200958;
 Tue, 26 Mar 2019 05:10:00 -0700 (PDT)
Date:   Tue, 26 Mar 2019 05:10:00 -0700
In-Reply-To: <000000000000064bcf057a59e3b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f7f7c0584fe33c0@google.com>
Subject: Re: WARNING in ovl_instantiate
From:   syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 01b39dcc95680b04c7af5de7f39f577e9c4865e3
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Fri May 11 08:15:15 2018 +0000

     ovl: use inode_insert5() to hash a newly created inode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176da0cd200000
start commit:   de6629eb Merge tag 'pci-v5.0-fixes-1' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14eda0cd200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10eda0cd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000

Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
Fixes: 01b39dcc9568 ("ovl: use inode_insert5() to hash a newly created  
inode")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
