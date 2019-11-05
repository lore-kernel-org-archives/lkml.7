Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13843C010C6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D681E2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfKELpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:45:01 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:54200 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfKELpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:45:01 -0500
Received: by mail-il1-f199.google.com with SMTP id y17so6286680ila.20
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QCC2Zuft5IrSbuyDgMXl4CHaLN5HBJGcl6ykToE6Ed8=;
        b=F3Og1irYZ8xdsfQOUe6LlXT9ecEto9cpw1cOHWX3JSwDkKSjsgz3ROBkQysl7wY4yV
         dgo9a7xNfdZ+V5paFX0qnfo5UWVLpGn0+ZYnxdLANlGlkctoycI7MMrEfV2a3okqwQ58
         w1F9rMJXKXP+bgDi3C704QYl14Wc6LQFqogyNdEPEF3vjAMLAZUC5Q6ZZiEe+NfZMqYc
         Rrx/3F20VqKaO99vlSaFZGprT3xuH8P1lIPkgaWW/oPIm5OeolSShvTF1/th0tLgovMn
         kAMh3FwnFSqecmjtlDRED3jJ9gvk9KeGm/W1N2ajWTNYsBlTb0ea5RymLpO8yalhq7zY
         3RPg==
X-Gm-Message-State: APjAAAW8gEIdW4g6rFyWEAAqKGuYqsi77gxmqCfJ8kReQ1/M8fPV/3vq
        n5YxEC7gsfLjYgbwtQU4BK/eQeIUfZc4TKwy3blsPihuQElf
X-Google-Smtp-Source: APXvYqxODW9NHJW/4EGLldbad5zqA1/v64aLeXSjpLD0OrWyJ+niu+pzFgfeGWWvRMHqE1vxcY6Q2oZjQUQLXqzmYw875vDSNqU9
MIME-Version: 1.0
X-Received: by 2002:a92:d981:: with SMTP id r1mr15781326iln.64.1572954300760;
 Tue, 05 Nov 2019 03:45:00 -0800 (PST)
Date:   Tue, 05 Nov 2019 03:45:00 -0800
In-Reply-To: <000000000000de1eec059692c021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058481f059697f6e7@google.com>
Subject: Re: KASAN: use-after-free Write in j1939_sock_pending_del
From:   syzbot <syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11150314e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13150314e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15150314e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=07bb74aeafc88ba7d5b4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd7044e00000

Reported-by: syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
