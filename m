Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB8C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7932067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="P7J9rXIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbfIPOBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:01:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38588 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbfIPOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:01:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id u186so31667qkc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zh1bX/1pt4TvUaavYlPJEShmROopWHh3ioE9bzCUP2M=;
        b=P7J9rXIwnfzfF/WxR2mtgZBrbVFC0dfwlxMJGL81H0Iul4qihss7GyFcYxVVEX1Q8J
         kTtes2RCYeJhBhcVH9c/pOTRJciW4XYPOiEZDjunGiVzwO1hOii9eyUB31UkR8nAV2W4
         rqahpuZxN7rX8MtGrc9t1HrOP4J+rLrMqmV+Lk8BY6mviYqkM7C31exC4HKvPV+0Xoku
         DRnjDPE+Oh2tHlpLEQDLcQqonEsY0EhzufbAyml+xC8h/rzV2Z1+bMxPo/2v117MdH3P
         zbV5t7g/31TJrsxgtbRt3Zo077SpaVlTFoo7gqQwz91+rIVDS2vNNc6DRORFBOORWNUF
         yqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zh1bX/1pt4TvUaavYlPJEShmROopWHh3ioE9bzCUP2M=;
        b=SZzCB2cwv9iQGaEAPG/C2mu+vh0Nsisp8Pc3wvPbzdQBX9xu4F7PjgqUjcSx7tquJ9
         tCnJTjkogmZt/0DPD3oXUa2v1+ryVJ9ikubVdaqLGOThe0heZTAk+b2XbIMK7BposDjJ
         bV/fgCeV3jG7hF/S81IZ3YjlTXdPqRT1OcrIMkI/kj0sban73vyAfT8Kycp5qAJWkiIk
         PkzTT65BZsS29GIL0i8Q/XZfJX1bBA/j7wPDo8/loy0xVXkX4WDP30gnlmEIVr1i3GZV
         BMTpRSDTx0tYicfGL4rdKQ4epy/e7r+P+BTsn2mzuu9hbDM0GnFp9WgC6vpuzqvSDspL
         LtIg==
X-Gm-Message-State: APjAAAUxMo7RWRDyHiHWpxAFuazOjMPHtfnonPPw3UooAQnip9Q5u3MQ
        t+7V+qbDaVCfAO/srbAjYzVFNA==
X-Google-Smtp-Source: APXvYqwuBCZ2NutJluSdfnmZwv5tJRl2t2BmHssSEPJ5DNdSJIRusGDB8RsgrPPn1JrYcTVmWdTVcg==
X-Received: by 2002:a37:6554:: with SMTP id z81mr43102qkb.107.1568642489481;
        Mon, 16 Sep 2019 07:01:29 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i4sm12548097qke.93.2019.09.16.07.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 07:01:28 -0700 (PDT)
Message-ID: <1568642487.5576.152.camel@lca.pw>
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
From:   Qian Cai <cai@lca.pw>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        peterz@infradead.org, mingo@redhat.com
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, thgarnie@google.com,
        tytso@mit.edu, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Mon, 16 Sep 2019 10:01:27 -0400
In-Reply-To: <20190916090336.2mugbds4rrwxh6uz@linutronix.de>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
         <20190916090336.2mugbds4rrwxh6uz@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 11:03 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-13 12:27:44 [-0400], Qian Cai wrote:
> …
> > Chain exists of:
> >   random_write_wait.lock --> &rq->lock --> batched_entropy_u32.lock
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(batched_entropy_u32.lock);
> >                                lock(&rq->lock);
> >                                lock(batched_entropy_u32.lock);
> >   lock(random_write_wait.lock);
> 
> would this deadlock still occur if lockdep knew that
> batched_entropy_u32.lock on CPU0 could be acquired at the same time
> as CPU1 acquired its batched_entropy_u32.lock?

I suppose that might fix it too if it can teach the lockdep the trick, but it
would be better if there is a patch if you have something in mind that could be
tested to make sure.
