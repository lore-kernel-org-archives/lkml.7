Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C4DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7D4222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="gicUrqAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKRWAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:00:39 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36230 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:00:39 -0500
Received: by mail-qv1-f68.google.com with SMTP id cv8so7108593qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uM3O9HqQgWRtXj1MLGone+IZFlYy7CPeRUTYOQhw/4=;
        b=gicUrqAkCdjKCwj3Ptmg69zLTOzebuZgKNBzETv9wjPrq20r7+YpZ45ldOYxZT3LID
         kIz4yQrGsBKcxltE8wCDCKVynU6p+ky1lAFkNYgpXTl1CWJa1l5L38vNDbFjWSnIqGi1
         UHnpa4BNXi40A0+f0VJlu1GLMw5uGEHlSVKvRxabyAEvuLFGPoMPChN5WdCVI00MRk28
         8BgQmrURpMzh9ls/Pt/P+n9IzSb+rxiGwhDCN9O01S3zC0W3/TenKSfafoUjQlOMKFOQ
         RB0UZlFywQIm9qRAUcKiWCpOGYkDY+qwkBsF796C8uNGL1EBX+AmNyhWdn9CnIyt6f8Z
         t1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uM3O9HqQgWRtXj1MLGone+IZFlYy7CPeRUTYOQhw/4=;
        b=tDZrha6xnPsPc25eMc04zbD+fdX88+84vOEDFaWgF2+sTvo5Q9gAltSWn91p7C1wMS
         MQQD9xJjV/KYSb+1zon3+OP3oLCpA7m1GCZlPjrA1frqKYIiIeQWElUmv+bZlynnJqMP
         xKl0/3ZNaHHuEKt66GIoUVfgv33cKdwIWTZu1Ra6wyWpAEQP7b+peZNwUuDeeNezq3H8
         xTOA3QMS+3/bkvec6c2Gw0Slz113f3KXJM9MXiQFF7gg+NQp0XjDg5fQHtdQyXw5Fn9g
         ytZzdddO/CPpaojAzQXMA8Wy3p8A36A9SGuz2LLthwSGMX578cB2e9I3VH4bDyMq4dM5
         WbcQ==
X-Gm-Message-State: APjAAAXNLDb2zUVZVSs35yOuyb2px4TPcdBCsK56fKzfhTtPJuLdKBbV
        Toc/grQAvpzQidjmUF3fieyp8Q==
X-Google-Smtp-Source: APXvYqwPcEqu5wYXBpQ8TuHfZ6/MKcfmBVgT8xSFaNfUnv/7d5jJQYrcCvVqVOrz5AlFpKEDx82Qqw==
X-Received: by 2002:a0c:be82:: with SMTP id n2mr28164023qvi.70.1574114438227;
        Mon, 18 Nov 2019 14:00:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:1113])
        by smtp.gmail.com with ESMTPSA id 8sm9097265qkr.29.2019.11.18.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:00:37 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:00:36 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSI: use-after-free in collect_percpu_times()
Message-ID: <20191118220036.GA382712@cmpxchg.org>
References: <1574113159.5937.148.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574113159.5937.148.camel@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Mon, Nov 18, 2019 at 04:39:19PM -0500, Qian Cai wrote:
> Since a few days ago, s390 starts to crash on linux-next while reading some
> sysfs. It is not always reproducible but seems pretty reproducible after running
> the whole MM test suite here,
> https://github.com/cailca/linux-mm/blob/master/test.sh
> 
> the config:
> https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config
> 
> The stack trace on s390 is not particular helpful as both gdb and faddr2line are
> unable to point out which line causes the issue.
> 
> # ./scripts/faddr2line vmlinux collect_percpu_times+0x2d6/0x798
> bad symbol size: base: 0x00000000002076f8 end: 0x00000000002076f8
> 
> (gdb) list *(collect_percpu_times+0x2d6)
> 0x2079ce is in collect_percpu_times (./include/linux/compiler.h:199).
> 194	})
> 195	
> 196	static __always_inline
> 197	void __read_once_size(const volatile void *p, void *res, int size)
> 198	{
> 199		__READ_ONCE_SIZE;
> 200	}
> 201	
> 202	#ifdef CONFIG_KASAN
> 203	/*
> 
> Could it be some race conditions in PSI?

psi doesn't do much lifetime management in itself: the psi_group is
embedded in the cgroup and the per-cpu data is freed right before the
cgroup itself is freed. An open file descriptor on the pressure files
will pin the cgroup and prevent it from being deleted.

As it's reproducible, would you be able to bisect this problem?
