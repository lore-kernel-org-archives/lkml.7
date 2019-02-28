Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD87C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4921218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcSzwiU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfB1CTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34371 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbfB1CSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so15725889lje.1;
        Wed, 27 Feb 2019 18:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3pqzFscLehpEZ2hqUDAWkPeJa10L+1HyUm9cWmYGvo=;
        b=rcSzwiU6b7t0TWgGr/ljZx1uqRAcbiy3G+NZh5gJYGUjEm9T1jRad/u/JoZQYaFE7M
         mYllg9ECQFKBYMwZZLK3TuZ+oahAIwdl5c4d4MaCGlD36ETg3UhvxNmbKN014s1IKYYa
         1W/k6HgDfHC/ixDa1UQ1XdRj02iR/VMePLxJsEPEXB3U/Xqs2Awy/qpnRta/nRpvGLGI
         QGn2XSUYiB5X+gex/UT5f0H/bINB3Sxs//n5JorAh/Jd30f5yIm+weJ1Mx7N+yXxZ7ID
         NR+3cACyQnu9YOI4lDTENeP0FubYF0eVxZvhh/nkG94SoASNnSpmjAUJMas2VuS4pkwJ
         wJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3pqzFscLehpEZ2hqUDAWkPeJa10L+1HyUm9cWmYGvo=;
        b=oc1nhm8hcUnxSJnjNwfOtGu2rcUkkT/gpDKrB3+UpNMnNBjnk7Kx6Uxakrm+xyqXTp
         krMvMY3YUiK1U2nXjp/4j0VL6xQsuHSClAlZw+Vy4qYBWSAM5Qk6rXsp8US+9DHICI3e
         d1vL8Yk+p7DFwYlpWJClj/pFVCs2rqRUDHY4Qbz+k91hWJ00e1g7xKG+WMz/xDzw8f95
         s5qdt2yw7xQsfbCIkPLN0BX/1C5kXoTLbi+2cJbbjIXfqgeq9Ceiib4LpB3GLN8JssmQ
         6YWsbL1HCDhz7hXpGNXeooyvamdJ0y5vAtslgtgLyz2S2Pi6nmsVkL455Wmyg7scGj7B
         tfqQ==
X-Gm-Message-State: APjAAAXRmxws66flqlyMlpttHgNuILooNBB33pI4wosdM232BL5Aaom4
        FkpjY/+mtmD9MtvEP5h52MbR/V81D928KQ5C/HT3vA==
X-Google-Smtp-Source: APXvYqzWe6cri8Gse7rcElCdjKRGVcKpkDf7XevhnZ0e47grzSZTqgx164SdJiDcfcV0hztEDCnR+i66kaEzwq9gNjw=
X-Received: by 2002:a2e:5b11:: with SMTP id p17mr3028779ljb.37.1551320328941;
 Wed, 27 Feb 2019 18:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20190228123136.064f94a4@canb.auug.org.au>
In-Reply-To: <20190228123136.064f94a4@canb.auug.org.au>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 Feb 2019 18:18:37 -0800
Message-ID: <CAADnVQJXiZyCvDVTN4_Z=CnEo2hb3nxGWg6YhArxN9zrPaC8JQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 5:31 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> kernel/sysctl.c:1238:13: error: 'sysctl_bpf_stats_enabled' undeclared here (not in a function); did you mean 'sysctl_base_table'?
>    .data  = &sysctl_bpf_stats_enabled,
>              ^~~~~~~~~~~~~~~~~~~~~~~~
>              sysctl_base_table
>
> Caused by commit
>
>   492ecee892c2 ("bpf: enable program stats")
>
> CONFIG_BPF=y
> # CONFIG_BPF_SYSCALL is not set
>
> I applied the following patch for today, but it should be done
> properly. Also this patch leaves proc_dointvec_minmax_bpf_stats() as an
> unused function.

thanks for the report.
working on the fix.
