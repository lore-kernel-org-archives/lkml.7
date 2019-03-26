Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37955C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC55920811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfCZXEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:04:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49645 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbfCZXEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:04:02 -0400
Received: by mail-io1-f71.google.com with SMTP id z6so11571838ioh.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yt+50zZPBRx4NLliJkGQS3+f9B8Up4ivzi1p9nl7nzw=;
        b=SF7VGU7ZPL0N5N65Jmpq3P17AYO9JCwVdzZBzw0WsAKnI1ldvgDsZkLHJSuEIVlmcw
         URT5qblNmECMe3ft7hDgq9pndhAjsogpYhU2+Rd3T2ygzWEpLSADa1oBuDTlBQ2ZiwX1
         dGIY9PEm0d9AbBL6TDktsRpX3W3B1XB4PecYeS1Z0qa00yTmxVbI1x91rTnmUf1atNUw
         lXnsH0Yl4cS+Xe906zDd03kLCA74CijzrXeeE6gkBw4b52nwGJ3t953ciPfPWir+MgxP
         FmLzG34hEFDCzUt4KUXgKTUrJbm8vuQiIyejq+SoRRCsv9piYDeMoFOWzXZurvMEybxt
         JpkA==
X-Gm-Message-State: APjAAAX8epQecywTbN9SdytVF3EanGYGwKdxULkLUKKIeP6JiJHo4CpB
        Rnk3jAvfKcJJgsuaaNdgFP355pWZhDTuq31UrCOoJr3OiGrc
X-Google-Smtp-Source: APXvYqx0+I3YpDOMsU1txB3REddsbdqehe79PdpD/0XvzpXd8wdlqz81y54uz4A4lldS3xVXWiXPLrD9NBur+ETkIMNHC+SwTkNM
MIME-Version: 1.0
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr10656299iog.187.1553641441254;
 Tue, 26 Mar 2019 16:04:01 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:04:01 -0700
In-Reply-To: <00000000000003cadb05814f3284@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036e81e058507565b@google.com>
Subject: Re: INFO: rcu detected stall in __perf_sw_event
From:   syzbot <syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        fthain@telegraphics.com.au, funaho@jurai.org, geert@linux-m68k.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit cf85d89562f39cc7ae73de54639f1915a9195b7a
Author: Finn Thain <fthain@telegraphics.com.au>
Date:   Fri May 25 07:34:36 2018 +0000

     m68k/mac: Enable PDMA for PowerBook 500 series

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1226cb8b200000
start commit:   b0314565 Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1126cb8b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1626cb8b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=a41ac89a0712acde0e84
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1707cd2f400000

Reported-by: syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com
Fixes: cf85d89562f3 ("m68k/mac: Enable PDMA for PowerBook 500 series")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
