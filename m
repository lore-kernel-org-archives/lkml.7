Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A7CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1832073F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfDLGoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:44:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34905 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDLGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:44:01 -0400
Received: by mail-io1-f71.google.com with SMTP id k2so7043327ioj.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 23:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nvp7ztOb1eozq3DPwMRJnm+OrNK0VnZje3xTWjckm/M=;
        b=ZNYOu48M5p9qMYlV6Mv9zfpmIynTuBubUgOI5cw2aEgo6miHznzE0YfUGPABBkMZsg
         lFOgLqjIZ4vvQlHqNlBji2BltR95BWZHgrTn9ZZUgBg8b0ngn+c92LM1Zp6T0oWNfozI
         R8w9ZtnLPEnce9kBr1ANny1w36LBDQWM7PDuOy/i4axOxxO+9CXOSbVmkG/tvL6l+u6A
         7uvW5h5zCdjYDJmU5U5slytLtaWncZ2a2bMTiTwBhvzdaeuDq8vGQR9Si+Onb2TuCb+p
         spGWiz6iiHJHmV0D+d3VyjH7UTDXnZN8B8pT/V9IGNVSx0LeopZ6dNMvOlce/OBVZjbc
         UEQw==
X-Gm-Message-State: APjAAAWYUWU80uciUh2th8ogILqym5stvlJpFOSo4Rn+7gItmpXEsRIB
        Z254ymSpU5MIQoWUbDdcaNIefs0yocbQm5MmTTSw+9Qwd5Gm
X-Google-Smtp-Source: APXvYqxmW56SWtZY2McV4W+bxn5Ag3GW6Qb2Q3mJnZCdGa1f+Z4xfPcY7s/GS26I/WPCF917ncZHDCxcktJW2P01+l2htdhOSdEp
MIME-Version: 1.0
X-Received: by 2002:a24:4645:: with SMTP id j66mr3359001itb.24.1555051441008;
 Thu, 11 Apr 2019 23:44:01 -0700 (PDT)
Date:   Thu, 11 Apr 2019 23:44:01 -0700
In-Reply-To: <0000000000002b42040573b8495a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfb6c405864fa081@google.com>
Subject: Re: WARNING: refcount bug in igmp_start_timer
From:   syzbot <syzbot+e28037ac1c96d2a86e89@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, benjamin.gaignard@linaro.org,
        cmetcalf@ezchip.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vincent.abriou@st.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit fc5e9d63a8db40e9e3a3b180be33d44af8a3cee8
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed May 24 14:52:05 2017 +0000

     drm/sti: Drop drm_vblank_cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f62c2d200000
start commit:   ae596de1 Compiler Attributes: naked can be shared
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=100e2c2d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f62c2d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=e28037ac1c96d2a86e89
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178537da400000

Reported-by: syzbot+e28037ac1c96d2a86e89@syzkaller.appspotmail.com
Fixes: fc5e9d63a8db ("drm/sti: Drop drm_vblank_cleanup")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
