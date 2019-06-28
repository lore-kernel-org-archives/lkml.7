Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56292133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfF1NFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:05:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44145 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1NFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:05:01 -0400
Received: by mail-io1-f72.google.com with SMTP id i133so6564200ioa.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YCxs/qt8Mwv3z7mR64kHU2i7RhK2QfF8Lu/zZDPEtsk=;
        b=EeZZkIhvQV1RW7VyEo0tBuNWxGeI9Fp7aqsh22yw1TrumN/RpTGq+RTQJJpX7OANBa
         x2SjxUKz2yCSCHfV+cz2ByijGl7+oM5vzgkCCO8BFEytR0tYF/QzaTAn3rVeotQ1l9JX
         IRP0Zf1WZZtQg/X7jEfQoPHNmxo7nGVwbQSjpMBYlKWDpudwYLdw646dgoMU6/578cr/
         +L1W1WwTroe5oxt/zZa6yZGRa1cXfwfHCBcmWBa8IJ3b9+vE8OPgGt0XWL+z2a40+cdY
         KOhToL+ak/vdiF69WTu5SKDuHpPqYUPqpN5B0JIq4Vaub9Yp7ID4bIoFKkLpcQdjTET8
         ghmA==
X-Gm-Message-State: APjAAAVfr0DZJ+mmVYb5imnRvkclpQzT5I5+xsDzbq6BzlzmNgw/KxLv
        16i9R0Ords3QN1eJv0A5yPgEC+CLYjCA2XYbctzv4WAXSC0z
X-Google-Smtp-Source: APXvYqx8GKh0Tz0N6JPHNRL9IOslCQEy3zMhF+Ww6SA10ngn8dacBYWiHU7ErPZ6cdknibLtC5lh5DRaS2I+orgfp5ZsyEQIgEVu
MIME-Version: 1.0
X-Received: by 2002:a6b:8d92:: with SMTP id p140mr10485891iod.144.1561727100535;
 Fri, 28 Jun 2019 06:05:00 -0700 (PDT)
Date:   Fri, 28 Jun 2019 06:05:00 -0700
In-Reply-To: <00000000000000ac4f058bd50039@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000104b00058c61eda4@google.com>
Subject: Re: WARNING in is_bpf_text_address
From:   syzbot <syzbot+bd3bba6ff3fcea7a6ec6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ast@kernel.org, bpf@vger.kernel.org,
        bvanassche@acm.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@kernel.org,
        netdev@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        xdp-newbies@vger.kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a0b0fd53e1e67639b303b15939b9c653dbe7a8c4
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Thu Feb 14 23:00:46 2019 +0000

     locking/lockdep: Free lock classes that are no longer in use

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152f6a9da00000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=172f6a9da00000
console output: https://syzkaller.appspot.com/x/log.txt?x=132f6a9da00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=bd3bba6ff3fcea7a6ec6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ae828aa00000

Reported-by: syzbot+bd3bba6ff3fcea7a6ec6@syzkaller.appspotmail.com
Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer  
in use")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
