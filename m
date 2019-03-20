Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CDE217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfCTAtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:49:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56162 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfCTAtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:49:01 -0400
Received: by mail-io1-f70.google.com with SMTP id l10so475761iob.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=34TooLQdVcI8lagfhQc4CIT5WCnP1wTTjoUvFK/95jI=;
        b=klOoaceDp8tgogSLEYeOl8tNIhs2RCS6XxFPLAr7S+qdFua9bH3IIA/LibYc2D7rY2
         Xj2cgy7grcgzpvoZ84Q9BBsYJuHuIZz6WYPxgJqFoxMk9Ms3Tzsglv5Jm9k6nMBH9Gf3
         xNePx6hHhsqctqzniXEpF+7U5mcsGq4V5IwqpgsVV2L2PUVlbzix5183QcL9phbGjAvd
         uIacaTiVDarC4GM86K/ylcc2ESv+mzIGts/dSxLjT+ftq44bvZVBbvM5ntYvrWOwxTAY
         Ru91GJY7WSLZDouIf19/qifAXsC4Ot2iJN63nly+tfGZhxTmrwdF067ljphK1nUlJXQw
         AQzA==
X-Gm-Message-State: APjAAAVH8rVoBVXirpKUY0pyIzZtO49i/QbsCy+sXP+9IdlwYsZ5Gdix
        t9OWrYtgNl79R4ib20Yt37aV/mpVzoJ6k6ZEwpbW06IN0iOd
X-Google-Smtp-Source: APXvYqx7zS+H4Jedbpdn1TRb3cKYCoifugmmZXSC2gmMDFAPET4Z0ljW/5N29EtJlpPvU8a6P85Fgix8M3QmQ/HQEE8qv2MLrnXP
MIME-Version: 1.0
X-Received: by 2002:a24:220a:: with SMTP id o10mr3308113ito.22.1553042940333;
 Tue, 19 Mar 2019 17:49:00 -0700 (PDT)
Date:   Tue, 19 Mar 2019 17:49:00 -0700
In-Reply-To: <000000000000f7cb53057b7ee3cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7bd5c05847bfcab@google.com>
Subject: Re: WARNING: bad usercopy in corrupted (2)
From:   syzbot <syzbot+d89b30c46434c433dbf8@syzkaller.appspotmail.com>
To:     crecklin@redhat.com, davem@davemloft.net, dvyukov@google.com,
        keescook@chromium.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-net@vger.kernel.org, netdev@vger.kernel.org,
        sbrivio@redhat.com, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Thu Nov 8 11:19:23 2018 +0000

     fou, fou6: ICMP error handlers for FoU and GUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a57f83200000
start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a57f83200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36a72af2123e78a
dashboard link: https://syzkaller.appspot.com/bug?extid=d89b30c46434c433dbf8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170f6a47400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e1df7b400000

Reported-by: syzbot+d89b30c46434c433dbf8@syzkaller.appspotmail.com
Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")
