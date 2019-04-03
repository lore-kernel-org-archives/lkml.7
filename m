Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988ACC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C842084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVTXbwnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDCO16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:27:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34365 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCO15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:27:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id y18so11885957lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oj98AJ5SxCJqLbMaBKWyaYJnW7QhiHu8Umax6AYXRzg=;
        b=JVTXbwnKrP4XqH2OXIu7DZ+HYbx8jx01vo90plmsrDjdxd2SM4MQDC6P0tEAtkK4Xy
         qBCKicwOpygK5MHl/Kx6CYbDqeGzd2Qda98ELOvaI4cQailsWRsDCg5Oc2JO02Bqf+u8
         l8qaFqQEC1NoUK7klh5KSQftB4vv+Bx8XfGxOdIFGSJvgqrsqaz2KQxm1sS/eKAjqMnL
         PuhhGeLSqtiZogoFxnoowO10NzGDLBZJvscjX+4ixCyT6zreEh/8g9HVsOFCGhR+6TH8
         3w01JUsnVNBampzEliEzq+r+BJkaE7pPdYM0zVVGYGm3KSu70FuUGl+ibSjhAnmkKbqY
         FF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oj98AJ5SxCJqLbMaBKWyaYJnW7QhiHu8Umax6AYXRzg=;
        b=eH++UnVXGUIzKqgRMDNk94L7mnJb4n/LEQPFZdLHNnrC2lk0lde9RB+TLNxOyhzX/b
         V0iSFZBCdJqg6PwoWEIknezpR2UOL0AEqh1VoulE9tHO3C0pKWQyJuHFSkCII1kc3IXS
         oF8WQYp7kDOj3EW/3G195UlDQZOGzTLH+rF4LhO+fBAnCKgK7upsDFMlQGYx15cZLYJn
         ITq064/+jf8NSQhPuUlSGv4VpSapRLg6+EmO0WM/QHg33ue0XlCkkjIQId9befUndwIA
         x047CzGtnrICPRU+xGsQ5fRUjV78Pi6igoPjDo0cUk9ATJ4YCK1jd5XLrpfcuPmYxuGa
         N6/g==
X-Gm-Message-State: APjAAAUq3NiYPo8h0pqzT0PSfEJzqkuj64csQwrxCowr6J+4iH9K3KN2
        v79d43bTiFACj3zPmZ52Ebs=
X-Google-Smtp-Source: APXvYqxsq4+pl7CInZh9GNpCOBDgTmFk1J1ptFbgCZD2jax48w2mkJr4V33fsnF4o4K/lVeuJXMg7Q==
X-Received: by 2002:ac2:53a4:: with SMTP id j4mr34407lfh.106.1554301675661;
        Wed, 03 Apr 2019 07:27:55 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id d77sm3005396lfg.55.2019.04.03.07.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:27:54 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 14E4646041B; Wed,  3 Apr 2019 17:27:54 +0300 (MSK)
Date:   Wed, 3 Apr 2019 17:27:54 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vince@deater.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Message-ID: <20190403142754.GE1421@uranus.lan>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
 <20190402130302.GL12232@hirez.programming.kicks-ass.net>
 <20190402132200.GA23501@uranus>
 <alpine.DEB.2.21.1904021050090.15645@pianoman.cluster.toy>
 <20190402150936.GB23501@uranus>
 <alpine.DEB.2.21.1904021709340.24692@pianoman.cluster.toy>
 <20190402213151.GC23501@uranus>
 <alpine.DEB.2.21.1904031009300.26186@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904031009300.26186@pianoman.cluster.toy>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:15:33AM -0400, Vince Weaver wrote:
> > Mind to point me where json events should lay, I could try to convert
> > names.
> 
> I was mostly joking about that.  But the event lists are in the kernel 
> tree in
> 	tools/perf/pmu-events/arch/x86/
>
> I don't think anything older than Nehalem is included.

I see ;)

> After letting the fuzzer run a bit longer I did manage to get it 
> to hard-lock with no messages in the log, though eventually while I was 
> fiddling with alt-sysrq over serial port did get this to trigger.
> Though if I'm going to start reporting p4 crashes I should start a 
> separate thread.

Oh. Will try to take a look on, thanks a lot!
