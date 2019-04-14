Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA7C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4093F2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfDNLGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:06:01 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:42040 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfDNLGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 07:06:01 -0400
Received: by mail-it1-f198.google.com with SMTP id r186so13250602ita.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 04:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tMe5p/G2UpkUBhQmMPxUflZU5IRPVS5LI2L3rzJjq1c=;
        b=ZKpKHHEJNe2w8U4JctIugEozc0fslmIy1eMgoIcO5nuEUWWv0gEyZF9S25YJd/QyIo
         q+MC03ITggdb1cEJgOFrv2/2p72knM3GnZSkEtRckePrsPa+E5B9RivyXvE+z0cytrx0
         +QbjoFS7Ci2PiI6FmgTVY08sUQgrLqM289ZuBRdP6eYgccRymDIVLZM1wieh8KRnrbSd
         QxerV7Td1btyRC33n9cLtbtf5M1Dvik6L1ZVi+qG89qgUR/aCciHO5Abo1qs5gX3ZgI0
         +0Ww6fNWQhcFA7aIyeqO3ZnnapCcaLD8N4onEBqWI4e2ntvkAXe/WVthYrhzWy/yUdu/
         Oh7g==
X-Gm-Message-State: APjAAAV1zA07vPv8bYRGdQnXxFa5G3826WChvDCd89fra2u0ES6Ow2uH
        D8G2x3I+yO3D/zOwVB7lBYtvCmT0nvkpRHQ6PWAjdsjJ0Mkk
X-Google-Smtp-Source: APXvYqzV/b5PqbTpCrU3D1CssIWSx/UWctl9u3xPacVTo2B66jXr16fyyOs2XL5ycWCdAQqYD48qDndQUTtoJhciAmr+GNaGlFMt
MIME-Version: 1.0
X-Received: by 2002:a02:8243:: with SMTP id q3mr12014395jag.6.1555239960611;
 Sun, 14 Apr 2019 04:06:00 -0700 (PDT)
Date:   Sun, 14 Apr 2019 04:06:00 -0700
In-Reply-To: <000000000000d05a78056873bc47@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064948e05867b8503@google.com>
Subject: Re: WARNING in kvm_arch_vcpu_ioctl_run (3)
From:   syzbot <syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, gleb@kernel.org,
        hpa@zytor.com, kernellwp@gmail.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        paulmck@linux.vnet.ibm.com, pbonzini@redhat.com,
        peterz@infradead.org, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 706249c222f68471b6f8e9e8e9b77665c404b226
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Jul 24 13:06:37 2015 +0000

     locking/static_keys: Rework update logic

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175cc587200000
start commit:   1d2ba7fe Merge tag 'fbdev-v4.19-rc7' of https://github.com..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14dcc587200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dcc587200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=760a73552f47a8cd0fd9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ad231400000

Reported-by: syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com
Fixes: 706249c222f6 ("locking/static_keys: Rework update logic")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
