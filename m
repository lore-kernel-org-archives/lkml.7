Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E936AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A692183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCTQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:13:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38627 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCTQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:13:01 -0400
Received: by mail-io1-f71.google.com with SMTP id b16so2508640iot.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nscdqcp2NdWhvT5RDMpoyXQ/8Y3AQw4wtQJaTg+659U=;
        b=mBaiz90F0KAm8ZixEI21Qh35si+nxjqwFat2LsVT+KcquCKKsiT5uimQlynIzdA8f4
         PreIgRswRm7XPv/Cn3JkMK5Qv9WGTVNrO2V0UBueIGXcdUpqCWRLRmgFU4PRaf/2RfmF
         1jy6lXLShKGy5uD6V5CP+KPlFBANFCBVhzooO2Q9T1e+aCTE8wCeQhzBER9o/Ub53c+E
         i05aG5TfJc3PHBGUfOyUkL17v6cl/IWpzav3OD9UFJFqHK8oi8ZzBMPw+3u3wAX5ZQ34
         gSeGwm1GxFGBTO87IVH2TlXYDhoPzWy+RCROsqI1zl4gVoA53cU5VG4eYjELhi91485Z
         Zotg==
X-Gm-Message-State: APjAAAXZqGMGDKJV5UPbzemn00oJscmo+en/xqsrHNd58PyKw66s3oyl
        e3S7ojEyxFZXEWxPo8auDKkFGb/OlaUZFC+CzsZRIRzS/MqE
X-Google-Smtp-Source: APXvYqxo5h7ak5xUxwZVqIsNhVY1O5NjE9NxxzsLDslwq5dn5XXI9U7Iwp5aVCM2HkN8ytheRbh5u12JcjoxiPk3qhx6HZrauGWO
MIME-Version: 1.0
X-Received: by 2002:a02:3941:: with SMTP id w1mr3260102jae.7.1553098381064;
 Wed, 20 Mar 2019 09:13:01 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:13:01 -0700
In-Reply-To: <0000000000009c1aca058474a076@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e05d8058488e521@google.com>
Subject: Re: WARNING: suspicious RCU usage in xfrm_get_sadinfo
From:   syzbot <syzbot+2792672c6a63f1dc867c@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e8e843200000
start commit:   f10e0010 net: xfrm: Add '_rcu' tag for rcu protected point..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13e8e843200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15e8e843200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59cd5d43b5df6955
dashboard link: https://syzkaller.appspot.com/bug?extid=2792672c6a63f1dc867c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2e24d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131ab8ef200000

Reported-by: syzbot+2792672c6a63f1dc867c@syzkaller.appspotmail.com
Fixes: f10e0010 ("net: xfrm: Add '_rcu' tag for rcu protected pointer in  
netns_xfrm")
