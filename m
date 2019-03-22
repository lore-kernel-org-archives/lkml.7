Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA13C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF42075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfCVWpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:45:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39816 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfCVWpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:45:01 -0400
Received: by mail-io1-f72.google.com with SMTP id a9so2948591iol.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zCALCNEO7NtFKxHfvEoBHzJUygt2XBFs5Dg/oqssbps=;
        b=VZSlv6i8QZl5Ai2XyINJa0s+7vTs2RLtU5Lk6Iel9r7QF76wzGOrdcDg+z3yQydaqh
         Cu2pQuSVYPV80AIZrm205mIRDWtkP1VI48XnWeu2CCivmcLG/D/PI8tSfK7Z66HgzQCb
         1ib8Rs9RNPMjPBaaO+t8ZxbZLIsbHzBdSrMblZ8vJf2QdckM1oQKc5V0MZzpUbpKZvyZ
         9EyzoeIFVlIPiEj7hTctOnU1iHVuO6TQFJDVRRtaVNcyxNu8rKbUVzCLJ46eSybZ5Ii6
         DsXFMM4UFXk5i85uB1LsVrazYsnMxW8sZkMDKuxzC2UATlMtdfFndHVUdp6V0gvfyIxC
         bSzA==
X-Gm-Message-State: APjAAAXwfsVqocX8bg2ZM2DqKk81/Xah/YB/mn7ZUwngRh5VBDRximOi
        MNecNy7Og0BpcFVQbuTkf8lOxBWQRbBxwL5o7FeBYMkCi1Wz
X-Google-Smtp-Source: APXvYqxlMHnEBpoHifDJpAyMFP2NLWonn97WJtkDeK1UM0im4KbDRyJkDObbN/BJfI9PK42gT6QHAX3y5Rr0EmcNS0ZY6CFOruj/
MIME-Version: 1.0
X-Received: by 2002:a6b:6218:: with SMTP id f24mr7986054iog.229.1553294700965;
 Fri, 22 Mar 2019 15:45:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 15:45:00 -0700
In-Reply-To: <00000000000080601805795ada2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1f98d0584b69aa6@google.com>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
From:   syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net, dvyukov@google.com,
        hans.verkuil@cisco.com, helen.koike@collabora.com,
        hverkuil@xs4all.nl, j.vosburgh@gmail.com,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maheshb@google.com,
        mchehab@kernel.org, mchehab@s-opensource.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f2fe89061d79706eca5c47e4efdc09bbc171e74a
Author: Helen Koike <helen.koike@collabora.com>
Date:   Fri Apr 7 17:55:19 2017 +0000

     [media] vimc: Virtual Media Controller core, capture and sensor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ea247d200000
start commit:   9f51ae62 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11ea247d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ea247d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62118286bb772a24
dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15701a33400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c8e4d400000

Reported-by: syzbot+06283a66a648cd073885@syzkaller.appspotmail.com
Fixes: f2fe89061d79 ("[media] vimc: Virtual Media Controller core, capture  
and sensor")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
