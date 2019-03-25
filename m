Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A8FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A174E21019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfCYAoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:44:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56849 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbfCYAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:44:02 -0400
Received: by mail-io1-f70.google.com with SMTP id s184so6631896iod.23
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ht9vVgqisNlHSzSc2E330AOKMhrQjy8GcRFdRRJeoXs=;
        b=Jy9Xmi7yj+MZXL4r6rvTlME5LW6KqUz5J8qLi7r+Usd5vQ2bn+KT+gTJAaXwHy0oxM
         8scdonB6KkMKYbyOG48ij59Vz3XIul6Hbvumabp6IgCb7hXG327T//AdPhkNPGf3ZQZk
         W4GHk6F44b82ebQH7rJHXJ1+OY3kzd55IfekNi/Qj8mEtgUmcR6zq7iozuvmO7ZG6hFi
         xHwgobs6EZMP6ZmUIqTWU1DMf626wD3cQvy+l91m+4Sk1afvIBEDggkOxqZFWfoM6KsB
         YevuEBOK+EezFNv8G8Q8oY5HoeEXxbI5zgT6FZdLk74h9k7ReCRGWWCuWbUv7XoEoyqg
         pQ8w==
X-Gm-Message-State: APjAAAU1xzDj7P9yV9SR/QlMRVyLayaYGJDX/250YZO9s+f6LkC1Am5J
        3ESb3mvAkK02wF/JNGjjIbggTrU9bX07kek0BpZwR9EQUP6f
X-Google-Smtp-Source: APXvYqwNs1aphaMvisiaLgVqVdKZnckeWVHnJZwjuazbq/2POf9Ja/kTFQVlk2lgxm6GGEH8BI6lDxQ54aeo9c7U75+hF7jARK5o
MIME-Version: 1.0
X-Received: by 2002:a05:660c:14b:: with SMTP id r11mr9466590itk.157.1553474641287;
 Sun, 24 Mar 2019 17:44:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:44:01 -0700
In-Reply-To: <0000000000006946d2057bbd0eef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000295e0d0584e08021@google.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
From:   syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>
To:     dledford@redhat.com, hch@lst.de, leonro@mellanox.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sagi@grimberg.me, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a435393acafbf0ecff4deb3e3cb554b34f0d0664
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Thu Jul 13 08:09:40 2017 +0000

     mlx5: move affinity hints assignments to generic code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12df1ba3200000
start commit:   442b8cea Add linux-next specific files for 20181109
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11df1ba3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16df1ba3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=7a8ba368b47fdefca61e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132815f5400000

Reported-by: syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com
Fixes: a435393acafb ("mlx5: move affinity hints assignments to generic  
code")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
