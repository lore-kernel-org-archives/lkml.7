Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9821021774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK1KaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:30:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:40518 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1KaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:30:01 -0500
Received: by mail-io1-f72.google.com with SMTP id d1so2450412ioe.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1y+8h0adrUwE7n/UFRdlXn6lrWhJARMArZmc7WSZSbo=;
        b=a87dCFVowgsbl16jgQZ7moG1k7WzYqEJfRHJ0/Bx9rXnmTkGuvlC9EvkMRRQxCNYji
         NfRUEih5a01gfAuECMvV5iY3gPF/hikLHWsfWdIDN0eLx4GMlvcQ0egWo9ReoOOiNKxB
         B/hlzsSiKs3Eq0Q/EiN+gkuI+YvNPAHMbtg1xhjhStgm1maPx0cI2Jk1yxNgwLqv91Eo
         CI6jg/hOtSUdD7Zbxsv9a19i0a1u/cHLSQlS+ZSUzg0Yv5/ZGQp7TzZChHS4RSnQ2KX7
         +U44NdMHvlCGGWyvue4iL6ph9hnHjzk03wcPOZYmmtOD1iaTqcru0NrOh+XBZbQbTXRP
         /cmw==
X-Gm-Message-State: APjAAAUgjGPNxdTXLsJN2zTRYR+Khuz8Tpiufp019eOwWwXvvF19amG8
        wOb4VaZYJup/mmjC1zOMNbaW0ShORDlVQ+FH1B052GoW9/yI
X-Google-Smtp-Source: APXvYqw2P2kVfRCOmAlhCFdPp4pODsE7Gp3HDeRuvO52RgpRAmsfSGU8ZjG8MAIR7k8Tm/JF3bkAGnvJEgGs1eN+T2lG1oJs2xsz
MIME-Version: 1.0
X-Received: by 2002:a02:cd31:: with SMTP id h17mr407619jaq.94.1574937000680;
 Thu, 28 Nov 2019 02:30:00 -0800 (PST)
Date:   Thu, 28 Nov 2019 02:30:00 -0800
In-Reply-To: <0000000000003872fd0568da185f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007825cd05986598e6@google.com>
Subject: Re: KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
From:   syzbot <syzbot+554ccde221001ab5479a@syzkaller.appspotmail.com>
To:     alexey.kodanev@oracle.com, coreteam@netfilter.org,
        davem@davemloft.net, dccp@vger.kernel.org, dsahern@gmail.com,
        edumazet@google.com, fw@strlen.de, gerrit@erg.abdn.ac.uk,
        kadlec@blackhole.kfki.hu, keescook@chromium.org,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, soheil@google.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 3fa6f616a7a4d0bdf4d877d530456d8a5c3b109b
Author: David Ahern <dsahern@gmail.com>
Date:   Mon Aug 7 15:44:17 2017 +0000

     net: ipv4: add second dif to inet socket lookups

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141e882ae00000
start commit:   b5069438 Merge branch 'stable/for-linus-4.17' of git://git..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=161e882ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=121e882ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
dashboard link: https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1363ccb7800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1272e2b7800000

Reported-by: syzbot+554ccde221001ab5479a@syzkaller.appspotmail.com
Fixes: 3fa6f616a7a4 ("net: ipv4: add second dif to inet socket lookups")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
