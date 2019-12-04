Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B816CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CABE206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfLDVlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:41:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53658 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfLDVlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 16:41:02 -0500
Received: by mail-il1-f198.google.com with SMTP id d3so811934ilg.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 13:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JrNPfPX8ooL5t/Vw7RYAMqCMbF8rwCtCqkj0exct6ns=;
        b=nHCyTH1mPVmZn4K5wI/tMlisU6bPyzwIyw9Eg5TaZZessgb7rfdwRGmOe+mEEWkuqa
         YvAYCB61xFqp5LR0qgn8agWBXLLCKbgB0kdDazs6JesjMXP48eeydf77uwXdGAY4aYiC
         UIE1sVVbH4Owt55ZWwfc/37kevb97d01MRvMEdLcJeC3bdxRFFTisXTk/ZeWFmU87d/3
         /RVgtOt0AaspXGkptFViMZvZOeIv5wI9qVHKbhCMu3DlXwWkqqlkpYyDbsyA52ajdju2
         UjkN1QA63tDRyBgGMp1w5E+KIP187IDBezyVo5DRhlEqNohYWg7rwyKG9/m1lNW++Fyc
         zj9A==
X-Gm-Message-State: APjAAAUfrD9hp+id125oUh/zJ9iuPcMQWgd2krwUe6w0U7pUpyYAfc6O
        pDel68+hI0tTROteyysfzhBQt7MAgSr55sepblX96YHjdxxD
X-Google-Smtp-Source: APXvYqweHEd887dmgHwZ98tD32QtHsIIU9QUEjKbdT4mjyi6aPIBc1Zjh5EyBzHGg/jDulIxR32o86hj/XmAPTryABiezG7aI+6v
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d3:: with SMTP id w19mr5157404jao.127.1575495661402;
 Wed, 04 Dec 2019 13:41:01 -0800 (PST)
Date:   Wed, 04 Dec 2019 13:41:01 -0800
In-Reply-To: <0000000000002cfc3a0598d42b70@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e640e0598e7abc3@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
From:   syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>
To:     aryabinin@virtuozzo.com, b.zolnierkie@samsung.com,
        daniel.thompson@linaro.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, dvyukov@google.com,
        ghalat@redhat.com, gleb@kernel.org, gwshan@linux.vnet.ibm.com,
        hpa@zytor.com, jmorris@namei.org, kasan-dev@googlegroups.com,
        kvm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mingo@redhat.com,
        mpe@ellerman.id.au, pbonzini@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, ruscur@russell.cc,
        sam@ravnborg.org, serge@hallyn.com, stewart@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127a042ae00000
start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=117a042ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=167a042ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=4455ca3b3291de891abc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000

Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
