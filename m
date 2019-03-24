Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98846C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5F21841
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCXBZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 21:25:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:39692 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfCXBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 21:25:01 -0400
Received: by mail-it1-f197.google.com with SMTP id e124so5579485ita.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 18:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=o87l/apfrZF46lv2vNvCnHxDi0DCoOhALlrLhZwnEzA=;
        b=YJXEssHGcQsk/95t0iWHk+7u4scxqAxXGe0quV45bI12hozSqiC/Ai+/Gm2DULqT0e
         ozMCpFqHY6Gpm0123mnGSm+GEpFSufx8JM7tp0FjPMeuDz2ol90p++d/s8uzxOlJMTbh
         j7wwhxuvvnNV2USaZ6EpAIzGN2D+9uRL0I7ZjWq7hD26q4J0mnNmSPp2t3jyXLdNcJHr
         s+r27HSJOr7TWy8sOQqUtzyhSTloGk98+Crr2pxCTGVM+U8E5JTri/a/+t3yzBwNDAzA
         BEGdfbOVr5wJfjjLRz0D+Tua5GKjkqGonYv1c3SXE4Gehd8cUNGVrPXC1ZPwI6EnZbV4
         EWuw==
X-Gm-Message-State: APjAAAVNLopZKBpu12bLTzKqqj8ZhQRwZkRXFhkpURzU6ntvAor4xCpT
        f3s7y2OL4GB6Dut6chRjXdbPj1GnDpwTniAxWNgPeqGQ+GOm
X-Google-Smtp-Source: APXvYqy4zl2fpQQ3IFS0acR7oh3vObZnSoyV2mIH3BloDr+5QGLBaP4/xnEwU038hQ1HNdw0/u1CUvYUN+mU34ggt2M/KuGUooAp
MIME-Version: 1.0
X-Received: by 2002:a24:10c2:: with SMTP id 185mr6145538ity.52.1553390700419;
 Sat, 23 Mar 2019 18:25:00 -0700 (PDT)
Date:   Sat, 23 Mar 2019 18:25:00 -0700
In-Reply-To: <0000000000007cd20e05809c2f96@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e560fa0584ccf44d@google.com>
Subject: Re: INFO: trying to register non-static key in icmp_send
From:   syzbot <syzbot+e1628a5e87492e6f1b76@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dledford@redhat.com, jgg@ziepe.ca,
        kuznet@ms2.inr.ac.ru, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        monis@mellanox.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit abd5f00844ec7fa507064ee4a22b3605c64c7d31
Author: Kalle Valo <kvalo@codeaurora.org>
Date:   Tue Mar 27 07:06:18 2018 +0000

     Merge ath-next from  
git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f9389b200000
start commit:   4aa9fc2a Revert "mm, memory_hotplug: initialize struct pag..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11f9389b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f9389b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
dashboard link: https://syzkaller.appspot.com/bug?extid=e1628a5e87492e6f1b76
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175c96ef400000

Reported-by: syzbot+e1628a5e87492e6f1b76@syzkaller.appspotmail.com
Fixes: abd5f00844ec ("Merge ath-next from  
git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
