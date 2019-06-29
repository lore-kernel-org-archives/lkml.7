Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D083C5B57A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37208214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfF2CKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 22:10:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45898 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfF2CKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 22:10:01 -0400
Received: by mail-io1-f72.google.com with SMTP id b197so8617048iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 19:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=84uQch8ytJ1lCabOHF26kS1aihVf0OWc3QTgyNOP9t0=;
        b=YGdetNMfnC6zU1MlihXpzgGHqS9Tb58UEyLjLuQnTRyx19eqdqIx75ofE4kPferhTG
         Tc2zlesfPOiylbicjYK0tywl3yptLUscL4SOS3ZuNO1//ewbz6NCAGH8/l5P+iLouaOQ
         A1tmc/+JmdKizMwLe5syvYDprf0WO0zUrn1ut/0rjcG6MEXFo5A7Knux010yCHPRDfmb
         d5kyZ5aTCSN2WWsnmwPlYLfpsecHEs4QCNdkWt7btfMxKeD/94qwMACgv93XosBea4Z5
         MauBvtBCbdxeIftu/Kf9dJDOOLxqjDjkUMsQCgi5OM+SEwp6o6lxWQAGhcnQp5/oP+cf
         SYgg==
X-Gm-Message-State: APjAAAUgn77mQaxZ/ePPDsGkYkg3vZGui9K6B5DooFAvmElK0o41sTUi
        LyesiqR0T0OwA3pCljzGOibX3yzU1zr8wb39UDHz+jHeDJ8K
X-Google-Smtp-Source: APXvYqwIj/ChdaSSPt20gSuvnjyqICrd1EGtQL3DgiudeFG0KMFP8BQKEBHpsTMm2Iudrae9YgBrLN5/PZRaKtNbeTFEr1JIeBQt
MIME-Version: 1.0
X-Received: by 2002:a5d:94d7:: with SMTP id y23mr12337354ior.296.1561774200691;
 Fri, 28 Jun 2019 19:10:00 -0700 (PDT)
Date:   Fri, 28 Jun 2019 19:10:00 -0700
In-Reply-To: <00000000000017c9e2058baf4825@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073a232058c6ce410@google.com>
Subject: Re: BUG: unable to handle kernel paging request in __do_softirq
From:   syzbot <syzbot+0b224895cb9454584de1@syzkaller.appspotmail.com>
To:     ast@kernel.org, bp@alien8.de, bpf@vger.kernel.org,
        daniel@iogearbox.net, dvyukov@google.com, hpa@zytor.com,
        jacob.jun.pan@linux.intel.com, john.fastabend@gmail.com,
        konrad.wilk@oracle.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, puwen@hygon.cn, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16aac819a00000
start commit:   29f785ff Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15aac819a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11aac819a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=0b224895cb9454584de1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1076d132a00000

Reported-by: syzbot+0b224895cb9454584de1@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
