Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE49C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19A120659
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfKUT6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:58:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:46400 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKUT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:58:01 -0500
Received: by mail-il1-f197.google.com with SMTP id i74so3905486ild.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kyzGaPalk+OtzhfGjgjsp1/zJC5fx+d1jrM2gzyAv18=;
        b=jvPF6z+KdvGUDFVAHRT4zJD/ZWoLm0DtiexhA9Ilg5kISfgJlLmOMIO1OLRsWCzWJK
         acNV55Wt29A3EhWueYpSTtpTspfPd2Bw/QiCFhV4PPqHRBzkgpOmFVzD7XQp/Gx5NO0I
         nQfjdbStq/a/ZfydG8yrUpupS2NgZkKy4tNJnjJSuOemwQHR+ifU52Phey1CJmvZje02
         dacgG/dI+cYsGunMg6EfA6yMyz05sakxvisFoyNSYuqIcVVX6sh/IR0QnEr10vbrMfHa
         nGsUkklc8/VQlNCUloT+AdKtoglAFrrvCImzEEPALJSaWi1xTTEIx9f4HWQS6Zxq09/Y
         n1cw==
X-Gm-Message-State: APjAAAXIyI13Z0quqoklB3BoaSq9a3TLTPFKMmmPkHUECinXVXeQoJ6k
        jh5fqW5O4qhMDnkCI6HD7SgyO7zq2o+G+OpLEyDXNA6wxVv9
X-Google-Smtp-Source: APXvYqzR/3sH9+ja80DnB3QgqV56ETLn3nZ9hdmsRzJEMAlxU1EkYOS6cQQlXeISKiEsafKa+XT4Cq33ry8YgrPFMK3XSs3EldbO
MIME-Version: 1.0
X-Received: by 2002:a5d:81cf:: with SMTP id t15mr9459731iol.288.1574366280984;
 Thu, 21 Nov 2019 11:58:00 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:58:00 -0800
In-Reply-To: <0000000000008f9c780581fd7417@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecb2cb0597e0b62e@google.com>
Subject: Re: INFO: task hung in __flush_work
From:   syzbot <syzbot+aa0b64a57e300a1c6bcc@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vakul.garg@nxp.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a42055e8d2c30d4decfc13ce943d09c7b9dad221
Author: Vakul Garg <vakul.garg@nxp.com>
Date:   Fri Sep 21 04:16:13 2018 +0000

     net/tls: Add support for async encryption of records for performance

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bf7ecae00000
start commit:   90cadbbf Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13bf7ecae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf7ecae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d41c8529d7e7362
dashboard link: https://syzkaller.appspot.com/bug?extid=aa0b64a57e300a1c6bcc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6629b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1222d29b400000

Reported-by: syzbot+aa0b64a57e300a1c6bcc@syzkaller.appspotmail.com
Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records  
for performance")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
