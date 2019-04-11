Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A347C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2CB20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDKGxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:53:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:50986 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:53:01 -0400
Received: by mail-it1-f197.google.com with SMTP id k8so4904640itd.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 23:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EZdY8iVL+fFQQIClcYKzMlggdHkYi7ihXNJz9fW3SEE=;
        b=WEiZfo7BKmg+hcskse0Rdl6kdxIfR3PKRn2Afo6R8+I0Gdp++u7gPagILMRRYaMK1R
         niMoPDxdMFrS6ActGc6ZxybPP3v25zJAvAP1vR0sfN3qM6LZIPz6ubxWTtcPAtkAFqOj
         5tFO1cxhYAJRF0Jra92xanwJAv1clnWI5oIFZxWibdQWqLeLvpMhb+grYVZ2YbE+U2PW
         yKeXe/GOBTaKoIvQocD0OvvwqDHMt0IqDUiNOwvTNi8EmVFLa1VKdpHhyUfwsMUKTE/R
         fL38GjtDbqMwKpiPcU/jMNCSKTljX7yHXmDbUYwNSzAV5MBEI5LsE3V9urXJsDrTtXT4
         b5xw==
X-Gm-Message-State: APjAAAVd1hWzIwahlBtHGr1gMLC8tR3lpq6Xqo2zJ+7JlEcJVwNjl2pY
        VC54W8sjDXFXoPg+diCyOHMXs38fYbjVzjsAe5B93mxbQ2HP
X-Google-Smtp-Source: APXvYqyt0QLH8gCTZSSERaBSf8IcoUNHff0C0lMfD0YB6HsakjxkJND7ZKvPLkYlRE0HUP+HnWjF8ltRP/dcJUbYePlbCoNM8kne
MIME-Version: 1.0
X-Received: by 2002:a24:5ed3:: with SMTP id h202mr2155101itb.17.1554965581079;
 Wed, 10 Apr 2019 23:53:01 -0700 (PDT)
Date:   Wed, 10 Apr 2019 23:53:01 -0700
In-Reply-To: <0000000000003b9c4b0574806070@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000192b4405863ba337@google.com>
Subject: Re: WARNING: bad unlock balance in ucma_destroy_id
From:   syzbot <syzbot+4b628fcc748474003457@syzkaller.appspotmail.com>
To:     dledford@redhat.com, haggaie@mellanox.com,
        hal.rosenstock@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, raindel@mellanox.com, roland@purestorage.com,
        sean.hefty@intel.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com, yishaih@mellanox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e1c30298ccab87151a0c4241fc5985c591598361
Author: Yishai Hadas <yishaih@mellanox.com>
Date:   Thu Aug 13 15:32:07 2015 +0000

     IB/ucma: HW Device hot-removal support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157538d3200000
start commit:   5b394b2d Linux 4.19-rc1
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=177538d3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=137538d3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
dashboard link: https://syzkaller.appspot.com/bug?extid=4b628fcc748474003457
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13351e2e400000

Reported-by: syzbot+4b628fcc748474003457@syzkaller.appspotmail.com
Fixes: e1c30298ccab ("IB/ucma: HW Device hot-removal support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
