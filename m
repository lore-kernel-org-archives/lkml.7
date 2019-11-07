Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA25C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF1E2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbfKGNng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:36 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37959 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389006AbfKGNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:07 -0500
Received: by mail-io1-f69.google.com with SMTP id q4so989483ion.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+84sf74G2+LtOjaIUAIm5mQgUcZUIwnjbC/PvAs6V+Y=;
        b=RyOyBRnsmA0GF28L+9c8EeDiVSgrh3VR6Hll8poUyUWYnVsxOPhnW6wG91JqktU8D4
         NQgeSX+G+lYDv5tosJrx/BOdcGN0NfOvwI6LmEZj0rM1qHl+zG6BAOBN6Ff5n6v5NlT0
         4QFYJ2eMXvTR/4FoiKL4kRmD842uKNojxW9Q/j/6GN0VUm+BEI4qWzKyQ1w+iuVIxBZI
         87WRPUZHs2hfIPT46+rVszEOygHguncHYe8USa0Ux6G59Opjr6VtMAA2//jT6G8cz9Ru
         QYJcb6jXMI90U50slq/nPkvFLW0TZUGYr99aFQGXm9MHejjm3v6hFFDd2I1tIhti5cih
         fEKQ==
X-Gm-Message-State: APjAAAXqHXt7e4WZh586JsKHiEH+/dWLPzwLZIh8wX3lZ4xWnkg6XI6b
        ZI29LXFzQUE+a2mmt4SlyG/aBa8rXQRUJ1E5QRfpHZ1kDX5c
X-Google-Smtp-Source: APXvYqyDXVEYlUfk7geo3GgENWWqznzoIPNLvT/v/4WhhgkMFihALxGFrTFCqPjEvWIS25EzJfmt9/ngeJ+New1kGdinWyOcoDmF
MIME-Version: 1.0
X-Received: by 2002:a6b:14ca:: with SMTP id 193mr3506977iou.140.1573134126410;
 Thu, 07 Nov 2019 05:42:06 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:06 -0800
In-Reply-To: <00000000000080601805795ada2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9f0a40596c1d46b@google.com>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
From:   syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net, dvyukov@google.com,
        hans.verkuil@cisco.com, helen.koike@collabora.com,
        hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl, j.vosburgh@gmail.com,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maheshb@google.com,
        mchehab+samsung@kernel.org, mchehab@kernel.org,
        mchehab@s-opensource.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tfiga@chromium.org,
        vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit d65842f7126aa1a87fb44b7c9980c12630ed4f33
Author: Hans Verkuil <hverkuil@xs4all.nl>
Date:   Mon Nov 19 11:09:00 2018 +0000

     media: vb2: add waiting_in_dqbuf flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1417a04a600000
start commit:   9f51ae62 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=62118286bb772a24
dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15701a33400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c8e4d400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: media: vb2: add waiting_in_dqbuf flag

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
