Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA10C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E36521726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfCaExC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 00:53:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52778 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfCaExB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 00:53:01 -0400
Received: by mail-io1-f69.google.com with SMTP id p143so5316179iod.19
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 21:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Z67mpu4tEpxV36iCPVLfT3t/z3ZTLgxfFfuo1ocJAXY=;
        b=IocGotpegg3u6vMivyNC5VhRqkL6v5q22V5BoCRlZ6kehtOiRHF3kpqBW31mZhJTGr
         WU1l2lbCHFT2dLmuakcPbmv5MkajUVLr8kQfAcnuev2hbyiqOhdRRtfGNHufaDsNqF0J
         3HnKsn91RSTD9WL7dKyE/KhlZ/En8HwXLeWQzNfmFbs2TpSL3XLBh/Ux+EM5FATia1Yy
         FHqRVMApfIEm5KdYiJZPaa3cOiBSlxUydfUqT/8PvjF0k4CsnvNjWprR3ZZxmQ2T7DfW
         AUmF1Wz1MT8vGbhV3BWERyLfWBUEOBYZRfSGsMe77ZY3FWL1aeWqWG7HG9fmzIiLqUK2
         wX+Q==
X-Gm-Message-State: APjAAAU17/USZmb57OiDFfvw5qWXZJYKIkueMfMjEsYQ6FkkVfZM+o+H
        GgVGLN327mTcEuYzwXoj6SsGKBzRFX7NGWcFcajh+T1FVqq9
X-Google-Smtp-Source: APXvYqwEA628FBlca0dGEPjIDQ2a4ByT8B+b2V7tikVoBJpvlh0rDQXWRFX1G2Ph74UxOodxWyiVFsWef62dWrNU7jviQMGNFNpE
MIME-Version: 1.0
X-Received: by 2002:a24:9884:: with SMTP id n126mr4488087itd.30.1554007981084;
 Sat, 30 Mar 2019 21:53:01 -0700 (PDT)
Date:   Sat, 30 Mar 2019 21:53:01 -0700
In-Reply-To: <000000000000b239d705736497a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ddb205855cad54@google.com>
Subject: Re: WARNING in free_loaded_vmcs (2)
From:   syzbot <syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com>
To:     dvyukov@google.com, hpa@zytor.com, jmattson@google.com,
        karahmed@amazon.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8fcc4b5923af5de58b80b53a069453b135693304
Author: Jim Mattson <jmattson@google.com>
Date:   Tue Jul 10 09:27:20 2018 +0000

     kvm: nVMX: Introduce KVM_CAP_NESTED_STATE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fba63f200000
start commit:   60c1f892 Merge tag 'dma-mapping-4.19-2' of git://git.infra..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1407a63f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1007a63f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=01bc9e7a8a3f138b71cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6513e400000

Reported-by: syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com
Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
