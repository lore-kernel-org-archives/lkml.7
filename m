Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C271C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416B82071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfK1CAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:00:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:43317 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfK1CAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:00:02 -0500
Received: by mail-io1-f71.google.com with SMTP id b17so4623804ioh.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 18:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DYCoVBntiKkpTeX6a8KJneZkYAcva9u1pdG4zXgpO64=;
        b=aLN1CqURoAbPNtsg0tzX9O6hM2rNbyMacjG6W76BR1z5qVCeQbaz8j2t/wIutc4/Vw
         nKE1BuFAP6b5HLzBPkkMjfwHGPFxW1U5Z1P+cttltzG3Eerge9B/Qcx6XmnbPX5yOT27
         gYHH2lXF0BnRkwihd7YfWVt0Fu21H9+9gX2Qy93vO7667NX+S5lsemu6MkpYOBOeH4kT
         T0tI+lksRbuIqA6nihjCYgKGqDYFm2HgcsoHM3X1rjiOUS2QvXLn2KlFVNrDJbh13rao
         UmI/qsIYT4pbrxXzbSu3KS9hfv6C4HZLrPHS9DCS4U2XTc24yjG4mNyo4d7BSHJnP/YR
         cWJg==
X-Gm-Message-State: APjAAAUQdecapK+n49aQuQgiikCo9VJpri7vgR3JngVPy8QajcXzGGZL
        4na50xeasOMgUv3CHfliejlcbRILmHo0rG8ve5GOnMiVn/XC
X-Google-Smtp-Source: APXvYqxa6cVqXVISZzxW/NS5ndS0aUKG+LFds1IRmdw/COM4lIqUf7ADeUv9oT1zbWREBSImJJDTBYinlwECS+K++PZEc9N9rGqG
MIME-Version: 1.0
X-Received: by 2002:a92:461d:: with SMTP id t29mr49468857ila.100.1574906401298;
 Wed, 27 Nov 2019 18:00:01 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:00:01 -0800
In-Reply-To: <00000000000038b5c205983c2df4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009aa32205985e78b6@google.com>
Subject: Re: WARNING in mark_lock (3)
From:   syzbot <syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, jakub.kicinski@netronome.com,
        jhs@mojatatu.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com,
        wang.yi59@zte.com.cn, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d665c1281bc89ac85b8b0c058c22a3f94640a1d6
Author: Yi Wang <wang.yi59@zte.com.cn>
Date:   Mon Oct 21 23:57:42 2019 +0000

     net: sched: taprio: fix -Wmissing-prototypes warnings

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132ee536e00000
start commit:   89d57ddd Merge tag 'media/v5.5-1' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10aee536e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=172ee536e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595c15c951695d1b
dashboard link: https://syzkaller.appspot.com/bug?extid=a229d8d995b74f8c4b6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511af5ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e0f17ae00000

Reported-by: syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com
Fixes: d665c1281bc8 ("net: sched: taprio: fix -Wmissing-prototypes  
warnings")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
