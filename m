Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726362064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbfDRROC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:14:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:36960 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:14:01 -0400
Received: by mail-it1-f200.google.com with SMTP id q203so2878090itb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=J2Ggu4EQi+uAKKKobFQcaVNuDnKuw7AvPd4iYVmNZgI=;
        b=nv4b4hD92EW0rRFc9jh/8DcR80YN6+EYZddCjHLqzNpXcpa67XSJKwhjV4LzxFlQ24
         DITTpPbyShSfa/MaAUsON8oB+w3A5xj+RlBru88EWNYPO9oTolS4SkQFgKRYbIn2QXgb
         sOs5qJCRMKNEeCThDs3AbmGIHC48f2Cz0JIWeM/Yt2UvJiQNuLFaBYGDYj/MikQKZZG2
         TUG1OfR2wFn6AxrZHVsM4Gq+OzgaKO8x0yDTpjAyz8fSuEgV0VbGQSUjE+M+HOaJSyZC
         eKw5Rf1cuxVlXVBkH0AoJsJtacGETVKjzE/yLhF1mdzfw2IQpotj/6ZaFLi9d4/rS0CQ
         UJPg==
X-Gm-Message-State: APjAAAWo8LIYL2iIXnbiPVmwTHn3t61jROLNbry1w4Z8CEMKQjq2bjEg
        pInleVuaNaNs37xly/5HAw5gtz48u4ooutvcIp/vvtwgo/mq
X-Google-Smtp-Source: APXvYqx0hx5HiFiwwAonNVXHLc+ntFx9eNBFkzfmhoTmHaaKNIJl946TXql3UKJPUtS6PNGHXJ4BtMrEflCTL2CGfu5z3uwLT+XB
MIME-Version: 1.0
X-Received: by 2002:a5d:84cc:: with SMTP id z12mr4997105ior.305.1555607640961;
 Thu, 18 Apr 2019 10:14:00 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:14:00 -0700
In-Reply-To: <00000000000091becf0586d104c6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d97b380586d1205f@google.com>
Subject: Re: general protection fault in fanotify_handle_event
From:   syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Jan 10 17:04:37 2019 +0000

     fanotify: cache fsid in fsnotify_mark_connector

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627632d200000
start commit:   3f018f4a Add linux-next specific files for 20190418
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527632d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1127632d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=faa7bdc352fc157e
dashboard link: https://syzkaller.appspot.com/bug?extid=15927486a4f1bfcbaf91
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155543d3200000

Reported-by: syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com
Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
