Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7812148D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 05:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfCWFgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 01:36:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:32774 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfCWFgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 01:36:02 -0400
Received: by mail-io1-f71.google.com with SMTP id n15so3537625ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=z++wN6MsNBlJdUdBn+pWH89WCwCZZPoYFH9M+GJyXWc=;
        b=L6CYOCzkWz+iJB/0eAtuU40wuxAYSLtphdEZtcwaTXpgRFUBW7Q4Pv47LBH9ZG4Zn2
         l+vw1dGcQ9w+4qV1KIEZL8ktSP65vabmBXjxCSN60zhX/7Q8WRh1hsc7HlK3hxMFW9sj
         kqOHvg22uXU/pQPh7XLzomeRmMW/C3BBidZBQ8raCDxQLH3rCpIX85s0X0o5bHiDKP87
         sTe9qvZY09HCs0UYuhFfrXjwdUfOpOU0t5Q8aVZIje5KITXuVhsB/3sHPd0h81CPWe+i
         hpqcJEOrdHM96BUf/u+jhwYgRDcXgdo9U+zU/VQCccK/axa5kJ6TOVs8m6gGslPmfNU/
         fb9w==
X-Gm-Message-State: APjAAAXyMfxpfNG3m1NQ3BVXQFbZ4vzZCtNjfhXxYuT21OtTznLWPS+i
        XpirkaQOrqeE933pSMwaeUhYk9mko78AbiRtZBONlC1tl4WC
X-Google-Smtp-Source: APXvYqzOkAJf9gB05Xqe+7jV0AzuXLOTdRwVNgTajFmFt+x6ObxihAWLOmt7wZGlqXgX8k7SBHd7/v7weC4udn7bK2KLYS5yUicW
MIME-Version: 1.0
X-Received: by 2002:a6b:760b:: with SMTP id g11mr9702414iom.249.1553319361315;
 Fri, 22 Mar 2019 22:36:01 -0700 (PDT)
Date:   Fri, 22 Mar 2019 22:36:01 -0700
In-Reply-To: <0000000000009ed0ce058474a0c1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c10d6e0584bc5866@google.com>
Subject: Re: WARNING: suspicious RCU usage in xfrm_get_policy
From:   syzbot <syzbot+670c11fba80a72c50a6a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, fw@strlen.de, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, suyj.fnst@cn.fujitsu.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f10e0010fae8174dc20bdc872bcaa85baa925cb7
Author: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Date:   Thu Mar 7 01:54:08 2019 +0000

     net: xfrm: Add '_rcu' tag for rcu protected pointer in netns_xfrm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10bddbef200000
start commit:   75e6a83b Add linux-next specific files for 20190319
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12bddbef200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14bddbef200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84a8ad88e2cbdfd4
dashboard link: https://syzkaller.appspot.com/bug?extid=670c11fba80a72c50a6a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129a0aa3200000

Reported-by: syzbot+670c11fba80a72c50a6a@syzkaller.appspotmail.com
Fixes: f10e0010fae8 ("net: xfrm: Add '_rcu' tag for rcu protected pointer  
in netns_xfrm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
