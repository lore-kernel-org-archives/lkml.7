Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B4CCA9EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918F9214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfKEIFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:05:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45971 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbfKEIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:05:02 -0500
Received: by mail-io1-f69.google.com with SMTP id c17so11833351ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 00:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A+4AkRt/iJ32TVTQDYf76dEd7rbEn0HxYNkhXJNAhU4=;
        b=Lj48zPkJNPytExTFpaieauPOxM1BUvx1wIzYyeYMyhaSJvp+6VPFpyGx7nznfwWLwT
         2f34KvXyj7gdKSaRSafzCPr8ZdrHT0Yxa4ho2AuulwDZoUst4JVKpWGqMZQCfT+NA2ya
         5q6ooRu9sZrHNHoChmqi2vuH2SnVKzKocPSplHntD42vcOla/fxHIn0JDS2YYpapOO1b
         Vr6iNjiKxpHgrVYCANurBX4UXPhj1k0T4ytMZad9h2qbAyv/bYry+IOyu/QgatR45NuX
         pmIGDdwUL5NceOgJC+oW2ju/THv5QeIbsqZP6PMs5AHwU+MOrde40BQuCBwjn16gpDTw
         3vlg==
X-Gm-Message-State: APjAAAXN7OnGg3A0dUPZZjmbqjdeAD3MiXsFC82+Iz0cxaWE9+MAXF0I
        xP1rmM++/omxdfmegGtzIcedNpCN1LimvSfiXYNL8PLjND8c
X-Google-Smtp-Source: APXvYqxxHa3WZGVREfBIgxsSHWRMFio4aR3soJvRprK7KTi8nNn6BI9Am+gZILpmI5NcZhdyGyBTD3WyVzvP9Bg1F+VtznmK0N4k
MIME-Version: 1.0
X-Received: by 2002:a92:8dd9:: with SMTP id w86mr31839322ill.93.1572941101014;
 Tue, 05 Nov 2019 00:05:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 00:05:01 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009427b5059694e33c@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr
From:   syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, ilias.apalodimas@linaro.org,
        joabreu@synopsys.com, jose.abreu@synopsys.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2af6106ae949651d529c8c3f0734c3a7babd0d4b
Author: Jose Abreu <Jose.Abreu@synopsys.com>
Date:   Tue Jul 9 08:03:00 2019 +0000

     net: stmmac: Introducing support for Page Pool

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f481c8e00000
start commit:   1574cf83 Merge tag 'mlx5-updates-2019-11-01' of git://git...
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f481c8e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f481c8e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c26333525dde4c39
dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16050314e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c59b2e00000

Reported-by: syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com
Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
