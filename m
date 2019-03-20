Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A8C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F032184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfCTMYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:24:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:44129 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfCTMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:24:01 -0400
Received: by mail-it1-f197.google.com with SMTP id z190so1972919itc.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 05:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yzZsyOBPk2mVki6aWk8bYi3PxGLUTmWInMgQm4PaJig=;
        b=mN2zkBWuIT92x6RjID/0gvPLyIpAXxye0K2lq0Js3nRqLiqnxCNFC1WZg9Uy0nXv+f
         /tXxEEA12BZ/AQqFbVbZ44BnvXaIooOI1IhJ3dAAbiciJWz/dI8P5fTNVzt/LBLeoLYK
         dxTIcnAvo/bvNe/+l+N1a7vcTz+Tqvy387OQyz3qF1TkL/iRapF4IoSV3FT7O4dOlEfa
         PQn4oC3EhyCj67KDyWid4ayM5a/zFGEIfJ3DR3hO4oD20mgyUnAV/76Mvy5jh870uDVI
         yoVH11TcOSEQ77/AyLV2wI5njzdxNeO7s0KBV9387ZE5hszR6rIhMwHH1dRwoB/g95KW
         dafg==
X-Gm-Message-State: APjAAAUTc1AVvTLYTMPEg1q8xR2PZfAQENIUa/xj5rbmYzsBcmE8UfLe
        0/BNRLOLWd3C6m03ER2WERxJKh61UXnHPHZAO+dbBYI3PWQe
X-Google-Smtp-Source: APXvYqwikRuQ9Jtv7r9PrhNSda7enOr/a+TY2zZd5yzbHmDETTLymI6IU+FWdoKzpan+XUgDrtKG2g6w9k417LXGJHev01ZLV5eu
MIME-Version: 1.0
X-Received: by 2002:a24:7d8a:: with SMTP id b132mr4397836itc.20.1553084640449;
 Wed, 20 Mar 2019 05:24:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 05:24:00 -0700
In-Reply-To: <0000000000000e4a41057b6c9792@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cdec6058485b2ce@google.com>
Subject: Re: WARNING: syz-executor still has locks held!
From:   syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>
To:     chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, oleg@redhat.com,
        pavel@ucw.cz, rafael.j.wysocki@intel.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c22397888f1eed98cd59f0a88f2a5f6925f80e15
Author: Chanho Min <chanho.min@lge.com>
Date:   Mon Nov 12 03:54:45 2018 +0000

     exec: make de_thread() freezable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ee6217200000
start commit:   c2239788 exec: make de_thread() freezable
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ee6217200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ee6217200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=b70f2aabc707c69c9239
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c9e26d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e1234d400000

Reported-by: syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com
Fixes: c2239788 ("exec: make de_thread() freezable")
