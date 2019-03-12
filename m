Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64360C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE46214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfCLG1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:27:01 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:52266 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfCLG1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:27:01 -0400
Received: by mail-it1-f200.google.com with SMTP id z131so1323996itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ywp1yr5NnGi3gAPkFDTZ9W5K0r3DGxfghSypk/TOnZ8=;
        b=NGcigw7ZlF8In/aMkTFsVowXNveaGqVV8GUHm3uGuhZZ2WTNnRtnrbluCoBQlyFfH/
         geF1NIbKUKre0MpO3XGAQEUSi3cXbNhIpCdnBjZAhoHqRcTfOj3ytgk+Tr+ACb/7uqvI
         py0D7sdnwkzKWvavOFuxQb9TNrbKiGRvoK8xSdsNoY4E/mcHhcq17ojyTpI3RzgNNvcS
         VxHgpC4C+YavSIcbwRMGO0qIfeZSJQ+lDrQe2HDqNapHB/VXBzJmkjFFL9sQ1Ia19FAE
         /NpIAexuFODoGBA4X68KWBtDd3odK/4k2G52yCaQYfynexRi0LMVHxKLLg5/KY+7gH9g
         hkjA==
X-Gm-Message-State: APjAAAU5wQTYg97wao6RlVOdy25CWnhZYj06TQsCSA3wqe6smZ7w9xUy
        6sYENiy9MLaZzrnOFbNA3Ox2qP7A9XKG9SSm+ly0xhsd1IYI
X-Google-Smtp-Source: APXvYqyqnkNtZ9vMHj9cj+NvQPPBfdeZw1DZ/+aZApYlG/KRyhIbbGma3DNsFbSEqJbENYokpZPcQ/+II8D8ckAgMk2Jqbtz7+6F
MIME-Version: 1.0
X-Received: by 2002:a5d:8141:: with SMTP id f1mr1557637ioo.9.1552372020484;
 Mon, 11 Mar 2019 23:27:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 23:27:00 -0700
In-Reply-To: <0000000000001b1a1d057e776c92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7206e0583dfc6b3@google.com>
Subject: Re: WARNING in hsr_addr_subst_dest
From:   syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk,
        davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri May 26 11:53:19 2017 +0000

     blk-mq: merge bio into sw queue before plugging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1681996f200000
start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1581996f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1181996f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107db700c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12304827400000

Reported-by: syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com
Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
