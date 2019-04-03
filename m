Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0CDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D0D20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDCBMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:12:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:57107 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDCBMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:12:01 -0400
Received: by mail-it1-f199.google.com with SMTP id s21so4680358ite.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FCwTOgxmFo0oDnVVeiPUacD8o954VtUYEUxjzO+xRdQ=;
        b=jj49v1hTc9HNphf7eoT+8wtG/5pLwG5cbc0p2axtidW/ud5W39ZTdt14n2MxfZ48b5
         GmAKlYGFlZ7BT2fIfD3VQ14hmyUf8S0rGKHlq4Rjj4ubaL2oTa04TUuiS3rMtiI8gfeM
         alv094V/JTTsSAkJ/caXaO8uypHgJpehMvwzXtIwZGVX4WCn2YtT4RMcpyJBu7m2u5dv
         iJbgBiAP61arN1M7Yz9o3CT7Dbq38Vlr1GdLMZSIM1xMx5MCwHi/Zh8viLrVEw5sQkNs
         Urpvxv+cgTTkThdF+75ppN+jJcrGlHHpLOwazC3N6GaYRDHb0V2YIx4Z83ApCcpvuQG6
         L7pQ==
X-Gm-Message-State: APjAAAV5vcYPUBZuBe73u5KXeH5F59pbK1Ngo3ei5EihOZszUnrcyMAa
        Iiw211/gmVF5SD7loQL06kQP+asrQiM67GZw6jCDpErx0rl5
X-Google-Smtp-Source: APXvYqyEYEQc//7zZL4I714pLlYM3XCXZ2FL5XBSds3ESVs+UJrU1EpRdxctocNVsnf9ftQ/f4rh+DY/lqoe1ED2uQoE08Vp3VwD
MIME-Version: 1.0
X-Received: by 2002:a6b:ec0d:: with SMTP id c13mr1625952ioh.23.1554253921072;
 Tue, 02 Apr 2019 18:12:01 -0700 (PDT)
Date:   Tue, 02 Apr 2019 18:12:01 -0700
In-Reply-To: <000000000000e02450058593df62@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db3c59058595f0ac@google.com>
Subject: Re: BUG: using __this_cpu_read() in preemptible code in ip6_finish_output
From:   syzbot <syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, ecree@solarflare.com, fw@strlen.de,
        idosch@mellanox.com, jiri@mellanox.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        lirongqing@baidu.com, netdev@vger.kernel.org, petrm@mellanox.com,
        sd@queasysnail.net, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 97cdcf37b57e3f204be3000b9eab9686f38b4356
Author: Florian Westphal <fw@strlen.de>
Date:   Mon Apr 1 14:42:13 2019 +0000

     net: place xmit recursion in softnet data

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c04b0f200000
start commit:   e1427237 macsec: add noinline tag to avoid a frame size wa..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13c04b0f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15c04b0f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e9bc94c16d346a6
dashboard link: https://syzkaller.appspot.com/bug?extid=51471b4aae195285a4a3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ffb07200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14412673200000

Reported-by: syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com
Fixes: 97cdcf37b57e ("net: place xmit recursion in softnet data")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
