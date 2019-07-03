Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F267EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8DA21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGCS0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:26:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48797 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfGCS0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:26:01 -0400
Received: by mail-io1-f70.google.com with SMTP id z19so3521445ioi.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ol2oTL6I09LrbBugODTrPEcLgmAtDlXO+xFKA9FYWzI=;
        b=Sy6BUW7zMl9HiF2LTxCiajntgvbr1Y4E2fBiykzEDlQ/rnmAJGt3EeEb/+7scqBauB
         iTNSfnrrWO7eZJpv/ttJ3bZirmwS/UtiSChipo19YTMQcQ2iGY7R/TV9MQuFcWmCLY9f
         7OH373tHiPtS56R0+yytLhwOHBzh/GXP5nSRAQQNJ08M6XtTjPhXnsusCliNncqEdNV2
         LQVG5z606DUWYdLj3khqOFDVFm3sy6zkgDNHQgmq2uX4cBl/o+LZu6gobpUF/t6CUCGA
         jfRmoouSVAFM+acKpBMPRwV6XwoDZImPylbYn8o3mbCsVzSENJhV7GNU/92PMDxoeAB9
         2KUQ==
X-Gm-Message-State: APjAAAUyNj/QIuuhKYevaXxpPCS8yD5mtmy0QZV8HriYLI+JzrFgLM9f
        tHFEYm9GaSXBO+4aIJ0PjeQCbdpyF3wxwQFFfuwn680mLVoM
X-Google-Smtp-Source: APXvYqwnKz9Y5ErGzM/oENrZog1dO7eB2V3AocjmtCzYXUDUaLNQ1kAbKUGqE/0CNl8wQiJx3GqOLtHaUDhnnEPnEz2HNfDxKgvN
MIME-Version: 1.0
X-Received: by 2002:a02:c50a:: with SMTP id s10mr45090759jam.106.1562178360550;
 Wed, 03 Jul 2019 11:26:00 -0700 (PDT)
Date:   Wed, 03 Jul 2019 11:26:00 -0700
In-Reply-To: <00000000000035c756058848954a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ac74058ccafe0d@google.com>
Subject: Re: KASAN: use-after-free Read in hci_cmd_timeout
From:   syzbot <syzbot+19a9f729f05272857487@syzkaller.appspotmail.com>
To:     chaitra.basappa@broadcom.com, davem@davemloft.net,
        jejb@linux.vnet.ibm.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, marcel@holtmann.org,
        martin.petersen@oracle.com, mpt-fusionlinux.pdl@broadcom.com,
        netdev@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ff92b9dd9268507e23fc10cc4341626cef50367c
Author: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Date:   Thu Oct 25 14:03:40 2018 +0000

     scsi: mpt3sas: Update MPI headers to support Aero controllers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130ac8dda00000
start commit:   eca94432 Bluetooth: Fix faulty expression for minimum encr..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=108ac8dda00000
console output: https://syzkaller.appspot.com/x/log.txt?x=170ac8dda00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6451f0da3d42d53
dashboard link: https://syzkaller.appspot.com/bug?extid=19a9f729f05272857487
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125b7999a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176deefba00000

Reported-by: syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Fixes: ff92b9dd9268 ("scsi: mpt3sas: Update MPI headers to support Aero  
controllers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
