Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E154C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643E2208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfFFV0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:26:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:59597 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFFV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:26:01 -0400
Received: by mail-it1-f199.google.com with SMTP id h133so81277ith.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 14:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8FLsmzT5fuRYDlPRpXfsHV8R+x45zmFIlbaKQu+jQrU=;
        b=EgMLq99Tu3/zbZh4ecOb1uL9C0UMlJgx4nZ8AADsnAg+cV4idtVAcbxnGX74/9R8S4
         B2EpT1pxOdeOnnorCGl1lElQwxyF7vNElxuIsV6vL/h91sZMHC1eE0mplEb3vOW8NpAv
         G2IevDPQfJsxTnA0Arjaiz66Y1ligZEy1cRLnoQ/Lyzp+3U6Vjuze5AyPTrOCrNrpSfk
         2q90BpFUF2C9DXi/SYbSt0HKeA4npXqDzzn+ZU6OxQaiqlW0P+Rq1HOTgPztANYjYbEd
         zyArhU2g6dFfcN+sEAT/4ImMgztb0uGsfcTt4BRpt/K3MSROQmMEFQEnga2KdyG1XXtV
         aUmA==
X-Gm-Message-State: APjAAAVpsRwSQRU7lP1GuEgp5GyHxEYH/ovsHjkHQAnUCzYsZ4icRZzd
        nbBShKkMffNIc2ZdKCZcNgfMAuwGQlpo4TrwSKVIXNRNuFrl
X-Google-Smtp-Source: APXvYqxl7JOalyt2i6XIsXn7vQ0MIDr2sMsgZJhOcVtzOU7sAoQq0Rfvs8Y/n2P0+sXCktgx3+s7D4eQfn486z0A1OdlZGHlD5Za
MIME-Version: 1.0
X-Received: by 2002:a6b:1488:: with SMTP id 130mr29049755iou.304.1559856360982;
 Thu, 06 Jun 2019 14:26:00 -0700 (PDT)
Date:   Thu, 06 Jun 2019 14:26:00 -0700
In-Reply-To: <0000000000004945f1058aa80556@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c11d6058aae5c30@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in corrupted (2)
From:   syzbot <syzbot+9a901acbc447313bfe3e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ast@kernel.org, cai@lca.pw,
        crecklin@redhat.com, daniel@iogearbox.net, dvyukov@google.com,
        john.fastabend@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d40b0116c94bd8fc2b63aae35ce8e66bb53bba42
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Thu Aug 16 19:49:08 2018 +0000

     bpf, sockmap: fix leakage of smap_psock_map_entry

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1137e90ea00000
start commit:   156c0591 Merge tag 'linux-kselftest-5.2-rc4' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1337e90ea00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1537e90ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=9a901acbc447313bfe3e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4b01ea00000

Reported-by: syzbot+9a901acbc447313bfe3e@syzkaller.appspotmail.com
Fixes: d40b0116c94b ("bpf, sockmap: fix leakage of smap_psock_map_entry")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
