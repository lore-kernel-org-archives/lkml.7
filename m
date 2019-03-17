Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB94C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70A22085A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCQKnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:43:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46183 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfCQKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 06:43:01 -0400
Received: by mail-io1-f70.google.com with SMTP id k5so11224987ioh.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QSzsPUt8vxZ35tdHZ1qW8SYxaq0LFUJlh8G5w5k1f74=;
        b=K04MLZUvQXlhQlrGOBBULRY6I/wASuVGFwfVL4z/eF3N3KPHUA3mZO0+ktwjPOd682
         Ciqh7E3MFuxO3FN9lSc0gikCzU6qy3JyvmvcueI2ir+ujGprzQ5ZDJ4uGTxOfrvYg6yW
         6LrwE+oUFdHb1FaEeg6/Zf5UsWuZgMqhmADIN/4qP0qZpVgBXjUTXxPlAIvWX/9Btk/a
         S/ULkvl6MJhaAyql6UBjTd9ZwDW6CBW+0rnSznPGFbq0D4naV44vlF+yV1BF4v+ASkv5
         gjHFT+6RIafGMNzko7zSsSn6iohJKN0dhxg0QHmwWn+K1yM07dYGsGTOeeNdHgGnJ/kZ
         uBmA==
X-Gm-Message-State: APjAAAUvCgogh9csBwWzvi/Gv54Pnkv0UDjmKxNq41EFBR43C81FIJrH
        k/THHRiDdYA1HY1EL7VPDwJCngTToLCaArPm+4uSGGxGycfb
X-Google-Smtp-Source: APXvYqwmFgNETKk0NZNGIFDQO6tfxXsdbGSANkbo1eM0unEk2mcATYVGrz/aP6blrqkfeHH/+t9TXK5IGYK99fcL0GbKb+NEdQwr
MIME-Version: 1.0
X-Received: by 2002:a24:6b55:: with SMTP id v82mr7150302itc.37.1552819381045;
 Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:43:01 -0700
In-Reply-To: <0000000000007da94e05827ea99a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b8d8a058447efc5@google.com>
Subject: Re: WARNING in rcu_check_gp_start_stall
From:   syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>
To:     bp@alien8.de, devel@driverdev.osuosl.org,
        douly.fnst@cn.fujitsu.com, dvyukov@google.com,
        forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        hpa@zytor.com, konrad.wilk@oracle.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        peterz@infradead.org, puwen@hygon.cn,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tvboxspy@gmail.com, wang.yi59@zte.com.cn, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f1e3e92135202ff3d95195393ee62808c109208c
Author: Malcolm Priestley <tvboxspy@gmail.com>
Date:   Wed Jul 22 18:16:42 2015 +0000

     staging: vt6655: fix tagSRxDesc -> next_desc type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111856cf200000
start commit:   f1e3e921 staging: vt6655: fix tagSRxDesc -> next_desc type
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=131856cf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=151856cf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000

Reported-by: syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com
Fixes: f1e3e921 ("staging: vt6655: fix tagSRxDesc -> next_desc type")
