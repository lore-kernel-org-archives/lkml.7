Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5587AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B97320880
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfCXPoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:44:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54923 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:44:01 -0400
Received: by mail-io1-f70.google.com with SMTP id c17so5886028iom.21
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 08:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0v0ERWCgLSac8gTHAFZWUbQR1vGLs0wY5MFYce5u7OU=;
        b=P2nyT04hl9F+eA+72dPcAOi9AsJTAQROWEBJP5jnik4L2W8VCPWyag0jpiOw74u0MK
         xg8xjlfi4enxFufmduMfMAa0VjGTDBnjBJ0RcpN3e1k8dloly+JMxg+ZQhZRzd0NFbql
         +kAb0GFtn89HAo/1LP4tDpL8BU5qGLh0vWcGaGIhvP6ZRUcgmER4xQusuaKEBEgAf7cb
         LO1fOflS4RVIapHvlib/tlBNGcQJc92rCVhDjSlbsLPuBiWLgRrkHLAG5rI8XIA5wugm
         QgJuy9pDRey6INiCrCV5clPSzlTOerr59c8ktlumOIzf0L9amGkST0tR4GJjgGERfRiI
         k9sg==
X-Gm-Message-State: APjAAAUehcmSFkJKO0ZhObLMXMiGYmftuX3J8X3+2MUNEd5Zecs/Zz1v
        Qkk9qEtH05LyM4eUMofUwmp7bzDpnJ1VNUqkOgfK6Ys0PoTZ
X-Google-Smtp-Source: APXvYqyq5JYo+DpszHc69XutlseqLB9RK/NBt7684qAjCcf6RWR8Pf/2trNldxktfh83/3dEiyfqQ6c0U6d+0j1V65Mr5fhXBxUF
MIME-Version: 1.0
X-Received: by 2002:a24:6c84:: with SMTP id w126mr8010540itb.35.1553442240632;
 Sun, 24 Mar 2019 08:44:00 -0700 (PDT)
Date:   Sun, 24 Mar 2019 08:44:00 -0700
In-Reply-To: <000000000000eb3fa9057cbc2f06@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee9d330584d8f424@google.com>
Subject: Re: INFO: task hung in ctrl_getfamily
From:   syzbot <syzbot+36edb5cac286af8e3385@syzkaller.appspotmail.com>
To:     avagin@virtuozzo.com, davem@davemloft.net, dvyukov@google.com,
        jon.maloy@ericsson.com, keescook@chromium.org,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 928df1880e24bcd47d6359ff86df24db3dfba3c3
Author: Jon Maloy <jon.maloy@ericsson.com>
Date:   Thu Mar 15 15:48:51 2018 +0000

     tipc: obsolete TIPC_ZONE_SCOPE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1377ec7d200000
start commit:   40e020c1 Linux 4.20-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10f7ec7d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1777ec7d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=36edb5cac286af8e3385
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f04d6d400000

Reported-by: syzbot+36edb5cac286af8e3385@syzkaller.appspotmail.com
Fixes: 928df1880e24 ("tipc: obsolete TIPC_ZONE_SCOPE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
