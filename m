Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5968218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfCUFcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:32:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36320 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfCUFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:32:01 -0400
Received: by mail-io1-f70.google.com with SMTP id a7so4267472ioq.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 22:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XhXBXG02S2iOILAL0KNxwKY/4fL9LXbK8GduvmtmBko=;
        b=Yj+8eCNI/QcVnuyabpS1uzhI/IBD19ewhGR3NA3WaQcn95gILDdRPAP6P1zw10kVHp
         +b2mraQ8fcBx+eNgrPAFhJMVfr9Capfx07CvYalvgZ3gVBSJmegIrAnM+KSxFxokrCsj
         HbOLcNPBp3X1Lh5OcQX/hQq/yENPlBZI5LYrGdnxRpMx5S3u9BqRxWepC8QyQTgZ3CWU
         55auwMtRho9+piGLSWVrq0Ox2aC+pAqv5ADvsaXW7OetmzsqInRrmHvFELHUaEnQ/vze
         oCqGuv1lOp9ASR7GWJlFrsYphvkYU157SNJP0s8zUyLo+smoJyP5SUlZhW0u3IIITy/Y
         v8Iw==
X-Gm-Message-State: APjAAAXzgba+jYWdd+VQ5Va7b40bXRbkgyGgpUvQqm2jFd36v5QWVtpp
        xKYYkWHKcUSBcosnwdqss/UWmmuqpve3336iLPAtBT+UF8tk
X-Google-Smtp-Source: APXvYqwG5oLWyjbGE6ewdBYLLd8/QJqWBPdBpJbBd5lO2AOuq4gByr1Wb7t00lBkf6HKg1HrD08mGyMktUPzxXK3Zn/iNXHZ6w5b
MIME-Version: 1.0
X-Received: by 2002:a24:6e84:: with SMTP id w126mr754009itc.3.1553146320227;
 Wed, 20 Mar 2019 22:32:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 22:32:00 -0700
In-Reply-To: <00000000000089d2c9057a0c083a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3976c0584940e6e@google.com>
Subject: Re: general protection fault in __x86_indirect_thunk_rbx
From:   syzbot <syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        neilb@suse.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit dee160df820de41ff2f59a715643680822a0ab06
Author: NeilBrown <neilb@suse.com>
Date:   Mon Nov 5 01:30:47 2018 +0000

     locks: use properly initialized file_lock when unlocking.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f39fd7200000
start commit:   dee160df locks: use properly initialized file_lock when un..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=100b9fd7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f39fd7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
dashboard link: https://syzkaller.appspot.com/bug?extid=83e12cf81d2c14842146
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd9447400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1121d82b400000

Reported-by: syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com
Fixes: dee160df ("locks: use properly initialized file_lock when  
unlocking.")
