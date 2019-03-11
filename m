Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5497C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE1420857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCKNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:05 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:51037 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfCKNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:23:01 -0400
Received: by mail-it1-f200.google.com with SMTP id i63so4991756itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2EhzN5XbYHFQTtG1JAAIyXoSHbmRVeXXvwKjVmg8rcc=;
        b=X3Q31A7pe5ssGFqJef3kWXbYcLAIVSOhOa/SBh/7D4RraV1W0HRWhBxXMSwR9dkyVD
         Pu6CC92Y1m53UXZfihqkqds4SW14VJ4haHjkuSh/QqIy3jOAogIfzAZhtlLiVstaSEce
         047YrmxiyGliOEKd2PMJmamiWYWXhh0BisZ8wkMPe54jdZllZxSjEKmhgFJInrZ/utSd
         K20W3E6tBbrca/MSDjGvaYqHa4UlTQrXp1RWBzAR0ATzdBeu4xiJoXVmi0oSitMxP0jy
         Rzadok0GPyoSWUjxxBLXhGYQ8iZ3DC/UbPZ+zkf0RgIdArcoz2rk556UofmP5LL6pN+i
         JeWw==
X-Gm-Message-State: APjAAAUebUAdsGs5FJq9B9aqSf6VMMmx77XBxLqhD1Re90oXahXkNf0w
        r/kZSfhazuvSlx7pmeTtiggtbTg6FXpPmizFF2dUjWrQ38u2
X-Google-Smtp-Source: APXvYqypCOSl+cov2ngYhPspk0BmvldODN0+SeLpdA8w10V4bqr7Cwo5XYDbOPfvWCaIkGf0DMHiWZlvE7rG1a1T81Xkd2e4eHX1
MIME-Version: 1.0
X-Received: by 2002:a5d:8b47:: with SMTP id c7mr19516661iot.21.1552310580995;
 Mon, 11 Mar 2019 06:23:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:23:00 -0700
In-Reply-To: <00000000000082477205811c029c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2ebc60583d178e5@google.com>
Subject: Re: possible deadlock in io_submit_one
From:   syzbot <syzbot+a3accb352f9c22041cfa@syzkaller.appspotmail.com>
To:     adam.manzanares@wdc.com, avi@scylladb.com, bcrl@kvack.org,
        darrick.wong@oracle.com, gregkh@linuxfoundation.org, hch@lst.de,
        jmoyer@redhat.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit bfe4037e722ec672c9dafd5730d9132afeeb76e9
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jul 16 07:08:20 2018 +0000

     aio: implement IOCB_CMD_POLL

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108886bd200000
start commit:   bfe4037e aio: implement IOCB_CMD_POLL
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=128886bd200000
console output: https://syzkaller.appspot.com/x/log.txt?x=148886bd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0064f906afee10
dashboard link: https://syzkaller.appspot.com/bug?extid=a3accb352f9c22041cfa
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156479f8c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128c75c4c00000

Reported-by: syzbot+a3accb352f9c22041cfa@syzkaller.appspotmail.com
Fixes: bfe4037e ("aio: implement IOCB_CMD_POLL")
