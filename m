Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4588C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCE22184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfCUBVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:21:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:39560 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfCUBVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:21:01 -0400
Received: by mail-it1-f198.google.com with SMTP id e124so1093050ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LlTMmdoG7E6wZ4rWK7uh0Mls5qpshkbwaYodTMDIO0c=;
        b=qsCjC2mfgDRRlR3Mv8NmefrBhq8Dr5W5WF4zXkfoYa/7RDrFzo3RN9XsFtB0D8Rtnf
         GeCotLJECa6zVdxOPDoFSxt+HFBIu3rNRPBxlUFYUmwgvV6m6cIknnuNc3J2+A1c4LWg
         5dYjkdzPkt4SpCuO7WuhhOfSa2x7SLVIpFapTMR4/yyLulZxRkC1fuK2mxZrdngSyM3p
         oFIhKEICblotYtlYfuA1ba42ont+YAEP/HIoff4Nb8JqVHYa4Z/NCKYK1gwFH6B8+/Si
         J9YPriQyQDSzib6Cxmjzl5xB+UvkhUB6JkbulqECUJlol257ey+mxNnbBXqv4Q81Pa1H
         wRhw==
X-Gm-Message-State: APjAAAWyCyqo0S/zA+8BuDY//5KVIcjluBxmo8sI01zl+DKuh1dC2Hhi
        wPiOtq5SqF7dw161XUniLo94lYrXT5jf4YbEInYYf8jKWDkr
X-Google-Smtp-Source: APXvYqxcVY0CRvgFLAgJTl8ubgj7AqjWomnlM5fnvxPCNXdlowNE3TQYXbjtpcmvXIx3eUaFNcvr2CAiwYQ0hMYDzPRWqO8A10vK
MIME-Version: 1.0
X-Received: by 2002:a24:e4a:: with SMTP id 71mr360124ite.0.1553131260157; Wed,
 20 Mar 2019 18:21:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 18:21:00 -0700
In-Reply-To: <000000000000aa8703057a7ea0bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d28ac0584908d43@google.com>
Subject: Re: WARNING in dma_buf_vunmap
From:   syzbot <syzbot+a9317fe7ad261fc76b88@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        j.vosburgh@gmail.com, linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maheshb@google.com,
        netdev@vger.kernel.org, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d5e73f7be850323ae3adbbe84ed37a38b0c31476
Author: Mahesh Bandewar <maheshb@google.com>
Date:   Wed Mar 8 18:55:51 2017 +0000

     bonding: restructure arp-monitor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e679f7200000
start commit:   d5e73f7b bonding: restructure arp-monitor
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e679f7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e679f7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=a9317fe7ad261fc76b88
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7b6f5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105a2783400000

Reported-by: syzbot+a9317fe7ad261fc76b88@syzkaller.appspotmail.com
Fixes: d5e73f7b ("bonding: restructure arp-monitor")
