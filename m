Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB197C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A459421019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCQPPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:15:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:56439 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfCQPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:15:01 -0400
Received: by mail-it1-f199.google.com with SMTP id j18so12478267itl.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 08:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OSrja0yauLqcPAmPXxHNrNjD+8DrlW6XBC25MsZs3A4=;
        b=BA2f5NkKBBbc2/Mblp77u0k8Bw4k+pdL8P6eeVStQyFu5TJ/puzEXyi1iYVRf3xqyl
         uvooBzIvQ5s3BRLiQsaZGFP9vV7zxONFmeUG3fFrY8M0wA9dPAUyVFZI4yVsegJwnIS+
         8jrfOfaAnZMbHsXjw/eK59HA6jJsg9m1azA0t6cTfbKD421mdeJDR28Qg4j2FApWBBw9
         jYlLAXdmylP6F0Ai1vbmlvFcpnwPQH3uOyArl3TZbZGiBbGim9pGnPzywHtz0AlTlxc2
         8DTnoCWUWrW3qpKl2o5JvDJHRpy5h0vVnF++5lh88q4yByhIBQAdvUfOBZWg8WjnhC5V
         ReSw==
X-Gm-Message-State: APjAAAUjwJ8jFG9KkvQ3Fc/4PJJwMSCJe/VcnBw9aNn/g9fK0muHx++2
        IycvKE2xnNzzhGZz0uEyPFWQf2yzlHYL793sc7A3H4MJ/6FF
X-Google-Smtp-Source: APXvYqygpej3AEhAGy2Eau25bvEIPxgcG+JlPdefS7YHo2S7uUP8TFhN8EMqMEjqo0ZBHNjGbc/TGPDVcmTqOwioU8ga4dc2bwM/
MIME-Version: 1.0
X-Received: by 2002:a24:2b0a:: with SMTP id h10mr199989ita.35.1552835700345;
 Sun, 17 Mar 2019 08:15:00 -0700 (PDT)
Date:   Sun, 17 Mar 2019 08:15:00 -0700
In-Reply-To: <000000000000bcd434057f4eb905@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050525e05844bbc5b@google.com>
Subject: Re: WARNING in tty_set_termios
From:   syzbot <syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, gustavo@padovan.org,
        johan.hedberg@gmail.com, jslaby@suse.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@intel.com, marcel@holtmann.org, mhjungk@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 162f812f23bab583f5d514ca0e4df67797ac9cdf
Author: Loic Poulain <loic.poulain@intel.com>
Date:   Mon Sep 19 14:29:27 2016 +0000

     Bluetooth: hci_uart: Add Marvell support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cd5c2b200000
start commit:   162f812f Bluetooth: hci_uart: Add Marvell support
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11cd5c2b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16cd5c2b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a950165cbb86bdd023a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121cee07400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fdaed8c00000

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Fixes: 162f812f ("Bluetooth: hci_uart: Add Marvell support")
