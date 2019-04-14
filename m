Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAE1C10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 02:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EB22147A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 02:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfDNCzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 22:55:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:52916 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfDNCzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 22:55:01 -0400
Received: by mail-it1-f197.google.com with SMTP id 73so13200268itl.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 19:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EpmA7tOPMeXxvHBfABlmb8FTDps5VZ6P9Hzfo+3xEOc=;
        b=TjrtE9IqtzGH9xke6Ux0m0YQBWPpFPD70vQ7by01natnyG0Be0sPYQsvPEyDSxkndU
         nmvGsOrzvplxZcP6AlK947u7v95VubYcD6tj15V++ZR83IWN4tS1Rln3D6Ww9ywoCOv2
         o/ZJxJMb6qXnK4ihyJQR7ivzwSFO+gXoYgiXFvJDvN1v91SlLUOrmFrYMT94wgx3/c31
         tf60odDo5n42xf6nTRPRb6yDqzxu+hsX88/OP1cd0FJClp6+AtE3TRIBLpW3AjB/nz9F
         DdrTEH3ro0x8ZRs3aRVoEowBYXrKdgxX2GGke0ph+OLLLsvuB/XxTpFQTOsPFNgnhJrC
         ASnw==
X-Gm-Message-State: APjAAAUB0yhFKN1ipumTLgn6YCNqh2T/KeLWIj1WTusUHcZMIvIbyLJe
        P7WiIbQa3NFLmYWo5aI7sHtIG+aJqKWC8X3YGAlLxZadCX6x
X-Google-Smtp-Source: APXvYqzxNqYArsgazGGOVEkorCoGxLAaBWKxHsEiTFGk8Oo2mZx5TvxIT9Dm+TrXC2QKEJLPhy/K+Offgzn9+L2tgZqNzDaG9X15
MIME-Version: 1.0
X-Received: by 2002:a24:6f81:: with SMTP id x123mr4742934itb.29.1555210500891;
 Sat, 13 Apr 2019 19:55:00 -0700 (PDT)
Date:   Sat, 13 Apr 2019 19:55:00 -0700
In-Reply-To: <000000000000e02bf505866414ae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074e9d5058674a94f@google.com>
Subject: Re: INFO: task hung in do_exit
From:   syzbot <syzbot+9880e421ec82313d6527@syzkaller.appspotmail.com>
To:     amitoj1606@gmail.com, ap420073@gmail.com, avagin@gmail.com,
        dbueso@suse.de, ebiederm@xmission.com, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-mm@kvack.org, oleg@redhat.com, pavel@ucw.cz,
        prsood@codeaurora.org, rpurdie@rpsys.net,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 430e48ecf31f4f897047f22e02abdfa75730cad8
Author: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date:   Thu Aug 10 16:28:09 2017 +0000

     leds: lm3533: constify attribute_group structure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f4cee3200000
start commit:   8ee15f32 Merge tag 'dma-mapping-5.1-1' of git://git.infrad..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f4cee3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f4cee3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=9880e421ec82313d6527
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b89af200000

Reported-by: syzbot+9880e421ec82313d6527@syzkaller.appspotmail.com
Fixes: 430e48ecf31f ("leds: lm3533: constify attribute_group structure")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
