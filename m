Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47920C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6C920673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ej65huN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfFFOfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:35:45 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37483 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfFFOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:35:45 -0400
Received: by mail-yb1-f196.google.com with SMTP id l66so1012559ybf.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HgJ0GZY//Len7veYiP6CvMdfuN08GbgxjLHnvQVRuds=;
        b=Ej65huN6br/BvsJL6NdryRgqMaigzdNrEh0yptxU6ktxfkOVfnGB8JhlcnDFegwM39
         1+xf+2IbGCkZB2jitqE7MsxKe30xIxv6oUIFZb6dZojIaggD1y9e4wkzFf6KEnZXQAqs
         Dka83U7UotuhVF2sxPWPJXwFEBL/RGPvmp+iW3hO/pbvvqr2hWVkwHI4hCcz1H+v8zVs
         OwjZQY6FfB4+yJ4wASjdtBBchHyOGI2lsAZ1758+/CfmAKb7zdYttFR66+IXUdJkua8n
         8l5PehvXi2ROk4xfrf1yIV+PuPc2tzcfIIjxZyYe149/ZfI5TuYzV25HnKl5aAl6A0yT
         kF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgJ0GZY//Len7veYiP6CvMdfuN08GbgxjLHnvQVRuds=;
        b=aZHDpCJN3bPssPZRZdsiTyKU/tpwIRrz8fWrrt47t3x31zVnsuw/GI7AtbPkeNsCRA
         nDtqKEtLumlwHO+Cpb6wUTgXVpg0nyi8z1PS6Mht+mHpmh2CVOXDJ09VDKXDfw/jL0fI
         sCFhzfmighORdfOAY0TSARYRvsSEvfgU21qycU4jOJLAP3M3vS8nYV9ToUkj/YWYLevb
         zP2x09WZppRWDIDDGG9l6/zdj8UL5qh4/ZPeesKQ+HuGL34BvL7NpxAfUe3lcCILQBjs
         UBY3MEBHlzzeghhywUU15g/iUwg6t34+I+x54IxUqVvN/2pisxbZ021v/xUUE38UsnLC
         eQqQ==
X-Gm-Message-State: APjAAAWcf51Rtu1fTpQbxm/w8dXS9SPJsz6Y3uz8C7hkYrvHvLPmC78B
        PK1S4r9CQujRY9o6iNsqqNCrEg==
X-Google-Smtp-Source: APXvYqx4wLLqF1nY5nqIufaWI5Hdcp2smawrQmPU3ZCZZRABh9cWLQ/l6pM/bekVLBiX79E90XgiSg==
X-Received: by 2002:a5b:a90:: with SMTP id h16mr21558068ybq.341.1559831744170;
        Thu, 06 Jun 2019 07:35:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id v70sm515376ywc.78.2019.06.06.07.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 07:35:43 -0700 (PDT)
Date:   Thu, 6 Jun 2019 22:35:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Subject: Re: [PATCH v2 4/4] perf augmented_raw_syscalls: Document clang
 configuration
Message-ID: <20190606143532.GD5970@leoy-ThinkPad-X240s>
References: <20190606094845.4800-1-leo.yan@linaro.org>
 <20190606094845.4800-5-leo.yan@linaro.org>
 <20190606140800.GF30166@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606140800.GF30166@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:08:00AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 06, 2019 at 05:48:45PM +0800, Leo Yan escreveu:
> > To build this program successfully with clang, there have three
> > compiler options need to be specified:
> > 
> >   - Header file path: tools/perf/include/bpf;
> >   - Specify architecture;
> >   - Define macro __NR_CPUS__.
> 
> So, this shouldn't be needed, all of this is supposed to be done
> automagically, have you done a 'make -C tools/perf install'?

I missed the up operation.  But after git pulled the lastest code base
from perf/core branch and used the command 'make -C tools/perf
install', I still saw the eBPF build failure.

Just now this issue is fixed after I removed the config
'clang-bpf-cmd-template' from ~/.perfconfig;  the reason is I followed
up the Documentation/perf-config.txt to set the config as below:

  clang-bpf-cmd-template = "$CLANG_EXEC -D__KERNEL__ $CLANG_OPTIONS \
                          $KERNEL_INC_OPTIONS -Wno-unused-value \
                          -Wno-pointer-sign -working-directory \
                          $WORKING_DIR -c $CLANG_SOURCE -target bpf \
                          -O2 -o -"

In fact, util/llvm-utils.c has updated the default configuration as
below:

  #define CLANG_BPF_CMD_DEFAULT_TEMPLATE                          \
                "$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
                "-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "     \
                "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
                "-Wno-unused-value -Wno-pointer-sign "          \
                "-working-directory $WORKING_DIR "              \
                "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"

Maybe should update Documentation/perf-config.txt to tell users the
real default value of clang-bpf-cmd-template?

Thanks,
Leo Yan
