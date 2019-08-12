Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A142C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB3220663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfHLSGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:06:04 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:50709 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfHLSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:06:01 -0400
Received: by mail-ot1-f72.google.com with SMTP id t26so1560446otp.17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iH/156rgMT4fJuQS0nAy3Ez5veVeDUxUwLRyEyTI9H8=;
        b=cIXFGHIOTGdeqr0AftnyZacp2qIjsJDns49npJN6QPNeZxBbFfAdWqDJgpwmJ1vphO
         aBO0xVdnkuxkxnOB8Ml9q99jFSymHwVZwbWL9lCTqXZ5dkKmF/oxnaVWUPdUMTi8MC0x
         UGp8WTNRoOmUX1ejHELhm5sIvKZcoRPU3uzT7Ji0bMRF1RRZCqTzrlkVID5QI/tDQ/QJ
         niLAN5/yWwdBDqsbzxLIlOzcE94n5jIqu63TzRP7kbMKkk4LmfZ7uOsw2Plek4sKTCzT
         QTT7C94ZzYuo0NODaJE9MCdAopZP/sLy8T117Kpd+WcZIDXHZ0Ic64yBlpPfz9e5Nir6
         V6ug==
X-Gm-Message-State: APjAAAU6JHZTW/moSMtgglmmXDq0gkezIGu+DONfJcHw7EaK+NJKHTcd
        i59tJAAp4RbEu1gGMoWASj+9FQ+rcCmsJwmCMJ9W75onFR6C
X-Google-Smtp-Source: APXvYqwuMjKnkHlImBDK/Uqqq5JTnDh9EQ7P5bcsypbrgVf6mLj8vhU+JGvuhxpJikQONeVKnmVPfbXgiZemqDb4ZclS/LuIRawB
MIME-Version: 1.0
X-Received: by 2002:a5d:860e:: with SMTP id f14mr25026723iol.242.1565633161044;
 Mon, 12 Aug 2019 11:06:01 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:06:01 -0700
In-Reply-To: <0000000000007593f4058fea60d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069a89f058fef604a@google.com>
Subject: Re: KASAN: use-after-free Read in rxrpc_queue_local
From:   syzbot <syzbot+78e71c5bab4f76a6a719@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b9a1e627405d68d475a3c1f35e685ccfb5bbe668
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jul 4 00:21:13 2019 +0000

     hsr: implement dellink to clean up resources

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b4ebce600000
start commit:   125b7e09 net: tc35815: Explicitly check NET_IP_ALIGN is no..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12b4ebce600000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b4ebce600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=78e71c5bab4f76a6a719
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165ec172600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119d4eba600000

Reported-by: syzbot+78e71c5bab4f76a6a719@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
