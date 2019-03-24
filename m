Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8281C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8939C2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfCXGJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 02:09:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:43078 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfCXGJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 02:09:02 -0400
Received: by mail-it1-f198.google.com with SMTP id w200so5917826itc.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 23:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TLpu5Z7BhgHeIfV99kpBMulqLfk4Qeg+yuXuPCVOlps=;
        b=nLKWvBhZgbXyMyzyiwzroaO0OVXsCQJO797p+ESAi8H3jS4dQXUB6cQqjfBEEg+I5P
         3BdZQeuWFttFtbFyWidyatTZzDE4SIcV7vrwSWUZZla3AT/kXxnhUJ6IjhRVv8BFlYFY
         0Frbxfb+w821QS0ae8RM2VbCMM5s8N3zHr1vHhZP7rC6mMR7F0bRBv4gTkZoGDgcKyC7
         IrwBVQCev+qNLiqq5pmqZnc2K2hv+4xA6rDOdNKgQMRgksD+S/6LrZ53P9M8heZjkwIq
         62cbqzfHfWWBP3tHWSzPti20Eo2LBwLVn6fjmMgPWFVDWCEmIoC40Wc7t9jz0iOCBDmr
         Bzzg==
X-Gm-Message-State: APjAAAUn6pwmbHoQQ/rnXHeh8qKBLDFXlsvUtQcRZnroP0Ajimgnwzau
        REjuvqZAT25ePDXKiaaXrq/EVNr8OkHB8BHTLxYtWgyQzlm1
X-Google-Smtp-Source: APXvYqxAKAfJWZ2v7Y++Ei2frHldyzdcxeLuASMyRXR+g8XVu3yjJeJ1kiz14OzgOvSMjElVnl9o+TPFn9Z2JppGVTrfGTJYSqM1
MIME-Version: 1.0
X-Received: by 2002:a24:6c84:: with SMTP id w126mr6854813itb.35.1553407741266;
 Sat, 23 Mar 2019 23:09:01 -0700 (PDT)
Date:   Sat, 23 Mar 2019 23:09:01 -0700
In-Reply-To: <000000000000bc9ddf057e577c98@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c14c60584d0ec76@google.com>
Subject: Re: WARNING: ODEBUG bug in netdev_freemem
From:   syzbot <syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com>
To:     a@unstable.cc, alexander.h.duyck@intel.com,
        amritha.nambiar@intel.com, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, decot@googlers.com, digetx@gmail.com,
        dmitry.torokhov@gmail.com, jeffrey.t.kirsher@intel.com,
        joe@perches.com, jonathanh@nvidia.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        pdeschrijver@nvidia.com, petrm@mellanox.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, thierry.reding@gmail.com,
        treding@nvidia.com, tyhicks@canonical.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 96e5da7c842424bcf64afe1082b960b42b96190b
Author: Dmitry Osipenko <digetx@gmail.com>
Date:   Sun Oct 21 18:30:52 2018 +0000

     memory: tegra: Introduce Tegra20 EMC driver

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14450b93200000
start commit:   28e8c4bc Merge tag 'rtc-4.21' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16450b93200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12450b93200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
dashboard link: https://syzkaller.appspot.com/bug?extid=979ffc89b87309b1b94b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a93c4b400000

Reported-by: syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com
Fixes: 96e5da7c8424 ("memory: tegra: Introduce Tegra20 EMC driver")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
