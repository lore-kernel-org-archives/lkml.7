Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2338C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C8521871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCTFVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:21:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:56852 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCTFVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:21:01 -0400
Received: by mail-it1-f198.google.com with SMTP id f5so449875ita.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9geYZ/ETSCiLBquOlYHg+QWiNjA7HTFC/bOSloCl7YY=;
        b=YctHIs6bxPqeyMBFhIQmUaI+q80eNAWBD76VPnsifnP9CtiZci09iO5kdgorG3ufMp
         f73aEY/Z1REVqJdlndTkbPSNRwT6167vIqfWiiwFZVqAgeegzgbx1VQo2cbQrpTuUP7a
         mf3xwj6deQvjOVWm5HHlcPZhEcETgHMclQHA4bizgBgVO0cnwAMsFpNPpEC1XIinz1Et
         e7E7RcdHp030186cipchIkCa24SIAbSa5EuQVWcM+9CLXBCDxi4woBdgtKR86LyvfY+7
         2gWiNr/SJeUgob33dsAm/UCUlQQtfnPgioG0ZTG/6387eKgpT02YGOWn7PXtlp80Qpq/
         GVqw==
X-Gm-Message-State: APjAAAU0Zogem86bnHTi+lS+CDUhQur5v2iv+9hW0fhXeHlqL9OuP6Jp
        ue7/EM5Cw36EAUCtXT3+aZSw1bsmGeNdVswDdaoC6k0vV8M1
X-Google-Smtp-Source: APXvYqzxyB/tyIlqMmbyrMnzb0EyYchghWE2XE+xX5mm26gb1hvIro80qUEQtvO3owxQq9R9omDB0/u1uiynD0Smo6oDpLHycJZJ
MIME-Version: 1.0
X-Received: by 2002:a24:ee41:: with SMTP id b62mr1604320iti.11.1553059260850;
 Tue, 19 Mar 2019 22:21:00 -0700 (PDT)
Date:   Tue, 19 Mar 2019 22:21:00 -0700
In-Reply-To: <0000000000004f8499057be95e1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ee87005847fc985@google.com>
Subject: Re: INFO: task hung in vhost_net_stop_vq
From:   syzbot <syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, weiyj.lk@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6b1e6cc7855b09a0a9bfa1d9f30172ba366f161c
Author: Jason Wang <jasowang@redhat.com>
Date:   Thu Jun 23 06:04:32 2016 +0000

     vhost: new device IOTLB API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1486ad27200000
start commit:   6b1e6cc7 vhost: new device IOTLB API
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1686ad27200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1286ad27200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=d21e6e297322a900c128
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141db34d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ef293400000

Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
