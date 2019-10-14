Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E99ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED4620882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfJND5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 23:57:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50914 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfJND5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 23:57:03 -0400
Received: by mail-io1-f70.google.com with SMTP id f5so24736124iob.17
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 20:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OuWAyTtmm63QQUGDPXR+DkHDOHPMuPnOWQaHNFnyLBY=;
        b=RrHWAXbt0P/HUfkmI6CxhyXoFqLarG8wQUYJvuPZYJeEner97f/6tc1rhsNjSD62M5
         jIKmvNWYA45bZexlJgjkhfd6QQiLv1i/XkCCB7NrNl56npGvgmhROAj8R7qijq1npOnD
         4DaQf6tjNyZ0KufsHgbG1uv0wxzl4MiadjlvTU5JwfCtStYi2XVL3i2lg/vypvk5JuEO
         wGXbxnLLgOShDFqRf2Bf1qMqOXRa7C6KjrVKQQLwdkDA8qP67lq52Bo8+OfUmXEc3ReN
         SFUOWafPXNIQH4lzdnbjk3Q5ySJLwQVJkYA7cea2IZa3c5EIHIA4llOSCOCxd9uOQgMJ
         N1QQ==
X-Gm-Message-State: APjAAAW039CsExQGl1Moqiafz+Hr+Sd7+uxvlgVEbO3GATxC/uMK/lI9
        h4346SJLKkRUeszNuALa9DodfKmH1APDYEcqBZtOop1Fbi4+
X-Google-Smtp-Source: APXvYqwVwyIy9nSYbsyJl/5Ky7DslcWs3entkTykv54QRnqMyvOOoULUzhOD3mtwNZ2fJRFRwM9mAxsY/zpxHu8l3i0Nylw2l3P/
MIME-Version: 1.0
X-Received: by 2002:a5d:93c7:: with SMTP id j7mr6139939ioo.167.1571025421311;
 Sun, 13 Oct 2019 20:57:01 -0700 (PDT)
Date:   Sun, 13 Oct 2019 20:57:01 -0700
In-Reply-To: <00000000000059b6d40594d0f776@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ba5570594d6dc99@google.com>
Subject: Re: WARNING in batadv_iv_send_outstanding_bat_ogm_packet
From:   syzbot <syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com>
To:     a@unstable.cc, akpm@osdl.org, arvind.yadav.cs@gmail.com,
        b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
        kgene@kernel.org, krzk@kernel.org, kyungmin.park@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        mareklindner@neomailbox.ch, mchehab@kernel.org,
        mchehab@s-opensource.com, mingo@kernel.org, netdev@vger.kernel.org,
        oleg@tv-sign.ru, roland@redhat.com, s.nawrocki@samsung.com,
        sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 26d051e301f67cdd2ea3404abb43902f13214efa
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Thu Jun 29 08:21:35 2017 +0000

     media: exynos4-is: fimc-is-i2c: constify dev_pm_ops structures

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a0aff0e00000
start commit:   da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12a0aff0e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a0aff0e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d2fd92a28d3e50
dashboard link: https://syzkaller.appspot.com/bug?extid=c0b807de416427ff3dd1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141ffd77600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11edd580e00000

Reported-by: syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com
Fixes: 26d051e301f6 ("media: exynos4-is: fimc-is-i2c: constify dev_pm_ops  
structures")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
