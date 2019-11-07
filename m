Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE14DC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90355218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389480AbfKGNnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51692 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389049AbfKGNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:08 -0500
Received: by mail-il1-f198.google.com with SMTP id x2so2614480ilk.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=faF2E7beRwWoi3uIIILRzqXOv61MWqBCOVzVfmKvnUo=;
        b=QIIvoz/tS2tbWOaB4FAFAn7GeUAV97y9OpaY21NLXP5iFP9x3O679IkK/J3OS1S4TU
         dyyuREjvGGvigdlCQhfF6VWNG16j34b+O7FneeZTgkBkBFj7K2A/+dnxL8vA7jeQQAhX
         qyKmrr06uXRkyPSQIGNcZ78ujzS1zC5RNH7LvqxriAuzpXldQAK8PE4LVvb66XvlKG9K
         3BJcpoDEhqFgOGOFFkLH6llyUXO8OfhpPUi8SGXW9MkvTauw9Lbz5RH+gAxOagS7+5IS
         XA8pxytrcHTzz1PSgWvqOhBmscqT/SEkgRj7Fy6mEuzjTTmVDKULCbepXPxT03F8BuyM
         CM5Q==
X-Gm-Message-State: APjAAAXF8AY+jiimAQ2Z8HcuyOMV59A5muiH6c37w2bKV9LARV6ivVtq
        YLQQuWcHWQrzbppbOVZ+bV2eslQ+hB+CS+fSSCNCs0ZPLCYp
X-Google-Smtp-Source: APXvYqzVYKWM2YDzF62mA7+9NC0nUV+ZtoPDNThvpzi9h0wK92j8hN87irxPomSaO4dsmofOF+c0rPnm4WVvuK8z7Omam0qTsX8s
MIME-Version: 1.0
X-Received: by 2002:a5e:d716:: with SMTP id v22mr3377836iom.152.1573134127190;
 Thu, 07 Nov 2019 05:42:07 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:07 -0800
In-Reply-To: <00000000000014008b057a598671@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5dacd0596c1d41e@google.com>
Subject: Re: general protection fault in vb2_mmap
From:   syzbot <syzbot+52e5bf0ebfa66092937a@syzkaller.appspotmail.com>
To:     hansverk@cisco.com, hverkuil@xs4all.nl, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        m.szyprowski@samsung.com, mchehab+samsung@kernel.org,
        mchehab@kernel.org, pawel@osciak.com,
        syzkaller-bugs@googlegroups.com, tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit cd26d1c4d1bc947b56ae404998ae2276df7b39b7
Author: Hans Verkuil <hverkuil@xs4all.nl>
Date:   Tue Nov 13 14:06:46 2018 +0000

     media: vb2: vb2_mmap: move lock up

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101a70e2600000
start commit:   e12e00e3 Merge tag 'kbuild-fixes-v4.20' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=52e5bf0ebfa66092937a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c61b0b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109d545d400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: media: vb2: vb2_mmap: move lock up

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
