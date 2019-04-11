Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE52FC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33D0217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDKBBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:01:01 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:58899 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKBBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:01:01 -0400
Received: by mail-it1-f198.google.com with SMTP id j203so4189040itb.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 18:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tv6qffGYPBYILk02p1FMdoKuMlPTDm5i51uvShtRcdg=;
        b=PYWCtFVwlzLch7pvvLvTAC5p2zXCw4xOPzKtiVAwXSaxZjmBQVBWz+fOL1kikuZIvM
         5svHM55GBYjPj726J/TTwS7Ygc+WFwQXSMJVETVvVQU+lXmYJtD+ukgZeWswPSwmmBIb
         BA2YIQ0QX+sFBO1Nga+J1VE6mujgo1kOBi1NJ9f66cK7+IQKKmAF5b8epFXHjm+Tu+yB
         zGUhZm4+2jqgcAKLaRFbBz1xMJYhche6Jc+WfNQste8bOJ68ehdNMAAPqa2FVz9zkPSO
         jAWc6oB5uw0+q77EzG7y/TckfmLrB2/ZyioJL4tP5Idy7KBiL65dqOPy90YaaI8luC33
         PFZQ==
X-Gm-Message-State: APjAAAVXwlZBwM1N3JXv49o7rv5/xU1K+eHYV3JgyKmDaDsu4oxKn0cY
        2LPLQ1u6SduNuvKMnzptgmvCiiFMG1L1BxBsj90V+VYU9k6k
X-Google-Smtp-Source: APXvYqxCZLGueWq5+oTUJrVwXdp0ypnCtB9uKcBjYF7CAUuJhz4sOdX1+9dO3GIL47zrKLAQa5u9dFaPzSh25WO+CAWv07XsXDdf
MIME-Version: 1.0
X-Received: by 2002:a24:3d8e:: with SMTP id n136mr1715965itn.3.1554944460297;
 Wed, 10 Apr 2019 18:01:00 -0700 (PDT)
Date:   Wed, 10 Apr 2019 18:01:00 -0700
In-Reply-To: <00000000000065a79f057a095de8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033a06b058636b877@google.com>
Subject: Re: WARNING in usb_submit_urb (4)
From:   syzbot <syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, andreyknvl@google.com,
        felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mmarek@suse.com, shuah@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 19 22:34:00 2017 +0000

     Linux 4.10

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b415ed200000
start commit:   e12e00e3 Merge tag 'kbuild-fixes-v4.20' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=7634edaea4d0b341c625
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce6fbd400000

Reported-by: syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com
Fixes: c470abd4fde4 ("Linux 4.10")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
