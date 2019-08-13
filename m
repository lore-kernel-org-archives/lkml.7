Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A28C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5820840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNjNUq8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfHMNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:20:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34797 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfHMNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:20:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id q4so9093669qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+RqCx8Sz4OY7JG4Zjdah7/bCRanDWn604Hcnz3VVsc=;
        b=qNjNUq8zA8MmSyHBBcCk6bZPnsqx4TLLk+BKb6CH4zoKyNcO2VeDB7vgfzB6pWZVrg
         k2ZPyNHBYK9tPMGdMvl6c7yLtSzHUDVn2kGdunqkDQuyGyFmQn7si5Hh8aFijnB+acSF
         ucpwWO4nbjZ9saqnh/zPr6GCK0e8i0xXJ+I8YbFu8Oz3JIzO/hWtAanXAZ9+DhYDSffF
         Lo8hcLSrpx04GYQl29TyIEafngrgLs2bhh2jI8oPWPQQsG0KoQ8rYNjHUcMymZcwshEU
         qUC1A46/6Gq2/dPN0V++Q5mJB05qzPEAnPJhzQLJpAMPBPI9bDbW+142ucf03zTER08S
         7X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+RqCx8Sz4OY7JG4Zjdah7/bCRanDWn604Hcnz3VVsc=;
        b=hn+0TwTE5TSQOeort31nuw8CRB8AkNz7uxb4HqtSrHv8ESSEu7Ev5xBYvMpaE88ZCF
         CrLtane4e6LHNIrtFJN94sLR3SOaHVUYKFWHsiJ8YBPxV+qrrizYhBM7v0cnyHjw7qRK
         NvR8Hsnad6ri2PJLIEg+QOQL56R98j7LgRdxnnwyVnOIi8rryOFW6ajrDK1bOnVIBjj6
         QcTn/wZCSIXJ1aD+aX9jzag3qcMUvMJeToQ2Z2z9/EMqUJbqKMz+wl/T12/tmO8uLZFl
         uUvybjroO3PT7ZFCCKp/u/qwqQ6vvYwi0v0ElNYoLad7V4lKPCvrb2RfLVdbP633mCOy
         1Rfw==
X-Gm-Message-State: APjAAAUexIVi2WXVDKpNO/AEmTwXDT4mBdlZRsN4X6XSWYTBHCL2z/+7
        pK/NHM4EsFYJ4K3hDUEyywg=
X-Google-Smtp-Source: APXvYqwua5BPAkwUIl4HEdlri5HURtlX/H6492pLGLcmoLMBVmhK1tqHZucxQ3OMiZoT1jE9A/tQcQ==
X-Received: by 2002:ad4:5405:: with SMTP id f5mr33807554qvt.242.1565702431854;
        Tue, 13 Aug 2019 06:20:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v75sm51933501qka.38.2019.08.13.06.20.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:20:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 790F140340; Tue, 13 Aug 2019 10:20:23 -0300 (-03)
Date:   Tue, 13 Aug 2019 10:20:23 -0300
To:     "Lubashev, Igor" <ilubashe@akamai.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Message-ID: <20190813132023.GA12299@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <ad56df5452eeafb99dda9fc3d30f0f487aace503.1565188228.git.ilubashe@akamai.com>
 <20190812200134.GE9280@kernel.org>
 <20190812201557.GF9280@kernel.org>
 <735aabdfa76f4435bdaff2c63d566044@usma1ex-dag1mb6.msg.corp.akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <735aabdfa76f4435bdaff2c63d566044@usma1ex-dag1mb6.msg.corp.akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 12, 2019 at 10:33:07PM +0000, Lubashev, Igor escreveu:
