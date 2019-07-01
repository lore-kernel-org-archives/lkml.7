Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C23C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8307221721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfGAMOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:14:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51497 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfGAMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:14:01 -0400
Received: by mail-io1-f69.google.com with SMTP id c5so14829656iom.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 05:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NWf6zAXmXdVI9wmyrTa+FuCFWEZ41w0HLTqj15sQqqk=;
        b=YI2CAaD9+0J8406nhHBswUdeziefQTKZdI05bLHoLHDp1FPCe3CK7lr640cTGI+cFh
         TFnTfhxe8pgmN9vv64sNYpUuK8CFUp2/1SohQyreWSLo3wPcHQQli6Ux4y6SGoFmdZnS
         p0iPlbqeoTE+z02HoIIoWIeLl9GF6v1pufAnerzkeSndnutIoN0QZOOqmw4EdK0zZRDJ
         dlEEtGpRfteFHHQrv4VJg/PBq1IsP6DP2BTKXlQ79wE0zCbcM/KnhmcvO/bb8UTVCuxo
         B9U20nK5IF/jqanpD4gL/c/rnx/8r5z1/XILVsWNqC2SwFyxrBXTf7LUH21iVZyWy2Qo
         OgPA==
X-Gm-Message-State: APjAAAVbRpIs6SjzWlCahEh9KroVxikFCC++qeMc7P/eTQNedUyGsVzD
        WPsEDlH6LcQt0glNquZBNcX8GIigFviHN+qMattZ7UxWnYTD
X-Google-Smtp-Source: APXvYqymMtF4Sb3QSuurBcHYsH3E8Req+IEh12sC9+1vRDayQ+vOG5A9GROOa0/UnLqUgLp/5wtZGfRSO49p8UhKW1mNXVSK9KiL
MIME-Version: 1.0
X-Received: by 2002:a5d:8497:: with SMTP id t23mr25182314iom.298.1561983240729;
 Mon, 01 Jul 2019 05:14:00 -0700 (PDT)
Date:   Mon, 01 Jul 2019 05:14:00 -0700
In-Reply-To: <000000000000a5d3cb058c9a64f0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000357fba058c9d906d@google.com>
Subject: Re: kernel panic: corrupted stack end in dput
From:   syzbot <syzbot+d88a977731a9888db7ba@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f7f4d5a00000
start commit:   7b75e49d net: dsa: mv88e6xxx: wait after reset deactivation
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=140ff4d5a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=100ff4d5a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7c31a94f66cc0aa
dashboard link: https://syzkaller.appspot.com/bug?extid=d88a977731a9888db7ba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130f49bda00000

Reported-by: syzbot+d88a977731a9888db7ba@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
