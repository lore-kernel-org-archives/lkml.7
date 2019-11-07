Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D56C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6B218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbfKGNnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:15 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36478 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbfKGNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:08 -0500
Received: by mail-il1-f199.google.com with SMTP id y7so2681722ilb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CZJgdUC1TpRcETObVUB558+pxazKYw5Wn3n/HURXADI=;
        b=gYs1h9FU1lf0sPbPsXcgsyPRj+AOj0X9yz4uwqN+XI3qo5Ch/zI7kXs9x35mQ+U/mA
         yiwgqQ/zWGqpy49cOg7rWgNclzr9d+kPCjG9UCyLitD2s6xgHKCiCo48foOZ2cOAwpxj
         pjCC5BqJo77DWpD2m+LZqN2bu6ul2AR1vWoC3lYhkyDo7S04zQSWjmwkYLv8Dzk1LTNy
         pwPWoTHjsk4UM2DPNSXU+AuiPxQP2XqwfkKFJBJgMiFZU460aUA6DBZhMewPNAAKO+Us
         epmyKPtwYoZAFM0Vy9PXQ27qZNxoNBlrKB3AjjaJ6SnSyxO0vVQHyrzlk/V1BGOl+WUL
         bB3A==
X-Gm-Message-State: APjAAAW25OUrcOK2r91Q6aW22yvS7CqvdXTaVmdBC1gd8ZOO9RFYI5pC
        3gm33RKN5hiBJc1qahmR8WWoSxQvREtoh0qPyxp2hMUYV/Zl
X-Google-Smtp-Source: APXvYqynOcIaT2y3jyHS10UgIJT51zZMfk/18yGsgEM4vujcLU66FRilTI2odarVdOVEi2iPozlH+L82DAgMEg7NmWA/wsb0TRhw
MIME-Version: 1.0
X-Received: by 2002:a6b:ed1a:: with SMTP id n26mr3703846iog.112.1573134125729;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <0000000000002a2fdf0573107004@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfa1ab0596c1d403@google.com>
Subject: Re: BUG: corrupted list in p9_write_work
From:   syzbot <syzbot+1788bd5d4e051da6ec08@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net,
        dominique.martinet@cea.fr, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 728356dedeff8ef999cb436c71333ef4ac51a81c
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Tue Aug 14 17:43:42 2018 +0000

     9p: Add refcount to p9_req_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f2258a600000
start commit:   050cdc6c Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
dashboard link: https://syzkaller.appspot.com/bug?extid=1788bd5d4e051da6ec08
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1196b7ba400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1022391e400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: 9p: Add refcount to p9_req_t

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
