Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3939F222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xl1Qun6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbfIRUAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:00:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38871 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbfIRUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:00:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so1281245qta.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgQ/PSk6s69IhIN3kvOl/nhDuvC2PFBPkZWWeBSDsGs=;
        b=Xl1Qun6EPEyvqTdKGERpDMNRYpTRFOq7YiV8XD0S2EmdmsptfOtLQd53pPMRs40OsP
         Zfy9SjE2m8yQ9aWYolH6euB+a9FwQpsK7Y2+IMqatO6MEdnrnCphSqpamfRBRAwMa/nW
         8vU3taJ1EUfiqL3F/p7jpVoT241bFVBCtNH22U5s8Ej7yj7vaQABp30uutX/vzYonf9A
         9lietmj1MbgOxYk5/tAT+6ERo8V7SOxyrePvTp4zvn3KLSn+JgvNajPuc5CGITRKlQjg
         yF174PcmWCm0KjNteIID1GoKRcbgW+VoVImpMVdVv2Pcx4CtCLT6ViBXF8Y8z5y6CXU/
         5IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgQ/PSk6s69IhIN3kvOl/nhDuvC2PFBPkZWWeBSDsGs=;
        b=EAe+99SKIA0LuT7C197Wpm35QK+T/HggXhQYRF1CHgrG5Ka2//UiAhHbQXijEGO/Nj
         /eBCk76yJ4PEBjI7nuFLzFXmEJmmzpV3m0gJlM5HSCDO3tPjlyd7uqtcVZOozuVXjUR2
         sQhnY2rLE4CJV+doyGAhPS6ZVkKDxkaAYZlwyUnnsWUG5cPhdDLiGPHUiTb+wG9yGyyW
         I17KSbna5hSF2fxtdMvsk264D8lC70WTZMPIX3Nk3flJUQlqiq/CvsoQoGdS3rfGxnWV
         6C1YsEhkcPIO8/qMk7Y2XgBI/z0L2mQ33H/kIX9VlmxJ0KEJApe8WjW2bd87U+dv5k7F
         b3dw==
X-Gm-Message-State: APjAAAXeB+BFsH2fJwxqv+spjHlgop7htpaQ5xcas2orC9vyjnxqBf7M
        dh0yN2m1cN/KUp2VbGg2gUYnHw==
X-Google-Smtp-Source: APXvYqx7ylgOdwTwai485piXcLjFj5zgpjU/OumbjBfWNGW3uR90d7CFqs4O9RiBxseGmXqWFaFurw==
X-Received: by 2002:ac8:16e2:: with SMTP id y31mr5909119qtk.370.1568836800501;
        Wed, 18 Sep 2019 13:00:00 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q207sm3616779qke.98.2019.09.18.12.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:59:59 -0700 (PDT)
Message-ID: <1568836797.5576.182.camel@lca.pw>
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
From:   Qian Cai <cai@lca.pw>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Date:   Wed, 18 Sep 2019 15:59:57 -0400
In-Reply-To: <20190917071634.c7i3i6jg676ejiw5@linutronix.de>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
         <20190916090336.2mugbds4rrwxh6uz@linutronix.de>
         <1568642487.5576.152.camel@lca.pw>
         <20190916195115.g4hj3j3wstofpsdr@linutronix.de>
         <1568669494.5576.157.camel@lca.pw>
         <20190917071634.c7i3i6jg676ejiw5@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-17 at 09:16 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-16 17:31:34 [-0400], Qian Cai wrote:
> …
> > get_random_u64() is also busted.
> 
> …
> > [  753.486588]  Possible unsafe locking scenario:
> > 
> > [  753.493890]        CPU0                    CPU1
> > [  753.499108]        ----                    ----
> > [  753.504324]   lock(batched_entropy_u64.lock);
> > [  753.509372]                                lock(&(&zone->lock)->rlock);
> > [  753.516675]                                lock(batched_entropy_u64.lock);
> > [  753.524238]   lock(random_write_wait.lock);
> > [  753.529113] 
> >                 *** DEADLOCK ***
> 
> This is the same scenario as the previous one in regard to the
> batched_entropy_….lock.

The commit 383776fa7527 ("locking/lockdep: Handle statically initialized percpu
locks properly") which increased the chance of false positives for percpu locks
significantly especially for large systems like in those examples since it makes
all of them the same class. Once there happens a false positive, lockdep will
become useless.

In reality, each percpu lock is a different lock as we have seen in those
examples where each CPU only take a local one. The only thing that should worry
about is the path that another CPU could take a non-local percpu lock. For
example, invalidate_batched_entropy() which is a for_each_possible_cpu() call.
Is there any other place that another CPU could take a non-local percpu lock but
not a for_each_possible_cpu() or similar iterator?

Even before the above commit, if the system is running long enough, it could
still catch a deadlock from those percpu lock iterators since it will register
each percpu lock usage in lockdep

Overall, it sounds to me the side-effects of commit 383776fa7527 outweight the
benefits, and should be reverted. Do I miss anything?
