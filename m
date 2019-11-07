Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E4C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C832187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbfKGOZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:25:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:45742 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfKGOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:25:02 -0500
Received: by mail-il1-f200.google.com with SMTP id n84so2772751ila.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aXA/qtZY4oOTCsYiBcMDsKnc02UJ0JcCx9sYAFguzus=;
        b=pNhiAddpuNvDcsPxf7GBhnwE1uLNg9Gh59z8K0V7NVv0SeZx5+jN+rkndROGycVG5O
         ECXMrodwD1/Ql7v4fzg9MiX9iZIhZIHpmMtAtbugr+oAO7QxU/n7ue0Ay23ui7Q5tr2E
         5JUr3cF8oR2aRVYDTFalJdB1BuXHv0pLIlz4vP+qRen6T1+GerIjy/fZTzEVS0IOz10T
         Tn7c7JneixQcJgukzP8rYv7gfytaqLdK5JNiQgmMIEuEuzax8HGs/nRl5PxjzbGq8n0I
         JTKKQ7MOCLzh7ynA2QCNCg1jmYFYsONmH24pYbverueizEhlTylfXaggI4sjo7T9LKxi
         aF7g==
X-Gm-Message-State: APjAAAUOig9Yk9k4vavvZGuVlTYTBXVjE7A830tB9Nmt/DkZCN7nCwHX
        QybxRNPatIppiFVLmBN5wNhtkzyOl+FsVJT+fNOfTs+HXQuM
X-Google-Smtp-Source: APXvYqzhVbQHRRQG3ztTd/5ul5cILBfkVe1smBx7OAbF3aZAZubRe2mOAuxRKz85d2VTjG3jiyDgI43LILSaID3QKvS3c8HmQDEv
MIME-Version: 1.0
X-Received: by 2002:a6b:b458:: with SMTP id d85mr3874308iof.287.1573136701319;
 Thu, 07 Nov 2019 06:25:01 -0800 (PST)
Date:   Thu, 07 Nov 2019 06:25:01 -0800
In-Reply-To: <0000000000005b2aad058e722bf3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043f47d0596c26e68@google.com>
Subject: Re: INFO: rcu detected stall in do_swap_page
From:   syzbot <syzbot+2a89b1fb6539ff150c16@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com, cai@lca.pw,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lpf.vector@gmail.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 32aaf0553df99cc4314f6e9f43216cd83afc6c20
Author: Pengfei Li <lpf.vector@gmail.com>
Date:   Mon Sep 23 22:36:58 2019 +0000

     mm/compaction.c: remove unnecessary zone parameter in  
isolate_migratepages()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=159dcaaae00000
start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
dashboard link: https://syzkaller.appspot.com/bug?extid=2a89b1fb6539ff150c16
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1456f9d0600000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: mm/compaction.c: remove unnecessary zone parameter in  
isolate_migratepages()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
