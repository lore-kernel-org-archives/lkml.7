Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EA120692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKUJ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:26:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:55122 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:26:03 -0500
Received: by mail-io1-f70.google.com with SMTP id f66so1724892ioa.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6ozcDbr2hFtQSnK/28jfucsXIR73JWIXzNBJp3f0sak=;
        b=DmqfsuoKMbm7oa1tmHYfeDhSnKLNA4RFTSRM/SAWev3y11Ze1svidnpTyhQnILZD9D
         s4pWgvBhJOFJrHnnKKXWYaSa31GRP/xh8vlZgCbe7p5tHLqNaeKel4s244zliImKwuUr
         ZB9rJqigVj6QuDZqTnynhJhwPZ+toRXRtqXGyKYgersdS0aFv0OPgro/r5BzlPYFFAdj
         nRzoY+DxwHw6uKAjLUZaEaaBCJVhIlpTqkTcgXhazT2tDa+JMOQMJXKz0HojPp2oo73E
         Ph/tfNOWWmCMt6quXS8fU8aMq/HTsY7Cf3AkETszX24asuvzIlGpIQhtbJDAyCjGGhy3
         hnlw==
X-Gm-Message-State: APjAAAVxSwPUKND+fYkSNPxdg8g63d6CITcAEoftZQ2aH3NvBcsHk6IK
        xjvbWs21cfpHQFR7/u8lRQuSG+eBXGlrP513aU2a5rfR4rEv
X-Google-Smtp-Source: APXvYqw8McZGbc2E/hPpvSV9U/mYJEuNQ3Tf7YiJBqO3ltBpa24uKOnf8sl9TjJv3OXD3dnvqSNkYTI9MC9u8nButoyEwUC6F1z+
MIME-Version: 1.0
X-Received: by 2002:a92:45ca:: with SMTP id z71mr9226460ilj.106.1574328361224;
 Thu, 21 Nov 2019 01:26:01 -0800 (PST)
Date:   Thu, 21 Nov 2019 01:26:01 -0800
In-Reply-To: <00000000000028f3c20597d2d8ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb10ec0597d7e2bb@google.com>
Subject: Re: WARNING in j1939_sk_queue_activate_next
From:   syzbot <syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152c6bace00000
start commit:   c74386d5 afs: Fix missing timeout reset
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=172c6bace00000
console output: https://syzkaller.appspot.com/x/log.txt?x=132c6bace00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4737c15fc47048f2
dashboard link: https://syzkaller.appspot.com/bug?extid=49595536c57ef38095ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b8ba86e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce855ae00000

Reported-by: syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
