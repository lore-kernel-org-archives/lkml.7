Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE1CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB09218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCPOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:49:03 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:53433 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCPOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:49:02 -0400
Received: by mail-it1-f199.google.com with SMTP id 190so10470376itv.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vqraUe22hltvBT06Q8Hxe34kgLnUZe8T9x+qnh/IhEE=;
        b=QYWI9FgqBz1rPN77qi+yZW2P/PMt3VkBUuAf3WeYrXU/PUkCGTCgM77WMaT0NYLC3r
         XqWCPT7JGm/kr20Qn5QqDgVvcKPyCy2JqRMUPMhUZWIszKIqlEVhRbeVOl0WffVn81dR
         rlcuVRt8fmwR1MD7jchEEl0bnYLRziIjKcoy9lO6IpTk5SUbck04UgnKpdcCvZydyTBh
         M0AK1Hh3wlAehujaCPyeSDe0uZ2+Ek0LFHoozv2vUnmOnfX6Eq8jU9JI4iII2ToUBZ2l
         ThB6vPWrNDmI82Gky6fznNWSUWoYcd93Nak37u210YC5ULU2QnRSRG9O3XKUSqNiYZqE
         B4/w==
X-Gm-Message-State: APjAAAVQHfNFJSkfc3KrjTvTx+DibMebVLiZ/ASmcaYcJyYFUfLYjw6c
        oP5TmsSMnFVDx0O4FFM+STuZEulLgoJvkNQl/kNR+DSPsauX
X-Google-Smtp-Source: APXvYqzDJAaZT+XQs6QE92W7Kh+mjTkfY8a8i0TE+TZDOIJpLSTbbye0+aCDAG3gPvYLRIHKuI/dX9J4gq3zv3UtEo9X/BXHYBTk
MIME-Version: 1.0
X-Received: by 2002:a5d:83c4:: with SMTP id u4mr5806299ior.34.1552747741958;
 Sat, 16 Mar 2019 07:49:01 -0700 (PDT)
Date:   Sat, 16 Mar 2019 07:49:01 -0700
In-Reply-To: <0000000000000655c0057cd141f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095d9b205843741bd@google.com>
Subject: Re: WARNING: locking bug in __queue_work
From:   syzbot <syzbot+6174a6c5eba4b3cdd606@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com, keescook@chromium.org,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, wad@chromium.org,
        ying.xue@windriver.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
Author: Jon Maloy <jon.maloy@ericsson.com>
Date:   Thu Mar 22 19:42:52 2018 +0000

     tipc: obtain node identity from interface by default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152adcd7200000
start commit:   52dfae5c tipc: obtain node identity from interface by defa..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=172adcd7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=132adcd7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=6174a6c5eba4b3cdd606
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11635d24c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f2ed58c00000

Reported-by: syzbot+6174a6c5eba4b3cdd606@syzkaller.appspotmail.com
Fixes: 52dfae5c ("tipc: obtain node identity from interface by default")
