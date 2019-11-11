Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE6221925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKKQHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:07:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:34310 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:07:02 -0500
Received: by mail-io1-f71.google.com with SMTP id a13so13831718iol.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gFl20HjZDqq+nPQeJUYSxv5Bfmo8ZIyMRQ74ccfUZsc=;
        b=MES1xGW/S8lVHtljDnvMNfc59ZpNbXLbdnYbfIk34BqpFhYGG709rxX6R7YFsKpy9k
         b64gZfxyLordDKipYgGBAncmzTj+kQfeUhcY+iTQbj3RNsQP4IA1WhR0Hhf4a9bSW58N
         1LBnWoI72sKdnhTB4UcMe8eHWbTsJ84YPpc/vlo4cRpcTOvbLVtEe4UNBwaa1fDeC+H9
         O3YxdinRsC4LVzDZ3dMJw/YeLV+b+u9uCzGulaiE6BhCSeyUkbxp2mAdusM023o1znNL
         GcRl8N6yqYS1RgIt7GTA7Yt0/UOb/vFpjnHLKKa/PmARyH0TqU3UbqxTRqBU4TK52ZHA
         pF3g==
X-Gm-Message-State: APjAAAVeSybTIm7qb7o7slxKiC3DPig0ivKse13aRRy1ufaCsoP1XM0A
        Dawh/3oO+ZwKH+S9H5T3PsSTPrexAWeRN2OGz7QYpVqcPNms
X-Google-Smtp-Source: APXvYqywxuAwIOiw8d0TKszs0yk4o9kaGMvUJ9K55SHH6Im/F08TWUOQQw1vBGPnwfBhSwGcTMIJv9gca9cNfCX3fkgdzA02Qkyu
MIME-Version: 1.0
X-Received: by 2002:a92:dd0f:: with SMTP id n15mr31057502ilm.146.1573488421314;
 Mon, 11 Nov 2019 08:07:01 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:07:01 -0800
In-Reply-To: <000000000000aae1480596a5632b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000692ac105971452c5@google.com>
Subject: Re: WARNING: refcount bug in j1939_netdev_start
From:   syzbot <syzbot+afd421337a736d6c1ee6@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17100f3ae00000
start commit:   9805a683 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14900f3ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10900f3ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=afd421337a736d6c1ee6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d713c6e00000

Reported-by: syzbot+afd421337a736d6c1ee6@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
