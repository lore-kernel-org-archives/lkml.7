Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFECC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A582187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbfKGNmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:25 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53920 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389182AbfKGNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-il1-f198.google.com with SMTP id y17so2621348ila.20
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=S2wRVclg8UQWRvym++3WP5HdS90cEd2sAd4gL9TrV+I=;
        b=Uw91gdJGCQY5fB5Nh/h9LLFcAjXAJYGL4vBd0CvebNkXcCSCCIsrhWaDtPQRBAKNPR
         3BqD3XM4Wl4gHkhPSOwkS7zi6HprzL/OC/zF3tWcf0wW1or3bqimll5hz1zqUWY0q31P
         mxsvIzc0CIli7lxM5Rjx85dGKwhwncwjzeduVezy6peL3B5TsGQsy3Tf+3qFmevXYhux
         R7VrHrrTmSis2mDjX9sCplpbeea87GRsmqF083783Os1ktrfmu09J7ZdLVo3IfvHH+KU
         WVJK7Xc18zbI61RNmU5k1YZZg7DYeT33T+CBbf2Q63OHHbfKMmsLUbT2RP9dTVaqx0AZ
         Idsg==
X-Gm-Message-State: APjAAAUBJ8TAURSUapijFPzQQg8ZgEjDIKTVcxND2KnGiWt/75d+8Yyc
        zkYkJ20pTXIeiOx10N3g0pP4M0M9KTlCVJ3cleo2RDxuLUJs
X-Google-Smtp-Source: APXvYqz9Q2PgD7h70IK2LJz5tS3XrxOEo+uTlIzI6FagviYlipCps0BesCYv8Ev2NfBqsoEX1aftYzudEyLJMvtAP/9TWFBjR5Lx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:394:: with SMTP id y20mr4277492jap.0.1573134129274;
 Thu, 07 Nov 2019 05:42:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:09 -0800
In-Reply-To: <0000000000008c6be40570d8a9d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5a6620596c1d43e@google.com>
Subject: Re: general protection fault in propagate_entity_cfs_rq
From:   syzbot <syzbot+2e37f794f31be5667a88@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andy.shevchenko@gmail.com,
        davem@davemloft.net, douly.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, info@metux.net,
        jbenc@redhat.com, jgross@suse.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, ville.syrjala@linux.intel.com,
        willemb@google.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit bab2c80e5a6c855657482eac9e97f5f3eedb509a
Author: Willem de Bruijn <willemb@google.com>
Date:   Wed Jul 11 16:00:44 2018 +0000

     nsh: set mac len based on inner packet

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170cc89c600000
start commit:   6fd06660 Merge branch 'bpf-arm-jit-improvements'
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=2e37f794f31be5667a88
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014db94400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f81e78400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: nsh: set mac len based on inner packet

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
