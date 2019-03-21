Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD02AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0E21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfCUSWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:22:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33628 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbfCUSWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:22:01 -0400
Received: by mail-io1-f70.google.com with SMTP id n15so5822861ioc.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fTLO6OcuHsHb44XDt78pjCY8tSBFpFvZ5qx5QixAZZI=;
        b=cgfY6ycZzlz+IkbPubCEngeUhiI+zaX3Fkhn+nyegbHJXmW0AJ6yEL0dzqvzLQx4+I
         RjMoxfYVEYnFSqG74zkglJP1VAyvlnei1LmDHIgz6juC4qJjbap7n9GQdODiUY7mkL8p
         OQq8F6v/XgccS+MU5j+A9gi3s3nPxPHUeqVehAZR47KlaEkjQisTmyngcMuKm+tGjVaa
         acOHzRIsFzZM5t5ZDliQDBggP6F2uSISm2iPIg33d7OkTMYnYkYI+8r5KW6KqOsfdEi4
         ilj9W0ivhRbSmzJbm0XWoPUO1AWC3KyQEb+Mvmwv1pjyCebnAQRDFSM30w42GoSLyusm
         reag==
X-Gm-Message-State: APjAAAWv1pUgToKULZ/Z/kvuVsXnUAsM/VM0wNwZs3NMKkyqYpUkYruD
        1uqosxr7MWPZNqZZxGTI+p9Yx/rgmgv20S8lCq/CJ2/lgXA5
X-Google-Smtp-Source: APXvYqwfKfcWYoLC2muoC5HxT06a0Hqy417x+/kQ/NPZelbuME0SoyhSJaSJ/ffzRHwSnLs2YB1A8wU03lJGFeDGI4rovr1XO69C
MIME-Version: 1.0
X-Received: by 2002:a5d:8358:: with SMTP id q24mr3698326ior.273.1553192520865;
 Thu, 21 Mar 2019 11:22:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 11:22:00 -0700
In-Reply-To: <00000000000017690505849d6b3c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000795f1c05849ed02b@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in hci_uart_set_flow_control
From:   syzbot <syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com>
To:     gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@intel.com, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 162f812f23bab583f5d514ca0e4df67797ac9cdf
Author: Loic Poulain <loic.poulain@intel.com>
Date:   Mon Sep 19 14:29:27 2016 +0000

     Bluetooth: hci_uart: Add Marvell support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112f0a3b200000
start commit:   162f812f Bluetooth: hci_uart: Add Marvell support
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=132f0a3b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=152f0a3b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=79337b501d6aa974d0f6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15397fd7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151e9e6d200000

Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com
Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
