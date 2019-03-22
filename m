Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7148A21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfCVJgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:36:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:37590 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfCVJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:36:02 -0400
Received: by mail-it1-f198.google.com with SMTP id m70so1573587ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6UX/TgGDLibE8vTJYl3LV3CO8yMVAlVvPPDilbU+4Xs=;
        b=iMlCRtrdNMaHBZLLKTyRL5lL1NTLaGJOd9Ft7TGymRezjiELr1YtwZCmP6yHHbY6Xn
         1WcrdzeHQ6SzTfuD3f+v0OJoSET1V9jYvhxyyDu3ihyyv9aaaRQkOknj05/Dj3pQQAFd
         E3JsR35gkaQ2ylZE12WjGOGOuhHVduU6IVEwdiALMYQxmjkk0y7ylrJj6MV4UmWUoq7m
         a1EOzWv+DDBbC43pu5sfac5u7LUxouHPTvSbXk5cVoNDt2iuq5ugcD9uTWPls1o92sOa
         +a29WwNOJcdGX3hyAXq7EiRcuGGgemihRp3sNAHs4bRdBDYAGIlN/UJqQ6mUsFoOmkl0
         TiQA==
X-Gm-Message-State: APjAAAX+4Xaf0LKr0A1x8B5p/xE+crHz3taqvMdDH2EJ3AutTFe2mdOq
        FU2qoFABn4sGl8IdzrIQ0rThkgAhBgZMlhufnuc0k4zcrNgk
X-Google-Smtp-Source: APXvYqzMAvq5h5tuI8AFCrBQB9bsrog7Ubvr5HoFyyOpwxjOaS0CGLcPugujchKTBIdK8BoQ36vtRG4nBXk8UQdBEqmLQ/eiqzRQ
MIME-Version: 1.0
X-Received: by 2002:a6b:e307:: with SMTP id u7mr6079118ioc.208.1553247361157;
 Fri, 22 Mar 2019 02:36:01 -0700 (PDT)
Date:   Fri, 22 Mar 2019 02:36:01 -0700
In-Reply-To: <000000000000601367057a095de4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035d0e70584ab952b@google.com>
Subject: Re: KASAN: use-after-free Read in get_mem_cgroup_from_mm
From:   syzbot <syzbot+cbb52e396df3e565ab02@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@suse.de, mhocko@kernel.org, peterx@redhat.com,
        rientjes@google.com, rppt@linux.ibm.com, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        vdavydov.dev@gmail.com, willy@infradead.org, zhongjiang@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection is inconclusive: the first bad commit could be any of:

2c43838c sched/isolation: Enable CONFIG_CPU_ISOLATION=y by default
bf29cb23 sched/isolation: Make CONFIG_NO_HZ_FULL select CONFIG_CPU_ISOLATION
d94d1053 sched/isolation: Document boot parameters dependency on  
CONFIG_CPU_ISOLATION=y
4c470317 Merge branch 'sched-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1592b037200000
start commit:   0072a0c1
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb52e396df3e565ab02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12835e25400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172fa5a3400000

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
