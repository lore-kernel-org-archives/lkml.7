Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF99C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29A72089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arQlIKcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEBQlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:41:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42507 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBQlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:41:08 -0400
Received: by mail-yw1-f67.google.com with SMTP id y131so2044455ywa.9;
        Thu, 02 May 2019 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/D28fWfWdJzUHVix7BI9GxltmT2+d98lgi6IpUKEDdY=;
        b=arQlIKcAUjJWaJIanQkq4b6YCMfBofw5/KEuiDDY1PXzfCDdCq0L1S4LYg17H3r/GJ
         KtVeBDGVfc2sYWpTqBbD82TALlaavOoUXK47P07igxT6b6/7pddxwrMJFWHkofWcCOtK
         q6Bv6gHJQ1tljOIe/+8VBS0WjOAOngriHIOzW3T3hRBEuoYAGm60X05EFZoekyHpYsFt
         6IM5pS6qj44SOMDKVHAvQtBYZ02AH/qEd7VHgkJ/zA/gIsu+Is8TjPlYQ3LemGOhy4ls
         wGCdLbt/LY3YIR5pA/xL7KxAHG06iRD38EDFNJ/uHELjjbXET15zBJGHH4+iHIIdTnoa
         uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/D28fWfWdJzUHVix7BI9GxltmT2+d98lgi6IpUKEDdY=;
        b=U3m3+FQR/4HXrKU6eBux91OTwYZ1MEcarIu04KjS6mFDvuZmFi32LWYTP+I2X1utgw
         IlGXYaMCMq3wMzpekgaftfC3rIRGbJqpZo4WU+JRgETcgA6tGRONUUv/HdDd5kr6m9yd
         I/Z4KDVV/Eyo3ZdXNG5qagv92+nVkuRJBrv8KFcBlCgmcd/VlmNmmwD4AfqzmsUq2AZy
         fH0tNw5MY91KqYR1XQ6jgNgDnlqPQcJ0j8yORUCgVTv+xYI8z/onxpJvsvOncCjytDo1
         yd01VcCThuitLnJePHSo2BX9TIQDzXwVBQfKLeH2Mys9V5iVOG5a6ZDs5YTA61j20sgA
         IG6Q==
X-Gm-Message-State: APjAAAVGlzQ1P/U/eIPXhoNx+alBHvgpxdReRJMjR6li+ef+TXGuSUjk
        69Q0ojax6FJLZCd3qOa7BKg=
X-Google-Smtp-Source: APXvYqx7V+w3u+YGizYvbbKac8Y18Xyfn/LtuVrGdmR9WDJC69XbvcxOprEe9bIvpivGOiwxwrcQ1Q==
X-Received: by 2002:a81:2d09:: with SMTP id t9mr3853041ywt.436.1556815267145;
        Thu, 02 May 2019 09:41:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id i13sm8755938ywl.22.2019.05.02.09.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 09:41:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCC24403AD; Thu,  2 May 2019 12:41:04 -0400 (EDT)
Date:   Thu, 2 May 2019 12:41:04 -0400
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190502164104.GB23984@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
 <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
 <20190501204115.GF21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506BF3@us01wembx1.internal.synopsys.com>
 <20190502143618.GH21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506D04@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2506D04@us01wembx1.internal.synopsys.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 02, 2019 at 04:09:43PM +0000, Vineet Gupta escreveu:
> On 5/2/19 7:36 AM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 01, 2019 at 09:17:52PM +0000, Vineet Gupta escreveu:
> >> On 5/1/19 1:41 PM, Arnaldo Carvalho de Melo wrote:
> >>>> The 1a787fc5ba18ac7 commit copied over the changes for arm64, but
> >>>> missed all the other architectures changed in c8ce48f06503 and the
> >>>> related commits.
> >>> Right, I have a patch copying the missing headers, and that fixed the
> >>> build with the glibc-based toolchain, but then broke the uCLibc one :-\
> >  
> >> tools/perf/util/cloexec.c  #includes <sys/syscall.h> which for glibc includes
> >> asm/unistd.h
> >  
> >> uClibc <sys/syscall.h> OTOH #include <bits/sysnum.h> containign#define __NR_*
> >> (generated by parsing kernel's unistd). This header does the right thing by
> >> chekcing for redefs, but in the end we still collide with newly added
> >> tools/arc/arc/*/**/unistd.h which doesn't have conditional definitions. I'm sure
> >> this is not an ARC problem, any uClibc build would be affected. Do you have a arm
> >> uclibc toolchain to test ?
> > This solves it for fedora:29,
> > arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install,
> > arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install and
> > arc_gnu_2019.03-rc1_prebuilt_glibc_le_archs_linux_install.
> >
> > Also ok with:
> >
> >   make -C tools/perf build-test
> >
> > Now build testing with the full set of containers.
> >
> > - Arnaldo
> >
> > commit 1931594a680dba28e98b526192dd065430c850c0
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Thu May 2 09:26:23 2019 -0400
> >
> >     perf tools: Remove needless asm/unistd.h include fixing build in some places
> >     
> >     We were including sys/syscall.h and asm/unistd.h, since sys/syscall.h
> >     includes asm/unistd.h, sometimes this leads to the redefinition of
> >     defines, breaking the build.
> >     
> >     Noticed on ARC with uCLibc.
> 
> Thx for this Arnaldo.
> 
> While this takes care of immediate issues, for the long term, are you open to idea
> of removing the header duplicity.

In the beginning we used the kernel headers directly, then, acting on
advice/complaints from Linus about tooling breaking when changes were
made in the kernel sources we were using directly, we moved to have
copies and notice when things change so that we could think about what
changed and act accordingly, without putting the burden to the kernel
developers to keep tools/ building, I want to keep it that way.

Now you say, validly, that there are bits that are designed to be used
by userspace, so for those, we should go back to not copying and using
it direcly, elliminating the duplicity you don't like.

I don't know, I'm used to the duplicity and the checks, not breaking
tools even when kernel developers make mistakes in the UAPI headers,
tools/perf is self container wrt the latest and greatest stuff not
present in older environments, and the onus is on perf developers to do
the sync.

This specific issue here happened because I made a mistake, which I
fixed when reported, now I have three containers for cross building for
ARC, two versions for the uCLibc based toolchain, one for the glibc one,
libnuma, elfutils and zlib are cross build there, so should make it less
likely problems like this will happen again.

> We could use a "less evil" idiom of copying only the minimal bits (since the sync
> onus remains one way or the other)
> e.g. I spotted below in bpf code and also seen in other ah-hoc multi arch projects
 
> #ifdef __NR_xx
> # if defined (__arch_y__)
> 
> # elif defined (__arch_z__)
> 
> # endif
> #endif

- Arnaldo

BTW: since the last report:

  25 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  28 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  29 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  30 fedora:30                     : Ok   gcc (GCC) 9.0.1 20190312 (Red Hat 9.0.1-0.10)
  31 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  32 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
