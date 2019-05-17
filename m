Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8145C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A142121783
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fauEAA2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfEQR7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:59:15 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:56110 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfEQR7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:59:15 -0400
Received: by mail-ua1-f73.google.com with SMTP id j14so1121913ual.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HjnJT2XdDYKQIIRI0wRs7dq5hVXPjCbb+2fdzHD9I4I=;
        b=fauEAA2BclMEIkmvf+xXGB/nJbN4RY0tU6omsopEkobMhC1+AP5VAckmbkX5Jzqknn
         SVEFNKrI8VdjzWjxuAHIDw100HFn1N5BdfERXxuB3YqEdUymRmiuuvCgnhg0zI8gHywV
         7Qhi/OJFgfd6qFzyZLNFC4vtMsHw0uVGtR0X9lmyqps1AWua+9WmmjjPJj+ozK8hqkqR
         B3mdI8FeOB26VZ7cYJHTRw4WXafKtSS6ERlIDidcVQnabczzRC+N2mZioB3O2ufTKuH+
         0/y6aO0L9vTt4iqVxTIb4UwKOewXmrx1fWV0uISJi/hzlgJ4OVM9qUngZhkqS0BJnRsN
         jPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HjnJT2XdDYKQIIRI0wRs7dq5hVXPjCbb+2fdzHD9I4I=;
        b=LXW4DniD3bZZWs5LrytYObYxB13gm3oSGm7rFBPIHZRzMjrJ/gMN+EtfWqdb6/V1gz
         r4vgCwbMF2cluGpjYCRyRMxsWvZhhBeZGLiYsU92pFTL1OH7Vb83R0b8ndrrJGii84hE
         Hscx/Bgagjw6MR3cA/eDyqvjecca1qFucyKUqjz4a0f+SVkRoSiPqteBVfq/WFaX2Pq7
         Gh4jGqzSzcFTXcUeWlHr58rEM3v/YoYqv36lD4qWwg6IknOGOKrgLiS586AQlm8tqivj
         ozW6FNW0yYVu1vZlxfCjftcKfGM8EtgfVRwMyvYbLCh7VQgTysLELNKbQXCsGoyl4EES
         IBZw==
X-Gm-Message-State: APjAAAWdqOf6by/w8pt3uyh73xhHmvey4A2RTtdlQQBbrUI7R9yLTj6R
        oDzlu66fbAIpXAMflH/SKmxiqGW56g==
X-Google-Smtp-Source: APXvYqy9+QxqphCtyHxQMDmhE5KTigqQMc819noadvyCGPewgyfNz/3vqRswvnvmOUJeMXqJiDeBGhpIdPA=
X-Received: by 2002:a1f:b20d:: with SMTP id b13mr13653vkf.75.1558115954425;
 Fri, 17 May 2019 10:59:14 -0700 (PDT)
Date:   Fri, 17 May 2019 10:59:06 -0700
In-Reply-To: <20190517084712.GL2623@hirez.programming.kicks-ass.net>
Message-Id: <20190517175906.78742-1-yabinc@google.com>
Mime-Version: 1.0
References: <20190517084712.GL2623@hirez.programming.kicks-ass.net>
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

> > -	local_inc(&rb->nest);
> > +	rb->nest++;
> > +	barrier();

> Urgh; almost but not quite. You just lost the 'volatile' qualifier and
> now the compiler can mess things up for you.

I thought the barriers added could force the compiler to forget what it knows
about rb->nest, and do the write as been told to. I appreciate it if you can
tell me more details about it. Anyway, it's a good choice to be protective
and always use WRITE_ONCE/READ_ONCE for rb->nest.

> What I'm going to do is split this into two patches, one fixes the
> problem and marked for backport, and one changing away from local_t.

I read the split patches. They totally LGTM. Thanks for all your help
and rapid reply! I appreciate it :)
