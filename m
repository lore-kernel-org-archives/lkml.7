Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB1C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590C120673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Q0M7VWKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503802AbfIXBMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:12:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33668 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391158AbfIXBMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:12:05 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so332462ior.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WurY0QsNHWYkiFJ4lR2GQjTCrN87RBBfa7aeics4Cjk=;
        b=Q0M7VWKoV5rjTZeLA2vmGVSMaVNYmdrqmxP3B0AHcUah2M3W5weL+DUgxujncpcb6N
         CLfJo/eT9BH4VOMhCVLwiU/I8N2gQC9Ez+1KjACYwGijg0vNvpd6/OxFuNjpGfdYZzMP
         RcKbBglb507EIrc14PPRfcNNrclTVpUu1G03uro141H5hdS0McTI8EBZ4v7VJGV2x42l
         nLPw2l3+OmJI70wafbfAB3Q/KwN9CMdUgTILW+DJWX1gG0KjMePnIEJxr/8SgKGbxmD/
         mQp+ropOIQ94YpPCZhPUJQJVnPELzOSQcTlH7P1fIC+on0dKMiq0gh9J1uVyM3qTIOUi
         aqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WurY0QsNHWYkiFJ4lR2GQjTCrN87RBBfa7aeics4Cjk=;
        b=aU/F08cK+xfll3vrCnekkEGnmvfq4CxzI1uKxrW8s9e+8vbZXD9ILSm6OvoDHxp+av
         AEmVHD90nEyJNqyEiNmS9XzAvIlMhFhVXIw1xIABGrP1KlxV+X7V4zeKMJ+OaMW6Wv0c
         zK/iA3A5GSqtwfEuxbO7Cdm0/jW8Lt8NqFv1bFTe+VncmcOZHoSwwsRz7uz1mc53vn4S
         Hq66K960qL7wmZ5AR/KHIEOx1zRSdvrie+lbvlJKa7kjmn47bZnVITw8JpPvcMJsKLay
         ABzNJkQvxxVoDx19Oh+RotrzQ8aRDGUWgG+7s5Yp5FO+1gAGdn2OobJ/bTHagLrMOARu
         WmRg==
X-Gm-Message-State: APjAAAUlEcueDrLDhFpsZkurKGslHAlQ4EifEf0qkqpAsKe5jE7wZOm7
        90+sF+ZlkMXkbcjuhHvYPTsPERc/xMuRhQ==
X-Google-Smtp-Source: APXvYqybWr7zyyHyYIWo0HTehVh4lBYUMG22HH6yePjFtk09hfB0+TVoaIvLUqSre1Q4uV8E2tbuPw==
X-Received: by 2002:a6b:b487:: with SMTP id d129mr481268iof.223.1569287524116;
        Mon, 23 Sep 2019 18:12:04 -0700 (PDT)
Received: from [172.19.131.113] ([8.46.75.9])
        by smtp.gmail.com with ESMTPSA id m11sm275335ioq.5.2019.09.23.18.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 18:12:03 -0700 (PDT)
Subject: Re: [PATCH] writeback: fix use-after-free in finish_writeback_work()
To:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20190924010631.GH2233839@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3b98fe7-5f43-71a1-4734-4c6fe46bbca4@kernel.dk>
Date:   Mon, 23 Sep 2019 19:11:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924010631.GH2233839@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 7:06 PM, Tejun Heo wrote:
> finish_writeback_work() reads @done->waitq after decrementing
> @done->cnt.  However, once @done->cnt reaches zero, @done may be freed
> (from stack) at any moment and @done->waitq can contain something
> unrelated by the time finish_writeback_work() tries to read it.  This
> led to the following crash.
> 
>    "BUG: kernel NULL pointer dereference, address: 0000000000000002"
>    #PF: supervisor write access in kernel mode
>    #PF: error_code(0x0002) - not-present page
>    PGD 0 P4D 0
>    Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
>    CPU: 40 PID: 555153 Comm: kworker/u98:50 Kdump: loaded Not tainted
>    ...
>    Workqueue: writeback wb_workfn (flush-btrfs-1)
>    RIP: 0010:_raw_spin_lock_irqsave+0x10/0x30
>    Code: 48 89 d8 5b c3 e8 50 db 6b ff eb f4 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 9c 5b fa 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 48 89 d8 5b c3 89 c6 e8 fe ca 6b ff eb f2 66 90
>    RSP: 0018:ffffc90049b27d98 EFLAGS: 00010046
>    RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000000000
>    RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000002
>    RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>    R10: ffff889fff407600 R11: ffff88ba9395d740 R12: 000000000000e300
>    R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
>    FS:  0000000000000000(0000) GS:ffff88bfdfa00000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000002 CR3: 0000000002409005 CR4: 00000000001606e0
>    Call Trace:
>     __wake_up_common_lock+0x63/0xc0
>     wb_workfn+0xd2/0x3e0
>     process_one_work+0x1f5/0x3f0
>     worker_thread+0x2d/0x3d0
>     kthread+0x111/0x130
>     ret_from_fork+0x1f/0x30
> 
> Fix it by reading and caching @done->waitq before decrementing
> @done->cnt.

That's some nice debugging work.

Reviewed-by: Jens Axboe <axboe@kernel.dk>


> Signed-off-by: Tejun Heo <tj@kernel.org>
> Debugged-by: Chris Mason <clm@fb.com>
> Fixes: 30638b0125e1 ("writeback: Generalize and expose wb_completion")

This seems wrong, though:

commit 5b9cce4c7eb0696558dfd4946074ae1fb9d8f05d
Author: Tejun Heo <tj@kernel.org>
Date:   Mon Aug 26 09:06:52 2019 -0700

    writeback: Generalize and expose wb_completion

-- 
Jens Axboe

