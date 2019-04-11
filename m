Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D52206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKMOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:14:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54470 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:14:01 -0400
Received: by mail-io1-f71.google.com with SMTP id c17so4662768iom.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cR60vCMLhHRTpswjZfhooIP8Hma1vPgin0AXvYMDh0s=;
        b=OeBy5l0OO9UJe54JmqY8x/3USvUgmKo8qvFkTr6Vt4p00ND0NUDDJrlH6Kp4N6OgPx
         Ed9qflugsb1HBujscdiq2Fu+Uj4mqLs5JNd9aMp3BythbQLt1KC6Shr3DBkGcn9JSsuN
         ATu1bXPY+d1iS0sPQePcbJMTkuvYrAXIWqdFNU0HsrU3msqmnuIavfI9nCSJzN5opVOY
         50SbZpGYCkCGMnmU+CSE0JBO5ksE6F0fg844Z1s9LJ7jEMJCuX5CL6ZcDvOy+R3Vknx0
         s2Y+chN/kocgFWoDQA/kRvZEinYYeqOZPGGSxuNDEPpLgbCX25IL2mSZL+gAyFep/P3I
         LJgA==
X-Gm-Message-State: APjAAAW9gYFReLS413h38hT9pHuQcoSL4KT+xkva6a5w00k6tWT3nLxx
        49WdcEN8wQwPbmBZivOrkaY3r91pWf4l3o1VgNDU0tJ3+teb
X-Google-Smtp-Source: APXvYqzK1P71Q/BRcrCT6iNrGNC8OrRFpihfnoYN3tGWPzEpTjqOgdt44TUuZDljqoC9+mI4MT7gzGGh5pO17DnrV81P4PMA4l0i
MIME-Version: 1.0
X-Received: by 2002:a24:cac6:: with SMTP id k189mr1833557itg.24.1554984840761;
 Thu, 11 Apr 2019 05:14:00 -0700 (PDT)
Date:   Thu, 11 Apr 2019 05:14:00 -0700
In-Reply-To: <000000000000b7fd51058370d0d9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000109c700586401f48@google.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
From:   syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
To:     benh@kernel.crashing.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 726e41097920a73e4c7c33385dcc0debb1281e18
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Jul 10 00:29:10 2018 +0000

     drivers: core: Remove glue dirs from sysfs earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f69eaf200000
start commit:   771acc7e Bluetooth: btusb: request wake pin with NOAUTOEN
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f69eaf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f69eaf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=91fd909b6e62ebe06131
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11770a8f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128c945b200000

Reported-by: syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com
Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
