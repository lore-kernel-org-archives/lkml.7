Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29C520882
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfDABgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:36:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52603 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbfDABgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 21:36:02 -0400
Received: by mail-io1-f72.google.com with SMTP id p143so7020789iod.19
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 18:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A/qvTuzWzcXrKwk5I9hqWbCkLBHuV3PpWBSNby7m4MI=;
        b=CZUJ1IpBvGU7JQijKjieWRkIDQ44RWGCtHaTZr2I35ixb3IUHgNj0r9l3BmBX7mUEC
         GoOc32Y1G/HWT6iczJ8pLcRMi0zc3/OZDRZp1FBj4PHSxhDN7/nl944tF6EkiWnXNa+y
         yxw1xb4gcFnrAJo3jIeDFb4sEj4yldnZXixVKwQMPvJ2pBMi3ZH7mHOj+ya0LgbX6vjX
         3J8iD+2V70FcsACm7bT7HDdAGLW4/idJmgrVMkm0kplAQzlBabpm2hQbvJX+hgIRiNZr
         9AkyV7kRYH0fEufel4beIh9+OCHD1wz9LX1RXi3wJqUZKLmfsQgcq0QZ4m4YLPHHjH9N
         KsJQ==
X-Gm-Message-State: APjAAAXWo4/6GmCm5RpowpLjsWbABUZjTD+VI2ZtgIyGd2yNKBGCMotk
        6+MHPUTzmxOMJa9zBdOMJbfEwq8D8NuNZLTXXkp4At9Zj3NJ
X-Google-Smtp-Source: APXvYqwvoXmhoAUfBKfjExPABvmIvM/cQrgmMgsL4VzBfhkMrbpnSevW8i8VZDVHAuWq+5SwN8DJMO6jLKKNdNX1eDjxksB6795s
MIME-Version: 1.0
X-Received: by 2002:a24:43c5:: with SMTP id s188mr5327781itb.25.1554082561338;
 Sun, 31 Mar 2019 18:36:01 -0700 (PDT)
Date:   Sun, 31 Mar 2019 18:36:01 -0700
In-Reply-To: <00000000000010c9390570bc0643@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000531f105856e0b18@google.com>
Subject: Re: general protection fault in _vm_normal_page
From:   syzbot <syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, dvyukov@google.com, dwmw@amazon.co.uk,
        jglisse@redhat.com, kirill.shutemov@linux.intel.com,
        kirill@shutemov.name, ldufour@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@dominikbrodowski.net, mhocko@suse.com, minchan@kernel.org,
        oleg@redhat.com, rientjes@google.com, ross.zwisler@linux.intel.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4a110365f1da9d5cabbd0a01796027c0a6d5e80b
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Wed Jul 11 00:45:42 2018 +0000

     mm: drop unneeded ->vm_ops checks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b0650f200000
start commit:   98be4506 Add linux-next specific files for 20180711
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12b0650f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b0650f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f3b3673fec35d01
dashboard link: https://syzkaller.appspot.com/bug?extid=120abb1c3f7bfdc523f7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a46568400000

Reported-by: syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com
Fixes: 4a110365f1da ("mm: drop unneeded ->vm_ops checks")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
