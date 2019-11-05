Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CDC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B1C2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbfKEQ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:27:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:46833 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390060AbfKEQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:27:02 -0500
Received: by mail-io1-f70.google.com with SMTP id r4so5644651ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 08:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xk1NyHbooEy4YsKg2M7xCtDevKehR0j6/pRBBy2vjNw=;
        b=G72xT1Hhh+unExdpqP5ig76bMvuKH0vxFHP+vDUVLZf1g0OOrb25LW2RW8Jcucw4UX
         gMaqLuT0ZOv34nTF7e6JyBl5ftecUe54T/sV9AUIRjnxLZamzUfKsAkxzkDuXk1kvFTl
         dQ7SXh6KnodGZKjXnI2NSagBBa3g3cI5eoF+z2IjIlouBQrE/4OxlZaQKrqfMPGlYeqV
         b5oci+nbYUslTID7DluYpU5efsp+LzU5lY6X15IgcHqQnIMJs/ulBnEYg4nBPwWgw1hJ
         wRwK8ChjsX5SqEuiwlsKi6SSrhaIQXFMqF0TFIy8awW7cHvThVgl3H90cR008NAqDERn
         HBjQ==
X-Gm-Message-State: APjAAAWIlwl2INguqzCxECENrBLbCsJlKvScMMiENU18KtIHfAkTzixH
        eG8lFrgssSxgnWW9aKONpi5FCuYtjZREFVGEm8qm7j/QtGzn
X-Google-Smtp-Source: APXvYqw3IqVWZQAVPDbpkfRF7hE8RcQNgey/R6Pf8G7Cgo3IYNCKrAbGg2rE8MnLaYC40eT3Z15gtUy8nMeNqMMOMFCOhtwdKjkd
MIME-Version: 1.0
X-Received: by 2002:a5d:9954:: with SMTP id v20mr4300127ios.188.1572971221308;
 Tue, 05 Nov 2019 08:27:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 08:27:01 -0800
In-Reply-To: <000000000000a367e3059691c6b4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e36a0405969be68c@google.com>
Subject: Re: general protection fault in j1939_sk_bind
From:   syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16267168e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15267168e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11267168e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110a8b8ae00000

Reported-by: syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
