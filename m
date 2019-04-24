Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187A6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4F62175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Hhz6FxNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfDXUnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:43:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53356 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbfDXUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:43:53 -0400
Received: by mail-it1-f196.google.com with SMTP id z4so4559434itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=yb4ofAvzRW76AntrL5s5EiMl5Z+vN1wmoWlh3oNHFRM=;
        b=Hhz6FxNyI06J7v9l5rjT7CMfbCHlEbHhhorXRBrqy7kbsfgraOayDkAwkLV/ryIOah
         ZnwjzM1KADAkWrOltsHVqBi64bMQ5gja1MC3awFHi1Z48zLw8lWRMu41+zHf007h34Yh
         nsXOrDV3p0ZlHZVy+fx03uOOX0R6KPAVNq/PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=yb4ofAvzRW76AntrL5s5EiMl5Z+vN1wmoWlh3oNHFRM=;
        b=P839KQ3y26WB/FUSB+UmDBWp1FwEpOj0ciAWOA98CH2LdBiFCNduEZg5CAYeMyWXrc
         NzTlV2x74Diixbvw+8yCmCaJz813JMKZ7i6+kbnyRY4+TQToNuOFWE+34Rp+afUKkBhd
         y+fxvAztVMtGeIekvxloQahbiUWQBTRadDa+bV3EczE1PUg94jL04Vy10Cr5JF6yX1KR
         einySezGyxUTh1zutaZ0nsitJwOqkxLa0bnwjcR8vyffe8cPwhjvOoux3nIzu5FwJiY0
         QQY5RRMcbDSW6qtGHos4+LhgfjYUrFu77UVvnnM5jwQ5vc48iZf6bonlahYeuPpWMA9M
         CmJQ==
X-Gm-Message-State: APjAAAX6Miuf0A1IqwpVQhw7jlmazeeRQqGHbIQTf3FSuV1848yJE22U
        ZvJ+BDeN3P2Kt1HXCBQkune1RA==
X-Google-Smtp-Source: APXvYqzV3ZYRf5O7yP2fShhZqBHDgrhLnVBBkuHOVLBUnkIDlE3Sp8KqKUq8kw538bJzdLwFu1IrXQ==
X-Received: by 2002:a24:1f06:: with SMTP id d6mr812525itd.11.1556138631935;
        Wed, 24 Apr 2019 13:43:51 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id z141sm8533240itb.7.2019.04.24.13.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 13:43:51 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.intel@gmail.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Date:   Wed, 24 Apr 2019 20:43:36 +0000
Message-Id: <20190424204337.22283-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <54772e18-2f70-34cc-29ef-b9291f4846e2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A minor nitpick.  I find keeping the vruntime base readjustment in
> core_prio_less probably is more straight forward rather than pass a
> core_cmp bool around.

The reason I moved the vruntime base adjustment to __prio_less is
because, the vruntime seemed alien to __prio_less when looked as
a standalone function.

I do not have a strong opinion on both. Probably a better approach
would be to replace both cpu_prio_less/core_prio_less with prio_less
which takes the third arguement 'bool on_same_rq'?

Thanks
