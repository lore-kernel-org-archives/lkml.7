Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF8FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E9222DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h+wT/ZP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfIDIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:15:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8xiRs6NgS8fvd/+UV+w0Qzk1DQ616SFtyCDThl8RyjE=; b=h+wT/ZP+45fKgRqfPcAGvfyrfZ
        NW5Xg5fDPpkjhEWhIGb/hGmNS0nv7/RG2H8FozYfhnnwxJhoSxTECbSD3at/Zjij5TBo5NxDiwRKa
        5LpIDthafAwIpnrHU+5busxCo+Uk7Bjm2WKbFkQdnNVriGBDmIjswLzAzYXy3SoS5WTz8FbJSCazy
        tjLkuTBhJrAK3h8D8sGLCCCc8MESAGbjxnCgi00QKNd8I+lL4TL1Wjr24SwAyv+UqzaaCF4xvQgvW
        9u+qLFUu6rERGBQ/vnCfHj0HwlKvh/HrPBNXOxHLOvh2C0a+TfWT+fTFtZAdo+rkf6r9HkPHig623
        UgF9wXvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5QRH-0006tf-8p; Wed, 04 Sep 2019 08:14:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D0D1306024;
        Wed,  4 Sep 2019 10:14:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA79E29C349A6; Wed,  4 Sep 2019 10:14:48 +0200 (CEST)
Date:   Wed, 4 Sep 2019 10:14:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904081448.GZ2349@hirez.programming.kicks-ass.net>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904042310.GA159235@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:23:10AM -0400, Joel Fernandes wrote:
> On Tue, Sep 03, 2019 at 05:05:47PM +0100, Valentin Schneider wrote:
> > On 03/09/2019 16:43, Radim Krčmář wrote:
> > > The paper "The Linux Scheduler: a Decade of Wasted Cores" used several
> > > custom data gathering points to better understand what was going on in
> > > the scheduler.
> > > Red Hat adapted one of them for the tracepoint framework and created a
> > > tool to plot a heatmap of nr_running, where the sched_update_nr_running
> > > tracepoint is being used for fine grained monitoring of scheduling
> > > imbalance.
> > > The tool is available from https://github.com/jirvoz/plot-nr-running.
> > > 
> > > The best place for the tracepoints is inside the add/sub_nr_running,
> > > which requires some shenanigans to make it work as they are defined
> > > inside sched.h.
> > > The tracepoints have to be included from sched.h, which means that
> > > CREATE_TRACE_POINTS has to be defined for the whole header and this
> > > might cause problems if tree-wide headers expose tracepoints in sched.h
> > > dependencies, but I'd argue it's the other side's misuse of tracepoints.
> > > 
> > > Moving the import sched.h line lower would require fixes in s390 and ppc
> > > headers, because they don't include dependecies properly and expect
> > > sched.h to do it, so it is simpler to keep sched.h there and
> > > preventively undefine CREATE_TRACE_POINTS right after.
> > > 
> > > Exports of the pelt tracepoints remain because they don't need to be
> > > protected by CREATE_TRACE_POINTS and moving them closer would be
> > > unsightly.
> > > 
> > 
> > Pure trace events are frowned upon in scheduler world, try going with
> > trace points. 

Quite; I hate tracepoints for the API constraints they impose. Been
bitten by that, not want to ever have to deal with that again.

> >  Qais did something very similar recently:
> > 
> > https://lore.kernel.org/lkml/20190604111459.2862-1-qais.yousef@arm.com/
> > 
> > You'll have to implement the associated trace events in a module, which
> > lets you define your own event format and doesn't form an ABI :).
> 
> Is that really true? eBPF programs loaded from userspace can access
> tracepoints through BPF_RAW_TRACEPOINT_OPEN, which is UAPI:
> https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L103
> 
> I don't have a strong opinion about considering tracepoints as ABI / API or
> not, but just want to get the facts straight :)

eBPF can access all sorts of kernel internals; if we were to deem eBPF
and API we'd be fscked.
