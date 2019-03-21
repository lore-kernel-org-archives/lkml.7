Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3BB218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfCUDeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:34:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54731 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfCUDeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:34:01 -0400
Received: by mail-io1-f70.google.com with SMTP id c17so2841631iom.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 20:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mTOvCXkdsi5TD05/HnWWDtFxRFA+wTXdCySkbn4fgVE=;
        b=cmICPsCy/gS9sUSC4XjE/5J+a5rucqg9zS470ML1MvFInj19EtT1I4WmX2UIimRRiT
         N3rLQn7F49oJ+9TKxj9IZRJkGU6qL3hlgur/AqbUpoPDns9C6b4ojhPAWSS9kJGaHXCY
         0+gnvOL8+1u3GXrB/WSAYWoEz1ICItDisJifMf7d9a3Pe4Bc+AACdzs6YB3+ihNNIQc1
         8bNHZ6kFBe/AzimeMeIfCkwW43bChsVuReyiOwowloUUL7KiSm7yWEb3WRFa+LfnkfGx
         Ywjx/Vrapkl1OnReieKq2aWnRmeDtcQhAoT0c5YAtB6JUjVl9cDrb1zZYZomzxJb3Ds2
         JuOg==
X-Gm-Message-State: APjAAAVdXRWN+xLA3f+WxY6lcuYqW0P03cqwibce3tq+dNgP76xVDrJE
        BVNx4euh+SirMpuFtO25o4TJ06hUcwGewzo00oSjvfoBxvhQ
X-Google-Smtp-Source: APXvYqyJ1OeEfrbbP472DGBNSp6TPz2cY7sxlzHrOiwQFC68q2ULtpuaYlc2iuX46eS7exuPiuDphTZfduQaoGJB5PjKkZjCSJ0B
MIME-Version: 1.0
X-Received: by 2002:a24:9796:: with SMTP id k144mr585535ite.0.1553139240613;
 Wed, 20 Mar 2019 20:34:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:34:00 -0700
In-Reply-To: <000000000000fd464c057a679adb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b93e5a05849268b9@google.com>
Subject: Re: KASAN: use-after-free Read in update_blocked_averages
From:   syzbot <syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sbrivio@redhat.com, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Thu Nov 8 11:19:23 2018 +0000

     fou, fou6: ICMP error handlers for FoU and GUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e33c17200000
start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13e33c17200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15e33c17200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcbea7daf3ea3e3e
dashboard link: https://syzkaller.appspot.com/bug?extid=0dbf864d3b52555e8265
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ae6d5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dbd77b400000

Reported-by: syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com
Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")
