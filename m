Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEFF206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfCKN1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34169 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfCKN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:27:02 -0400
Received: by mail-io1-f70.google.com with SMTP id b14so4129397ioh.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VWU2m1RX7iavw4kVeCgSMRa3DS+moozJh66YQJgHQ3A=;
        b=cVyifISMEB2eqime4DqQAzqyjlVBA1Wj/fuYuLWTvtRTqYG/z+K/6TeoQcbfC8uZhA
         d6z180Fd36Wdg7T34JbOx6oNIXyj2g4chPza4Mju357zVNk+QfrY7duCBVZIH7qVx9K3
         bZcx0fVznAb9ZlQT9dSszeCsl77WkzPP0P5GCAqTkgaYvdKzkL8rashugYyxi/eFgzX7
         w6EXzi18i0ayQKNnP5KhaCowBsVV+0JA3EBnU/FfdZnCOvd3rm3x7j2uclOUHHIs45aC
         n+nDdU3qXe8OJ3NlPpTmMSuJZT01woPgOQKA/6hLW66lc7EvTuvOJmbEPzRlboQGAr1a
         hC3A==
X-Gm-Message-State: APjAAAX4/Pym9gtWK22HYVEt+h+Tqg1/qeVrJg096Y43k0afX2yQLQ2B
        aVCa5O7uOfCbSBzjQs+MEi7Smbm5/zEWO+GELM6QrJSNNrN4
X-Google-Smtp-Source: APXvYqwm4uXQhbjcZTwO5Da1no3X8pfd9NYxhICDb8AGRq9UsI9ZT+NJ75gTDI36NNkcPf/bTUZc6/ptphC0i4L3HgtzFJDv/PC5
MIME-Version: 1.0
X-Received: by 2002:a24:152:: with SMTP id 79mr20568631itk.25.1552310821285;
 Mon, 11 Mar 2019 06:27:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:27:01 -0700
In-Reply-To: <00000000000033d5e205801b05d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015781e0583d18794@google.com>
Subject: Re: general protection fault in rxrpc_connect_call
From:   syzbot <syzbot+7966f2a0b2c7da8939b4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 46894a13599a977ac35411b536fb3e0b2feefa95
Author: David Howells <dhowells@redhat.com>
Date:   Thu Oct 4 08:32:28 2018 +0000

     rxrpc: Use IPv4 addresses throught the IPv6

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107ecf23200000
start commit:   46894a13 rxrpc: Use IPv4 addresses throught the IPv6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=127ecf23200000
console output: https://syzkaller.appspot.com/x/log.txt?x=147ecf23200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=7966f2a0b2c7da8939b4
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dc0930c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f3766b400000

Reported-by: syzbot+7966f2a0b2c7da8939b4@syzkaller.appspotmail.com
Fixes: 46894a13 ("rxrpc: Use IPv4 addresses throught the IPv6")
