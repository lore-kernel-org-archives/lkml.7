Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E86C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7866B2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfFZKEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:04:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38733 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:04:01 -0400
Received: by mail-io1-f70.google.com with SMTP id h4so1999880iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=exl153K25/taUt9Rsw73TloMA0hiX8bAhHaTEHW6ZTA=;
        b=Z023OaM6qTj9hGNDWsKomaz2Lu2K33XjnF86kQTBhbncqeqg/OtPWNP+bwoKMgIqie
         DATXR9HGWRaFrWypSR5PCxKbF3nrhJeZ7eS/Le8YyaJUFBw5UH/meMHMYSBiJcf8PGr/
         PUDlJqpdADQeTLCDYm9AkZf6TEriB/jrRYCCNwujwXx1hvkXeP9cWGkjQJakwcRL2bBO
         gCUA3pg0nxxA9NN2xXhqxqWNDEjhMrKo2fZ1evBH+vsjoWz2soXAokiEwaEcQPQF48Wk
         6ibWWFOwHMhWgP9i3YUoOo3fQxBsfA/J/MOh10ag7Z/LmYZGhYDfafG24vDCMU0/FD/Q
         sNJg==
X-Gm-Message-State: APjAAAUl5djOHO5YwEH3HqWWC3HQidCt5XozUY69al0dsW8zNPpb60Kl
        whwtz4ltB5gZDK2keKhZLb/yW39j041RdYBaL6A7Eb23dIUT
X-Google-Smtp-Source: APXvYqwjUE5ldaZ0lVaY4C4RiUyQfnHzMpnYbDfKVDsrYcE6TyIzmVuSJ2rh9klHqtLrh4mmTHyypSXUrkxrJ2dOclLlmSpALX3c
MIME-Version: 1.0
X-Received: by 2002:a6b:bf01:: with SMTP id p1mr3795081iof.181.1561543441017;
 Wed, 26 Jun 2019 03:04:01 -0700 (PDT)
Date:   Wed, 26 Jun 2019 03:04:01 -0700
In-Reply-To: <0000000000000c4e3e058bd5008d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a739d058c372a77@google.com>
Subject: Re: KASAN: use-after-free Write in validate_chain
From:   syzbot <syzbot+55c548ad445cef6063ab@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1555b795a00000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1755b795a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1355b795a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=55c548ad445cef6063ab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128ce13aa00000

Reported-by: syzbot+55c548ad445cef6063ab@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
