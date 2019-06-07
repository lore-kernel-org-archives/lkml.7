Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E033C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212722083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="iY/5AEZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfFGOOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:14:50 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:36779 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfFGOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:14:49 -0400
Received: by mail-qt1-f171.google.com with SMTP id u12so2416090qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+y3LOysYYQjbxrvphbJGTKWQIXJ+UeatMaUjSDdw104=;
        b=iY/5AEZrOpuQWmCbToJkcfvzmPcrHRik9JsKBkOqc7hQ1YSdcVkhFcZVm/On8VeWSS
         qXM5gYgX9y/LaF1pvker4O6Cwq31+RXieCN48GHtm2rtS0Z6G/3VoqFGkRar0NzAmJST
         whDGY0VQPxrSR5UQ87wdV+z2YeacRFmKW4BiTi3OsjWYGk66v5PkR77bX30/81mjaccf
         p6NOL+OzJM2cyc924SurvYqg9+03TiL0JPuzloK1sbuWt5eea2S9sf4QqEPgkoVQO9RS
         crruuSRVQ0wODZY910DRJRPLnNsNVfYLsdkUJ24C38lQJRBdoYpQikjxOZzk9SoNlP9G
         d8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+y3LOysYYQjbxrvphbJGTKWQIXJ+UeatMaUjSDdw104=;
        b=F4LvTPHexkTbHSAMG/7hbXjhy7ck2xg9PFlrVeXu8T4RLsVc3QjEmqK1pFn46Rohcu
         4TilFj29k6sCdQKxjop5tVMAptsBh0W5fpqpUqlm4gBQTttblVeeYKlpr2J/kjv1FFxB
         ytmjN3Y3njIMqxU7lXxinYAA/C48Tri5F7d6WohBwxGFzSt2cFy0uwoUT1Jw1NqTYSL4
         tjdfcHiJkC0xp957CcU0wQlyfSbzjoqr95HB1TJv/YApeREKuyyFPvVaCuRXFFrbQiKn
         8N/mrbXf56/WjS8kgw/SC9YqQQ0E7b6kHRi2IwM+ZXvJ4aAFQuWz9iYZ2R7VcA9jfPk3
         coHQ==
X-Gm-Message-State: APjAAAU76ni2Q+XngpXnqS/OxY++uUxFk37PI5PDeDY4WMbvgrwZWTdl
        beLbtpPvUR2UhLaRbVNNyCg0hjJVhdo=
X-Google-Smtp-Source: APXvYqxbRmiEZn7NFKxkrNdxSU/i+fA1CEX/O3qd6VQubf1FU5ztDnQtLOQtXiq8eXbP9PD7rPX8nw==
X-Received: by 2002:a05:6214:41:: with SMTP id c1mr25251328qvr.138.1559916888399;
        Fri, 07 Jun 2019 07:14:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d16sm1207025qtd.73.2019.06.07.07.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:14:47 -0700 (PDT)
Message-ID: <1559916886.6132.52.camel@lca.pw>
Subject: Re: "locking/lockdep: Consolidate lock usage bit initialization" is
 buggy
From:   Qian Cai <cai@lca.pw>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Jun 2019 10:14:46 -0400
In-Reply-To: <CAHttsrYCD1xvL6hf6dXZ_6rB2pEra0HDZ+m5n8EMQr3+5AShnQ@mail.gmail.com>
References: <1559855690.6132.50.camel@lca.pw>
         <CAHttsrYCD1xvL6hf6dXZ_6rB2pEra0HDZ+m5n8EMQr3+5AShnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-07 at 11:21 +0800, Yuyang Du wrote:
> Thanks for the report, but
> 
> On Fri, 7 Jun 2019 at 05:14, Qian Cai <cai@lca.pw> wrote:
> > 
> > The linux-next commit "locking/lockdep: Consolidate lock usage bit
> > initialization" [1] will always generate a warning below.
> 
> I never had such warning.
> 
> > Looking through the
> > commit that when mark_irqflags() returns 1 and check = 1, it will do one
> > less
> > mark_lock() call than it used to.
> 
> The four cases:
> 
> 1. When check == 1 and mark_irqflags() returns 1;
> 2. When check == 1 and mark_irqflags() returns 0;
> 3. When check == 0 and mark_irqflags() returns 1;
> 4. When check == 0 and mark_irqflags() returns 0;
> 
> Before and after have exactly the same code to do.

Reverted the commit on the top of linux-next fixed the issue.

With the commit (triggering the warning
DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)),

# cat /proc/lockdep_stats
lock-classes:                         1110 [max: 8192]
stack-trace entries:                     0 [max: 524288]
combined max dependencies:               1
uncategorized locks:                     0
unused locks:                         1110
max locking depth:                      14
debug_locks:                             0

Without the commit (no warning),

# cat /proc/lockdep_stats
lock-classes:                         1110 [max: 8192]
stack-trace entries:                  9932 [max: 524288]
combined max dependencies:               1
uncategorized locks:                  1113
unused locks:                            0
max locking depth:                      14
debug_locks:                             1
