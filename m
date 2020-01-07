Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B0BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3186920715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgAGB2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:28:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:47815 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgAGB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:28:02 -0500
Received: by mail-il1-f198.google.com with SMTP id x69so44026902ill.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=75DRJK5klYoLUbzgyGRVpTRFYRrPHK+zNd4vNtL85ZQ=;
        b=sdEwMQGzW4IYLtOZpUOPq9ok3HkL/ltQ/9oPm9TKfA/Y30aAIE5iM/lOEWPvaSCRYW
         qG2qQNyb8TBLIvwC1CdO+P/e9ffH8VwKS4z2V+1CVKuQ4Rp7e+pqQyodUqP9kG79DjbW
         YPDv5wHfY/ykipbPcUsiLzDzIu2bhXc2AQtiEUIzzRvRUR90TixT6MGu1DfcI109+dAq
         kG3DVzPRR410WwV9vk/6A3aElYIf30/GkWgqcnvRcF4SFjFU2bA1QZgfcAzuOEkRtbDz
         uvpj0cO+tjvqTt5cVC1vWt0aiLvklwxFkwDui+IDodKaFlbmbTtUngkbNoMIYuX7VQy4
         aewg==
X-Gm-Message-State: APjAAAWMQjNCy6ssqilwW1NPr3AcxlcU2bhLmr5JMS/gHZtVbPIPWMe+
        OvAFJ8GI87X+hD+gVQZpP59jvj+fs5Qzrgo2WhLPcYQWCK3S
X-Google-Smtp-Source: APXvYqze6nKMW0nX6ASAFlo5hVUFSK6rrj7ZAUCJAj0dZPg3taWf89Wj800pPzrot4VgciXRshJGrcRY8N62dRXGw0WFccatqMpz
MIME-Version: 1.0
X-Received: by 2002:a92:d151:: with SMTP id t17mr73212526ilg.175.1578360481266;
 Mon, 06 Jan 2020 17:28:01 -0800 (PST)
Date:   Mon, 06 Jan 2020 17:28:01 -0800
In-Reply-To: <0000000000009cd5e0059b7eb836@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d04359059b82afd9@google.com>
Subject: Re: general protection fault in dccp_timeout_nlattr_to_obj
From:   syzbot <syzbot+46a4ad33f345d1dd346e@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit dd2934a95701576203b2f61e8ded4e4a2f9183ea
Author: Florian Westphal <fw@strlen.de>
Date:   Mon Sep 17 10:02:54 2018 +0000

     netfilter: conntrack: remove l3->l4 mapping information

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10957485e00000
start commit:   d89091a4 macb: Don't unregister clks unconditionally
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12957485e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14957485e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2f3ef188b7e16cf
dashboard link: https://syzkaller.appspot.com/bug?extid=46a4ad33f345d1dd346e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ff2869e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16693751e00000

Reported-by: syzbot+46a4ad33f345d1dd346e@syzkaller.appspotmail.com
Fixes: dd2934a95701 ("netfilter: conntrack: remove l3->l4 mapping  
information")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