> On Mon, August 12, 2019 at 4:16 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Mon, Aug 12, 2019 at 05:01:34PM -0300, Arnaldo Carvalho de Melo
> > escreveu:
> > > Em Wed, Aug 07, 2019 at 10:44:15AM -0400, Igor Lubashev escreveu:
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -279,7 +279,7 @@ struct evsel *perf_evsel__new_idx(struct
> > > > perf_event_attr *attr, int idx)
> > >
> > > >  static bool perf_event_can_profile_kernel(void)
> > > >  {
> > > > -	return geteuid() == 0 || perf_event_paranoid() == -1;
> > > > +	return perf_event_paranoid_check(-1);
> > > >  }
> > >
> > > While looking at your changes I think the pre-existing code is wrong,
> > > i.e. the check in sys_perf_event_open(), in the kernel is:
> > >
> > >         if (!attr.exclude_kernel) {
> > >                 if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> > >                         return -EACCES;
> > >         }
> > >
> > > And:
> > >
> > > static inline bool perf_paranoid_kernel(void) {
> > >         return sysctl_perf_event_paranoid > 1; }
> > >
> > > So we have to change that perf_event_paranoit_check(-1) to pass 1
> > > instead?
> 
> Indeed.  This seems right.  It was a pre-existing problem.
> 
> 
> > > bool perf_event_paranoid_check(int max_level) {
> > >         return perf_cap__capable(CAP_SYS_ADMIN) ||
> > >                         perf_event_paranoid() <= max_level; }
> > >
> > > Also you defined perf_cap__capable(anything) as:
> > >
> > > #ifdef HAVE_LIBCAP_SUPPORT
> > >
> > > #include <sys/capability.h>
> > >
> > > bool perf_cap__capable(cap_value_t cap);
> > >
> > > #else
> > >
> > > static inline bool perf_cap__capable(int cap __maybe_unused)
> > > {
> > >         return false;
> > > }
> > >
> > > #endif /* HAVE_LIBCAP_SUPPORT */
> > >
> > >
> > > I think we should have:
> > >
> > > #else
> > >
> > > static inline bool perf_cap__capable(int cap __maybe_unused) {
> > >         return geteuid() == 0;
> > > }
> > >
> > > #endif /* HAVE_LIBCAP_SUPPORT */
> > >
> > > Right?
> 
> You can have EUID==0 and not have CAP_SYS_ADMIN, though this would be rare in practice.  I did not to use EUID in leu of libcap, since kernel does not do so, and therefore it seemed a bit misleading.  But this is a slight matter of taste, and I do not see a problem with choosing to fall back to EUID -- the kernel will do the right thing anyway.
> 
> Now, if I were pedantic, I'd say that to use geteuid(), you need to #include <unistd.h> .

Right, and that is how I did it :-)

[acme@seventh perf]$ cat tools/perf/util/cap.h
/* SPDX-License-Identifier: GPL-2.0 */
#ifndef __PERF_CAP_H
#define __PERF_CAP_H

#include <stdbool.h>
#include <linux/capability.h>
#include <linux/compiler.h>

#ifdef HAVE_LIBCAP_SUPPORT

#include <sys/capability.h>

bool perf_cap__capable(cap_value_t cap);

#else

#include <unistd.h>
#include <sys/types.h>

static inline bool perf_cap__capable(int cap __maybe_unused)
{
	return geteuid() == 0;
}

#endif /* HAVE_LIBCAP_SUPPORT */

#endif /* __PERF_CAP_H */
[acme@seventh perf]$
 
> 
> > > So I am removing the introduction of perf_cap__capable() from the
> > > first patch you sent, leaving it with _only_ the feature detection
> > > part, using that feature detection to do anything is then moved to a
> > > separate patch, after we finish this discussion about what we should
> > > fallback to when libcap-devel isn't available, i.e. we should use the
> > > previous checks, etc.
> > 
> > So, please take a look at the tmp.perf/cap branch in my git repo:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.p
> > erf/cap
> > 
> > I split the patch and made perf_cap__capable() fallback to 'return
> > geteuid() == 0;' when libcap-devel isn't available, i.e. keep the checks made
> > prior to your patchset.
> 
> Thank you.  And thanks for updating "make_minimal". 

Ok!

 
> > 
> > Jiri, can I keep your Acked-by?
> > 
> > - Arnaldo

-- 

- Arnaldo
