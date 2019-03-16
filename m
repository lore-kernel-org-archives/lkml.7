Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E76C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC6D218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfCPOtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:49:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57185 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfCPOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:49:02 -0400
Received: by mail-io1-f72.google.com with SMTP id e1so9420371iod.23
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6Ih334lsMXYA3vrLFwQIID70wP9goKKAOO0YhMild90=;
        b=nz7b5UW9byLtsjlJCVzkzSx5ckS8om/QsCgolUYRyipkOyfHvE4gKtmRqvLdbPpb8h
         MaeZcGfinkRi3pZy0zcZOlJeBCQ0pyAUK2dit2/zaNrgtIMTsZ910mZ+FyB95wBxwaDe
         FrmQF9aUFZVvCFI2zwJ2++aTb5dh8lQtfIEwWYVZkdzugCadm1O5fsG95oTVK0/Pah5M
         1cHx60XimznsU2cJYBr9Z4lfNlstceObV5cyu38A3y/qAWD3K/28gikg27whX3Z6pxx4
         Y5PNRyd6hvIsi7K9mv8tSUsKHpfboSXiBEWMGGMI46H9JKKVzP6v5bL84LHjk0mmlQT8
         e6Nw==
X-Gm-Message-State: APjAAAV7nmlWgzYZRdBi/frXsdLStkRNOB6O22IELAy/yYdZwMNHs8G4
        Ws5nKM0ZkN3KGInd2ilbjNos15h6ZbYGNoF5dOSDftzaoiSN
X-Google-Smtp-Source: APXvYqwpdzJ2261pgi/WowVvQ1a/sDmyPD23XbTT1QQCCe/uP5p4kYEIx8LSDGzPqXWzzUWAKC3qAAyOSj2TerREz2n3kvj0tpKe
MIME-Version: 1.0
X-Received: by 2002:a24:1991:: with SMTP id b139mr5070875itb.38.1552747742080;
 Sat, 16 Mar 2019 07:49:02 -0700 (PDT)
Date:   Sat, 16 Mar 2019 07:49:02 -0700
In-Reply-To: <0000000000004a6256057ca3b6bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097b4a405843741e6@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in default_read_copy_kernel
From:   syzbot <syzbot+12f17c177de05efea72d@syzkaller.appspotmail.com>
To:     alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        dan.carpenter@oracle.com, gustavo@embeddedor.com, joe@perches.com,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        o-takashi@sakamocchi.jp, pasqualirb@gmail.com, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de,
        twischer@de.adit-jv.com, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 65766ee0bf7fe8b3be80e2e1c3ef54ad59b29476
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Nov 9 10:59:45 2018 +0000

     ALSA: oss: Use kvzalloc() for local buffer allocations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ae57db200000
start commit:   65766ee0 ALSA: oss: Use kvzalloc() for local buffer alloca..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=106e57db200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ae57db200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=12f17c177de05efea72d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c27125400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152a2a43400000

Reported-by: syzbot+12f17c177de05efea72d@syzkaller.appspotmail.com
Fixes: 65766ee0 ("ALSA: oss: Use kvzalloc() for local buffer allocations")
