Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D33C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEA7216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="n0kuHRY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfGHOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:32:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36195 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfGHOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:32:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so14751606qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgj5LsjWMVt3uA7AU+5EiBzsCoU8sQY1EReSmwcxt0o=;
        b=n0kuHRY3ZgOzBursA5auRJFUrsUpG9UEo8EViVHwRjZwW5OUjLi16etpytmAmQS4j5
         sR7RFBRnGzpRWgg40zSvzE1tdzcYk2BM7rQl9ra8F4I91IQCSXneneFewJ3bbSGJUKVZ
         tZ6y1jBYTjuPYk1H6SfcRcEwzXWZMnjvy/VsFECb17Ac9rlPoaJ6Wlzmgn/BYDNLF/cM
         oUQ8lmXVuFu3PoTIaxitctRiD0r0hseyWMltfDH3rBQLq9DYTcWXjEgEhPRYWQFEuYLq
         ZIsysXHCi2cYHbkGpITeDTindM2uJ1j96GaeaBv5OTEN/rfQ0jRGnkfp+/3ngK9h9co/
         N+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgj5LsjWMVt3uA7AU+5EiBzsCoU8sQY1EReSmwcxt0o=;
        b=TT19+8Tcto3sRXRFA7+VC20ZS2Gwl9UjeVAz7IYu/IOafONh5IJ2KsyBgIgjI0gJiI
         /IFaS9hDSKRlCHTT3mKRB3a7y1hM0XZz9rONKUEYDrOSimTH5zehvca0W+2cK0rekRH1
         DxQooRYK2VkAKKAUUmFKh6F8WV45lWvTxhEKeQbn3kQmqOxLp50cI71fDTdDTUjUnqmz
         6nsTPAbysYFjvtDyY+lqGrkaBHF1nFvR8fObuVFoZ3KIu+XitE7X08qsqPUB4Pf0xSVk
         viaGbMf7W2YezcGabjok6p7FcnO8DZ5Gd6LmAdbKMGU49nq7cu7Q05ykRCeSCGHinA4T
         X0qQ==
X-Gm-Message-State: APjAAAU0T8FIJRjCJ5GH34BPajlyQMdwC80N04jf+s8DsNWBonDX6pWG
        kv0mEZs9FMDT7UgJYm9m2xtDVQ==
X-Google-Smtp-Source: APXvYqwwc4BaBrQsj5h8zlkbN6fHFM6eIvYFfivWzpf/pcxIjkWthFjzJx4pXwVHeGZYhdObZ/usig==
X-Received: by 2002:ac8:4084:: with SMTP id p4mr14522174qtl.172.1562596366464;
        Mon, 08 Jul 2019 07:32:46 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l19sm4294245qtb.6.2019.07.08.07.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:32:45 -0700 (PDT)
Message-ID: <1562596364.8510.1.camel@lca.pw>
Subject: Re: [PATCH v2] sched/core: silence a warning in sched_init()
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     valentin.schneider@arm.com, linux-kernel@vger.kernel.org
Date:   Mon, 08 Jul 2019 10:32:44 -0400
In-Reply-To: <1561466662-22314-1-git-send-email-cai@lca.pw>
References: <1561466662-22314-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Per discussion, sounds like this is the best thing to do in order to avoid
compilation warnings.

On Tue, 2019-06-25 at 08:44 -0400, Qian Cai wrote:
> Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
> will generate a warning using W=1,
> 
> kernel/sched/core.c: In function 'sched_init':
> kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
> [-Wunused-but-set-variable]
>   unsigned long alloc_size = 0, ptr;
>                                 ^~~
> 
> It apparently the maintainers don't like the previous fix [1] which
> contains ugly idefs, so silence it by appending the __maybe_unused
> attribute for it instead.
> 
> [1] https://lore.kernel.org/lkml/1559681162-5385-1-git-send-email-cai@lca.pw/
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Incorporate the feedback from Valentin.
> 
>  kernel/sched/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..12b9b69c8a66 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5903,7 +5903,8 @@ int in_sched_functions(unsigned long addr)
>  void __init sched_init(void)
>  {
>  	int i, j;
> -	unsigned long alloc_size = 0, ptr;
> +	unsigned long alloc_size = 0;
> +	unsigned long __maybe_unused ptr;
>  
>  	wait_bit_init();
>  
