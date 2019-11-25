Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B58C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A0820679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfKYP7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:59:04 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44323 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfKYP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:59:03 -0500
Received: by mail-il1-f199.google.com with SMTP id b12so13966977iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yUeyiVmdRHn8X3vVnYT/vxc1eNRVQp5M/ypw1pAPYls=;
        b=sLRg0nYV+3tnMrkDFy5i3W85fZcX1iq1gzPj5Op2jo+dNAtlwclkD8lAWvILN3jx3O
         RkqGHLbXkJ5ZCgfQ/O4+54IRT+QJfWiw758a/ajlMaxtqO0tJNdrMlPM796kNy8Pk5ER
         oeI+EAsZRDiY9rEC4wERDbhbns0VO2SlFf/S6FhBm+uqxLQj/eRPrsJH66AnhvYaDGZK
         7DMmW/4j7lQZpWPBBBGQqpDXbiHtKm5x1UpfPVg9T4gpTtmNnJ2/nXIcPKaCHFYfI0++
         ORg7fo/N7cPxorAY6OSIaWK4JNaF1UbVf9dxebbkKN9hjHSgN8Hk0cmQOkOqh4xiWyjg
         cW4A==
X-Gm-Message-State: APjAAAWElvqKo3pDhU/CodX3VI+PBb0jh0UKMEo9jCvOJTwLOvAEo1Fs
        vawwJeX1pXTSf20vPVDhnkcyDXeeWhSTbrDL3nfY1OZnsAQR
X-Google-Smtp-Source: APXvYqynVxr815BoQYCNcPSokDuYaA68dhLy+qgKHBbYcNAk9X2Ea0HhaZtIBiKAZNrG636O8LHiBoEC1+w40u56oce5fDI8pN/j
MIME-Version: 1.0
X-Received: by 2002:a92:831d:: with SMTP id f29mr34892240ild.263.1574697541284;
 Mon, 25 Nov 2019 07:59:01 -0800 (PST)
Date:   Mon, 25 Nov 2019 07:59:01 -0800
In-Reply-To: <000000000000013b0d056e997fec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093bc3b05982dd771@google.com>
Subject: Re: WARNING in sk_stream_kill_queues (3)
From:   syzbot <syzbot+13e1ee9caeab5a9abc62@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        ilyal@mellanox.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 3c4d7559159bfe1e3b94df3a657b2cda3a34e218
Author: Dave Watson <davejwatson@fb.com>
Date:   Wed Jun 14 18:37:39 2017 +0000

     tls: kernel TLS support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127a8f22e00000
start commit:   be779f03 Merge tag 'kbuild-v4.18-2' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=117a8f22e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=167a8f22e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=855fb54e1e019da2
dashboard link: https://syzkaller.appspot.com/bug?extid=13e1ee9caeab5a9abc62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165a0c1f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114591af800000

Reported-by: syzbot+13e1ee9caeab5a9abc62@syzkaller.appspotmail.com
Fixes: 3c4d7559159b ("tls: kernel TLS support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
