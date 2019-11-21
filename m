Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD6AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AFD20715
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKUF4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:56:01 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:51023 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUF4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:56:01 -0500
Received: by mail-il1-f199.google.com with SMTP id l63so1939049ili.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 21:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mfH1KiCJRKrkCk6Xo24N026hP3QeH2tnCMon9TkgaqE=;
        b=C1x0pRpFdfQcp5SoxjA/T0zzL414j0CzjsoHcrpX7zAS0ueWakNswXKtF8/0jEpjAP
         8KcTSDFZx2wqA/1qai2REhQKZDR4C/2vVcCgQgRuarKju6kPavrSdAPk44z5f+3vRTSR
         bS1Jk73zE3udfcBUtI5ABL0wUo/MXdNHkUCZ2608MupKgw6bA7pw/YrvmWKYN4eJTbgB
         P5qAMY55VLhkhdMZw1LkQUyXFlTay0R26X/OYnh8n1BaaAIuACCZGvGrnPxNFT7tuAr+
         62tNHrULwFoVyPKnqaulbmLkVNbvdxd+4ABzWRhKtPuLuhvE5SOKlhaFEi8TtuIGO2GO
         tMnA==
X-Gm-Message-State: APjAAAWZMsUoKiV8x4crXh6eb3LNyK8BWvz5kSb/WmBZoIOnk5yjKca0
        YU0fNH+NWyPVqKxkEfMgZb1mr8M3iSs8lfPqY03FbQApkIxj
X-Google-Smtp-Source: APXvYqwUKLMPCVsGilywR82DgOMl8S8nXlNM4DAw4/+MPXBC9kph9vWN1fhkX08eEJ5ztd1Hs8pxMXnFldFW3iiHqxZP+FOWzVdW
MIME-Version: 1.0
X-Received: by 2002:a6b:9245:: with SMTP id u66mr5976497iod.98.1574315760516;
 Wed, 20 Nov 2019 21:56:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 21:56:00 -0800
In-Reply-To: <00000000000072cb6c0597635d04@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab834f0597d4f337@google.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
From:   syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyun01@kylinos.cn,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 206aefde4f886fdeb3b6339aacab3a85fb74cb7e
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Nov 8 01:27:42 2019 +0000

     io_uring: reduce/pack size of io_ring_ctx

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f98af2e00000
start commit:   5d1131b4 Add linux-next specific files for 20191119
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f98af2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f98af2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b29d2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3956ae00000

Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com
Fixes: 206aefde4f88 ("io_uring: reduce/pack size of io_ring_ctx")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
