Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F269C46495
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D5218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2h82MMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfGDVPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:15:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44214 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDVPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:15:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so7038754otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MQQ07rB52HYdqZ61pXH1qpFuHoSeCNE8eQWm5DgwWXQ=;
        b=e2h82MMxM5QusbuIi3nIbhQZEHtR5kFU/nUkkFZx5sWrINuwT/dfST5LGTGrdk0of0
         Rxutpk8embd/ZBpeCuB4tF2xstGtmG3VhwWYmzEgblCfleeE1WJyQbpvzU7CTc7azKiH
         1clDKRW77SjF7lLqXyEQlgH0LF6A0i58ndW2LtlPMyT7Gcvf2aWACIGJwAHPGNDiTi3O
         HcvqV6iu+Eb9yIOndD22y66tjf2hG9i5gjODvkaLAnLrKf2cw3bavtwQRgwfAlGyRNTm
         qmiBMYH8jFIXRWcRMnYUovXZ6h6iAIuC/vlo4Vz+Euk37hR4t8wr1fIG7e/o6Cq8AMm3
         Eh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MQQ07rB52HYdqZ61pXH1qpFuHoSeCNE8eQWm5DgwWXQ=;
        b=to+zm20BuRnz0Jfl+UwGT0GeVUASsyaAgSmIvi8ml9IY2iGkU7zBysi53+0SzgHzwS
         TFzRX4CkzNltAUV6zDmvd9ZRgPGiuhIYcet37fChpojrBcAVJ8Jad7xu/yp06prtVCGw
         l7z4kECOKU3tiOylI9SJPGTbowDgAyDvMpiVOOI1oQxiS7NNiIvNu+ZDynx9kwuuYVic
         25l1PitEuAirJCZa6LCTcVXwbKaah/GhBaSHvsCllJeErE+95dVliGCAN4ddmzszgwMR
         IluImZlcEbEW/35wqorK78i0aJLHe9L6rOrOJf3pc2U9WMCh4+8ADhc5WdDOFmE7Nsmw
         2W2Q==
X-Gm-Message-State: APjAAAUXLKUE0cZ7uYVnD2O0flPv4jdmWiUNMV/rao+JG1pkTDpqaXa6
        J5+5y3hDVfYp+ViHYQWywhUi6g==
X-Google-Smtp-Source: APXvYqxsMa7vLQ93NSh84aEkmHW8QFIZWysP4vFr0NJkhQd2Eo1hNKRNG91e9aM9VDX4aae3UBAGAg==
X-Received: by 2002:a9d:bcc:: with SMTP id 70mr62005oth.210.1562274952935;
        Thu, 04 Jul 2019 14:15:52 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r25sm2277692otp.22.2019.07.04.14.15.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 14:15:51 -0700 (PDT)
Date:   Thu, 4 Jul 2019 14:15:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>,
        axboe@kernel.dk, hch@lst.de, peterz@infradead.org,
        gkohli@codeaurora.org, mingo@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] swap_readpage: avoid blk_wake_io_task() if
 !synchronous
In-Reply-To: <20190704123218.87a763f771efad158e1b0a89@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.1907041408040.1762@eggly.anvils>
References: <1559161526-618-1-git-send-email-cai@lca.pw> <20190704160301.GA5956@redhat.com> <20190704123218.87a763f771efad158e1b0a89@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019, Andrew Morton wrote:
> On Thu, 4 Jul 2019 18:03:01 +0200 Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > swap_readpage() sets waiter = bio->bi_private even if synchronous = F,
> > this means that the caller can get the spurious wakeup after return. This
> > can be fatal if blk_wake_io_task() does set_current_state(TASK_RUNNING)
> > after the caller does set_special_state(), in the worst case the kernel
> > can crash in do_task_dead().
> 
> I think we need a Fixes: and a cc:stable here?
> 
> IIRC, we're fixing 0619317ff8baa2 ("block: add polled wakeup task helper").

Yes, you are right.

But catch me by surprise: I had been thinking this was a 5.2 regression.
I guess something in 5.2 (doesn't matter what) has made it significantly
easier to hit: but now I look at old records, see that I hit it once on
5.0-rc1, then never again until 5.2.

Thanks, and to Oleg,
Hugh
