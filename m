Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61434C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A79213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfCTEQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:16:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:51306 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbfCTEQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 00:16:01 -0400
Received: by mail-it1-f197.google.com with SMTP id e63so1133531ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 21:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oWEvckGEY393Hykz/QUBOZnwaQ45jbmNDkXIKkWMZJE=;
        b=MUBKW4eZ8Tzb5wDQ97HrClQA2x8cDYXK4IrE54Vn64nrrZCu+gDhtU5RwaswtaexMi
         P9DTfllcIfSFDemOQ0pKMhRDUC6gq0suWjD4WBHleMhIBaWSxtLbxGBfcXfBf3ARQJyh
         T55VHaNyKwRXlFSjjXHWhmdEuI+05pUWBO5kPPRpAREgmwR/fnPylWFliZNrJbhn3lcp
         F5qiBLohuhCM3Liqx4cpEKdttZ212i+ClDdClBnmsXU6Rvy3mixTWdq6Clhuv9aFQsur
         B7iWBXm3aYKXr9EFEnHY47JkokX9W/fSahLF9hgxHeDmoiunrH8RCIdGx4Qg5WzMcYYz
         taeg==
X-Gm-Message-State: APjAAAUMQQ0mfoWw7MrziPje3H1t3aqQBz0VHejR5MZGPIbRrynZEyRg
        6IplPfAo//4E0e2RIuyTmO+yBODl5xA7TUpE1fxtzLcelcNp
X-Google-Smtp-Source: APXvYqzHWmrTwxYGJohbLAl6JjkI3lJkLJJRJeQAdexKbkbp60U6uMGxDr8NbpdRRu1LoAUMAh+29VwvLCnn0yqlW13EebKRIObm
MIME-Version: 1.0
X-Received: by 2002:a24:b007:: with SMTP id d7mr3537621itf.8.1553055360882;
 Tue, 19 Mar 2019 21:16:00 -0700 (PDT)
Date:   Tue, 19 Mar 2019 21:16:00 -0700
In-Reply-To: <000000000000c93833057b6d496a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a1eb005847ee152@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in default_write_copy_kernel
From:   syzbot <syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c3005d200000
start commit:   65766ee0 ALSA: oss: Use kvzalloc() for local buffer alloca..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13c3005d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15c3005d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=d4503ae45b65c5bc1194
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1789354d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162ebe2b400000

Reported-by: syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com
Fixes: 65766ee0 ("ALSA: oss: Use kvzalloc() for local buffer allocations")
