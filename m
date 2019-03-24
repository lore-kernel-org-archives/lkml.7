Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC71C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E80020880
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfCXCQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 22:16:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:41948 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCXCQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 22:16:02 -0400
Received: by mail-it1-f198.google.com with SMTP id q184so5640027itd.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 19:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NI+3zaFLSRZs9sBqyW51t7XrhlVl051kFI8gGqFgfC4=;
        b=NvZftw6wbHXiAM+TPG0abtLLUC6aUGdSpos7jeQ0XzWVW63pC2zHWw7KEtlllS+wB/
         DTI+qfJCRwqU+7NaJl6rsyoEOssF9TPpHKYrYlurYaqr5Cx5GWuEGAc2CLekcCQOQpnT
         Mt+2k+456CVLNUw8R5Nf3thAFN1th3k/7L+aM8yZyN4BRHPr/tZDgM9yiTX1y4ezykNK
         GOw4zJAsEM3TkZGyNS5GbDHYEk4k7yAWstak2Fn7qdr8/jHQGUeT74E2aXR6mE2+BDgW
         HgF07dRNDmchEdvipr5LZe1RcK1OxvqiWjeQWUtAOxTvDR7Fv6AiAsDczIg1dd3vc2OE
         /K8g==
X-Gm-Message-State: APjAAAXWiD8wf+Ho5DLCnJAdwOV1mGTe/vvIPbUGmP3S/s7GaXj2R5sl
        2LmYt14MgSR48bL5s2DAstm6Xu2rjjBT5Pkuwg/7e9TDNehg
X-Google-Smtp-Source: APXvYqxxXK2a/2UR63qUugijt4ITVELrcK3BEwxf6njq23CTbYEHfjuipl4JeHglzvWSwnv9m0xyJA94niQ5nsBxxZZzhFOy05bZ
MIME-Version: 1.0
X-Received: by 2002:a5d:899a:: with SMTP id m26mr13114627iol.268.1553393761219;
 Sat, 23 Mar 2019 19:16:01 -0700 (PDT)
Date:   Sat, 23 Mar 2019 19:16:01 -0700
In-Reply-To: <000000000000f302fc057ea3b499@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000557b4c0584cdabed@google.com>
Subject: Re: WARNING in bpf_prog_kallsyms_add
From:   syzbot <syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        idosch@mellanox.com, jiri@mellanox.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7607dd35fc34893214284cca740d015154d20452
Author: Ido Schimmel <idosch@mellanox.com>
Date:   Mon Jul 17 12:15:30 2017 +0000

     mlxsw: spectrum: Trap IPv4 packets with Router Alert option

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e0ac07200000
start commit:   645ff1e8 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16e0ac07200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e0ac07200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20271e14bc1c87f0
dashboard link: https://syzkaller.appspot.com/bug?extid=987e48d84abddbe2506d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c69d20c00000

Reported-by: syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com
Fixes: 7607dd35fc34 ("mlxsw: spectrum: Trap IPv4 packets with Router Alert  
option")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
