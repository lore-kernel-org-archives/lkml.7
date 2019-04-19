Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5AFC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51092204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfDSSj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:39:57 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48826 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfDSSj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:39:56 -0400
Received: by mail-io1-f72.google.com with SMTP id 186so5213222iox.15
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9GG250W1uR9v7CnVvHHW+E6SPNHnBXsTXZ6Fs+l+fvk=;
        b=Qemph3K3pj+CIT4VefetxcSBZ6OgoqExgOoCmjVJYUPxIuiT3L5hSpnAVpHd7rx8Mt
         xg3cz23u7BzMIsEoKOdCJ+d0/3jHgxUF6Xj9gmadQPgSAKbvZbodqDcWM0yJmnFmerJ1
         ozxzxGOzQMuFFwK97jeSJgww1rw0mPzumqR40PKSq7RvzcAEJRX4KAqUTCPwMbupZle4
         UY/m72vnVg2/hz8A7OkkdXyYzMTkip3dUwpJbyH9V6yG73BL8qrOKfeLx/vbm+yKwp2H
         c3Usbd0RXDf2qgdcmcG26ZeXZXErtggNFSzmZ4szlsYkytqu6AoVg2Vn8vw+xcAz1Vuu
         7tdw==
X-Gm-Message-State: APjAAAW0MnctJYjivGZqucABKNQwxN9kSQYTbVPRJL5BtZmUE5LAami1
        i9N9c1lcwY0NH5l0I+BTjEyiTyJvn2ybPr7dgy2Zila3ra+F
X-Google-Smtp-Source: APXvYqxwTd3P66I9Qzs2OGTstgOgAtAsleLVLGNtfyV0RBpMHZtRWiEwZYu8LU3gCmGGr0arownWf5uLyXPHiB7cQExfurd1jBmE
MIME-Version: 1.0
X-Received: by 2002:a05:660c:20e:: with SMTP id y14mr1812862itj.17.1555662060542;
 Fri, 19 Apr 2019 01:21:00 -0700 (PDT)
Date:   Fri, 19 Apr 2019 01:21:00 -0700
In-Reply-To: <0000000000004a6d7c057e77e97e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008265310586ddcc2a@google.com>
Subject: Re: KASAN: use-after-free Read in refcount_sub_and_test_checked (2)
From:   syzbot <syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com>
To:     -O-request@vger.kernel.org, acme@kernel.org, aisheng.dong@nxp.com,
        alexander.shishkin@linux.intel.com, andrew.hendry@gmail.com,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dvlasenk@redhat.com, fabio.estevam@nxp.com,
        gregkh@linuxfoundation.org, jolsa@redhat.com, kafai@fb.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, mingo@redhat.com, ms@dev.tdt.de,
        mturquette@baylibre.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sboyd@kernel.org,
        shawnguo@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit cd67d3272768aa3f44c0f7cc71b82a112dce01fa
Author: Aisheng Dong <aisheng.dong@nxp.com>
Date:   Thu Jan 24 13:22:49 2019 +0000

     clk: imx: scu: add fallback compatible string support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f0432d200000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13f0432d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f0432d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=b0775615fa4c4479b691
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15df396b200000

Reported-by: syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com
Fixes: cd67d3272768 ("clk: imx: scu: add fallback compatible string  
support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
