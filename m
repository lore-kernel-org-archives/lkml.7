Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05318C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EDE21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfI3KxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:53:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40828 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfI3KxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:53:01 -0400
Received: by mail-io1-f71.google.com with SMTP id r20so29413884ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hI5UiabcxF02JCdIXhKz7T8NGcvRDQ9zry7wX/9b2Wg=;
        b=GqmYTNm+KUbAc+Haz4akMyD6rWgJ5TusNYrAFLAGIlycWZtJM699e/JHaX4CcjABuM
         FXfTD7egBg0xcymX4IEFnk9pyOjMMWwk79uc7WS+w3E1ZJtJrNbvWHQFO42AZgUIq18S
         DYCh1HtEW7GzUgh92jwlKvn+J3pdTeQJRxsJn1l5MVBY2y44HrrNASYyIG/cK/IOyToI
         nyklXNkEIOOcQi4WCu446nNnzkUliUMeTPOkysgDXGhrAwfzEfHFSr2jzuETIrMctO1P
         +6wQvFgehGAzPNs6pEghFCf6ZyJZ+Jr7anXuoet9R6U7Vs4O8HvWqae1wfYUpCziJMGh
         0MVw==
X-Gm-Message-State: APjAAAXQgs62wysNcFdATxAjK66RBlPFbZu89l8r8vr6VT7VPSPFPo+F
        670WjtfW91EdNbsZIenAS+bdfJFXCZgHIuNhIjy6G+FBziwP
X-Google-Smtp-Source: APXvYqxRYokbmnvyKs8m43W2eYhxiwwUbwWy13gugzMDjSun9tKIic+MOKtsA0/QDSj4eyEqMzAj3mnJOFEjdYOCIauwyEoJD8+B
MIME-Version: 1.0
X-Received: by 2002:a92:c0d2:: with SMTP id t18mr20022479ilf.239.1569840781088;
 Mon, 30 Sep 2019 03:53:01 -0700 (PDT)
Date:   Mon, 30 Sep 2019 03:53:01 -0700
In-Reply-To: <00000000000084fb070593bff0fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c5e810593c30a8c@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in xsk_poll
From:   syzbot <syzbot+a5765ed8cdb1cca4d249@syzkaller.appspotmail.com>
To:     ast@kernel.org, bjorn.topel@intel.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        jonathan.lemon@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, maximmi@mellanox.com,
        netdev@vger.kernel.org, saeedm@mellanox.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tariqt@mellanox.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 77cd0d7b3f257fd0e3096b4fdcff1a7d38e99e10
Author: Magnus Karlsson <magnus.karlsson@intel.com>
Date:   Wed Aug 14 07:27:17 2019 +0000

     xsk: add support for need_wakeup flag in AF_XDP rings

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17848acd600000
start commit:   a3c0e7b1 Merge tag 'libnvdimm-fixes-5.4-rc1' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14448acd600000
console output: https://syzkaller.appspot.com/x/log.txt?x=10448acd600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ffbfa7e4a36190f
dashboard link: https://syzkaller.appspot.com/bug?extid=a5765ed8cdb1cca4d249
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1096d835600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129f15f3600000

Reported-by: syzbot+a5765ed8cdb1cca4d249@syzkaller.appspotmail.com
Fixes: 77cd0d7b3f25 ("xsk: add support for need_wakeup flag in AF_XDP  
rings")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
