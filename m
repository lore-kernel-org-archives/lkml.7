Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AEF20659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfLEBzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:55:01 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:36374 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLEBzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:55:01 -0500
Received: by mail-il1-f200.google.com with SMTP id v15so1324122iln.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 17:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4FLc7BuR7w3spPKHAoaSawNb5C2SfyMpTNFxv+oG8mk=;
        b=GasmWAI/7mkAK6lU4RTT1nQFCu3sFTBgTZbHv04ppg8pZiwN/4ul8OqbnMPysq/o+F
         i50mZULnF7N5vBb8a8sskvVbfT9KSPT9OBW67CLeQ+ZXA2sdzxD5VfJzc9Pehu9Xuhof
         FkrP5m0qrksSVZ+DvS3LVADMiYoud0DyQzQERVoYG19odMG6rnNySnv34H+ti27PycA7
         5kS+4IUIPFTXDiO/sac5ZwjgkMX5OvLABo1/O4KAHGBWUN6LuA67IEkatJ+VdNnajdLq
         82blsHDHP1S8jWfacGlDNKAEPaIrLOWvRMdVE65n6o9Qavl2BCnyC6XOq+DeYYEQsxHv
         lBlQ==
X-Gm-Message-State: APjAAAU2HRoTB46FJmh56qKw3fGtmWdRBuZQwM9imQaR2wIIxIATToV6
        H3yp4Z/ifBJOJgi6i+vFXmuq0tFYfBA2hVA/NuDdNH/VQDAI
X-Google-Smtp-Source: APXvYqzjP5/pIC/q5gNc7zKo2jBv47pzxF64WSrgioGICxedl/zZ1B9K/JruZLRezQwWnrssF3NgLpBc60Xng6Z/+9lTWhY+cHrY
MIME-Version: 1.0
X-Received: by 2002:a92:4818:: with SMTP id v24mr6139534ila.96.1575510900571;
 Wed, 04 Dec 2019 17:55:00 -0800 (PST)
Date:   Wed, 04 Dec 2019 17:55:00 -0800
In-Reply-To: <0000000000008399d40598d8a34d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000918b470598eb37b7@google.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in pcpu_alloc
From:   syzbot <syzbot+59b7daa4315e07a994f1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andriin@fb.com, aryabinin@virtuozzo.com,
        ast@kernel.org, bpf@vger.kernel.org, christophe.leroy@c-s.fr,
        daniel@iogearbox.net, dja@axtens.net, dvyukov@google.com,
        glider@google.com, gor@linux.ibm.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0609ae011deb41c9629b7f5fd626dfa1ac9d16b0
Author: Daniel Axtens <dja@axtens.net>
Date:   Sun Dec 1 01:55:00 2019 +0000

     x86/kasan: support KASAN_VMALLOC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c70f36e00000
start commit:   b3c424eb sch_cake: Add missing NLA policy entry TCA_CAKE_S..
git tree:       bpf
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12c70f36e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c70f36e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8ab2e0e09c2a82
dashboard link: https://syzkaller.appspot.com/bug?extid=59b7daa4315e07a994f1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140df641e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147dcc2ae00000

Reported-by: syzbot+59b7daa4315e07a994f1@syzkaller.appspotmail.com
Fixes: 0609ae011deb ("x86/kasan: support KASAN_VMALLOC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
