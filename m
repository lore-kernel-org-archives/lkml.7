Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25117C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA4C20838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H6mwJP3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfLJWLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:11:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45156 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbfLJWLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:11:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so16961643otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSKHjYgVXPlCtWKcNtNTh1vGxe8+YnF4aFxtCgHQkqI=;
        b=H6mwJP3szbcrHV0L5CCnmkWCAoaddD0zQE1e/J1v2E8TO1Xq67ygQDZE6pEjP3j762
         Qve11GKLwOMxQOKTrO0xVM+pI9CKkl/N6E0YRtkgH6mL+zByb0WURtxXTMcWlwvh9ZjZ
         dqDfkvmxnNukVuIlBdlHurgCdj7jFCU7wEyFOrK8UyY6X5+Zu9F22DTWLRDKWSIYdkJ7
         ahKrFJ7bkhLvfRXYZY86Ko6/OBPFhEo/zgpN4Wk/LrpmtOihqDs/HqAQdP0KeyAO3xCv
         vIn3ugrDALs/rHuA2Kq4CNzYtQGGwqYb3uRUHAXIii7cx89V4DARWheEwMmXky+ejX+w
         XKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSKHjYgVXPlCtWKcNtNTh1vGxe8+YnF4aFxtCgHQkqI=;
        b=ZZBjxkSIyOLoDRYeX/Dr7drN67HmGHaeM8oChIdZT3hLGSAH6tyeJInYu9liHiYqJo
         ok/3HvCVUhl4WCDX2A/TBWQANm8XDliRT7M+mznq5pnCK/W3B25B4XHYYY74/itKtEPg
         eMCnfbpVN1B5eJCTEjsiwjwz6AO9nIg7+PHDxhgGK3cdsxYctQILh9HczE/2CzzuEpjF
         Mh+EGBjfMlA39rYTC2B5rrnnFygl7TPnbN/7xjCNPEy0yHkVPk2B0sRLZMFL7ibA6KOu
         MYSkBDBkZQ1wndX/2nsq451XLTdiawMSyr/qvdLQbksy+ABr1Wzim0GXleYvQ35xSQn5
         TAVA==
X-Gm-Message-State: APjAAAUcWKggVkF6u/bEaYHcEfpYkK7ibnv0F9tksUvNKpWpcL2TNTBX
        HsQEecoADdRdbJhZkp6Yy4er+Aj7n4bVpw==
X-Google-Smtp-Source: APXvYqx3dsMqGrQ9+KOyqrcwDpDXDa7GifVMgMbRs2EWOTfWSKiuA9uSWVcTGCCbC0kx2MHZI9ytcg==
X-Received: by 2002:a9d:6a4c:: with SMTP id h12mr22065otn.81.1576015863860;
        Tue, 10 Dec 2019 14:11:03 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id t7sm64608otk.6.2019.12.10.14.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 14:11:03 -0800 (PST)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ienif-00002g-QL; Tue, 10 Dec 2019 18:11:01 -0400
Date:   Tue, 10 Dec 2019 18:11:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+68dce7caebd8543121de@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, ast@kernel.org, boqun.feng@gmail.com,
        byungchul.park@lge.com, daniel@iogearbox.net, davem@davemloft.net,
        dledford@redhat.com, kernel-team@lge.com, kirill@shutemov.name,
        kuznet@ms2.inr.ac.ru, leon@kernel.org, leonro@mellanox.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, mingo@kernel.org,
        netdev@vger.kernel.org, npiggin@gmail.com, parav@mellanox.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        walken@google.com, willy@infradead.org, yoshfuji@linux-ipv6.org
Subject: Re: KASAN: slab-out-of-bounds Read in ip6_tnl_parse_tlv_enc_lim
Message-ID: <20191210221101.GA147@ziepe.ca>
References: <0000000000005175bf057617c71d@google.com>
 <000000000000e22b3c059960bebd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e22b3c059960bebd@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:08:01PM -0800, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit 30471d4b20335d9bd9ae9b2382a1e1e97d18d86d
> Author: Leon Romanovsky <leonro@mellanox.com>
> Date:   Sun Feb 3 12:55:50 2019 +0000
> 
>     RDMA/core: Share driver structure size with core
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b7bb7ae00000
> start commit:   3a5af36b Merge tag '4.19-rc3-smb3-cifs' of git://git.samba..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c4a80625153107e
> dashboard link: https://syzkaller.appspot.com/bug?extid=68dce7caebd8543121de
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1068a44e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146386c6400000
> 
> If the result looks correct, please mark the bug fixed by replying with:
> 
> #syz fix: RDMA/core: Share driver structure size with core
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Seems pretty unlikely

Jason
