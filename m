Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0AFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C5B20879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbfEXRpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:45:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46443 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfEXRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:45:00 -0400
Received: by mail-io1-f70.google.com with SMTP id s83so3098089iod.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c2mQ7jAjg1TkTNQW+Q7cBX89VBXvYUUqtTETBXNcAmo=;
        b=DN3DwWHeb+5loymoIDvsgqsJVG1073vGSw+SJVjc+BZUeJptROi2Y/uuq8jqV/JP2D
         XgGrGuQSd5O2hSG8d3dmNC2eQD7gIUp+uXrhfx6hZBccfuXzsoxzqUL5GJndmpw8CnjF
         GFw6EDBaSy6CCzP/jBtbzm4GlF9FGeh/b2enTUvUFX0bN/wNiRjKJjH4oUW9Z//v2Uv1
         cNJ3LFI6dnc+wr2WBG9iWV0li3jMn1Ymq8m3zD/Q1PKWuk53TM2bCJRK+pqczl2cHNAd
         JV+japLfo84f7+3u1taW46lZbotAXUAyJkePNrEO/toeSFXwNVjW+REcKR5ItnXEGoSI
         Gs3w==
X-Gm-Message-State: APjAAAXav87dxq2ilXsHWTZH2sgTCpRo8A/s9BmKlsG8TBedu1ju/IFe
        8dC9Igiktl7gJzG4rWsTOfM+iVY1YMm5E+X7HG5flSqyO9hT
X-Google-Smtp-Source: APXvYqwTesnYfoO4m7EBs45C7CQ2/IhrVDP8iqnoEDeVN0X6LAEhL6WyQvLKWv+zmXmPZg7B2WTv4c2OMokRUbMI/0k8Ou03o2Fm
MIME-Version: 1.0
X-Received: by 2002:a5e:c241:: with SMTP id w1mr4606151iop.237.1558719900226;
 Fri, 24 May 2019 10:45:00 -0700 (PDT)
Date:   Fri, 24 May 2019 10:45:00 -0700
In-Reply-To: <000000000000a99a470589247007@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f520bb0589a5c19b@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in rhashtable_walk_enter
From:   syzbot <syzbot+21ad49ad4c11cbfba8d7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hujunwei4@huawei.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, wangxiaogang3@huawei.com,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7e27e8d6130c5e88fac9ddec4249f7f2337fe7f8
Author: Junwei Hu <hujunwei4@huawei.com>
Date:   Thu May 16 02:51:15 2019 +0000

     tipc: switch order of device registration to fix a crash

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10dbe682a00000
start commit:   510e2ced ipv6: fix src addr routing with the exception table
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12dbe682a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14dbe682a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82f0809e8f0a8c87
dashboard link: https://syzkaller.appspot.com/bug?extid=21ad49ad4c11cbfba8d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1648fdb2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16437cf8a00000

Reported-by: syzbot+21ad49ad4c11cbfba8d7@syzkaller.appspotmail.com
Fixes: 7e27e8d6130c ("tipc: switch order of device registration to fix a  
crash")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
