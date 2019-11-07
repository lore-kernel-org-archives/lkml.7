Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C87EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EB12077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbfKGNmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:54 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43661 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389145AbfKGNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:09 -0500
Received: by mail-il1-f198.google.com with SMTP id d11so2648246ild.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lTBwmsnLCzbX/olH5Mwl+G5iNSg0YQFvLfdGOpbbv6E=;
        b=AXDHogu6mZ3iKGWVKrvDZSXx7spjQkjTZDMH+GVprcCwciqQoVOeJJRzZUs4oeWfoj
         ArJ4qsWoij8sRPtiZGSnQm3NamNxmho0XpflogEGrRQIdlOkfEnilp6w3wiPukHjvt5F
         o+VAPfHBhduW4rVGd/VXuFuGM8qlYcVfYM/tuux1jngxv+XJSjWGuKXwp8C7T9OhGmVw
         kG+3UiCDyysQhF4bS3Cc7fGn847KGPVx4DiST18supURtaCLb8lI7ARkmzqtnU5Zdbwj
         ScSPkqunBCtRt0AWD+8tDEWYBAaELV4MFrUhO++X9Mtu+XuJYUJQo1Wv1LkmQZQAuUDh
         I0AA==
X-Gm-Message-State: APjAAAX2ipycJzdoTwkMpp1QJYaXoGCJDPkjiLT1zqFAuOKaAbW73LAU
        44gaCeUJM/QoiKSgLx4wq/n+QNE4byweyZJ+LWFilXwOxIRF
X-Google-Smtp-Source: APXvYqz6ZViFFcstbOLQh1BYSSIMXfKvEDzmUndoSodku49jzXKlimDRlia/G2rBwC2BghwEl5PykfBqcmfIdbePjHfamdgABMJ4
MIME-Version: 1.0
X-Received: by 2002:a02:1c41:: with SMTP id c62mr1425jac.132.1573134128561;
 Thu, 07 Nov 2019 05:42:08 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:08 -0800
In-Reply-To: <0000000000002996510581a1487e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eac5200596c1d46b@google.com>
Subject: Re: general protection fault in qca_setup
From:   syzbot <syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com>
To:     gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, vdronov@redhat.com,
        ytkim@qca.qualcomm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit b36a1552d7319bbfd5cf7f08726c23c5c66d4f73
Author: Vladis Dronov <vdronov@redhat.com>
Date:   Tue Jul 30 09:33:45 2019 +0000

     Bluetooth: hci_uart: check for missing tty operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1436b32c600000
start commit:   d1393711 Linux 5.0-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0dbf8843bb75efaa05
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130894af400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10799004c00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: Bluetooth: hci_uart: check for missing tty operations

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
