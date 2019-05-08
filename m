Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15C3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D7721726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfEHQwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:52:03 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:54432 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfEHQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:52:01 -0400
Received: by mail-it1-f200.google.com with SMTP id w1so2683655itk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0mythnzPfhPVWyHlhf2vS5jhrjHuHUNNfUDlg+aYw9A=;
        b=eSDsfN4JkFHLdvt0HpYNhY/0HbaACSddfmaXFjr7Uod0nI3hI6TJYIXpNYb8nKbMd2
         eUMdGNawAmXbzVMfuvbCbBGkkChRdxMJyDSxhuJl1jLwQbQIOdY8jTX7de7iSONsXcc7
         htKfUeYH1qOIby3JYgX/oZJfyj95c6HBvnGUvWhNPWAE+hLopkJoNiX1oh7bZNL0P9/W
         95Qpe7gVZhTTCo96mfM8uFe6JkHiENkAFPnRAsGGjSYM2tx+t4vTzui0mG0HXkrWuh+T
         S2tUULNDZqmj3BjGQLDREpCaZ/If4jaYNIA0KEF5P3GePWBv2kxYgXE7zwETLlTVnFmr
         IlPA==
X-Gm-Message-State: APjAAAVg2kfiOyAHx9JEDST1CszMoHdNl+gJVlyqg8goHoT9HSckFPhy
        +ATBFj/puL3yHVxUIr5vlH5KBf/mzthLiUA3D+bJTJ+qL3tL
X-Google-Smtp-Source: APXvYqzn8EGCMk5VzujP7HVqRUmMSRCGOcAA/AZcz33of0OiGm4u2Q+CbAdIyc3cECPxBabsd8wQ6BLVyHwoK22/ZFtvHA6zWcpP
MIME-Version: 1.0
X-Received: by 2002:a02:b088:: with SMTP id v8mr30068575jah.21.1557334320874;
 Wed, 08 May 2019 09:52:00 -0700 (PDT)
Date:   Wed, 08 May 2019 09:52:00 -0700
In-Reply-To: <000000000000a573da058858083c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe103805886326ea@google.com>
Subject: Re: WARNING in cgroup_exit
From:   syzbot <syzbot+f14868630901fc6151d3@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dmitry.torokhov@gmail.com,
        f.fainelli@gmail.com, guro@fb.com, hannes@cmpxchg.org,
        idosch@mellanox.com, kafai@fb.com, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, netdev@vger.kernel.org, sfr@canb.auug.org.au,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, tyhicks@canonical.com, wanghai26@huawei.com,
        yhs@fb.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e42940e8559c8bbffa8286cc78067c75eb42b374
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue May 7 01:03:30 2019 +0000

     Merge remote-tracking branch 'rdma/for-next'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1746b4e8a00000
start commit:   00c3bc00 Add linux-next specific files for 20190507
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14c6b4e8a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c6b4e8a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63cd766601c6c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=f14868630901fc6151d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fcf758a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1202ffa4a00000

Reported-by: syzbot+f14868630901fc6151d3@syzkaller.appspotmail.com
Fixes: e42940e8559c ("Merge remote-tracking branch 'rdma/for-next'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
