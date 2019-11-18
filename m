Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC1DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAAE206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfKRCOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:14:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46204 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfKRCOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:14:02 -0500
Received: by mail-il1-f198.google.com with SMTP id i74so15065088ild.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 18:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0hJK8rPWOFUddMB0lJimGQDZPQJFXDrAgb0buhY0TvU=;
        b=DiDh5/YbTnZ0yaPsiMRC1v6sPcBkSYzjW6THiOGzso6VPeoypYd028EQehMXbV0QEO
         EXQTCgndkkNqDABgDHTQW7S0H1ALCWze1GIPKRjzjbGtqVCkWEN2ruwVoeufs1/LHDzY
         8AKjl8WTp0zw0j/K9ijnj3dA+ITj3oztprYE9D3PbWjM1oDyUMIY4r43H7OFOkDPem/M
         1el2hz/ankMgz7eYNK52ye2qYsk6Pw6SFHODmcpAniQoo6bOqQ/mUBMj8Ja/HlOiUAZi
         hnPnwnpPtiIv+ZpZSTn3KavyNTjeS1DFktJwE5NqDVbstz3XU5KyRTvjVq0C3zsf2kaR
         NkEg==
X-Gm-Message-State: APjAAAVa2XUwcM7i9D5m9qZxdDOMitzsm0jjZeYyAOCbfzg+TyhpQ6ml
        hNpX0aHC8zYoGEqgknXxF7DThptQb7h26MPJJ2h/RxSFh2Pz
X-Google-Smtp-Source: APXvYqwZhRrNpOcp3K1jSna3NVMQ3Y9eKDGXT7VjA9/ZYXXiCNJMlXd57obKMz7tPT7gqZ5PakMzS/X78yIoSTTNHjwPUi2z8UDS
MIME-Version: 1.0
X-Received: by 2002:a92:660e:: with SMTP id a14mr13677440ilc.235.1574043241343;
 Sun, 17 Nov 2019 18:14:01 -0800 (PST)
Date:   Sun, 17 Nov 2019 18:14:01 -0800
In-Reply-To: <00000000000044cbf80576baaecd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f41905979580cc@google.com>
Subject: Re: possible deadlock in path_openat
From:   syzbot <syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, ast@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108f4416e00000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=128f4416e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=148f4416e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=a55ccfc8a853d3cff213
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101767b7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c15013200000

Reported-by: syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com
Fixes: 8e54cadab447 ("fix default_file_splice_read()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
