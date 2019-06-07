Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A6C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896AF20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNCRPlL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFGJ6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:58:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33403 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfFGJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:58:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so855802qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DYaslGuRCa44w27gCTBvwFQNPiCOo89j5a92HT1O398=;
        b=gNCRPlL5SC+waW1M964joyZ8kMUdAunRd0kG2R0C3sWB5B8AwM4yXoHZDbl/s+VEtP
         WYXbP6xATcoLWTTvcuy9SFgWcIg7JbxHPYcew0ZPeQ/QY3/fxBBsWrcpj0qPc8EpyRcM
         nvhTc2y5F3BrqmiUNxdGpNx5vpDhO8OCPI6D555S9mzfUR5vAiGGYgarsFHsBdGccDiA
         80LZRj2aZdhvOfLehAI5nE1cZz+Jy7Xm/Qe0HdCFW1Pj9z+sH+YhYHITYZaV8IRjkSjh
         92oT/4VuYF9Ow5L2FyT4NqFYMe1hijDDrM1bJwUZ86MHz8CZlXfzrCKDYf7NEwdtHN5F
         rwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYaslGuRCa44w27gCTBvwFQNPiCOo89j5a92HT1O398=;
        b=Z4+560gQ5Bl1d9dMxcvRlC02H6QQ/O4DfjWh3EtcgSJIM2Tihj/blYZKOc78mI+G6j
         XV+F6ziMv83dkd95ZgD5jIPJ8YMxapJk8kTv9i7U4LopIfkZtJnLuR1+iRXcCP19a4DF
         9DDCgTB+AbZFEeeTX30lzNH0Fb249tb+2rMnhmIyKCZCmvJ6rbZyjngK10ZJvnG/8Umh
         W3RYWChd9+qBhboi4M21UnnYN/yyUHi7KusK3n9iCtzrpAxBqQ+MzkqDseQwvJOe40g9
         ZtpZ5PHrSzUTvWyCctSDTn/iI5/4dT5cnp+S9NloZyL69uuNw58HRc869HMN8VBntfyk
         d02g==
X-Gm-Message-State: APjAAAUGk+Z7nFDLc3jF/X1xvrDz74uAvvsnYtSCOIFOT5ZRG/cdl4WU
        I/zCLU/7HFpXjUSavAtaGUTliQ==
X-Google-Smtp-Source: APXvYqzuPCkCoJMd93+bmUPkXRWcKmfAOtQiwBn348DGiv4tPkZy2smKLzEhRZ2ORX+iZMnBTJy22Q==
X-Received: by 2002:a05:620a:533:: with SMTP id h19mr43063500qkh.325.1559901521594;
        Fri, 07 Jun 2019 02:58:41 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id w16sm970120qtc.41.2019.06.07.02.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 02:58:41 -0700 (PDT)
Date:   Fri, 7 Jun 2019 17:58:31 +0800
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
Subject: Re: [PATCH v2 3/4] perf augmented_raw_syscalls: Support arm64 raw
 syscalls
Message-ID: <20190607095831.GG5970@leoy-ThinkPad-X240s>
References: <20190606094845.4800-1-leo.yan@linaro.org>
 <20190606094845.4800-4-leo.yan@linaro.org>
 <20190606133838.GC30166@kernel.org>
 <20190606141231.GC5970@leoy-ThinkPad-X240s>
 <20190606144412.GC21245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606144412.GC21245@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Jun 06, 2019 at 11:44:12AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 06, 2019 at 10:12:31PM +0800, Leo Yan escreveu:
> > Hi Arnaldo,
> > 
> > On Thu, Jun 06, 2019 at 10:38:38AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jun 06, 2019 at 05:48:44PM +0800, Leo Yan escreveu:
> > > > This patch adds support for arm64 raw syscall numbers so that we can use
> > > > it on arm64 platform.
> > > > 
> > > > After applied this patch, we need to specify macro -D__aarch64__ or
> > > > -D__x86_64__ in compilation option so Clang can use the corresponding
> > > > syscall numbers for arm64 or x86_64 respectively, other architectures
> > > > will report failure when compilation.
> > > 
> > > So, please check what I have in my perf/core branch, I've completely
> > > removed arch specific stuff from augmented_raw_syscalls.c.
> > > 
> > > What is done now is use a map to specify what to copy, that same map
> > > that is used to state which syscalls should be traced.
> > > 
> > > It uses that tools/perf/arch/arm64/entry/syscalls/mksyscalltbl to figure
> > > out the mapping of syscall names to ids, just like is done for x86_64
> > > and other arches, falling back to audit-libs when that syscalltbl thing
> > > is not present.
> > 
> > Actually I have noticed mksyscalltbl has been enabled for arm64, and
> > had to say your approach is much better :)
> > 
> > Thanks for the info and I will try your patch at my side.
> 
> That is excellent news! I'm eager to hear from you if this perf+BPF
> integration experiment works for arm64.

I tested with the lastest perf/core branch which contains the patch:
'perf augmented_raw_syscalls: Tell which args are filenames and how
many bytes to copy' and got the error as below:

# perf trace -e string -e /mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c
Error:  Invalid syscall access, chmod, chown, creat, futimesat, lchown, link, lstat, mkdir, mknod, newfstatat, open, readlink, rename,
rmdir, stat, statfs, symlink, truncate, unlink
Hint:   try 'perf list syscalls:sys_enter_*'
Hint:   and: 'man syscalls'

So seems mksyscalltbl has not included completely for syscalls, I
use below command to generate syscalltbl_arm64[] array and it don't
include related entries for access, chmod, chown, etc ...

You could refer the generated syscalltbl_arm64 in:
http://paste.ubuntu.com/p/8Bj7Jkm2mP/

> I'm now trying to get past the verifier when checking if more than one
> syscall arg is a filename, i.e. things like the rename* family, that
> take two filenames.
> 
> An exercise in loop unrolling, providing the right hints to the
> verifier, making sure clang don't trash those via explicit barriers, and
> a lot of patience, limitless fun! ;-)

Cool!  Please feel free let me know if need me to do testing for this.

Thanks,
Leo Yan
