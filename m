Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677FEC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3940621D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfLQUQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:16:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:52187 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfLQUQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:16:02 -0500
Received: by mail-il1-f198.google.com with SMTP id x2so10282248ilk.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Zl7jDCng4WsJS3fDlSVM0kBHR2q0XfgZ7N4MzVpx9q0=;
        b=eRcAL8Ckt/pAnIQ1zKHxGTqVVT7Co61yvJKESUdE/ofz8t9eb4g8KISACAW4OL/Fza
         HmnNNNXincG6iruDPCc9UvpC3OHVgaKMb17RgQ93XGaoyfsz7PpOf3zDoTHJlr4lttNi
         wJ+jUOnAcNFZ4b+I7O86ZG4hUfEV+LSw7F813GV6bFDoZC+9DsUP+x2HZz3XnXQv7Nx6
         z0BWZkNRgYeNBX9988gZ9wnSdKKk31U4Y9M4O0Mu84Hrl9LZSH9YFJd0AV4MuVC5WTQK
         LbeOAwi5S0ki1np1UDzvgw87rLzgtvyurqA3LgXQ6WnUqey6yoBGTe9jHEfd1BAGU8g+
         QWbQ==
X-Gm-Message-State: APjAAAW4hz85lxa8hk5RdjyvoRYJ+GIPTUtF2I83+u4Hu5yq5oDQ9dAs
        sshppg/mC3oUcH7E33VAq9WsHh6xgOGRCle1hJFKbxypjk4Y
X-Google-Smtp-Source: APXvYqzICrG8Yo/ALydErrhDqX93YfSSAQ85FdUg4jalGroBJiT3BB12c6HUe2ZyNSlzlRnSA4l2+EVqSg+tk5rH2iwmoObAicm0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:25cb:: with SMTP id d11mr3095867iop.263.1576613761732;
 Tue, 17 Dec 2019 12:16:01 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:16:01 -0800
In-Reply-To: <000000000000a6f2030598bbe38c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037571c0599ebff87@google.com>
Subject: Re: WARNING in wp_page_copy
From:   syzbot <syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bjorn.topel@intel.com,
        bpf@vger.kernel.org, catalin.marinas@arm.com, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, jonathan.lemon@gmail.com,
        justin.he@arm.com, kafai@fb.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        magnus.karlsson@gmail.com, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 83d116c53058d505ddef051e90ab27f57015b025
Author: Jia He <justin.he@arm.com>
Date:   Fri Oct 11 14:09:39 2019 +0000

     mm: fix double page fault on arm64 if PTE_AF is cleared

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1378f5b6e00000
start commit:   e31736d9 Merge tag 'nios2-v5.5-rc2' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10f8f5b6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1778f5b6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=9301f2f33873407d5b33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fd9fb1e00000

Reported-by: syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com
Fixes: 83d116c53058 ("mm: fix double page fault on arm64 if PTE_AF is  
cleared")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
