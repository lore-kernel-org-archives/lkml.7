Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E6C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450532084D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfKFH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:27:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:41274 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbfKFH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:27:03 -0500
Received: by mail-io1-f70.google.com with SMTP id v5so10763087iot.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 23:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NYZBN2qq6yyZ8/rwJcWC5cQMVkLTLOTvsfT7QODO4L4=;
        b=mRt8ET8O05HfsVOeCeRGAmUkrwXs6ZXXss7zwxtV4tMM0d+bF1zCpnDvvQHT6A+EdI
         nz6W6o6H2kLZS1VbRV6wWumiJBpYMXej7iHER4cDvy8Ox01yJdpK724+wU+drslOuYVT
         3NxE7WInZ6epvodETS6c7t9znSseGAQjJBQxAV3N1iRpbIbAF3ZztiupSDiBLHLGgkQl
         iKvDy35aki/i/Xw7slVbz3AH8X4R7gJppMngsqBqpwQAlmrMISaGyH6pYpVhyjCOyPBh
         xR1V9Bsz0mjfctb/nnRMPvjBCerC7R5PU182JhK7BJA478/h2kSJOvq37gQejtUMPWKt
         EYzw==
X-Gm-Message-State: APjAAAVngYjY3SA892ZW8jJH+CuO5h4ymaFJEvDm2kaHlFycWrO1ZOke
        4LkE9CpVym/L408UqQ5UkOMsXOzV4JmA0tvE06utCxQFx9mZ
X-Google-Smtp-Source: APXvYqyd5FMJZ30orhu9VqKFCYkocrvkw/KRPvt/6hEEuXDUTOVp4lK7oLQ6TTlI9LlVVvYppYwsRyiSWDBpBRBhmASMZ1QlV/mc
MIME-Version: 1.0
X-Received: by 2002:a92:1b1c:: with SMTP id b28mr1150609ilb.278.1573025221369;
 Tue, 05 Nov 2019 23:27:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 23:27:01 -0800
In-Reply-To: <00000000000047580205969ee89b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008aea290596a8795e@google.com>
Subject: Re: general protection fault in j1939_sk_sendmsg
From:   syzbot <syzbot+7044ea77452b6f92b4fd@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15874852e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17874852e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13874852e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=7044ea77452b6f92b4fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a99e8ae00000

Reported-by: syzbot+7044ea77452b6f92b4fd@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
