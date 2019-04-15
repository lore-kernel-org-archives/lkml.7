Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5149C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0554218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfDOSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:07:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43740 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfDOSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:07:02 -0400
Received: by mail-io1-f70.google.com with SMTP id n23so14691087ioj.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 11:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sWDXitSXlziTm+++5hupMV/gNlZiFqZLcHdxBDIQI/g=;
        b=lLS7Aerf251lE6H40YMv2EJnaV598wjmE7Pnckm62oMRnG3ftrYNPI12/oY3jP+Kz2
         zK8oV6UUQr9E0daQW/rs+mSxA3YZYooIVghKUL/Vb+9gDWxeVSg1pfyJwijKRicxmQFc
         MfayhyZ/6Rt2rKxVanth9h2KCqOR2jFpMSO1pPgQ4k97YUgBppePfY35COfxInlC5Yfh
         od3koMlS9muzGiG5TyfxhVCeOohOBI2kP5PoYVEI5nDD6b3hZ7anBWSTlvFAiVLImn7G
         5M2R3VyULq8paEgEMtKCQXRypdCpqhK1fdcHBN+RH5gomZa/KAcpVSvuIW+D6kCfRpbN
         fi/g==
X-Gm-Message-State: APjAAAX5lbIK1uKSOYbTpU5JHVN96k/twD8sb6qMjGYESjhZD8kRu6OL
        hNnF5JASijTqCe/XRM86tocpNETANQ4shnfVgiPRPxqUNkX0
X-Google-Smtp-Source: APXvYqx0gY6g+2OoPZQ584Plr9254eaEc4NfCwE81pXgQZQ90f7wBQk1ajxCYplrhDsHPSEaMJ4M0gcCIUSpM+gPrC1Hij3C9kuO
MIME-Version: 1.0
X-Received: by 2002:a24:4155:: with SMTP id x82mr6251777ita.34.1555351620851;
 Mon, 15 Apr 2019 11:07:00 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:07:00 -0700
In-Reply-To: <0000000000009c60fe058665c584@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dca3e3058695845d@google.com>
Subject: Re: INFO: task hung in __io_uring_register
From:   syzbot <syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hare@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6c271ce2f1d572f7fa225700a13cfe7ced492434
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Jan 10 18:22:30 2019 +0000

     io_uring: add submission polling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161ab467200000
start commit:   dc4060a5 Linux 5.1-rc5
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=151ab467200000
console output: https://syzkaller.appspot.com/x/log.txt?x=111ab467200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=16dc03452dee970a0c3e
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eb47ed200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112175dd200000

Reported-by: syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com
Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
