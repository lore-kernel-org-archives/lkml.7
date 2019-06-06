Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A877EC28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812B52083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4GhBjo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfFFJwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:52:13 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36857 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfFFJwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:52:12 -0400
Received: by mail-yw1-f68.google.com with SMTP id t126so624931ywf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OF/6ZkMdc/RdYDV51lRDRPrAIYbV+QfL4/gwTFmX58o=;
        b=i4GhBjo22XTIEoTVFapUwK6vtxHp2srk589bcFqG7zA6h9A7QlQy8wk4zcip8ufPkv
         Wom0pmtc9P0E8pgBGK2uZpFBOvYSULfziXMHjdcl2Cqwha/EgKFSEi4wp8WmHk1I2Cb3
         HtHBbhoFiPMDqajIz628DOwFKJGvxum1mBMnXEsHvtKHPpkzxvUQ3d8fhUgn6/yuggHV
         xvbBzu511lKlcEysVXWtNjVoVsDU98d2JSgux2auBYwS09gi962zYd2O47DG5dwMFJd+
         88wKOuQfDn7OyXbJb2Tjq6RDVaqOKSU2yZq285mMJN49Wyb+wHXed//7aLWqRp+iHQwH
         M/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OF/6ZkMdc/RdYDV51lRDRPrAIYbV+QfL4/gwTFmX58o=;
        b=FmVzF+gcWz1PwdUV0q9j4UdHeXoZHhXeTU2DDaf9eaJjE7w7ywvTOCWyicSlTfCQG0
         xIix+16cJzxu7pkLceT5C6LDTHOpW75KIv+XhHlYStqP4iiuYDcUJ6S0PMcKwe90E2g8
         66Fzww3xl5Xh6udg7YLyKEtLiA1f1N3dGtuTyL9u0lDCKYRK9EuhEeML5APlkzxM7JLb
         QS8g0QgEBNx90/wncQReGUaX3Ij1iu82lpJEbx5ehtf0T4qqBuWVCQgXM63vuXJ/P1y9
         LCp0d4ylSwCestsHcMLbmNnU3LxDy9haMlSNUc8OojkHkKEIXYBjWnKJl8hcwS7bmIqv
         bwBw==
X-Gm-Message-State: APjAAAXmnWUT29TSeEjgFRdz2En6R6+gzdHcgf27X6DqxW3gDPWQZp8F
        dl2kqCwhblghEL5L4feDNudshQ==
X-Google-Smtp-Source: APXvYqzIj6mHr6vIMB/M2RU7ehBrhqLjyy5K3mdgCBcs8U4OXzN7ueQNfKWSr3JXx53EPAHS6jc2aw==
X-Received: by 2002:a0d:c5c4:: with SMTP id h187mr22411029ywd.450.1559814731356;
        Thu, 06 Jun 2019 02:52:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id r6sm359910ywd.47.2019.06.06.02.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 02:52:10 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:52:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 0/4] perf augmented_raw_syscalls: Support for arm64
Message-ID: <20190606095202.GA5970@leoy-ThinkPad-X240s>
References: <20190606075617.14327-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606075617.14327-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, Jun 06, 2019 at 03:56:13PM +0800, Leo Yan wrote:
> When I tried to run the trace on arm64 platform with eBPF program
> augmented_raw_syscalls, it reports several failures for eBPF program
> compilation.  So tried to resolve these issues and this patch set is
> the working result.
> 
> 0001 patch lets perf command to exit directly if find eBPF program
> building failure.
> 
> 0002 patch is minor refactoring code to remove duplicate macro.
> 
> 0003 patch is to add support arm64 raw syscalls numbers.

I found minor issues in patch 0003, so sent out v2 for reviewing.

Sorry for spamming.

Thanks,
Leo Yan

> 0004 patch is to document clang configuration so that can easily use
> this program on both x86_64 and aarch64 platforms.
> 
> 
> Leo Yan (4):
>   perf trace: Exit when build eBPF program failure
>   perf augmented_raw_syscalls: Remove duplicate macros
>   perf augmented_raw_syscalls: Support arm64 raw syscalls
>   perf augmented_raw_syscalls: Document clang configuration
> 
>  tools/perf/builtin-trace.c                    |   8 ++
>  .../examples/bpf/augmented_raw_syscalls.c     | 102 +++++++++++++++++-
>  2 files changed, 109 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1
> 
