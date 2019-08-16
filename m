Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABBDC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6618020644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfHPMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:32:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37896 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfHPMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:32:01 -0400
Received: by mail-io1-f70.google.com with SMTP id h4so3121995iol.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 05:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wryiOfAG/Vz/DIYvCN28nq1K6mp/nU+skMXU68jljsg=;
        b=V7h4jB+4Ttlrbf/Jbt93xDP7b0TeeH4uuvGue3KlY421XU5IB+AwYSV+UImlLlZ1LC
         /eymj2bT/6id2IYXHDaXv1qC5g+jBKrcue6sqkAI97TECsxrMc4DICPjSzCfsb7k+YUL
         He8ElNHmE6f2Q/VWgEaQ8ntK0ec8iysDXeGX58QvuLTr3Td0b2G2tOTOJkW3UiB66vOy
         WROfq5HaKLKVFKfQEJ8jtsiywzFkVQouyVll4zXQoaLHZeeX8ScN6NfzoLEmHZkJxqIv
         c5V+Sk8PO61J+epdwLbA9Ei4pnD5ncIT8lchNZ1XKrFKzgMkFkZvL0W5E/0rbXVcfQx6
         wJ8w==
X-Gm-Message-State: APjAAAWMDwPYWcDNRwoJOUkICtcT1Qfg7Fvz4m+upnG80jB0kG9YCMCd
        WIWXMvAHCYQDrEiRx/HtyCHbrDyixIGjSU9xH2IIVBTIzp5+
X-Google-Smtp-Source: APXvYqwVJZ1Ky9uvJUxacOGklcVPT1U9nm8gtTHrxo5JaCS/yJtbc56F1jQsb9fE/hCBKAGguMun8qINwfLvsNNf8Go2W64uQ/Eb
MIME-Version: 1.0
X-Received: by 2002:a02:a703:: with SMTP id k3mr10331137jam.12.1565958720687;
 Fri, 16 Aug 2019 05:32:00 -0700 (PDT)
Date:   Fri, 16 Aug 2019 05:32:00 -0700
In-Reply-To: <000000000000ab6f84056c786b93@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000479a1705903b2dc9@google.com>
Subject: Re: WARNING in tracepoint_probe_register_prio (3)
From:   syzbot <syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com>
To:     antoine.tenart@bootlin.com, ard.biesheuvel@linaro.org,
        baruch@tkos.co.il, bigeasy@linutronix.de, davem@davemloft.net,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, maxime.chevallier@bootlin.com,
        mingo@kernel.org, netdev@vger.kernel.org, paulmck@linux.ibm.com,
        paulmck@linux.vnet.ibm.com, rmk+kernel@armlinux.org.uk,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ecb9f80db23a7ab09b46b298b404e41dd7aff6e6
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Aug 13 08:00:25 2019 +0000

     net/mvpp2: Replace tasklet with softirq hrtimer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ffb9ee600000
start commit:   ecb9f80d net/mvpp2: Replace tasklet with softirq hrtimer
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=100079ee600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ffb9ee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4cf1ffb87d590d7
dashboard link: https://syzkaller.appspot.com/bug?extid=774fddf07b7ab29a1e55
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b02a22600000

Reported-by: syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com
Fixes: ecb9f80db23a ("net/mvpp2: Replace tasklet with softirq hrtimer")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
