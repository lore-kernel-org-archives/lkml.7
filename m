Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0802B2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFEBQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:16:01 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:40036 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFEBQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:16:01 -0400
Received: by mail-it1-f200.google.com with SMTP id u10so591453itb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tq94hQ5Or5MBqoFOhglGdojFAqBC1MTKP/WSj5YIV/8=;
        b=ul3h1ARL6gd8EQU+e1NzyWursTH+hoI+a2DR+w2Qzy2jnYp4d7L9uWPTII8E6nugFW
         z5ip2pPdpDN8hR+7V84G+E3Mc6kJ70uYnDOB8ndzkP2+bNxPa+7R+M1XqDI8kZ2fFKzO
         jUSTk4OKx18bTMzaw2Y4L0GkDMZjVjf9Y1KIBTq0gwHDAVlL4G/ifzzPyo8UvX5/8oxn
         +yCUVQEFqjpy+y1y6B6/LnCSjfSzUFACjwJjSVo+i/H7Mb4DNaYDatOYoalYXY0atVpS
         ChLhTlYerlv25cob3cyO9ogdLwAmODaYzyuX1v2ii2n+Rpktyoj75lzi/1Ot1JawTPbK
         qX6w==
X-Gm-Message-State: APjAAAXwJaD0v+8ktSBUmO2yxv0mn3HwUB+TVTN7+Poy/52OnWqQ2ox0
        atObkAy6s6mzwUux00I1CgV0eq+5zvsQqPVgtlmZuuxDjri5
X-Google-Smtp-Source: APXvYqyZ29aiETxQGapPeY5BBEdXLC0rlE3NJCR2G4dNoGSX9gBRxgTLHXrDZB5y+iumqWQ8OcygrjVAkKZaPDKVOogeeEOvOhLK
MIME-Version: 1.0
X-Received: by 2002:a6b:e00b:: with SMTP id z11mr6761741iog.27.1559697360239;
 Tue, 04 Jun 2019 18:16:00 -0700 (PDT)
Date:   Tue, 04 Jun 2019 18:16:00 -0700
In-Reply-To: <000000000000543e45058a3cf40b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d42b5058a895703@google.com>
Subject: Re: possible deadlock in get_user_pages_unlocked (2)
From:   syzbot <syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com, jack@suse.cz,
        jhubbard@nvidia.com, jmorris@namei.org, keith.busch@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, richard.weiyang@gmail.com,
        rppt@linux.ibm.com, serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 69d61f577d147b396be0991b2ac6f65057f7d445
Author: Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed Apr 3 21:47:46 2019 +0000

     ima: verify mprotect change is consistent with mmap policy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1055a2f2a00000
start commit:   56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1255a2f2a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1455a2f2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=e1374b2ec8f6a25ab2e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165757eea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dd3e86a00000

Reported-by: syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com
Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap  
policy")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
