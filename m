Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D4EC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB57724670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xPIWUQdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLFR64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:58:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38368 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfLFR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:58:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so5929146lfm.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7NoV/MZ+gAAoZ3Ywqfb6WiDTdgr5NlWMlKnaR0k7Lzk=;
        b=xPIWUQdV5LzJHwy1Das6+ElrkvtWT59j1TuYG5c0CnFe8LLvlFSbV1AtTFeH0eWFXm
         2HnkXvu4+LhaB/Yyc6Ebd3e9DMzQ73EOBA1BaGU3IKNO1wb/NW4fMm1QBsghglhTDEsh
         aXfN2NpslfWhdWrWWlqkiLSCx3qcUFW4tLvoU2mPH8fARaN/V9jIpo9b7v4OnPr5RxMY
         Kd7JixMDVB6cbCQF91N8w16hdQxNpvwTU7Aq9EhAY4NyuLPEXBLiEWN7kTZ0ZZaTyRpE
         fh+15LYfm2UTLuQdzbkGChhYwzZWsUZHpcmFNXb8TTHSPsKoU4uMeGzaLsOW6cZNteyT
         A7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7NoV/MZ+gAAoZ3Ywqfb6WiDTdgr5NlWMlKnaR0k7Lzk=;
        b=CzSFuWZxveElaJmMAYslKkpJI76mQ4QvsN7GZh6tXnn3VkPLMaR/m8+SMnBQKadgl0
         A8vSIJaPt7YBBhDaP4gokk1qB7zDhs9LkECzKIlBPpEUx4AUBW02xHICDq29BJwIkBYs
         dbmlXsVvUUYdFZ5EBgaZ3FZyb1bIcIvYRdQAb9zFN8rdxyXJeuXxsaZKwNBCemIP1e5K
         xLU5thpox0OEWGPSlgvUlbxvDYtSNtBbrrtDE6rKMwWn2YfQjfNeA5kvhljURgyDG4lD
         ciZ18frSItd4c9GI0zfNVrsIwvDTdif2h6eIjsE1Ux/6yOqS0XabJnut67SG3mdq3lhK
         1e6w==
X-Gm-Message-State: APjAAAW9Hjty63HAjRgpXKr7atRYq4RBswtk8uY2D89nqNwbe6uCAuw3
        nzPdu24aaYDvCFO6vs3HiH613g==
X-Google-Smtp-Source: APXvYqxjLx+wuStYVrUdLvIoHiJhniLWG67QUZ6v3B2GX1ZIkBURojsq0dmiv9FisfdZMreI2xy4vw==
X-Received: by 2002:a19:84d:: with SMTP id 74mr8623455lfi.122.1575655130609;
        Fri, 06 Dec 2019 09:58:50 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c9sm5959949ljd.28.2019.12.06.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:58:50 -0800 (PST)
Date:   Fri, 6 Dec 2019 09:58:39 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+5013d47539cdd43e7098@syzkaller.appspotmail.com>
Cc:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, dirk.vandermerwe@netronome.com,
        edumazet@google.com, eranbe@mellanox.com, eric.dumazet@gmail.com,
        john.fastabend@gmail.com, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (5)
Message-ID: <20191206095839.29d2024c@cakuba.netronome.com>
In-Reply-To: <000000000000fdad650599064dc5@google.com>
References: <00000000000054cc6d05834c33d7@google.com>
        <000000000000fdad650599064dc5@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Dec 2019 02:14:00 -0800, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit 9354544cbccf68da1b047f8fb7b47630e3c8a59d
> Author: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
> Date:   Mon Jun 24 04:26:58 2019 +0000
> 
>      net/tls: fix page double free on TX cleanup
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ebd77ae00000
> start commit:   9e9322e5 selftest/net: Remove duplicate header
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=47f2db597668ac40
> dashboard link: https://syzkaller.appspot.com/bug?extid=5013d47539cdd43e7098
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148763eb200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1416ff3d200000
> 
> If the result looks correct, please mark the bug fixed by replying with:
> 
> #syz fix: net/tls: fix page double free on TX cleanup
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: net/tls: fix page double free on TX cleanup
