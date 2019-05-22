Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D068C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5557121841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfEVDQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:16:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:44074 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfEVDQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:16:02 -0400
Received: by mail-it1-f198.google.com with SMTP id o83so796704itc.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 20:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3nIzlGw+4wszd7mCGI8udFQIKx5mXZuEZdlx7TUEr8s=;
        b=UIKumpIgP/N2coyPB/n489/gQ2ESSORUfeDlcky4rb8BghnkvnVuxMFnbCNNTc1x10
         3BcyiVGLT+iypa2PUBtIeD3/ONKTjhGpAdCAVeS0NiSt91qftr5urfM+0X6RGjSqtzzD
         B/eoV5H8NZAxeRv/YRbCnByVbvV+tRxwbXJS8mhDGHbrXs1Mb1Qv/4IisBpmrrrZ2lok
         D/ixxQGpFp1jyU+qJYXBv+VFevMps6qRJbocznOn11CrV8Mrz5wsAH0LSvtQqTkG7Mhv
         FgvLaGgl94ZmvsqGZAu0nB8Ah0e2jyQQmLqWyL8aUugceNC3M5Py9dH/FGikb9KFE7/y
         JEmA==
X-Gm-Message-State: APjAAAW6EDtLeOUTLuJAxTG1WE4j9iN7hBzwkss/GeXWdEPY0DOVY/et
        xFv6LEBUZ6sUQOmtXUm/Gtz3whHbUictjeChDHZU0/vBO09K
X-Google-Smtp-Source: APXvYqxp+o+WQM7bTF4SCjOC36sALTlwx1QmJGZsN4sPxGpKCkBFjyv3EMuUBqqVKn8wzyZnUI3z37a7vKmMtQ7mfrLWFQqBAHmU
MIME-Version: 1.0
X-Received: by 2002:a5d:9d4f:: with SMTP id k15mr7079076iok.100.1558494961163;
 Tue, 21 May 2019 20:16:01 -0700 (PDT)
Date:   Tue, 21 May 2019 20:16:01 -0700
In-Reply-To: <00000000000033a0120588fac894@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b645c058971629b@google.com>
Subject: Re: WARNING: locking bug in inet_autobind
From:   syzbot <syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com>
To:     Yong.Zhao@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, ast@kernel.org, bpf@vger.kernel.org,
        christian.koenig@amd.com, daniel@ffwll.ch, daniel@iogearbox.net,
        davem@davemloft.net, david1.zhou@amd.com,
        dri-devel@lists.freedesktop.org, evan.quan@amd.com,
        felix.kuehling@amd.com, harry.wentland@amd.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ozeng@amd.com, ray.huang@amd.com,
        rex.zhu@amd.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com, yong.zhao@amd.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c0d9271ecbd891cdeb0fad1edcdd99ee717a655f
Author: Yong Zhao <Yong.Zhao@amd.com>
Date:   Fri Feb 1 23:36:21 2019 +0000

     drm/amdgpu: Delete user queue doorbell variables

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1433ece4a00000
start commit:   f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1633ece4a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1233ece4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=94cc2a66fc228b23f360
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163731f8a00000

Reported-by: syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com
Fixes: c0d9271ecbd8 ("drm/amdgpu: Delete user queue doorbell variables")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
