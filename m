Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73237C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4B922CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O86lsLAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfIDTyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:54:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33178 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIDTyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:54:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so58125plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=zVEggXc4NanJ8GS8Ki3BGLJbkMKiAmWM9IclbMTNoGs=;
        b=O86lsLAw4Av2uvQ+fhP7kYtfih5r6K05xH+HGpxKSb7ZFLw+X4Q3l0cAMoWMXsX5+1
         yRtHeSn+fmF1rvDKrLfzLrucSV9UosmCkfmV2nbV80DaLIZPSK8TDel1Q94h8Qc0+PDi
         g0e5ecZ3RWr83+gZTuBtYc8KP8rrO6WYfHA0CpOkAW4Uw4+Pm+nnbEaZF2xtMvc3JC7a
         mdLCO7NMtd2sS+S+zkBBeg3bhuOm1I0zSVJK+w92TCPNPnFyp8ZQ0quZOPoKkxZ5KE/o
         LJiK55VbvSakXB2dv6LHRaNZ8zzPVrN24mzMW4z0X5WQpOYPAKQCj7bduBN0jRep2crq
         aaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=zVEggXc4NanJ8GS8Ki3BGLJbkMKiAmWM9IclbMTNoGs=;
        b=pZZIWY2Ux29kiVBAL1bi3JNTzsGSMcgzF5BWR+8snrzGu9gMVkihDla1vge4uTDmbP
         hH45cvNRoMvZMrR86bsEOFUC/wnDC14jNZNSoO9CzNPhvV8mk/IoQ//zeG/dU0SlwNuB
         EcHPFkwOB+SJLxsruz4jXTUr15PrTLhygNKtTyLd4uacT7E9g93pGWXUgU7+22np7wlM
         jUKg0fftJTk5UpEcVPPHFYnhQhRUUkaMi0S4ZYCNa1zYuAnzaJt/SnewiDAqX8sJV74d
         b2WmU5TJyFgnD8r0tDcWd0ryNkbp5+Uf264250gKGnJAhQqb8km9H8VgpkitbQC2ClDc
         0quQ==
X-Gm-Message-State: APjAAAU+HuzXrk6fxIsHVVNYhwI2/69vjspjlNtO+sB1lfWs9Qm25Zqz
        HBsn3J1xjOw4CxLojpTJCBRJrg==
X-Google-Smtp-Source: APXvYqwR/4/43dbf9ZNog736j7K01wvmb9AMqM1m0dVw7+TYaOgrQwy2t1siHO4MQsCO51RQKPTjxg==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr42019502plk.33.1567626857331;
        Wed, 04 Sep 2019 12:54:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y15sm30056819pfp.111.2019.09.04.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:54:16 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:54:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two commits:

commit a8282608c88e08b1782141026eab61204c1e533f
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Tue Aug 13 15:37:53 2019 -0700

    Revert "mm, thp: restore node-local hugepage allocations"

commit 92717d429b38e4f9f934eed7e605cc42858f1839
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Tue Aug 13 15:37:50 2019 -0700

    Revert "Revert "mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask""

made their way into 5.3-rc5

We (mostly Linus, Andrea, and myself) have been discussing offlist how to
implement a sane default allocation strategy for hugepages on NUMA
platforms.

With these reverts in place, the page allocator will happily allocate a
remote hugepage immediately rather than try to make a local hugepage
available.  This incurs a substantial performance degradation when
memory compaction would have otherwise made a local hugepage available.

This series reverts those reverts and attempts to propose a more sane
default allocation strategy specifically for hugepages.  Andrea
acknowledges this is likely to fix the swap storms that he originally
reported that resulted in the patches that removed __GFP_THISNODE from
hugepage allocations.

The immediate goal is to return 5.3 to the behavior the kernel has
implemented over the past several years so that remote hugepages are
not immediately allocated when local hugepages could have been made
available because the increased access latency is untenable.

The next goal is to introduce a sane default allocation strategy for
hugepages allocations in general regardless of the configuration of the
system so that we prevent thrashing of local memory when compaction is
unlikely to succeed and can prefer remote hugepages over remote native
pages when the local node is low on memory.

Merging these reverts late in the rc cycle to change behavior that has
existed for years and is known (and acknowledged) to create performance
degradations when local hugepages could have been made available serves
no purpose other than to make the development of a sane default policy
much more difficult under time pressure and to accelerate decisions that
will affect how userspace is written (and how it has regressed) that
otherwise require carefully crafted and detailed implementations.

Thus, this patch series returns 5.3 to the long-standing allocation
strategy that Linux has had for years and proposes to follow-up changes
that can be discussed that Andrea acknowledges will avoid the swap storms
that initially triggered this discussion in the first place.
