Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E95C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2B020693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT41n3az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfDDQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:47:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36824 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDDQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:47:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so2720305ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuUJCkkF8EMeJhXuUWpVcEjJ3aQNWsOOW9Ft9o4wkUw=;
        b=vT41n3azLBzPxsjuLtHLjhEXyWSoRrYcY8AOY4/ad1KCN3DBKMX3gZK+X+yigUPKUo
         rx6foXla0O3fYtS+m9Dfa03GpjfFELLvkGaTC8d2TbzYfmisEP/k7saD8BfKPDLe8UZV
         jGC+sjzPxo6lCGNdoOrvdBWMyVebByL2ZlDU/rKQNvBCRwFYiEZFtI8TyBsYf4xeqH6p
         4O/XHAIRuwNNKBvyc9jcBHf6KQgiIZAKelygbp3jnr6ECDqM/oD90VA9HKJCZwZUe7i1
         pyXP5Te5qbzyoxx8NHtzWjL/1fqYfHDcIPwvacC344nkbCmdraQYfXhczaBsbUox1Qbd
         EvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuUJCkkF8EMeJhXuUWpVcEjJ3aQNWsOOW9Ft9o4wkUw=;
        b=NjYZbBsscexaoatQoqjHaGSDaO500jT9a3hosIm65SMpH7oB78UlMpN4kBnweKxfg8
         gVZ9YM87Qh9bBK89B4u9tsYVwqrbsSjJ8lb31xkebJ3beZdW7jcR6MzlL+/axCjMpJDF
         uvHeLlEvKceoHmNwEknkJB/n3wHpL6mFOlWBLQ0VLSOMLyZ62oaRoZbHYpz2hzk9rphg
         nmuTxE0OJxd369GsjcbLu46iqAahaad5HLtzibyoxdSi0esS4HxlMTjWuoYhb5TgO4j9
         oPvN3KGO0+JN/yOF7UlA3OicE9y/cKZ1M7WT785pFi6LU97Wg+dNSaSxkFwSgJBR6SHN
         JjJA==
X-Gm-Message-State: APjAAAXuzA2LeTaSWD+vkU5B59LL6FllNlDGYehVutuiTVahFrGOQ7qT
        jBXYoRrc8BUGOU5hrC3qsrp6qcEh
X-Google-Smtp-Source: APXvYqwIH35wa0aknRh53RHPK4HJD8UsM+ImzyK4tKGrlpokK5Qc0Lec99iRXt6HjV2MmKcjk1bgNw==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr4086539ljj.166.1554396422353;
        Thu, 04 Apr 2019 09:47:02 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id i66sm4079357lji.43.2019.04.04.09.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 09:47:01 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 73C21460438; Thu,  4 Apr 2019 19:47:00 +0300 (MSK)
Date:   Thu, 4 Apr 2019 19:47:00 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
Message-ID: <20190404164700.GR1421@uranus.lan>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
 <20190403191944.GH1421@uranus.lan>
 <20190403203144.GI1421@uranus.lan>
 <alpine.DEB.2.21.1904040922350.3758@macbook-air>
 <20190404133327.GP1421@uranus.lan>
 <alpine.DEB.2.21.1904041234340.5098@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904041234340.5098@macbook-air>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:37:18PM -0400, Vince Weaver wrote:
> On Thu, 4 Apr 2019, Cyrill Gorcunov wrote:
> 
> > On Thu, Apr 04, 2019 at 09:25:47AM -0400, Vince Weaver wrote:
> > > 
> > > It looks like there are at least two bugs here, one that's a full 
> > > hardlockup with nothing on serial console.  The other is the NULL 
> > > dereference.
> 
> OK, it turns out the hard-lock and the null pointer dereference might be 
> the same, I have a random seed for the fuzzer from a hard-lock crash that 
> reproduces and it generated the null pointer crash.  (This is with your 
> patch applied).

I see. My patch simply eliminates wrong event for unimplemented general
events, but it definitely won't help with nil deref, so it mostly to
eliminate some potential side effects.

> I can try to see if I can bisect down to a specific event sequence that 
> triggers this, but that can be tricky sometimes if things lock up so fast 
> that the event log doesn't get written out before the crash.

Oh, Vince, I suspect such kind of bisection might consume a lot of your
time :( Maybe we could update perf fuzzer so that it would send events
to some net-storage first then write them to the counters, iow to automatize
this all stuff somehow?
