Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9A21734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgACJsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:48:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46304 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:48:02 -0500
Received: by mail-il1-f200.google.com with SMTP id a2so22936962ill.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 01:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zfhs8YRWlSgmuSFGXbqJyQsI/XchWtbdF57Va++zvNw=;
        b=gDIktUt0iun5OPrk5MZTiv/u/jIkcHNBaSp/fSupftB6c0YHne9wxBSYMQmQYBp1O9
         +gINaLlI6Q8YiuAcrAeZtf9trdwuBUy9a1T8u2Em9ZmSMTKjZYva5v57tPn5q45hWHtX
         G0trq6X6/79Y4ay0ZpIqW6jl7FzB7K9ezs9eYsG8aS9FyQ66dbfZgOWKzRb4gg7BpiMF
         dCg5L2nZHcPOjD/w/jKu2u3UXtTp0syBrUPwmMn78bxTnrTzjWuTPxlQzKjQuFXuVntS
         B/LK9/c4NEw5A3O/cgXAvMAhKzR3a9ECJptLQX3FDNDh64GYeeQSpeGDmf78blqZWV1D
         mzLQ==
X-Gm-Message-State: APjAAAU+o/36JUUQ7Iq+vpGEQRDwCfShbyXNr/aRC8fa83xMImEU0s34
        NzXNCvAVvBt206nhEcnZ3CWhLszI++AeDP44O6NFd64U80KA
X-Google-Smtp-Source: APXvYqyAAJrBpm4Sbnrf8d6tOqPsb094c6EUG37fsf+Xtlfb67I+HkehfzTSOHCUxnbaSv6jsQKLF3DwUGl9KNDKrZRTYyxC+C5E
MIME-Version: 1.0
X-Received: by 2002:a92:4448:: with SMTP id a8mr75875825ilm.256.1578044881277;
 Fri, 03 Jan 2020 01:48:01 -0800 (PST)
Date:   Fri, 03 Jan 2020 01:48:01 -0800
In-Reply-To: <0000000000005f7f920598d25a5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000969b9d059b393473@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vcs_scr_readw
From:   syzbot <syzbot+7d027845265d531ba506@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, dave@mielke.cc, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com, kilobyte@angband.pl,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, nico@linaro.org,
        nicolas.pitre@linaro.org, npitre@baylibre.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de,
        tomli@tomli.me
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 0c9acb1af77a3cb8707e43f45b72c95266903cee
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Tue Nov 5 09:33:16 2019 +0000

     vcs: prevent write access to vcsu devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11602fb6e00000
start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=7d027845265d531ba506
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c0459ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4477ae00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: vcs: prevent write access to vcsu devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
