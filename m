Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D09C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772E720651
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvQSxlDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDCPAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:00:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40045 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDCPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:00:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so15168951ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBgtZeqqgWhVA3vR38jD5K8DSLuvT8cbg05BJci4cXE=;
        b=tvQSxlDZAxNJTXUK4IZuY58zmESJvaFSHrkLirT5bvKMHbhUEkp6GcAf5FU5EvnuGn
         8OsS+cswW8FyBOTlSsyhpi5gO4IKNDk0dfUjT9zYLlI2BRifkQPCCKTgh5JV4yijqdlt
         E1LbvjgWXV2rtzQa3bJwn15pLoLecU53oFvGUBhLxtXGZs3tzsSv7+hxJ4FZDsMw2fzo
         dXka1BV+PR7lxbv1GqiOiA4KZmRHZ7P92a94Vt2evrcVUgxPAEI8fTeMPUcWCb/K48Xp
         keCSCC7qRvtWC4VfQffEEn4QVoH2V/Ne/6YgWSlNnkjv9vKCJycGw5bSA52h7vz4NFAA
         MY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBgtZeqqgWhVA3vR38jD5K8DSLuvT8cbg05BJci4cXE=;
        b=V22TZg8jCE+sp6LRFKlqxWbNc2t78V4MObgQWj9xdzTzbx7wPM3dzMI0qbV5JBXtwA
         VyzOrB6e1A8YKnqoUlTuQ66elN4PY+UZqmDpwbI2rN0vR0x7TsHcQqD3B2r9xBdDA5J9
         iHJem2JxDMb2UVm1nPtAskyjZKOAaRMH6rwpLV6WY6hZCGCIUeKwT2WgmASD3IjpQmr0
         dDf5k4eJtkBpdrHqpcSQq4SBmu0OGLr/EGtU2rA2u70FVAuk+QlcpUhiebYZBA8oZb1/
         RJKGIHvWvBNzvE5pPLZ2+NYt2hbBdCP1cNQb+FKX9W+KFAE1mxkGq3H3eK9+k0r6Char
         kCQQ==
X-Gm-Message-State: APjAAAUPNTCQG8RPRBiB+N8rb/N+sZnB2/T+SuXGNR9yY6DHp7Z+g5Dr
        p6uY5J3zBzl6LFLwBO/Y3Jw=
X-Google-Smtp-Source: APXvYqwFgmqk13823VqeLP/m24lrXysW4i7+zfrG3TmHdtALZjqDh+6TuFXw+kFNirYWEREoF1jSWg==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr143075lji.130.1554303627806;
        Wed, 03 Apr 2019 08:00:27 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id z15sm3289033ljz.55.2019.04.03.08.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:00:26 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 2E8DC46041B; Wed,  3 Apr 2019 18:00:26 +0300 (MSK)
Date:   Wed, 3 Apr 2019 18:00:26 +0300
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
Message-ID: <20190403150026.GF1421@uranus.lan>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
 <20190402130302.GL12232@hirez.programming.kicks-ass.net>
 <20190402132200.GA23501@uranus>
 <alpine.DEB.2.21.1904021050090.15645@pianoman.cluster.toy>
 <20190402150936.GB23501@uranus>
 <alpine.DEB.2.21.1904021709340.24692@pianoman.cluster.toy>
 <20190402213151.GC23501@uranus>
 <alpine.DEB.2.21.1904031009300.26186@pianoman.cluster.toy>
 <20190403142754.GE1421@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403142754.GE1421@uranus.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:27:54PM +0300, Cyrill Gorcunov wrote:
> On Wed, Apr 03, 2019 at 10:15:33AM -0400, Vince Weaver wrote:
> > > Mind to point me where json events should lay, I could try to convert
> > > names.
> > 
> > I was mostly joking about that.  But the event lists are in the kernel 
> > tree in
> > 	tools/perf/pmu-events/arch/x86/
> >
> > I don't think anything older than Nehalem is included.
> 
> I see ;)
> 
> > After letting the fuzzer run a bit longer I did manage to get it 
> > to hard-lock with no messages in the log, though eventually while I was 
> > fiddling with alt-sysrq over serial port did get this to trigger.
> > Though if I'm going to start reporting p4 crashes I should start a 
> > separate thread.
> 
> Oh. Will try to take a look on, thanks a lot!

Btw, Vince, is there a chance to fetch last seuqence the
fuzzer inserted into events input?
