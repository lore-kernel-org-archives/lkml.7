Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255E1218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCPOJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:09:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:32782 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfCPOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:09:01 -0400
Received: by mail-io1-f71.google.com with SMTP id n15so9503756ioc.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mdx1Tr+U8/cTvqNjg2L8RR0jt1fW4ZLI1VGMJj9BJoc=;
        b=k8/uUaWktRk0Obus+GM0ukri3LILIzCll4i69uO1twk8Ac0JZKTZHVzDp1eL5eIWec
         SqKYpe56GeAWdcFBqDs9RrX2Rl2TySO8ZsFUxwrQL+8uwDXnx4fX1i7/opyEGH09pvma
         IdYsQdQbSKSc4JZjPhEfZepQXptKurE382DmlhBC/uGO4KtAHuiveJni4smlW7IjCrzR
         Ngeh9bAQenSgO6AQRLRpL5lonbGTJ28aa+IqMVjsy/hL6yCRoWkN+86VyvaNBp6OuBh8
         ZRQnkawCJilKuklylOFQ7NTfAbulSrQ8by4iIpRmWfY/b135duDt39vopLiGXGQG19Wf
         XP3w==
X-Gm-Message-State: APjAAAXQM3T6JR9fj79DUDyvzDq3G8EHEMVo58vdA/4BWgxXqNpfMFtW
        baRB1rrjUXOO1mD3GLo3bqeqlZEsJN36fszNJLaCwfiVQ4Iz
X-Google-Smtp-Source: APXvYqyGskTuuP2wuKMBNWZqi/D+82hTeHNUomXy4EELlpwj/7C+9rJTSQancETC6/DB5WYp2xtbwtERA2a8AqyfoQes5qUJtGyq
MIME-Version: 1.0
X-Received: by 2002:a6b:ec0d:: with SMTP id c13mr5710117ioh.23.1552745340692;
 Sat, 16 Mar 2019 07:09:00 -0700 (PDT)
Date:   Sat, 16 Mar 2019 07:09:00 -0700
In-Reply-To: <00000000000089bb100583e5fe7a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000757009058436b23f@google.com>
Subject: Re: general protection fault in sctp_assoc_rwnd_increase
From:   syzbot <syzbot+85e0b422ff140b03672a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        lucien.xin@gmail.com, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 89664c623617b1d34447a927ac7871ddf3db29d3
Author: Xin Long <lucien.xin@gmail.com>
Date:   Sun Mar 3 09:54:53 2019 +0000

     sctp: sctp_sock_migrate() returns error if sctp_bind_addr_dup() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b17777200000
start commit:   89664c62 sctp: sctp_sock_migrate() returns error if sctp_b..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14717777200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10717777200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b613f0327d980b6b
dashboard link: https://syzkaller.appspot.com/bug?extid=85e0b422ff140b03672a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12613b13200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f1884d200000

Reported-by: syzbot+85e0b422ff140b03672a@syzkaller.appspotmail.com
Fixes: 89664c62 ("sctp: sctp_sock_migrate() returns error if  
sctp_bind_addr_dup() fails")
