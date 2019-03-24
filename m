Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4926C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2F32148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfCXHfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 03:35:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51998 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfCXHfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 03:35:01 -0400
Received: by mail-io1-f71.google.com with SMTP id y18so5287418ior.18
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 00:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Tb6hbSz7QJfU3STDpb3qAlCvwBNFR3Y5spmhaX59toU=;
        b=l0JBgkTCdpCPyFPHSwqKRdb13q0vm1oZzvgz2k9IKXN29CHWtN7XVZncBx83aTPfUN
         suzvwJH6qFAoWlxddASnE22Rs8O5kNPYEhXrEO3ZR5Q/hfNQJrjfjSydnAy1Em9yakKL
         V3uEmGVLIkei5RUJjei/dh4tEF+zpNc5tumcU0fvxGOHiThn95oo6jda0AsJwXFUtgly
         zldmoUR6lfn+whK18jIczVCNaRhVwq6knlfcF0W/FfCO5JvFpaO2DMBQO+GroluVfYRN
         noq8sZSF1YPTn4oKEQBdMlt1svhAUKnTav8WsmipOR5VqwqJf9owm/3bo1l4wqOtijen
         0wBA==
X-Gm-Message-State: APjAAAVUoiywOKhxrs8jCy7eSWe1b8GjnW8iQk7pO+STX7iB9xzHnblG
        Z2I9oPcTZz8F5lb/g0bB5dMpY2R2+PrxHIYhNZUsbNDi/0JN
X-Google-Smtp-Source: APXvYqycjcc0exb2f2tjz6rFgVlnjVAl4Nis6sRSs02Mtxp5FLAjjfrUSMJP6XY+mWSSrseC3TXf08NWZpLrgvROhX1ok/3TwcW0
MIME-Version: 1.0
X-Received: by 2002:a02:97f8:: with SMTP id v53mr13751082jaj.100.1553412901327;
 Sun, 24 Mar 2019 00:35:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 00:35:01 -0700
In-Reply-To: <000000000000fa4f60057e499989@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c5a7f0584d220fa@google.com>
Subject: Re: WARNING in batadv_mcast_mla_tt_retract
From:   syzbot <syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com>
To:     a@unstable.cc, alexander.h.duyck@intel.com,
        amritha.nambiar@intel.com, avagin@gmail.com,
        b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        heiko@sntech.de, jeffrey.t.kirsher@intel.com, joe@perches.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mareklindner@neomailbox.ch,
        mark.rutland@arm.com, netdev@vger.kernel.org, robh+dt@kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tyhicks@canonical.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2ed30cfcf866f657349bf9f54a017a957cd98378
Author: Heiko Stuebner <heiko@sntech.de>
Date:   Thu Aug 2 11:36:41 2018 +0000

     arm64: dts: rockchip: enable dwc2-based otg controller on px30-evb

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177e9917200000
start commit:   4b3c31c8 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14fe9917200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10fe9917200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=83f2d54ec6b7e417e13f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139c6408c00000

Reported-by: syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com
Fixes: 2ed30cfcf866 ("arm64: dts: rockchip: enable dwc2-based otg  
controller on px30-evb")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
