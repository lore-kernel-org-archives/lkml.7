Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D805C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285702087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCQUtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:49:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:40993 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfCQUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:49:02 -0400
Received: by mail-it1-f199.google.com with SMTP id q184so13054450itd.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 13:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AdDJQGRn1HKxzvaNiNMtuUjAUxpN+UvUqzicULcWxYI=;
        b=DU1vw7qd06zKpvWjfZJM85hyR2nSFHi1R5fognJWIGpMm2gAVDjopDXZpWI9Q39m0c
         RdJQSFlCS9ARJnXPq1M2WRFffmUG3cM++D0jm0iuEj/GaaiGOVzWg0aQvN4rYUENgaEK
         Pd9CcUSISt/r+21NvYQx5nrrcAcHjRotqqqqdgso3QzXtfJx4tSiWXkPariJngpf4NS4
         PKNp8YdS39UQP9IIEpGrf00lp0jmY/oh6+NNn+Izja6vtW3TOKpWziBbvGmvZFrS5oel
         tcVQ9a3pA9IJsAytnSZ1UgEHApvtHWK8xLmxyqygz6lPcN1KQJqT05PYyV7M1BK0f6Y9
         CmsA==
X-Gm-Message-State: APjAAAWakHouNjA4VqCguZWmcFnK+cySE3h6jq4xdmmplR1sKcFAzVpb
        hkHuYPRIFpNTDoTn3uwLNlcBbY3lToNQR9UH2e9hNPNbiNqG
X-Google-Smtp-Source: APXvYqxojhExD56b/yMGdo1rthu1JsRKBbq+nglPXYMv7KIAn0A7lR9LfGenfJEuOvhjcVopDkkpLBAFNpERS8o441NA3SoXY50Q
MIME-Version: 1.0
X-Received: by 2002:a02:3f1d:: with SMTP id d29mr8708325jaa.4.1552855741444;
 Sun, 17 Mar 2019 13:49:01 -0700 (PDT)
Date:   Sun, 17 Mar 2019 13:49:01 -0700
In-Reply-To: <000000000000b05d0c057e492e33@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db3d130584506672@google.com>
Subject: Re: kernel panic: corrupted stack end in wb_workfn
From:   syzbot <syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com, cai@lca.pw,
        davem@davemloft.net, dvyukov@google.com, guro@fb.com,
        hannes@cmpxchg.org, jbacik@fb.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, mgorman@techsingularity.net,
        mhocko@suse.com, netdev@vger.kernel.org, nhorman@tuxdriver.com,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, vyasevich@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c981f254cc82f50f8cb864ce6432097b23195b9c
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jan 7 18:19:09 2018 +0000

     sctp: use vmemdup_user() rather than badly open-coding memdup_user()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137bcecf200000
start commit:   c981f254 sctp: use vmemdup_user() rather than badly open-c..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10fbcecf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=177bcecf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=ec1b7575afef85a0e5ca
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a9a84b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17199bb3400000

Reported-by: syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com
Fixes: c981f254 ("sctp: use vmemdup_user() rather than badly open-coding  
memdup_user()")
