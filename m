Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A372175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfCSU5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:57:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39866 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:57:00 -0400
Received: by mail-it1-f199.google.com with SMTP id e124so204869ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/c0cLgztPxpr4gyUPJgRCZbpdW1E/Hy6xSGhyI6afgY=;
        b=GN3NSixu58g74z6detaCTsx0nsQGcxquvTKBs4vEJLJdO9fxgiwbN17oGKft0Nblwd
         nSeYHnZmCOXrOovfg7QzaBjebGtExtszK2cio2+9cGm7aYiPAO9L++Cc7yAzPu26xX2V
         W8tHfBI4UsgpQTpazTwWQecbFCVFUEJoJarvU81lE0UxjCF0gqEg/ZiZu1TlrQ4JCvXk
         tDGrxssBWwUOBsveCkZvuf1v7aCm4ckknxmMUGJZo/KBPTfOUt6f/3kqeTk2i2myDJlo
         mzAi0dgaD5cZSOW80GSeGjzLtf3iH4msFsT1arRDiYxVtYIhAJO68A2EJ5/q1m85KPxG
         gzoQ==
X-Gm-Message-State: APjAAAUwE1xU8tGb/Rf2kd90+NFPWJ4qY1Re5OXEetBKSvep0qoo5T9f
        qXY2Z4Ze54q3E8BfsySNb1XlrssMg+Og8ZSX5bypl/tZdWTn
X-Google-Smtp-Source: APXvYqz/Pn19S9Ka5Um6SHuK7Rsa7htNw2ddmuDXs55897Lo8IQhF5I2C/bds0hA0yVsOW9Yg3fZICdIk+IX6QI4Ln824z1kLAFN
MIME-Version: 1.0
X-Received: by 2002:a24:4acc:: with SMTP id k195mr1323423itb.30.1553029020128;
 Tue, 19 Mar 2019 13:57:00 -0700 (PDT)
Date:   Tue, 19 Mar 2019 13:57:00 -0700
In-Reply-To: <0000000000008a14a5058474a025@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001224fa058478bf4b@google.com>
Subject: Re: WARNING: suspicious RCU usage in xfrm_get_spdinfo
From:   syzbot <syzbot+bfb3cbc2e9467b566c8b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, fw@strlen.de, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, suyj.fnst@cn.fujitsu.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f10e0010fae8174dc20bdc872bcaa85baa925cb7
Author: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Date:   Thu Mar 7 01:54:08 2019 +0000

     net: xfrm: Add '_rcu' tag for rcu protected pointer in netns_xfrm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166cae2b200000
start commit:   f10e0010 net: xfrm: Add '_rcu' tag for rcu protected point..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=156cae2b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=116cae2b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59cd5d43b5df6955
dashboard link: https://syzkaller.appspot.com/bug?extid=bfb3cbc2e9467b566c8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12af288b200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147162a3200000

Reported-by: syzbot+bfb3cbc2e9467b566c8b@syzkaller.appspotmail.com
Fixes: f10e0010 ("net: xfrm: Add '_rcu' tag for rcu protected pointer in  
netns_xfrm")
