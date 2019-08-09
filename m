Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775E7C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5360B2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437383AbfHISJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:09:02 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:44617 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437234AbfHISJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:09:02 -0400
Received: by mail-ot1-f72.google.com with SMTP id q16so70430827otn.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=V25+XUIaKi6XUm0H56UptnIU5DSM67dQfXdundGFO4c=;
        b=kIt8jpjH4+9x4XNADpGlUt6ULUMYZeWaDmjJ0OFUpLLniK4DM0cUtgNfLJsSfxA77I
         mSghvneifR2LDbrmSdflE/R/04rOPxDyZV4uv9hYddMm8e/9Dtpja1gDBrbNhtw4XHEb
         F4vR++DJLXnpy3f23q35jYK6dxWA19mlOJ2IneCETV9mFdPeno05phx75b2tfgV7KmzM
         UFgRvy01FpRkVZyjajjZ7X34dLsylFDuPo7BbVMV1kwtRNb5awqL5qAKmntTSMWpZrR4
         0HOYLWw9K5c8efwskE6hyTa5D5YvTxBtGL1eS0kgl/Wb+cHr3CzCXEEqD8jPpQjZdgVf
         1Fdw==
X-Gm-Message-State: APjAAAX06YS32MODGkSjMeiVMyedcLBz1tpfZpbHzn0sNszChZv772aP
        tQAhw2za93l7aG9hhcEIB9xWhAE89ksXo6NxmO+wF1OGoCiw
X-Google-Smtp-Source: APXvYqxIodrbP/4N+EQhfOL74zP7r1vRk2mIoqLfGEyOIGZ+MQRSRuTeM4nmX6vaBwiaKnSNp8mU1E6XaJuPIgpRx/CcNuiRkERU
MIME-Version: 1.0
X-Received: by 2002:a5d:80c3:: with SMTP id h3mr23172856ior.167.1565374140994;
 Fri, 09 Aug 2019 11:09:00 -0700 (PDT)
Date:   Fri, 09 Aug 2019 11:09:00 -0700
In-Reply-To: <0000000000008cf14e058fad0c41@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d5bbf058fb3116b@google.com>
Subject: Re: KASAN: null-ptr-deref Write in rxrpc_unuse_local
From:   syzbot <syzbot+20dee719a2e090427b5f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 5c2833938bf50d502586e16b9dad1e3cf88fda6f
Author: David Howells <dhowells@redhat.com>
Date:   Wed Jul 31 15:26:05 2019 +0000

     rxrpc: Fix local endpoint refcounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1519a11c600000
start commit:   87b983f5 Add linux-next specific files for 20190809
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1719a11c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1319a11c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28eea330e11df0eb
dashboard link: https://syzkaller.appspot.com/bug?extid=20dee719a2e090427b5f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ceae36600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ebc40e600000

Reported-by: syzbot+20dee719a2e090427b5f@syzkaller.appspotmail.com
Fixes: 5c2833938bf5 ("rxrpc: Fix local endpoint refcounting")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
