Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F0C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698492075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFEGrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:47:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37573 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfFEGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:47:01 -0400
Received: by mail-io1-f69.google.com with SMTP id j18so18257820ioj.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0DTPebv5NG8S97eb6NYfGtH6s2XhZbJcgpOSN9G3WRc=;
        b=ETslqs7H6MnFYihiBoPs9AJGwgrk9RuLblZn2ZT4ngVSI7CNyD1fihQc9tBQbeV8jO
         mTDMCi8g6d+OIu04FVivTvBmdx+O5t4iCTBlRTixGvlS9l18klI67ay1d0XuMv2K2pKA
         QtTZtZBRyz1hlMGiFfAJK47WdoX2hcIRRWj3CbjHs6BDtSQRJEl1+nUId2Ym5cajp3s2
         u/D4X/oXmFscbRsHUXnpqyK0J6clOGWoF86FJ1jw/pcqWpN6b9pbD6WQwq0TfxMjd+kH
         0XzVUZIAt3+eylcq1CamrpAK0WmxH75D4dewQe0jQN2hPXrb35jRmpBneepr5MAGp1S1
         6GSw==
X-Gm-Message-State: APjAAAUmgTZzcpP6gxW4WuYs9hDXQ/Nvm3ivHlGbLMGccSX9vI2tIQuU
        GuhYeNWwyYlCp1bV8QmjUa8wkUTej07WQYmzP+Xud/7QOY6E
X-Google-Smtp-Source: APXvYqxcRwKznu5s/WF30ioOt1OAX+adyD0fCRP3X69hk9R87NnszpPYpCAzlAXH7mBu0a2hct/HG73f5mTEx1ANoDYrvg/aI0Iv
MIME-Version: 1.0
X-Received: by 2002:a24:2b8f:: with SMTP id h137mr7710740ita.162.1559717221001;
 Tue, 04 Jun 2019 23:47:01 -0700 (PDT)
Date:   Tue, 04 Jun 2019 23:47:00 -0700
In-Reply-To: <00000000000097025d058a7fd785@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e878a9058a8df684@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in css_task_iter_advance
From:   syzbot <syzbot+9343b7623bc03dc680c1@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        daniel@iogearbox.net, hannes@cmpxchg.org, kafai@fb.com,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        netdev@vger.kernel.org, oleg@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b636fd38dc40113f853337a7d2a6885ad23b8811
Author: Tejun Heo <tj@kernel.org>
Date:   Fri May 31 17:38:58 2019 +0000

     cgroup: Implement css_task_iter_skip()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1256fcd2a00000
start commit:   56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1156fcd2a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1656fcd2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=9343b7623bc03dc680c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102ab292a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f0e27ca00000

Reported-by: syzbot+9343b7623bc03dc680c1@syzkaller.appspotmail.com
Fixes: b636fd38dc40 ("cgroup: Implement css_task_iter_skip()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
