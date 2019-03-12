Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E88C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C904A214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCLD7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:59:01 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:59323 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfCLD7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:59:01 -0400
Received: by mail-it1-f198.google.com with SMTP id 9so1062518ita.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Rg1C2aX0HyUdcFpVwU4EWVeEJy42p9kXBaO9Wh8/VOs=;
        b=XZDNkkwutIAN/Qt9ij64PgTtXDsgBxijsZtp6nKkk5AhUyLP78jsYBO+LDJF6KryxR
         i07jrbwHKlnzyT186EeRKJdBxULZ+i/oIJ8L/45JYHkRVuzouR6Al49F1Bdqt+JwD6CG
         jgqIFvgww9fmDakE6PlLeaRBzLbb5GHmzdd3agR8HvgGfTRq5FmpMEoVf9HMgBf7K7hQ
         whTii1W4bKyEx0nw+KajewmRhC4G718+BFMnGsOY+rX60J+buhhFpu949HqrDoqJUOPJ
         Ep+2IwibG4XwSpRnHae3+8UtNEreB6sf++Y6EWv54op+wyd4YNWti18LutbZDH531q0T
         kTxw==
X-Gm-Message-State: APjAAAUPhkS3WthGHJCQejHTsb6JKWriVkbHS1sWM9oTpAK0LgpJFikr
        aRhOfHC3mbE331FR1sL+3iksA+OyTfDagivCzlq6UND81gVM
X-Google-Smtp-Source: APXvYqwx9h7KDCPuvh+6fEd+XQtf2O1zRoUBFtwZYLOb127vefqqt6zi0UA2Qkz2LYFWcqyT1Fnl/+4tGtcpRf0Lowm6YM5gcQBt
MIME-Version: 1.0
X-Received: by 2002:a24:6283:: with SMTP id d125mr833066itc.14.1552363140443;
 Mon, 11 Mar 2019 20:59:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 20:59:00 -0700
In-Reply-To: <00000000000010b2fc057fcdfaba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c75b50583ddb5f8@google.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
From:   syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>
To:     airlied@linux.ie, akpm@linux-foundation.org, amir73il@gmail.com,
        chris@chris-wilson.co.uk, darrick.wong@oracle.com,
        david@fromorbit.com, dri-devel@lists.freedesktop.org,
        dvyukov@google.com, eparis@redhat.com, hannes@cmpxchg.org,
        hughd@google.com, intel-gfx@lists.freedesktop.org, jack@suse.cz,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, mszeredi@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, peterz@infradead.org,
        rodrigo.vivi@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 34e07e42c55aeaa78e93b057a6664e2ecde3fadb
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu Feb 8 10:54:48 2018 +0000

     drm/i915: Add missing kerneldoc for 'ent' in i915_driver_init_early

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13220283200000
start commit:   34e07e42 drm/i915: Add missing kerneldoc for 'ent' in i915..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a20283200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17220283200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abc3dc9b7a900258
dashboard link: https://syzkaller.appspot.com/bug?extid=1505c80c74256c6118a5
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4dc28c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15df4108c00000

Reported-by: syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com
Fixes: 34e07e42 ("drm/i915: Add missing kerneldoc for 'ent' in  
i915_driver_init_early")
