Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1022C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8405A20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393098AbfFMQyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:04 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:54588 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfFMCxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:53:01 -0400
Received: by mail-it1-f198.google.com with SMTP id n81so6811240ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 19:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Np5gXReZhEQY+f0111rtDnwU/KIuuZ02Fmiq9/XZl1M=;
        b=MATjW/+hcDlTZqTOJM63qTNWIrRKgGPDjJh7+jKZ+mQNJ9jTN/T/+51ZsOcpAX3O8N
         RV8gf8xTjWU2w4QWgj/0OqJsXWFAdvYN2qmDTKq7SAFWU78z+cjU547FVo2TL/t/a2ve
         pYGx0gltmrzudWgqoHmn2YzZ65f7fdCNOZVKowv8+NmfmzxzHmEH7p8n39Tlge2OC5Rx
         deJ1wQCoDuhfUccwcAG44P6c7zKbYu6FAy2d+HFvxqL9PEr5IJ//IeNjnL1Zqmofld6G
         jBl4aT8i/OIZ18GK1Qq0eGW8sqnrwKrPNYvWS4jZBU1hG/3ihmVd1Lc0lFdsJmQaX0xx
         klSA==
X-Gm-Message-State: APjAAAVeqaCZiiPOnCN/3uaaP3ao1IX43v2H27xwoixOa6BZCwLLJzT+
        AaN+3lZQfzWgQF0quO6aucLpZgPO6sN91tBH2O+u32oomEk2
X-Google-Smtp-Source: APXvYqx5IsSM2NAOI/iAdm4c3z4Q0KMokZxWs1UI+Ut9ao7lxnz24tDe4bNCdFgQ1DgRpytXrLHrXA/sEafV/s9VWjsSAD+q/q20
MIME-Version: 1.0
X-Received: by 2002:a24:9d15:: with SMTP id f21mr1753140itd.13.1560394380348;
 Wed, 12 Jun 2019 19:53:00 -0700 (PDT)
Date:   Wed, 12 Jun 2019 19:53:00 -0700
In-Reply-To: <000000000000a861f6058b2699e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0103a058b2ba0ec@google.com>
Subject: Re: INFO: task syz-executor can't die for more than 143 seconds.
From:   syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
To:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4ddc1b28aac57a90c6426d55e0dea3c1b5eb4782
Author: Chao Yu <yuchao0@huawei.com>
Date:   Wed Jul 25 23:19:48 2018 +0000

     f2fs: fix to restrict mount condition when without CONFIG_QUOTA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142f4e49a00000
start commit:   81a72c79 Add linux-next specific files for 20190612
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122f4e49a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa46bbce201b8b6
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab2d0f39fb79fe6ca40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250ae3ea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1568557aa00000

Reported-by: syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com
Fixes: 4ddc1b28aac5 ("f2fs: fix to restrict mount condition when without  
CONFIG_QUOTA")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
