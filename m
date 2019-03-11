Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F82084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCKM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:28:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:37056 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:28:01 -0400
Received: by mail-it1-f199.google.com with SMTP id q141so4901515itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5SguhSjRaBeKASDnq4NS1UTdP8TVYxXJzl38J97xMJM=;
        b=K5vET+hC9E1ONoL2Bh+IVR5OI3SMTOMr1+zmF3e2bVfhpQx4/ekAnBwphmvHJrxwMz
         48ojZkhCxZjbsJw7WnndjwNoVOYZzeiOubhG2t9+VA5IAX1FDpxDIfCAW3dbRrzEn7Za
         xJe8Ke1SRNayCJPPzAlSNLas15BKGH/LGL0paAlZm0vHwgNHH0QCWQ8MTqY981atnX9l
         SoTWShqpmbObJD6XNJZvLZp4FruMvVywv8b/0jEuZgW+eNZ8UjO31moN9VYVN5QXNWNa
         9P5HnfRShhs2ZCpvxtCpWLOM7/y71zu47BV4CXmQE8mdrZXBU29D6zJ9nojqY6QV/Xgi
         4vMw==
X-Gm-Message-State: APjAAAVHPgKlDCOg13iw7LJTFnggk7IRvkh3Nh9o6CbEF7JV43yHF7iM
        BeG/Kv3d2n0AuXXybR174qsR795prMmbUw/eQQ6+fDD+YAFG
X-Google-Smtp-Source: APXvYqw/mjS82d4F16fxA/hfkteK0jWmS9MPkDnJp0ehJLFJa1wXHzDXluYmwFvIT4GfrvoITnzXDfbMBNjVM9JJMBspey1DWWL6
MIME-Version: 1.0
X-Received: by 2002:a02:3b19:: with SMTP id c25mr19045903jaa.0.1552307281061;
 Mon, 11 Mar 2019 05:28:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 05:28:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011f13c0583d0b48c@google.com>
Subject: WARNING in vkms_vblank_simulate
From:   syzbot <syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        rodrigosiqueiramelo@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 09ef09b4ab95dc405ad4171ec2cd8a4ff5227108
Author: Shayenne Moura <shayenneluzmoura@gmail.com>
Date:   Wed Feb 6 20:08:13 2019 +0000

     drm/vkms: WARN when hrtimer_forward_now fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128448cf200000
start commit:   09ef09b4 drm/vkms: WARN when hrtimer_forward_now fails
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=118448cf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=168448cf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1e0e0ec44d1e5ff
dashboard link: https://syzkaller.appspot.com/bug?extid=0871b14ca2e2fb64f6e3
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1787db8d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fc9883200000

Reported-by: syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com
Fixes: 09ef09b4 ("drm/vkms: WARN when hrtimer_forward_now fails")
