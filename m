Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A82FC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27CF21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCTTkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:40:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:59516 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTTkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:40:01 -0400
Received: by mail-it1-f199.google.com with SMTP id q192so365256itb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2I+f565Y1NtdA0KH4uBTOc2mgcFoDofIvczZasaZa7Q=;
        b=QXGzY1Ewfdw6W0/4QZmkYF9m3Mvi4+hTIHYNGn+J3C7tmhl/sPr6kPXOdv9o+m13+Z
         gfs0zDokTyXOzZHkUwl8drgt4BUHimOmOOWGJGp09CSVwEE2JIAgQhQWWswrtdi/UcNq
         T6SB9e45L7nVWVgCN1FIeh5DEmPFZ94EhjvjzZZT9sscxXf6GgonpfSccZLWjry4/8FK
         W31SDoBogzQ08VyGN7Yy9xK5F7KAfCj+Jtv6dpnAEp7yyqKerb+OeSq/f/LZSrp9WTBs
         JUc1HrV4/kcTQiU1RA81lE6Wg6rOrPSM5j0wMiRntUXx3EF4OgHcH668eZ67Q1gXoOa+
         yHzw==
X-Gm-Message-State: APjAAAU/Ubmh0EgghQ5JT2z+J154v9Ws6F8geBhRQV3CuJNHhQzybw7s
        lvfHwnjWBjtNE2AvRloQN1JqnYSOMXq97stxQpRCj7WEQWi9
X-Google-Smtp-Source: APXvYqzzFZnRA8b0m9Te9gHW0nkqzNpsHZP7/nMQCDcHH9V6x2GsV1Z5lv3wQx++gJJXgI1WUYYF2J549JXLxJnAMhLWQeZbWbZv
MIME-Version: 1.0
X-Received: by 2002:a24:d603:: with SMTP id o3mr858917itg.17.1553110800589;
 Wed, 20 Mar 2019 12:40:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:40:00 -0700
In-Reply-To: <0000000000005943f3057acf6a1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090e7eb05848bc9b7@google.com>
Subject: Re: possible deadlock in v4l2_release
From:   syzbot <syzbot+ea05c832a73d0615bf33@syzkaller.appspotmail.com>
To:     ezequiel@collabora.com, hans.verkuil@cisco.com, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab+samsung@kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        sque@chromium.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 757fdb51c14fda221ccb6999a865f7f895c79750
Author: Hans Verkuil <hans.verkuil@cisco.com>
Date:   Mon May 21 08:54:59 2018 +0000

     media: vivid: add request support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=145c3a6d200000
start commit:   757fdb51 media: vivid: add request support
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=165c3a6d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=125c3a6d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=ea05c832a73d0615bf33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b8e6a3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e73e2b400000

Reported-by: syzbot+ea05c832a73d0615bf33@syzkaller.appspotmail.com
Fixes: 757fdb51 ("media: vivid: add request support")
