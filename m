Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364A4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147022154A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfK1GwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:52:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44867 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfK1GwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:52:01 -0500
Received: by mail-io1-f72.google.com with SMTP id t16so12477510iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 22:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2d9JKwKzyEklAE9Y0Al7lbLvDjVGrJsOdz2MW8XRI6k=;
        b=Fy7EpFAGTknmZFILso937JcIgotlgfBwFhk9ZAnfHGGlKKWJU22PxmR4vCaFuSXefo
         luDmptpZVcRxMS0xMh/oIirfQkAE9KBTmxvC3DaZO5gbyMGymkiJIZspjhN/tGUhR6yb
         Qbq5e44zKoCbyrPTYiRFPAMFyfuOvg+ulftiJ5Xgmdv/O1nXJuMqqwJhq1W/1rOIAm8R
         e9RBiUbNlvgH5pEFUXzAwkJh+t+fOHPLkKswKcpxlGGGh8RB7S0py3SLANr0ZhynUUgw
         k1Md+sogyoEVZ7Uw+CQzTOAa7imGPFDhKB7UO2TbwM8KGdvb6xzXqq6r0ZwwKNpyU7a0
         RdOA==
X-Gm-Message-State: APjAAAVs8QEU8ycbPajVJGKeVNha85gjfEsR/18GhBK6PpuQqE5ZO6H6
        TMpz3bm9s0+uJrvlrKuFJf5h4vcswR3AaK2gfJfWBYdaJvss
X-Google-Smtp-Source: APXvYqx5W1RZO7+3nd+L3OfHiIN1nhLb8vKwT1pMfJipAjyN/TdB0OArpLiFIBjYuYMxGprFVYmxz6y+5YYKemJMGYyZ2IplBP7m
MIME-Version: 1.0
X-Received: by 2002:a5d:8953:: with SMTP id b19mr13030362iot.168.1574923920949;
 Wed, 27 Nov 2019 22:52:00 -0800 (PST)
Date:   Wed, 27 Nov 2019 22:52:00 -0800
In-Reply-To: <001a11447acae6b4560568e08829@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db46890598628cf4@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ntfs_attr_find
From:   syzbot <syzbot+aed06913f36eff9b544e@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-ntfs-dev@lists.sourceforge.net, matthias.bgg@gmail.com,
        olof@lixom.net, s.hauer@pengutronix.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9dd068a4b85a68733213c874d08ef768bbec8d01
Author: Matthias Brugger <matthias.bgg@gmail.com>
Date:   Fri Jul 31 15:03:13 2015 +0000

     soc: mediatek: Fix SCPSYS compilation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10880f02e00000
start commit:   0adb3285 Linux 4.16
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12880f02e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14880f02e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df0c336cc3b55d45
dashboard link: https://syzkaller.appspot.com/bug?extid=aed06913f36eff9b544e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1430ded3800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1533214b800000

Reported-by: syzbot+aed06913f36eff9b544e@syzkaller.appspotmail.com
Fixes: 9dd068a4b85a ("soc: mediatek: Fix SCPSYS compilation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
