Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2CC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416820C01
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfIURlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:41:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44139 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbfIURlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:41:02 -0400
Received: by mail-io1-f72.google.com with SMTP id m3so16167710ion.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 10:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Vou0Mi/j/M2Ma5Ajew5/N8RpeWCXouricDj+EREdNZY=;
        b=eIkPx7bYzpsyK7uBLDA9ap/5h1c6dWVxT8OEHJZ9t4uSiFJEks7M/8qvQcR+PBpBk1
         gUqnBeNKF1SOP/wXJjHbTBdIVPXdIGLlkY2/8cJxyhIMl4QYq1T4A04aGkD8NPAMSA+v
         Mf4TnEDsmFVm1oLryxMj+GcbenmJ6P9uGC31IHR4Uy8foDU94m6w/A+TK/NxnSD0999r
         QksNKaDBY/KrFLSsKtwmp49onSYPuiOI5Ac/uxPgs/FB0jPKtn/2D/82mmkHuTLEb+C+
         qEUEeU+BRBFsxbHYhMxb1eyM0xXvT2q4H/dFFZiCxIrAAhDv1tvKw0Znp1VT5o5E8Nxw
         75hw==
X-Gm-Message-State: APjAAAVeevaHDo5abfu6YBLGHfjqe/IG5lH1jW7/q2Q9/+zql2Bi1PEm
        AV/RuNwXjeXq16HWmhGO2vw0AouM+SIEDL55xoMMxK0Tz145
X-Google-Smtp-Source: APXvYqyr/QnaH7gCOgIYf0MJcv1TUeTtRpr75v8rwd0Su2cX1DH7UXwxXu2hOzyHWLdGdlgaclDhr2teY+qtZB+BASzqQhvSpW0K
MIME-Version: 1.0
X-Received: by 2002:a6b:ec07:: with SMTP id c7mr4441481ioh.84.1569087661223;
 Sat, 21 Sep 2019 10:41:01 -0700 (PDT)
Date:   Sat, 21 Sep 2019 10:41:01 -0700
In-Reply-To: <000000000000727bd10590c9cf6c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab325a059313b071@google.com>
Subject: Re: KASAN: use-after-free Read in rxrpc_release_call
From:   syzbot <syzbot+eed305768ece6682bb7f@syzkaller.appspotmail.com>
To:     MAILER_DAEMON@email.uscc.net, davem@davemloft.net,
        dhowells@redhat.com, hdanton@sina.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2baec2c3f854d1f79c7bb28386484e144e864a14
Author: David Howells <dhowells@redhat.com>
Date:   Wed May 24 16:02:32 2017 +0000

     rxrpc: Support network namespacing

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16240b09600000
start commit:   f97c81dc Merge tag 'armsoc-late' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15240b09600000
console output: https://syzkaller.appspot.com/x/log.txt?x=11240b09600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61f948934213449f
dashboard link: https://syzkaller.appspot.com/bug?extid=eed305768ece6682bb7f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cf8ea1600000

Reported-by: syzbot+eed305768ece6682bb7f@syzkaller.appspotmail.com
Fixes: 2baec2c3f854 ("rxrpc: Support network namespacing")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
