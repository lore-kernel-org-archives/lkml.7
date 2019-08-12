Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C62C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB25A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1Ukepgq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfHLWk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:40:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44807 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfHLWk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:40:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id d79so78164750qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=kdeR2ekazPPacbcNxY/1Vu/Or4DQHYsQYtQCeaE7Fv8=;
        b=1Ukepgq5x/sRZRBTKuW2bpxHjMqNBl9lA3fZd6ACoiOUlZrodm76pXyqZQHI6GOx+D
         xbi8W+2Hpek7iJlTtNsJ0n/GY3d0zOO/+hMncALdkrptGAausq8GAz02qlSLFUyGOnSO
         YlvcdLw19C5ddbsT4NyTYU2Ys9pnHk36jh3IQReKoKYk4E0NuhOsQtW4YkAswNeM+hwN
         VQ5jcq+D4+praHjSGgxeQNEdusvSTHHhoJudTQrpbNmO6PDHYQwVHDsGqtPCqCxOoq0D
         Sms3GbZiZCRjwtbV69MHRoIsDh6VqW7czkwAZ7TA/aKeQ3Gm2/2OKK1kdBPY20t8Bp+v
         6xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=kdeR2ekazPPacbcNxY/1Vu/Or4DQHYsQYtQCeaE7Fv8=;
        b=Q0HDMGdfgSqu5BAWi9McHcIrZ9mWWFocE59myjPJIhvvBGM1D6Vqxb78dM4ZLvjEYd
         4DPAx1h98YaKe6H5neujT0ZYHEoesNepOUvdQaqdSQmtcX1Y3iC1mnROh/SsMMBmqwgC
         2+Y5paRR+A0mmOCrdXCPrxSZk6Osab0+0togQB8hSK/0er7TDPho23ay+DYUl5Stmat9
         GHtT405utblruoJpI1Kbu1w1SWG04mwbz7haa0c2KtIeS2R/efF6/rLldD+/nFXVX4rx
         zh9lJsqY7brCrLqDedLDbbDdOG51m15LbFv2/3XpvtTBb79LNgp8Svt01qlSsjtGvDGp
         Qnmw==
X-Gm-Message-State: APjAAAVcvceg6CmowUaIuxcLrL0pMBsOm9nq5uvseoe0pFx9hFJ1D9YF
        73FiNjJP0Sj7B27/uNcs+8rzvw==
X-Google-Smtp-Source: APXvYqyxtPM7GqksDlKwbnRQDvRzu7ixT+BoGcvf6Isa5kkNd+JSjdxb275tOajGZo7sCTYRRLzmuQ==
X-Received: by 2002:a37:b982:: with SMTP id j124mr2940613qkf.251.1565649657128;
        Mon, 12 Aug 2019 15:40:57 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p23sm47935782qke.44.2019.08.12.15.40.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:40:57 -0700 (PDT)
Date:   Mon, 12 Aug 2019 15:40:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+193e29e9387ea5837f1d@syzkaller.appspotmail.com>
Cc:     arvid.brodin@alten.se, davem@davemloft.net, dhowells@redhat.com,
        dirk.vandermerwe@netronome.com, edumazet@google.com,
        jiri@mellanox.com, john.hurley@netronome.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in rxrpc_local_processor
Message-ID: <20190812154047.25d60679@cakuba.netronome.com>
In-Reply-To: <000000000000ac9048058ff3176e@google.com>
References: <000000000000492086058fad2979@google.com>
        <000000000000ac9048058ff3176e@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 15:32:00 -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 427545b3046326cd7b4dbbd7869f08737df2ad2b
> Author: Jakub Kicinski <jakub.kicinski@netronome.com>
> Date:   Tue Jul 9 02:53:12 2019 +0000
> 
>      nfp: tls: count TSO segments separately for the TLS offload
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d04eee600000
> start commit:   125b7e09 net: tc35815: Explicitly check NET_IP_ALIGN is no..
> git tree:       net
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=13d04eee600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d04eee600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
> dashboard link: https://syzkaller.appspot.com/bug?extid=193e29e9387ea5837f1d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159d4eba600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ba194a600000
> 
> Reported-by: syzbot+193e29e9387ea5837f1d@syzkaller.appspotmail.com
> Fixes: 427545b30463 ("nfp: tls: count TSO segments separately for the TLS  
> offload")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Is there a way perhaps to tell syzbot to discard clearly bogus
bisection results?
