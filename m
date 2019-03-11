Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE7F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfCKNXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:03 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49467 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfCKNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:23:02 -0400
Received: by mail-io1-f70.google.com with SMTP id m15so4091098ioc.16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pK1+3s0qzliVgO8uChK0ndiAxt70wC3Rvaiv9+li/DY=;
        b=NQZqD6yi6vCvdv8kZqGTV2z4ph1UL4lxp9/+KfszTEVAmYLa/cPA0E/1nJ2LEEuD//
         igh3Avo+c5riewFDUBszG++m2jON6nsPyLXh6lFC1bTJDLKyFQYbZv9iGHA6mqFQH/NL
         EZh+T06oGBzuKw+l8aL9NYZYX4cEiomHAKd65wdcVt1p9ho9GOE7udLiYMGaFGru4/jg
         d3HzVMyQHMuIZKwguqykxt4FRZnKqhYqlwfiwM0eZKJUcsOubg5V6JgJOatBhTtL++hY
         OjGupKLneF2bvFqr3Ct51cZsAV0cnUi7EfEctENPUbSR2BmbKtmqPKyDju+aD3gOk4dq
         +tqw==
X-Gm-Message-State: APjAAAXcotTVIQ7WfsZGb7lz/BDQ/UJsrIMMuG7b+4fSwKfO0UXoARM/
        YAmeDsgGShdGY2ohTv5i4YFBzZBHIGpm2Kx4annXuth7GQkN
X-Google-Smtp-Source: APXvYqw5xG9uh2Gm9ddSyDz77pKjUJDXM3u365mXqCK7rViSoBgkjkhHMLjtY6/G8/Jdbai85TvgA8JTT2fUbMwoYP5kc6yuI0bN
MIME-Version: 1.0
X-Received: by 2002:a24:78cb:: with SMTP id p194mr20558447itc.7.1552310581223;
 Mon, 11 Mar 2019 06:23:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:23:01 -0700
In-Reply-To: <00000000000054cc6d05834c33d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c66d400583d17848@google.com>
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (5)
From:   syzbot <syzbot+5013d47539cdd43e7098@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, edumazet@google.com, eranbe@mellanox.com,
        eric.dumazet@gmail.com, john.fastabend@gmail.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 94850257cf0f88b20db7644f28bfedc7d284de15
Author: Boris Pismenny <borisp@mellanox.com>
Date:   Wed Feb 27 15:38:03 2019 +0000

     tls: Fix tls_device handling of partial records

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d9d977200000
start commit:   94850257 tls: Fix tls_device handling of partial records
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1039d977200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d9d977200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47f2db597668ac40
dashboard link: https://syzkaller.appspot.com/bug?extid=5013d47539cdd43e7098
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148763eb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1416ff3d200000

Reported-by: syzbot+5013d47539cdd43e7098@syzkaller.appspotmail.com
Fixes: 94850257 ("tls: Fix tls_device handling of partial records")
