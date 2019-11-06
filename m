Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC9C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916502166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfKFPUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:20:03 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:45681 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfKFPUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:20:02 -0500
Received: by mail-io1-f72.google.com with SMTP id c17so15084349ioh.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QbobwaWWXn01psZxrEEOIRgurZbAVL2YBBMKCRdbKg0=;
        b=KxUFSSzDbnbumcL/GgIbQfN8spPRIaGbAzIFK24L096iugRWUzA5IvxeE12LAse5fs
         PyOW2k0XCpFX7ltH9So79rFH9Xpab1stPXycKBDwkfvY0t08ORwy7C9kE482BICQBCCw
         2/n+aVXKuDwL8DRAirFC+Dv3xo+9hFIX/WUf/xdGTG4JLzfy1BxfTZgsDD4FOuF8vOAf
         iDKiAmjXdw3FccI06dqdJDWaO51CkjS159an+gTyWNQsORBPJhYdj+1Gj62w7bdBkxNj
         2OQ/cQPUbC9H656wtH+lcAkBw1ZJ07Dks+/I8WE1cFI2+CqZA32dplun7IeXSVUjBDMP
         Tnuw==
X-Gm-Message-State: APjAAAUsQxJlpF/GHvrMYZw2Clzg/ug6TVCpJSL3NqCgJBHNxYPsT3Uy
        R2CaUW0kLtac+7UfdIB8SGlmPJq33qZ2x6Drk1o/qVIuuKvj
X-Google-Smtp-Source: APXvYqypSQ9fhpxFp136CkTuJg8S2JHGyT1Q1HM7ZQrLQcFZ1R8db4+KQgj35ozavDMfx9kbB4OKxsoKjNLFZ6xz4SrlcF5/UZsr
MIME-Version: 1.0
X-Received: by 2002:a92:8c92:: with SMTP id s18mr3258760ill.2.1573053600559;
 Wed, 06 Nov 2019 07:20:00 -0800 (PST)
Date:   Wed, 06 Nov 2019 07:20:00 -0800
In-Reply-To: <000000000000b2de3a0594d8b4ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012ff570596af15cc@google.com>
Subject: Re: WARNING in drm_mode_createblob_ioctl
From:   syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>
To:     airlied@linux.ie, akpm@linux-foundation.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dvyukov@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
Author: Kees Cook <keescook@chromium.org>
Date:   Mon Nov 4 22:57:23 2019 +0000

     uaccess: disallow > INT_MAX copy sizes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125fe6dce00000
start commit:   51309b9d Add linux-next specific files for 20191105
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=115fe6dce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=165fe6dce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1212dc3ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f604ae00000

Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
Fixes: 9e5a64c71b2f ("uaccess: disallow > INT_MAX copy sizes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
