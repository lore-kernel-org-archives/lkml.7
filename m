Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4AAC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E00E223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=indeed.com header.i=@indeed.com header.b="Jh6y+i7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfGWQpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:45:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40698 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388050AbfGWQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:45:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so5159423otr.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ADevYrTtujyVPlK2tuwzFrUbRUoPbF6rtrn0E36CPHM=;
        b=Jh6y+i7ilzxWsEyzWSh5ajwKZ3FeaRcz5c8xrmJ1BaE6ye4FKc3bYOK0/IPng058dI
         vaXiuqO3ZWMsCAKZ07n/iVLG3THw1XMi89oOPXPxBeLWjs+0Ny3RFcpdve25jPP0+Gdb
         hvd/8UiFnj7jNfmaaswaFUfXxGn4mHrGa6QpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ADevYrTtujyVPlK2tuwzFrUbRUoPbF6rtrn0E36CPHM=;
        b=YDhOE82E18RGKc4Vp7aNO503i0Bv1DzFftg6AnkZp550S9dAQqKxpueLf+nRyk114I
         yfj9GQ1a4oOCwbmDGfH+ZNn6IyBE4WGgVIWOo6i6Fn+VvxYLHb6simJ87JVHg9uOfUjU
         +E/U+i/TNWJcf/qmj17I7E7Eo+5mMyJZ/iA+y57bOmOzi6C/wJzmtTe9o2PAh22BIO/h
         6YEQzpvYQJNLn+nYaitvXbEopAL7wJfuFGr25xcTwH4CyIfabUDXnzadN85ihl4/brJl
         zSNlZ5AW484XodMa/ccgXXkjvTc16u05PF5Xe0ELFCZsa1MI5KWlGpn5su4s5b8gITlQ
         WxSA==
X-Gm-Message-State: APjAAAWU56fz+bPNf+1mBh95qHbojUyMRl/F5FP7r1UJfkyECXgiURGX
        BDUTby800fX98qjmQhwZspeuqw==
X-Google-Smtp-Source: APXvYqzL573W3YN7hPujIgZU9FHf6KOYF+tUoiFz+r5UIB2LRrk29uxvKLYvtzCvG0M+hnD6Ll/pMw==
X-Received: by 2002:a05:6830:154e:: with SMTP id l14mr21648154otp.365.1563900308442;
        Tue, 23 Jul 2019 09:45:08 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id f125sm14937391oia.44.2019.07.23.09.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 09:45:07 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v6 0/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
Date:   Tue, 23 Jul 2019 11:44:25 -0500
Message-Id: <1563900266-19734-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog v6
- Added back missing call to lsub_positive(&cfs_b->runtime, runtime);
- Added Reviewed-by: Ben Segall <bsegall@google.com>
- Fix some grammar in the Documentation, and change some wording.
- Updated documentation due to the .rst change

Changelog v5
- Based on this comment from Ben Segall's comment on v4
> If the cost of taking this global lock across all cpus without a
> ratelimit was somehow not a problem, I'd much prefer to just set
> min_cfs_rq_runtime = 0. (Assuming it is, I definitely prefer the "lie
> and sorta have 2x period 2x runtime" solution of removing expiration)
I'm resubmitting my v3 patchset, with the requested changes.
- Updated Commit log given review comments
- Update sched-bwc.txt give my new understanding of the slack timer.

Changelog v4
- Rewrote patchset around the concept of returning all of runtime_remaining
when cfs_b nears the end of available quota.

Changelog v3
- Reworked documentation to better describe behavior of slice expiration per
feedback from Peter Oskolkov

Changelog v2
- Fixed some checkpatch errors in the commit message.
