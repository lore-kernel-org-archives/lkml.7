Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FC9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7512082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfCVLMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:12:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39930 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfCVLMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:12:01 -0400
Received: by mail-io1-f72.google.com with SMTP id a9so1425108iol.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 04:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QzfVqyAnN/h+qIVkoR4mNKnETJKDzl2/36aBzpyJRe0=;
        b=lKZxD5QK6okCq9u1VhbjmZw/bRcu4DDaVHVNe0JEy7ZNltgk/y9wCfP2ovVIACBl+6
         bf/OCMPWC415cXO1JiBSelL89VQQib8PsDtGjrbvp1nPpS2NdCgIbtQM6PFDTAOLbYC6
         R/eBWIlVJ8QOqRIj1IHFievcGhXttMZtOMQwVlsA3d3kf1kPKvm9ARalL3408Miouq8p
         lG7dyQev10WmJjhiAZx43irRMXX6gU1rJI1s4mnbhluFt0VgFfYCrdz2QT2aO170o9GV
         ne/tAt7fVrWXMrEEdMxQ83V5xKHVylonpzqNm3vN3/FDOl05CcdFfbx1+gj8kfLYTn2q
         ejpA==
X-Gm-Message-State: APjAAAVdOaLMY4/FPFlHKnQV2luZnIkt6xw5kY/SVmfBICaB2oPaalKP
        wo7tXJEBQXWoYXIHWy6Hlr+SkwlFjL6mOJMyG4oeeaQ4VCOp
X-Google-Smtp-Source: APXvYqzEecdmv4P0Pzagq79s/ymGJp5chb959YKwLhsPuRP02GhTqnUfY5R4TZXu5X6rK7uzRrTPquvtolKPvBhNsvlk2oj2pumZ
MIME-Version: 1.0
X-Received: by 2002:a6b:510f:: with SMTP id f15mr6476671iob.59.1553253120394;
 Fri, 22 Mar 2019 04:12:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 04:12:00 -0700
In-Reply-To: <000000000000bfd4270578abe88b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ccc900584acecc1@google.com>
Subject: Re: possible deadlock in flush_workqueue (2)
From:   syzbot <syzbot+a50c7541a4a55cd49b02@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, davem@davemloft.net,
        jiangshanlai@gmail.com, kuznet@ms2.inr.ac.ru,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sbrivio@redhat.com, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f547fac624be53ad8b07e9ebca7654a7827ba61b
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Fri Oct 12 14:22:47 2018 +0000

     ipv6: rate-limit probes for neighbourless routes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17affd1b200000
start commit:   f547fac6 ipv6: rate-limit probes for neighbourless routes
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=146ffd1b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=106ffd1b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=963b24abf3f7c2d8
dashboard link: https://syzkaller.appspot.com/bug?extid=a50c7541a4a55cd49b02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12097f03400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b55ac5400000

Reported-by: syzbot+a50c7541a4a55cd49b02@syzkaller.appspotmail.com
Fixes: f547fac624be ("ipv6: rate-limit probes for neighbourless routes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
