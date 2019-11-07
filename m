Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEBEC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA51D2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbllSLrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbfKGKUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:20:37 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41107 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:20:37 -0500
Received: by mail-yb1-f196.google.com with SMTP id d95so242912ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=djmxnkfgo5IC0LeotOkmJPKSf90Q/NYI5vMLUdSE/0c=;
        b=HbllSLrCMvfgraY6qsfXqJYjR8v4l8SJdb5g45ZCGfzZAK2DWF2upH3pdyKzeQptgR
         /rO7ydQYlUaumUmthGapoF79dBYfEKYnXm0HCvYM7CmC8b8c/6OeKAPdFD1fOf1/Wg11
         tpdM8Hhsd+GnObAz6HySsK4Ug4Kp37Y0MYVAjiSVuwd9aYsaEmzFyV9bFINuh1gSIIVt
         LZiSzEc36IIWydM3MpjJZMDUrp8tDEFNY0jwpGwjFmAc4WTgnkafqsihuC0Y/iighWbz
         I5Bz3vBT7FfGQWOk+eHbubIGcrSsuIstlbETISvRGY4erTu9JhBIbRCaEExC7NV3mxkm
         FuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djmxnkfgo5IC0LeotOkmJPKSf90Q/NYI5vMLUdSE/0c=;
        b=YK9zCOPKAU3QE4pv6ZpeF2NIOLRi+OvscZURS83yrBNusU4S/utHLDIU8AKz+kHinw
         dYp+G+8jxJ/YJiNEWEuNiXczkS1sZIoq8i+k1tTfCI0svoredu9rKenuYg8ZWmYAHQST
         vxnRhZPmlAzSwer/YwyS/L9SQTkyToN2Qkk7vTggRcSnMKfFPC7DBtnjo/yYZLItdcQk
         PYHgKyBQurcKRhW1s3hBJEaYGe1rcbVjJSpYO5G/aCWH2HgYd5HP2QEQolQr4sDeIXXU
         kx4yAm1zdEcb/GT2+KShJh/9H/QNdrGTdpkTww14/t3Unm3QZQRuWWhtwvEpn6yaZjSd
         xdag==
X-Gm-Message-State: APjAAAUE1uEQC3op3McAUMdf9BFpbc8DFAhMfh79/vVU7NvLXBr/AUL+
        RuOVsMmLo8EC1yVD4E+iVW7b3w==
X-Google-Smtp-Source: APXvYqwBeLTlEWIuKJ4sTRvTfvckJiN0J+dRftpdoo6pE12XjJU7+Qb1XAVjF8+MEwqMFZmISrLVlA==
X-Received: by 2002:a25:bdcb:: with SMTP id g11mr2576735ybk.359.1573122036522;
        Thu, 07 Nov 2019 02:20:36 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id z14sm600364ywj.74.2019.11.07.02.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 02:20:35 -0800 (PST)
Date:   Thu, 7 Nov 2019 18:20:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] perf tests: Fix out of bounds memory access
Message-ID: <20191107102029.GA32679@leoy-ThinkPad-X240s>
References: <20191107020244.2427-1-leo.yan@linaro.org>
 <20191107094226.GC14657@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107094226.GC14657@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:42:26AM +0100, Jiri Olsa wrote:

[...]

> > To fix this issue, we will use evlist__open() and evlist__close() pair
> > functions to prepare and cleanup context for evlist; so 'evsel->id' and
> > 'evsel->ids' can be initialized properly when invoke do_test() and avoid
> > the out of bounds memory access.
> 
> right, we need to solve this on libperf level, so it's possible
> to call mmap/munmap multiple time without close/open.. I'll try
> to send something, but meanwhile this is good workaround
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Thanks for reviewing, Jiri.

You are welcome to send us the fixing patches, I am glad to test it on
qemu_arm.

Thanks,
Leo Yan
