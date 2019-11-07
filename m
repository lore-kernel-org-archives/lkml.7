Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9EFC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64C62187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbfKGNmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:19 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:49434 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389127AbfKGNmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:11 -0500
Received: by mail-io1-f70.google.com with SMTP id x1so1844074ior.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e82UTgwLSYIZvR2zraa9Nggc087nss86NXJiBWUJu+E=;
        b=RNHOVyjaA/G0ds3NxQypcPUPna+mAmz6gOOsIk6bfdPrp/Wd0MDOKk21FQpl2cTMmB
         HMit5luEbkbkYzpnZEagEGPfnvG9hHbmwOMaTiuXUrpjC02C1EQ2fOds9xJ1MVLDE5pz
         /hcis9+pXfe63KBPUSLmnOt0KLPTJsVhGhO8mFi8xFq3caK3DeEYQVnkuPYegST3QANg
         LCmBMQFglEPx8TLLhHx5OMqiCNa6YkeC1UuJMLojUK0QVb3KbJ042G+kSLHkDTh/rvV6
         IiicDcWMpioUg8Hc510g5++JT3tdb8ogVu+hojvN5k6JLNFK9WSLLma0+rBSwYtVLe7p
         Z2qQ==
X-Gm-Message-State: APjAAAW/JZOHfh6Xp61p4ozP5St1vU9JqtTkt86l6F74NOvoK21GAaWy
        NVSTikEDBgg+4p3jvAi1NWij0Sw/sZp0pVH+548uY+kYRjWk
X-Google-Smtp-Source: APXvYqy2SR949y+R/aVsMmYYpVrF/WYb/9SXBHKSkoi9zyTyoMPvuzLrrPMK2lAbn35Yo+YCSE2zXinrZz2HbDMgOboAl0ltcz5n
MIME-Version: 1.0
X-Received: by 2002:a92:35dd:: with SMTP id c90mr4277087ilf.191.1573134129105;
 Thu, 07 Nov 2019 05:42:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:09 -0800
In-Reply-To: <0000000000000cc0de0572736043@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3131f0596c1d4ed@google.com>
Subject: Re: KASAN: use-after-free Read in __schedule (2)
From:   syzbot <syzbot+ceded3495a1d59f2d244@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liran.alon@oracle.com, luto@kernel.org, mark.kanda@oracle.com,
        mingo@redhat.com, patrick.colp@oracle.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 26b471c7e2f7befd0f59c35b257749ca57e0ed70
Author: Liran Alon <liran.alon@oracle.com>
Date:   Sun Sep 16 11:28:20 2018 +0000

     KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14830572600000
start commit:   234b69e3 ocfs2: fix ocfs2 read block panic
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=ceded3495a1d59f2d244
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1634bbae400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1728324e400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
