Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7064C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB85233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 14:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfIAOGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 10:06:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46079 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIAOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 10:06:01 -0400
Received: by mail-io1-f72.google.com with SMTP id k4so15451783iok.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 07:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9+b64TJ7Wgc7oSj44lFhNcMZ8K+apd8ZDigaEmOoDQs=;
        b=Q87EDxhLALEQtT4uVLooTp4ju1tGgPHff6z2cXV/0qH/7UdA4G+W4xv/7xxBSKm9b5
         VsXki/r147CQS9gD01aqdcPNzimppuP3kK+MHu0ghUjghlspU3coEG9/47Vwoxy+Sdw7
         RSIKdF9lxgxtJUriB8rASO7cADZT/dXWZw3AOetSlyrW6PW2xQFfCpiMNMwr1/vTI8AQ
         La1ZxhlCIM5cQDn9/VnuBbHjiURPTJxurwph69XvWvFz6qPkC8fPJTuNNUUl7CO+uagP
         aDvoRZ0K6ZMZ9jwkYQJw4hl2dVA2DZmAtYtfwVd6Oe/oswpJQcWlza2MigXrvQrkJK9s
         QxIA==
X-Gm-Message-State: APjAAAUIRdT4j4AtFZG13XQOZvu+pO1T4oFOb0EjcTpNAWp2XsYCgrhR
        IT4j5odTf2cmVnouDNg3wKxGC40YLTujLDNmJOerQ1r2Vy3b
X-Google-Smtp-Source: APXvYqygGQ3rpl4o7+tjLJB/SJ7oeQRVOkbVbQnlAaICG51/j53rAYoLcGLBC5rWvW23w9FodKiZbrc7PyHh4kLjEr+72FGrPdt/
MIME-Version: 1.0
X-Received: by 2002:a5d:81ce:: with SMTP id t14mr8009244iol.97.1567346760477;
 Sun, 01 Sep 2019 07:06:00 -0700 (PDT)
Date:   Sun, 01 Sep 2019 07:06:00 -0700
In-Reply-To: <0000000000003675ae05915a9fd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5f0e805917e5a60@google.com>
Subject: Re: WARNING in kfree
From:   syzbot <syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, ebiggers@kernel.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 3deadeebafcec6a0a7c9397bd32ea5ac6d5191c1
Author: David Howells <dhowells@redhat.com>
Date:   Mon Jan 21 14:04:22 2019 +0000

     vfs: Convert debugfs to use the new mount API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115d9e56600000
start commit:   ed2393ca Add linux-next specific files for 20190827
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=135d9e56600000
console output: https://syzkaller.appspot.com/x/log.txt?x=155d9e56600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ef5940a07ed45f4
dashboard link: https://syzkaller.appspot.com/bug?extid=5aca688dac0796c56129
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1595ee12600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16df7fd2600000

Reported-by: syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com
Fixes: 3deadeebafce ("vfs: Convert debugfs to use the new mount API")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
