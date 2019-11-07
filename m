Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EC821D7F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbfKGNmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35361 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389127AbfKGNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:09 -0500
Received: by mail-il1-f199.google.com with SMTP id w69so2679254ilk.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lYXHu1+8CxUYZrtgD2bXy/E8sjSme0LaouR97ajask0=;
        b=e5BP4eiqYKa3CGOSMqsboUuV+X2542/7zLl06wKYdr8ezvCRb6pYaNvlyfvH8r0Icm
         rS9rC0fIy7FGDWAPuYODWX9VNzz83r5RXQsqyZq655toNAqcMJF+kI5cjqdw/dfMAK0a
         XbPI0c3a2g8Q66ObWFKtMZxOwaoUe5gx+xdRJkb8vPmtyFo+odRI/oMndrBZTK03Gkgs
         nF2kob3+RMbk1SKRlqUo012els+pdJAJtGAYGp0gVHYchh/dyXvnmQ0f29IOrpdURHft
         3G1DfdDbrdDkqQSytEWOffHSzK3ppecKusw5/cY5MViG/hXdtYM7RLs/oqLET0AcVNu8
         WJAA==
X-Gm-Message-State: APjAAAVYY2sib/MH1pa4twmvuha5WOaecHzI8bT6i73yQQu6OJN9qoxU
        VdrKCLihZId/zW21VlGXqOhDVAh0wQErhl7XUXywl5Juk0/4
X-Google-Smtp-Source: APXvYqyCn5PnsReBzzn0eMeMMCw+qkOz5YAQ4Lrcbdu5KR2Dy7fnX7Bn1RK2uLQWMUldMvI5RwDNhljITPEXD6xZrL9jqRFluc7a
MIME-Version: 1.0
X-Received: by 2002:a5d:9756:: with SMTP id c22mr3662214ioo.233.1573134128190;
 Thu, 07 Nov 2019 05:42:08 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:08 -0800
In-Reply-To: <000000000000f68d660570dcddd8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e51d450596c1d472@google.com>
Subject: Re: kernel BUG at net/ipv4/ip_output.c:LINE!
From:   syzbot <syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, johannes.berg@intel.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, posk@google.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        willemb@google.com, yhs@fb.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488
Author: Willem de Bruijn <willemb@google.com>
Date:   Wed Jan 16 01:19:22 2019 +0000

     bpf: in __bpf_redirect_no_mac pull mac only if present

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14175486600000
start commit:   112cbae2 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=90d5ec0c05e708f3b66d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ed6e2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1539038c400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
