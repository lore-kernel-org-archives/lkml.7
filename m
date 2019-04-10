Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260EC2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfDJLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:33:01 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:55871 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbfDJLdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:33:01 -0400
Received: by mail-it1-f198.google.com with SMTP id g184so1953039ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 04:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1dmip3wsT91A1U/O8Mm/N+XuFmXuTDdZ3uCFA46Bg/s=;
        b=TQb1Aoj0I4gwnnANH2sNdqNxTuC+a4u38a4KHR/at/bSHAeRme8iH3LfQBba/pZ0IA
         2Lq493RmhMPXbhKxrjkL6nfcKAiRDeIfYUa8+xavCTtGSgIDvh+4yYuNCyKWiJld3pQF
         REAHA6yi67ciHOcF7dMtfEGMJZgHWvXFRWUK6eugl+taD6ekoJh2dkjGzLSsptG5jFU/
         On/Kg7ZJxySGXW86sMHf6u6OYy8JdPsMLs7gRvlLilOpp/qojpCC+yHjBMCVHjnK6YTd
         PS9DKhwvUf59+hhJAch8joAtlTLnX8GK+G7fAs7gZqNYzQhk9Jel7BX+iDBFVwX4qjpp
         7gtA==
X-Gm-Message-State: APjAAAUU1qFaZtmU+WPwDs8JDdTlGv+yGqHMRB2v4Y2dA2yEm7HCU36k
        seYeOBFBOx7iKgHVRFI/KykmGNftY8fTnuFKJtMqpO3wTb2H
X-Google-Smtp-Source: APXvYqw9LUEwbyfu7yoP3X8wIi8roEXNwSHaeuCz8Sge1qmjOx4+ys8JFawfyD0G0PMYjGXQQ1CPr11cuTkwLC69QGPm9NcOw1Pq
MIME-Version: 1.0
X-Received: by 2002:a02:ba89:: with SMTP id g9mr7030012jao.14.1554895980463;
 Wed, 10 Apr 2019 04:33:00 -0700 (PDT)
Date:   Wed, 10 Apr 2019 04:33:00 -0700
In-Reply-To: <000000000000b98a67057ad7158a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000940af705862b6e90@google.com>
Subject: Re: KASAN: use-after-free Read in __lock_sock
From:   syzbot <syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, glider@google.com,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        lucien.xin@gmail.com, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8f840e47f190cbe61a96945c13e9551048d42cef
Author: Xin Long <lucien.xin@gmail.com>
Date:   Thu Apr 14 07:35:33 2016 +0000

     sctp: add the sctp_diag.c file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1719585b200000
start commit:   0072a0c1 Merge tag 'media/v4.20-4' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1499585b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1099585b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=9276d76e83e3bcde6c99
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b80cfb400000

Reported-by: syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com
Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
