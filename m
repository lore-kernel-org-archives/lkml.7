Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D988C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF9A20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfDAH6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:58:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55332 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:58:02 -0400
Received: by mail-io1-f71.google.com with SMTP id z19so7436474ioc.22
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7EKRemsi17Qp7W2SsJHAn5hK7JPxXirxunTpAg9x/9M=;
        b=RwMBThtDJTz0lN3mFX89+pk7gWoKx2YSFxJHvDFSazhvlBTaY2jfHMZSBejQVNu+FU
         prxzXZOfDNI5VszOHWPPgDwDJoNEhFHoa73nyy1QXjyOwoslcOKW6/PoGtIfED4TPw1D
         NZzvOFERs00fjcq4u5ylYg9DcI8tveaDSpp07RHWNng50Oro0eZcnGg8uPq87glXFQFy
         3kVzL+J1HH6WBS1Rk/n3bddjyR0QRVWIAjFT3wpuoSGBcs9jtjkJa5+M6SKWTVBqaBH8
         JQ+yYHdihdnzR0NkgyM92KFuWherQSpUul4NJSdPoHgKjVPrAa1N8KLxUcxeU60F/I6s
         I5lQ==
X-Gm-Message-State: APjAAAU21WLBJb8hl4HfIllXN5ctBxq4cICQRMz3XvDv+KQFOW0S3ZBZ
        5LCve/lPIrbxnEB2+Tyr3ZZXJ4xfq2FMidoKzFnhjupwrmA5
X-Google-Smtp-Source: APXvYqztnrMIgOO7OA7/CaoNeTeMdhpTMn0H30n6IcO2ud1PkbQxL68lKuhdyzkQSodu1AG2z0DYY2zvFRJ32jtBYINRlPsJP9i8
MIME-Version: 1.0
X-Received: by 2002:a24:7bd3:: with SMTP id q202mr5412604itc.32.1554105481033;
 Mon, 01 Apr 2019 00:58:01 -0700 (PDT)
Date:   Mon, 01 Apr 2019 00:58:01 -0700
In-Reply-To: <0000000000004f7eb00570be9f92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002402ed05857361e0@google.com>
Subject: Re: WARNING in port_delete
From:   syzbot <syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com>
To:     alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        colin.king@canonical.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paulmck@linux.vnet.ibm.com, perex@perex.cz,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 63d86a7e85f84b8ac3b2f394570965aedbb03787
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue May 1 20:08:46 2018 +0000

     rcu: Convert rcu_grace_period_init tracepoint to gp_seq

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f86d2f200000
start commit:   091a1eaa Merge branch 'akpm'
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14046d2f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10046d2f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c8abb920efa77bace9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102e2c91400000

Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
Fixes: 63d86a7e85f8 ("rcu: Convert rcu_grace_period_init tracepoint to  
gp_seq")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
