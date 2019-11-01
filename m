Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF7CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05685208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XR0UyO54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfKACLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:11:03 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35184 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:11:03 -0400
Received: by mail-yb1-f196.google.com with SMTP id i6so3326710ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1IpQ5yrU/zKS5eXo+I63m9HfKa17nh+pWeMiMjnE5U=;
        b=XR0UyO54FjhAyQkQzh7uMgu6WhMIK60RDQ6oDi5wxF/Yqm3YSYq8FvrDTUcLusiRlh
         r7AV3lNFk8ppjPP6Y0js06Oyo9pBjdRtNKUYdH6ahFzQ9GofPxePI351Rs2u9zu8NeOs
         W+9Ko2Dv48OJlU2Ds5u3ZDbhm7X7jrbcd4AH7x9VXvmtfYI9A0u/gVAYcR85EuwRPIKw
         OtQvPzWYEEPxT7/YJp2F2YtX+7BkeFxufrLkwjKhC84YDNSyS+BZeeqecmCkjbNScEDx
         biqj6Qt+z6zt+9pkg4Z7AfaEJDa2DbnQEFEem+zZiOrLJ9w/CUQFBw1E62unH5XE5/6S
         8clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1IpQ5yrU/zKS5eXo+I63m9HfKa17nh+pWeMiMjnE5U=;
        b=WDpGGCWMppz9v7R+Ftqr42MBdiZyvLgBsXypK5NdQIFHWicblTV0vvPk1Ao8XMkA6T
         nnymYsG4lZqojrlCXxMEqS4jjw8/4VnSKWohMuFa+xDLcnRFNZcYtLlaqUrZ73KYm+ZU
         S4Eii9+MIRdeVxRznICDaVIecNTIXnK5kxv6b8sSuMxQbtnSzNsF6TR9d78Tito0K+Jb
         GC46mThpkB/hGdobTmfiRtyhiqBpUMHrAswquOBUNq9JZCn64//emThoGY8N2wAf4MYY
         0phH1hdyVzJqJFZe0Oi2KD07BSOK4cG9F76BVzKPQWovKuhiMz1a0h5IhYzpzOFWaa/k
         DhMg==
X-Gm-Message-State: APjAAAXhI5Ncy+9Kp21/yFJgyOvCyxrWonB6TClagBdN1saias1Omo2N
        EU29Kwn+9zsXADN2Y3TwC+P/Vg==
X-Google-Smtp-Source: APXvYqzId8ITMPZB5pucnrOhtG+7QX9MsMLQS+7xdbkIg/NP3vcVVaoArxzucVKcuMTQxcdPtg3UUA==
X-Received: by 2002:a25:7343:: with SMTP id o64mr7148385ybc.513.1572574262530;
        Thu, 31 Oct 2019 19:11:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id m5sm3773775ywj.27.2019.10.31.19.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 19:11:01 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:10:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: Re: [PATCH v1 0/4] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20191101021055.GA26019@leoy-ThinkPad-X240s>
References: <20191024151325.28623-1-leo.yan@linaro.org>
 <CANLsYkzaB2kU20ibuDJVokYeEEuR8wd7MoHzX9+UKnM0jNV1Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzaB2kU20ibuDJVokYeEEuR8wd7MoHzX9+UKnM0jNV1Jg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:14:15AM -0600, Mathieu Poirier wrote:
> On Thu, 24 Oct 2019 at 09:15, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch series is to address the issue for synthesizing instruction
> > samples, especially when the instruction sample period is small enough,
> > the current logic cannot synthesize multiple instruction samples within
> > one instruction range packet.
> >
> > To fix this issue, patch 0001 avoids to reset the last branches for
> > every instruction sample; if reset the last branches when every time
> > generate instruction sample, then the later samples in the same range
> > packet cannot use the last branches anymore.
> >
> > Patch 0002 is the main patch to fix the logic for synthesizing
> > instruction samples; it allows to handle different instruction periods.
> >
> > Patch 0003 is an optimization for copying last branches; it only copies
> > last branches once if the instruction samples share the same last
> > branches.
> >
> > Patch 0004 is a minor fix for unsigned variable comparison to zero.
> >
> > To verify my changing for synthesizing instruction samples, I added
> > some logs in the code, and reviewed the output log manually for
> > instuctions samples.  The below commands are tested on DB410c board:
> >
> >   # perf script --itrace=i2
> >   # perf script --itrace=i2li16
> >   # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
> >   # perf inject --itrace=i100il16 -i perf.data -o perf.data.new
> >
> >
> > Leo Yan (4):
> >   perf cs-etm: Continuously record last branches
> >   perf cs-etm: Correct synthesizing instruction samples
> >   perf cs-etm: Optimize copying last branches
> >   perf cs-etm: Fix unsigned variable comparison to zero
> 
> I have reviewed and agree with the changes in this set but won't move
> forward until Mike has looked at patch 2/4.

Thanks a lot for reviewing, Mathieu.

Sorry I forgot to loop Mike in this patch set, and respin patch for v2
and have sent to mailing list.  @Mike, please review patch set v2 as
you received, Thanks!

Thanks,
Leo Yan
