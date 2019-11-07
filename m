Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC8C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1102077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfKGNmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:07 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44309 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfKGNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:05 -0500
Received: by mail-il1-f199.google.com with SMTP id 13so2642709iln.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rGCeFvT/AQARxs+6mGwlebmAqlHglnh6rUP8Pgma5SE=;
        b=EeSiBB4zcdokOv2ZUZNwcNvZ6M317dnsJnc637lMbgyMIc0G2MR1+ohAKdXXtpSnQU
         519BnzC4cIrsm0NoZe9kaakN4KJtcoMpUHdt1GLow1XNa1Wg9W6wSY0FJ46Zl+WcFTL4
         kj01mpW/i9mVmR7kSSAZRcYyjiSnlA8EeM9+t/LI4BONo2u+GIU1irfrHGt7vq+5LFIp
         +KCy+XL+LPudYTCkofstrcZo5cx2EdeH5B5mNXFTXR/s8yiKa6ufGdZmHfkmlAi5Ie+T
         FnnC0MnO+P8ncnLD+y9Ms0T/XiBp4lddHMgujSGw1o1K7IEx1dgvqIm7TizUDljS6ga0
         4Brw==
X-Gm-Message-State: APjAAAU3ObJnp75RX/HMIhHcbqY4rDrBgTV+uPBlffYkxnL+nvhu2Owv
        fhtVqfKOkReqNUU4NKlMlOTNDOYesgOE5DVKYF4lx3Mk0Q50
X-Google-Smtp-Source: APXvYqxHTBWUBJD+8E1NyDqdkz7hV5BSqgFdxPIDCKCY0BxMuoog4ra33v5nSn+Kxh1U5HB1IkGWjlzMWRyONaT5JSDK+u98616Z
MIME-Version: 1.0
X-Received: by 2002:a5e:d917:: with SMTP id n23mr3702806iop.28.1573134124661;
 Thu, 07 Nov 2019 05:42:04 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:04 -0800
In-Reply-To: <001a113fe6d081698f0568a5dcac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af44bb0596c1d4e8@google.com>
Subject: Re: KASAN: use-after-free Read in _decode_session4
From:   syzbot <syzbot+a7db9083ed4017ba4423@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sbrivio@redhat.com, sd@queasysnail.net,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit c6741fbed6dc0f183d26c4b6bca4517672f92e6c
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Thu Mar 15 16:17:11 2018 +0000

     vti6: Properly adjust vti6 MTU from MTU of lower device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1710f0dc600000
start commit:   0b412605 Merge tag 'drm-fixes-for-v4.16-rc8' of git://peop..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8addcf4530d93e53
dashboard link: https://syzkaller.appspot.com/bug?extid=a7db9083ed4017ba4423
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bf273b800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117045d3800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: vti6: Properly adjust vti6 MTU from MTU of lower device

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
