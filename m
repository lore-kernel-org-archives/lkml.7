Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777B9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5B120833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUS0eLKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfEPSiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:38:02 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49842 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:38:01 -0400
Received: by mail-pg1-f201.google.com with SMTP id e20so2656396pgm.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3j/4tr8CrKpqGGvqHCEPSLn57jN1xeOSywr/5Ae9rTM=;
        b=jUS0eLKxVhmfNjWiAtxwVyjVnsmrN2HNyKGU2ySEflldzKc3Gc9TTaoDCfyVzx6/0P
         4m2criIXsk5HbgXDlNxoyaqLt63pNi4cK7jSx4WgxOunn2tjhE56CVMIfb5g9fpTxMo1
         SNUypGqklImXvZv/7uG5xzKj3Vk6+eZFVOWG8lETNgsc9jewIY/oiFBa87mS0EicjXXG
         nHUBpddZgJhNy/NhYVwE2l2yjU1P/97BhtVeVWWNyZYIKSGktrrds+MVJGJ7vAZaYyMN
         rh6vYMf9LJptDdl6VfPb0k36yPMSqL6c7OM3JQmN3ACkGaTMZmG6DtKPjw+/qvMB3MVS
         j1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3j/4tr8CrKpqGGvqHCEPSLn57jN1xeOSywr/5Ae9rTM=;
        b=MVhP1/nVMttdM6hlBURN5xf1tYuiD/PivdP7LrFNtY5uQgcVsHG7M5tq66MFQlPx92
         XJ0m87cV79Uul1nCJdi6r3ovNilIQ3gkE/f5As8gtGrrpQ2c7piX7BVU+1aIMb3sOlL+
         3SVAitiIDQH9HP4iZ5wVTviu7xoqZVX54/AUh9ubhlI5qHsP4/eyYZWMPmUDJ0c+VUcm
         acRo3sbxLrMZ9ePowmGgmpdxDQkkOvS/e8hFiZLv0KMEr9iK7P26CPdgW/9hKv7Jeq5G
         RT4Fr9DtfsPLSn4cgVL6Lw29Rrh/QKt00mO0Yby/WufCR6fj6j1cuNdVurIPBW7NT5ZK
         TxPQ==
X-Gm-Message-State: APjAAAVAY2is/vrzoK0Srk4elAsqvxcYguDsQJCWYaRmk5Vo7vSftlCi
        l00znOhoA+q6+51VaZRnwroj7nudYw==
X-Google-Smtp-Source: APXvYqyMwym9Xsow2mBymLy3/VC+EfHHl/uXbkBkH4AUrf9SOyEUTEF+6bTf/FVRxMCnszBMXDP6ncqUM98=
X-Received: by 2002:a65:478a:: with SMTP id e10mr52135748pgs.310.1558031880782;
 Thu, 16 May 2019 11:38:00 -0700 (PDT)
Date:   Thu, 16 May 2019 11:37:47 -0700
In-Reply-To: <20190515104824.GD2623@hirez.programming.kicks-ass.net>
Message-Id: <20190516183747.166545-1-yabinc@google.com>
Mime-Version: 1.0
References: <20190515104824.GD2623@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [PATCH] perf/ring_buffer: Fix exposing a temporarily decreased data_head.
From:   Yabin Cui <yabinc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Indeed, good catch! Have you observed this, or is this patch due to code
inspection?

I observed this. I was using perf_event_open instead of linux tools perf
to monitor a process continuously forking new processes, generating a lot
of mmap records. And a sample record happens while generating a mmap record.

For missing barriers, I thought local_xxx provided implied barriers. But
I found atomic_ops.txt said not. Thanks for reminding! I will add them in
path v2.

I also think it's a good idea to use READ_ONCE/WRITE_ONCE for rb->nest. Will
use it in patch v2.

