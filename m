Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A353C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594102190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuAw0E9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfCURQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:16:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40558 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfCURQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:16:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so7475981wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DKcQGM8M4debln5K+3Jr7J/PvGT3qJUxVI5tds+CAlU=;
        b=RuAw0E9oSQ36GGjNk7pH4PhOtLc5/drrQkZOalyEinXHjwlYfUpuVqHxPjs6c55D3Q
         0YMzOsojikHxyi3yPtSE2D1q2Tb6WVWzjDXrob3vRAu4MRiItjLSUq+kNPgPme0+/SmP
         JfpnrcSnDHZBGT0qPyTBx88P3eNmn5M5+rid2z3H/71nVyqrFA9qiwOnoz2C4v+21Yg8
         jIO3DysD+x2T2JKIE5IvIFSXd/L45RLzNwghYi1QWZCWHRyHKhsSYScidk5QH0/48GW7
         4mXgtlc2xgQZFmEuJZi398TvuI1E12ycp1Al+Ktph4Y9Xrsb042X+ndQOfV1WWKVmrTo
         /nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKcQGM8M4debln5K+3Jr7J/PvGT3qJUxVI5tds+CAlU=;
        b=Ld2pebujPSoLKtUuvyorHh+fTb07TlBqZhsfhNaypSMcNOW/sPiD1uSURMxlHcrGes
         xgvNizawoZSzhnRt3odMBmbGidZ16k/CMlk3BiFS1a2Jh6B2noEGChPcDyhc5cug52Ai
         c2J/ZDLPamPslbxzyR746rsUHqkRHGWSpE8zojASAWtqqbhRHEPDEFVMvhkaTPazo9Fg
         CfJIcu4eopVvtJi7qWxrupK960kQR0koaRDjsYvD7XI+EDfUgiJT88Rg5dNUSa1qhcJu
         FADIB8sL3frtzFD53cRTqvbm65ga8A6kJOxwERrK9J7lK9Jp1Ogg9Wq4x1ohpAD1Fpw2
         QwhQ==
X-Gm-Message-State: APjAAAXSbJBg9hIN3Zq3jT/GZ1Wi/R7mAPZN1c1P5eyEMpiJwyczhkig
        YCCvw4py+x9HC9BZU8fIwsv+2g==
X-Google-Smtp-Source: APXvYqw39MepSfBGbkLJBG287reRgsRnmwvehwsi/ftep//V+7skxQvnDqFZnOpPeeCfkx4GwxJdcQ==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr3257001wrn.324.1553188573982;
        Thu, 21 Mar 2019 10:16:13 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t2sm11491232wra.9.2019.03.21.10.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 10:16:12 -0700 (PDT)
Date:   Thu, 21 Mar 2019 17:16:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-kernel@vger.kernel.org, patches@linaro.org
Subject: Re: [PATCH] perf arm64: Use local headers for target compiler
Message-ID: <20190321171610.wv6gcdc7jd54mato@holly.lan>
References: <20190321161353.16198-1-daniel.thompson@linaro.org>
 <20190321163917.GH3967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321163917.GH3967@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:39:17PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 21, 2019 at 04:13:53PM +0000, Daniel Thompson escreveu:
> > Currently the set of available syscalls is generated from the
> > target compilers default <asm-generic/unistd.h>
> > (i.e. /usr/include/asm-generic/unistd.h on a self-hosted system).
> 
> It shouldn't, Kim?

Adding a bit more detail... if I take that last line from mksyscalltbl
and run it without -dM we get the following:

ash$ gcc -E -x c $KDIR/tools/arch/arm64/include/uapi/asm/unistd.h | grep '^#'
# 1 "../arch/arm64/include/uapi/asm/unistd.h"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "../arch/arm64/include/uapi/asm/unistd.h"
# 21 "../arch/arm64/include/uapi/asm/unistd.h"
# 1 "/usr/include/asm-generic/unistd.h" 1 3 4
# 1 "/usr/include/asm/bitsperlong.h" 1 3 4
# 22 "/usr/include/asm/bitsperlong.h" 3 4
# 1 "/usr/include/asm-generic/bitsperlong.h" 1 3 4
# 23 "/usr/include/asm/bitsperlong.h" 2 3 4
# 3 "/usr/include/asm-generic/unistd.h" 2 3 4
# 34 "/usr/include/asm-generic/unistd.h" 3 4
# 502 "/usr/include/asm-generic/unistd.h" 3 4
# 707 "/usr/include/asm-generic/unistd.h" 3 4
# 828 "/usr/include/asm-generic/unistd.h" 3 4
# 21 "../arch/arm64/include/uapi/asm/unistd.h" 2

With the extra -I we pick up the included file from the $KDIR/tools
instead.


Daniel.

> 
> > The numeric values are then generated by the host compiler using
> > tools/include/uapi/asm/unistd.h .
> > 
> > This leads to some nasty version skew problems (including failed perf
> > builds if you are running a bleeding edge distro and want to build an
> > older version of perf for testing).
> > 
> > Let's make the target compiler use the local headers too.
> > 
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > index c88fd32563eb..1aca6a839e4f 100755
> > --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > @@ -56,7 +56,7 @@ create_table()
> >  	echo "};"
> >  }
> > 
> > -$gcc -E -dM -x c  $input	       \
> > -	|sed -ne 's/^#define __NR_//p' \
> > -	|sort -t' ' -k2 -nu	       \
> > +$gcc -I $incpath/include/uapi -E -dM -x c  $input \
> > +	|sed -ne 's/^#define __NR_//p'		  \
> > +	|sort -t' ' -k2 -nu			  \
> >  	|create_table
> > --
> > 2.20.1
> 
> -- 
> 
> - Arnaldo
