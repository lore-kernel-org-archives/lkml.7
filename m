Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643FDC10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A98F2083D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfCWG6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:58:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55838 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfCWG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:58:01 -0400
Received: by mail-io1-f69.google.com with SMTP id z19so35750ioc.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 23:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+jHD7zt1qXUVETzDrb4TXsejELYIvphHth1sfbXCJ4A=;
        b=ADv5MJw62HaxKGLXy/Y8Yi8zHBYJbdZuf1bRQ9hf36VDMghXP5UZZYkoFA4sXjE+sh
         h9oVhDp+Mf2SZWy98guTcC3o73QUZQEyR+89++lnXwq0svW4vhKVl/XVXGlKdLJqi35G
         CYlLUF+0b+uXNcHFeouh4m4e2LOS7qvWwQLmIgjG/eFdYeR9jWS0GzcWU2Bp5oyf4d7F
         6wZGlbCRst8B6QLspPGdNtlRxg2E7AqHg+Z7HnN9x6MqEGPVY3mSOOmBA+lQqqJXsw1L
         +SGgb4c0kck3N3ldveoApe/Z0KedRkm05SK32of1RFmEXA/8QBJ8XfvTP4HVoMoSxEHt
         3zsQ==
X-Gm-Message-State: APjAAAXdQQZoDIIiHgtH9fh5nM8tDT8Xog8TEYPsQNsv84aF5WWA/yCI
        KJMFFKzp1htDf+1eEJBZ6L/tuzJEBzuQen/KXili1sDTV5Kc
X-Google-Smtp-Source: APXvYqywqECM9/Qy92UXMEsDYx1iP1dfg9HZOliwz/kdC2P/qr0XuINM0xz3ri0JvJsG92CT7IWy2/Am1ma+Blh3R0ZglJZjHXnS
MIME-Version: 1.0
X-Received: by 2002:a5d:8597:: with SMTP id f23mr9525256ioj.148.1553324280668;
 Fri, 22 Mar 2019 23:58:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 23:58:00 -0700
In-Reply-To: <00000000000033ebee0577262a98@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8654a0584bd7d5d@google.com>
Subject: Re: INFO: task hung in process_measurement
From:   syzbot <syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com>
To:     airlied@linux.ie, dmitry.kasatkin@gmail.com,
        dri-devel@lists.freedesktop.org, james.l.morris@oracle.com,
        jmorris@namei.org, jsarha@ti.com,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tomi.valkeinen@ti.com,
        zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8fe5616b20e5742bb5fee0e77dffe2fc76ac92a0
Author: Jyri Sarha <jsarha@ti.com>
Date:   Tue Jun 14 08:43:30 2016 +0000

     drm/tilcdc: Restore old dpms state in pm_resume()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10daff1b200000
start commit:   291d0e5d Merge tag 'for-linus-20180929' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12daff1b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14daff1b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8212f992609a887
dashboard link: https://syzkaller.appspot.com/bug?extid=cdc562bc26a2b2b0a94f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e285e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1237fe81400000

Reported-by: syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com
Fixes: 8fe5616b20e5 ("drm/tilcdc: Restore old dpms state in pm_resume()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
