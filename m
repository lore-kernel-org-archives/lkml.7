Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED8BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F62204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDJEoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:44:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:54178 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfDJEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:44:01 -0400
Received: by mail-it1-f199.google.com with SMTP id o197so1199387ito.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 21:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D9uY9wfjPgxafxN96VuhVPMk10AftLSB40jLhWMlsHI=;
        b=rota/y94rOQUsjetIMY/GchmYSLh3s3/f24j178fhaP7jFWdnEQwBzhrCKJ7DxdoFQ
         pbI7RC4ueYtriBwfyhMa98invuqrlhsT3ZCQVvy/MTT3lU4q6u3Qqi1u/0iz7mimWnEw
         bM+sMqaHBg+Am9AUIrdpUjrzs1pgXF7KYRxcS/5mBBwV5ObFoLOFfOhb4QcdkQAJa7h4
         WE3Rxgl30mJuFIMM5ZGNDswjgZLdqEY9x9oJh4Mo3GyOE3mdL9bc8Eo776nlhCaPbPdq
         ZcWPcWXt3F3gxdsfgAhgnX37xy76IMpm7jtyxkQ1LqlVHF43oLCAzsSNAOL8Yv0KGjZ7
         CP6w==
X-Gm-Message-State: APjAAAV9N8GtVpOTpwIOgXXnKPgXWgBCGtzsA3Gxk0x7Iagy7lUR/aEh
        Ogt9U4O0pfBiv6E0E2HXed82q+3u1AgHSFjFCivN69GJLmD5
X-Google-Smtp-Source: APXvYqyRga4bPij5qUcrQx4xWsEU9LjTYsqP7NCaiTpwsE98in8ZkuCKcwGGAqI6XtY//X0d/xl51snDvrGW0RclSd38s4pqcpE7
MIME-Version: 1.0
X-Received: by 2002:a05:660c:34a:: with SMTP id b10mr369669itl.13.1554871440701;
 Tue, 09 Apr 2019 21:44:00 -0700 (PDT)
Date:   Tue, 09 Apr 2019 21:44:00 -0700
In-Reply-To: <0000000000005b7c64057ba003fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e50a29058625b741@google.com>
Subject: Re: BUG: unable to handle kernel paging request in tpg_fill_plane_buffer
From:   syzbot <syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com>
To:     bwinther@cisco.com, hans.verkuil@cisco.com,
        helen.koike@collabora.com, hverkuil-cisco@xs4all.nl,
        hverkuil@xs4all.nl, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, mchehab@s-opensource.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f2fe89061d79706eca5c47e4efdc09bbc171e74a
Author: Helen Koike <helen.koike@collabora.com>
Date:   Fri Apr 7 17:55:19 2017 +0000

     [media] vimc: Virtual Media Controller core, capture and sensor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b9542d200000
start commit:   6a1d2932 Add linux-next specific files for 20181224
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16b9542d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b9542d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9369d117d073843
dashboard link: https://syzkaller.appspot.com/bug?extid=aa8212f63ea8ffaf3bfa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0363b400000

Reported-by: syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com
Fixes: f2fe89061d79 ("[media] vimc: Virtual Media Controller core, capture  
and sensor")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
