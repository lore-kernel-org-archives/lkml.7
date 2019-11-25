Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5746CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6AE20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="EzZ2Px6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfKYRkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:40:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38754 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:40:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so7716036pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 09:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PU2OcTJib2FEZCO1+EC6n/q7O1nFdX7GUda6zHMnWpk=;
        b=EzZ2Px6Zht5jTSbcT4wZXq7XoUzg3ELf9KnSjVfwZY6qPCXdLAs0Bud5oD73CKNWcw
         IogNuIZthU6pcXD47kbxJJcGlr3Z/x6kj7WsJzhaA91cHaEN9fugwnjFAm4j21cRPSoW
         xCYEqwIRZ3lNSZjaMV3U1PG0Gltb+Bws0aJPqmfPNgLunyrClUgttyvj/D+VCy0Ap3ME
         WGfc2FSr5LxwkXYhTO62ef3CVexOp18hgj4ilr9/0MgWT4oRk/I01c1yK9AXr8Z2OrzK
         TzueyAFcOa4PlaKzIm0SZ8iqf/wW/uiUlhiOZjKPAI50KoqSW223yXw9oDa5nKDO65Db
         21Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PU2OcTJib2FEZCO1+EC6n/q7O1nFdX7GUda6zHMnWpk=;
        b=BuIJcbdg6nR2KAb0U4/9/I3mieG3zONRNy6srbaXKrGqSDOmKRdA7viT3rDVYonuee
         2jubrIf9VQBGRyljBJlJ6/Dndcz2tY8kPcDz02NfiHq1t67LSwN02AqUu4YU68YG8kdm
         1TfzqHOCcEZ8Ll5b2JTRlDIFHFUu9InEkNcbrbZxvihY7pu/69kLQTSG/n0T8HXq/i8Q
         xAnOKPJZuI/LKvTPR/36LResx8M9pg3HkTAnBGmz6K6XgDYtSlF0e5UGeBoG+bV1a0HL
         EnjEddvaD4wDmocntC//vmFvCR9ZM8ys83n1SBny5fHxChVZJOaJ+dKSNsXK0/8LZBLg
         QKQg==
X-Gm-Message-State: APjAAAWk0u58rAGmVs0mQTcW3oqAcrXjy/2XF3Z/cIwgCTdeBl1n4/1P
        mXhBnSdqOVumnyxORQWjg4aSZw==
X-Google-Smtp-Source: APXvYqxtGVIhqBr/k4qZbkvbGJ/4yO/5Bkpqb+skwsxuP3qDbEWgyC1v/SGycn6AZG8kDPEo1sUP2w==
X-Received: by 2002:a63:a449:: with SMTP id c9mr33513974pgp.53.1574703604127;
        Mon, 25 Nov 2019 09:40:04 -0800 (PST)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id m6sm8935278pgl.42.2019.11.25.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 09:40:03 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:39:56 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+13e1ee9caeab5a9abc62@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        ilyal@mellanox.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: WARNING in sk_stream_kill_queues (3)
Message-ID: <20191125093956.58133ee8@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <00000000000093bc3b05982dd771@google.com>
References: <000000000000013b0d056e997fec@google.com>
        <00000000000093bc3b05982dd771@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 07:59:01 -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 3c4d7559159bfe1e3b94df3a657b2cda3a34e218
> Author: Dave Watson <davejwatson@fb.com>
> Date:   Wed Jun 14 18:37:39 2017 +0000
> 
>      tls: kernel TLS support
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127a8f22e00000
> start commit:   be779f03 Merge tag 'kbuild-v4.18-2' of git://git.kernel.or..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=117a8f22e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=167a8f22e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=855fb54e1e019da2
> dashboard link: https://syzkaller.appspot.com/bug?extid=13e1ee9caeab5a9abc62
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165a0c1f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114591af800000
> 
> Reported-by: syzbot+13e1ee9caeab5a9abc62@syzkaller.appspotmail.com
> Fixes: 3c4d7559159b ("tls: kernel TLS support")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looking at the repro timeline I'm fairly confident that
commit 9354544cbccf ("net/tls: fix page double free on TX cleanup")
stopped this. Even though it must had been appearing earlier due to a
different bug, because what the mentioned commit fixed was more recent
than the report.

#syz fix: net/tls: fix page double free on TX cleanup
