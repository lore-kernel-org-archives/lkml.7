Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FFFC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09272196F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 14:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKIOcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:32:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:51323 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfKIOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 09:32:02 -0500
Received: by mail-io1-f70.google.com with SMTP id v14so8424026iob.18
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 06:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JZi5tkp/gckqrQSG8tYsCT0DyycZxwi5ufMcg5DoU5o=;
        b=IrIZsa5QBtHNOphFV7mlc4mrxrhX680skJgGJNdZSXaRY3rtucuHZMRdpYtB11c9Xh
         ObXe5TspVwgLs+VEViuFLOmBeIHq/Qsdv50TMTJdV5jMoCDqtTRpwSMX0080RGE0JUOF
         CgVRn6CsUSq0Q3ccaolfNJwjCJNFtL4wuuLTCxq3RIwuwu1P0sUNgRBPB2yg1OqEU2Ml
         UZcyiArankqgeF7D1qUMCJJ5KmJhGRMgay8TMjncwVGH3anfk3t+NFRvIkWGoYwatki3
         PTrNn3lA1wmnLj+t/AX6TyvQl5mtAxfq7+YOyUOBuZQg5cuuc/EoCHTsiwE51M7NvKRZ
         2nHg==
X-Gm-Message-State: APjAAAWiYhseS3LP9s2rFltRxB3RvwZAH4I36ZF5DbNEghbP6csFxx9x
        g0ZejXH762dBSwmPU0AfJSvZ2VCzFzyPS9B4E7JgrF6Je5Ck
X-Google-Smtp-Source: APXvYqyoeCdf8LV4IECaLdOHYImFqe90Hff/exUBRMytawJCGLHrKdaUiBLrWfSr7NsrTpsl73JiShExe8f7ksVJLj1e/jt5f1X9
MIME-Version: 1.0
X-Received: by 2002:a6b:7847:: with SMTP id h7mr16503562iop.141.1573309921226;
 Sat, 09 Nov 2019 06:32:01 -0800 (PST)
Date:   Sat, 09 Nov 2019 06:32:01 -0800
In-Reply-To: <0000000000002b42040573b8495a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9fb820596eac28b@google.com>
Subject: Re: WARNING: refcount bug in igmp_start_timer
From:   syzbot <syzbot+e28037ac1c96d2a86e89@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ap420073@gmail.com, ast@kernel.org,
        benjamin.gaignard@linaro.org, cmetcalf@ezchip.com,
        daniel.vetter@ffwll.ch, daniel.vetter@intel.com,
        daniel@iogearbox.net, davem@davemloft.net, ecree@solarflare.com,
        edumazet@google.com, f.fainelli@gmail.com, idosch@mellanox.com,
        jiri@mellanox.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, mcroce@redhat.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        petrm@mellanox.com, sd@queasysnail.net, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vincent.abriou@st.com, xiangxia.m.yue@gmail.com,
        xiyou.wangcong@gmail.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 323ebb61e32b478e2432c5a3cbf9e2ca678a9609
Author: Edward Cree <ecree@solarflare.com>
Date:   Tue Aug 6 13:53:55 2019 +0000

     net: use listified RX for handling GRO_NORMAL skbs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a5452ce00000
start commit:   ae596de1 Compiler Attributes: naked can be shared
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=e28037ac1c96d2a86e89
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178537da400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net: use listified RX for handling GRO_NORMAL skbs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
