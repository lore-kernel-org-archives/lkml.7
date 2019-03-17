Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1C9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CB12085A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCQKnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:43:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50400 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfCQKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 06:43:01 -0400
Received: by mail-io1-f72.google.com with SMTP id s24so7274417ioe.17
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wTgv78jjaW2zKNT3hGEqn6xhzNVvM2xJXFrGJwez7EU=;
        b=l0j3oCdD6YrDY3bwM4QM/brIbrbM9hMaDgQAlGEx3ZxZn4eMJ1SyNppSSZMd0OVlJI
         3S2XrcFvyuPXPa2zr8gAmGc36MB7rXjY2bYGpweKT7VqzZVHAGsmmrBeQntWolUcXHt5
         YClyzEHi1PyridGn09wyPOtBY8xFw9UPBSelW+aTgAnZMHE9zguOc0v/Zygkktn4TS+k
         mz9N/upJwC6AacXlkUAW3ybdivVNoTIMU85pGky8hJBlaPiSrjMj50nG8CFr4w46O21d
         h9NJLEOUZ901yynzc3s6N2Eg+2a+je6uE0LEz1Z+4GeFKFBOrMEvDKCY6kCl5iVxIBwz
         xiag==
X-Gm-Message-State: APjAAAXZNwm68dvPX2kWlT29JQKtEkm9CLqGWZy+VtWrPXfK7D/JYZ1M
        bHUbEkWB4TjAusZUCyW1IL6aGExXqIQMbdQl+4N4EYhAWpEh
X-Google-Smtp-Source: APXvYqzTZB+rnFnwyOyOAYWeGsozYhs8YV/UZArezC96lqCwC7P+MGqzflAUGBZnODh+fyYILn4uisFm2mW2ZA1HDabAGukuWcnZ
MIME-Version: 1.0
X-Received: by 2002:a5d:914f:: with SMTP id y15mr8142623ioq.18.1552819381224;
 Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:43:01 -0700
In-Reply-To: <00000000000052a5500584348100@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e4ca4058447ef02@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in linear_transfer
From:   syzbot <syzbot+a39b5d3c50e55e24fb4d@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        dan.carpenter@oracle.com, gustavo@embeddedor.com, joe@perches.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de,
        vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 65766ee0bf7fe8b3be80e2e1c3ef54ad59b29476
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Nov 9 10:59:45 2018 +0000

     ALSA: oss: Use kvzalloc() for local buffer allocations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b70c2b200000
start commit:   65766ee0 ALSA: oss: Use kvzalloc() for local buffer alloca..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13b70c2b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b70c2b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
dashboard link: https://syzkaller.appspot.com/bug?extid=a39b5d3c50e55e24fb4d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113945fb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ed3cf7200000

Reported-by: syzbot+a39b5d3c50e55e24fb4d@syzkaller.appspotmail.com
Fixes: 65766ee0 ("ALSA: oss: Use kvzalloc() for local buffer allocations")
