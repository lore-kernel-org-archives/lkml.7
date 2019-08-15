Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF0C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18812083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfHOSGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:06:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55672 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbfHOSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:06:01 -0400
Received: by mail-io1-f71.google.com with SMTP id s22so423836iot.22
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 11:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6O8fj8Cxesz95GcJ9dIMRrMkW2S+HMSqZq3eO7hi+58=;
        b=GePur01PuJ9YCVfotxEea2yhjn4u2QsV/x9GLS7wwJu8MOUCq7x2AaBnu9fS9Cj1zy
         3nKyU0M1VnjJttDSrcg/rVvhRkA4UG42a9DC0v50UhrIAe5SASErUpfzeeutqyuD2Cnd
         unlCkRJck6PaqUb9oN8tUzR3NCQbmm7KN92zJCYjPE/GL/+yH/o2TSaNM7xpj1HbSr8p
         J6AEuWssWUmJE21xX2+O0N/H4DLxZOVQ7Sw7TBZp+H9DXKt9JUQT/naVMYtvmOATf86g
         PDegZcvGz3P0zCr/ZIJ5vOCyqv7Rl4jQnvncnYOOj+0KhQp0j0JNyq/TbZ3gp/pSUkgC
         r92Q==
X-Gm-Message-State: APjAAAUKwsV6tZtT/xtdqLk4k3wpTHK5ilCmJTAD3bF97Wwtn2miACqb
        epg4KahbJSiiONOAE9FJMyMcous8pvVbDbpsfSJqr3igryvO
X-Google-Smtp-Source: APXvYqy5AXhfLngIaYgaBxvvQokDgu6mxb5nb/n1uzcS934nnva7+99gALTUcVp1YZPMTW8pM5S3MBUS6LmViOkPPydAWfs2qe0V
MIME-Version: 1.0
X-Received: by 2002:a5e:8209:: with SMTP id l9mr3454621iom.303.1565892360493;
 Thu, 15 Aug 2019 11:06:00 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:06:00 -0700
In-Reply-To: <000000000000523ea3059025b11d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e75f1805902bb919@google.com>
Subject: Re: INFO: task hung in tls_sw_release_resources_tx
From:   syzbot <syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, hdanton@sina.com,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 130b392c6cd6b2aed1b7eb32253d4920babb4891
Author: Dave Watson <davejwatson@fb.com>
Date:   Wed Jan 30 21:58:31 2019 +0000

     net: tls: Add tls 1.3 support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118e8dee600000
start commit:   6d5afe20 sctp: fix memleak in sctp_send_reset_streams
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=138e8dee600000
console output: https://syzkaller.appspot.com/x/log.txt?x=158e8dee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=6a9ff159672dfbb41c95
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cb0502600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5dc22600000

Reported-by: syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com
Fixes: 130b392c6cd6 ("net: tls: Add tls 1.3 support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
