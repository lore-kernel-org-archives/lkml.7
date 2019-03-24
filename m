Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B447BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B665222D1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KHz7dNWS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h6qNMqUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfCXMKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:10:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:10:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A29CA60907; Sun, 24 Mar 2019 12:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553429407;
        bh=pGNez2YdNaCE0yrFF5gHb3gawdjVWj8QBy/WMgnL/c4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KHz7dNWSVtBczzuDgkADZJYrM29sfc9uKwa2uUJf2nAj50ONK2QYxf/e5/wVT19rj
         wmUADfzlPN6a4Zf/E2nIQ2FxSmDL/XvWbuVo7C2Ex310luOO/P8yutrug48qShyL/U
         1XPAZI351bu0HJnDKn6THRsoZJ9avGB5ypLMEA5Q=
Received: from x230.qca.qualcomm.com (37-136-86-22.rev.dnainternet.fi [37.136.86.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4767F6085C;
        Sun, 24 Mar 2019 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553429406;
        bh=pGNez2YdNaCE0yrFF5gHb3gawdjVWj8QBy/WMgnL/c4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h6qNMqUqfWBwl71e7oCdW0sGH1QrwRO/WYeBcmGmhNuJ9jb4QXxA1wzNCGB8A5rKS
         oM7StHydpdCwozMm38WNBXOCUPl10sxJRe1t3QOsiZmnZmqlQF4ri9xS8UAbwTnvDH
         rTMi2QEvUJuOx8vZ3+wT4EWVcZym9G2xMtA4ljIs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4767F6085C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     syzbot <syzbot+e1628a5e87492e6f1b76@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dledford@redhat.com, jgg@ziepe.ca,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, monis@mellanox.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Subject: Re: INFO: trying to register non-static key in icmp_send
References: <000000000000e560fa0584ccf44d@google.com>
Date:   Sun, 24 Mar 2019 14:09:59 +0200
In-Reply-To: <000000000000e560fa0584ccf44d@google.com> (syzbot's message of
        "Sat, 23 Mar 2019 18:25:00 -0700")
Message-ID: <87imw8mq20.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+e1628a5e87492e6f1b76@syzkaller.appspotmail.com> writes:

> syzbot has bisected this bug to:
>
> commit abd5f00844ec7fa507064ee4a22b3605c64c7d31
> Author: Kalle Valo <kvalo@codeaurora.org>
> Date:   Tue Mar 27 07:06:18 2018 +0000
>
>     Merge ath-next from
> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f9389b200000
> start commit:   4aa9fc2a Revert "mm, memory_hotplug: initialize struct pag..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11f9389b200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f9389b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> dashboard link: https://syzkaller.appspot.com/bug?extid=e1628a5e87492e6f1b76
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175c96ef400000
>
> Reported-by: syzbot+e1628a5e87492e6f1b76@syzkaller.appspotmail.com
> Fixes: abd5f00844ec ("Merge ath-next from
> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I highly doubt about the bisection result pointing to this merge. My
ath.git tree only touches drivers/net/wireless/ath and I can't see how
the drivers could cause the reported deadlock. I don't even see any of
the ath drivers loaded.

-- 
Kalle Valo
