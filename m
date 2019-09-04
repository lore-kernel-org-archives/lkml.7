Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F58C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BC921883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d7+hNZWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfIDEXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:23:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41748 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDEXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:23:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so5744613pfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vgx/JXR+xsDdowArTuVaRCNwjOEb391A40/id0tFqc4=;
        b=d7+hNZWo6qi/Ei1kERkoCd9yUP3jMZTGVpswBCXwELQ+V66Tq9qjqOahSovrSsqtw4
         eqmDU/Fkj3aJDbzGf3w359r+7lQ0j3e/XpJzomoS7cMAxP1uBHotGcuG32W9nmnpqEQz
         csKGqd6Nyjut44kghWQaw9W7wo0gDpKTmPOQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vgx/JXR+xsDdowArTuVaRCNwjOEb391A40/id0tFqc4=;
        b=TR+y+EPl95P/ukTMAHUAOQjEvMFuPeHkBkuFPrsCQdVM2F17PwSRklfkl0lco+G3fU
         IPn5m6VyqkAI2fdEmF4MSxaddCCMmIk+nGTrR8xSYF+vJ5knVR4sQcXCu3yZ8rXLyGbE
         byfYxK1oPaBTW+4f+43dtdk/4ReoIuRm5UaNIXSNfwsnnIiNrWLbMjeOTXO6J0M3YsjH
         PXoNCakntUOQ92H1pM2tjTrA+6lcgRm8yKVnDXn+V7a7af22PjXIjPv42kvEkYIdtoQ5
         1qWOEefT7SZCXx3+AzCl0x0AE6p3E8tCzM3Qtvk96W+7jjwrIHlzezuP0VxJq7gk8mxq
         A1Jw==
X-Gm-Message-State: APjAAAVcUQINEaotDYmKLlUZTmgRkcpSexne1ErhkkKosv8jok4r/vHd
        b1lDYD2p2ZujCrhVFlUqgWolrA==
X-Google-Smtp-Source: APXvYqzyQeVMaZwCveC4tlMombFJKmyQ4R+pOzTSLE9Hwz74c7ky1wf6HzqSVLNs+gfymYrWyyVAKg==
X-Received: by 2002:a62:d4:: with SMTP id 203mr13060737pfa.210.1567570991448;
        Tue, 03 Sep 2019 21:23:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j128sm17865153pfg.51.2019.09.03.21.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:23:11 -0700 (PDT)
Date:   Wed, 4 Sep 2019 00:23:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190904042310.GA159235@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2924d91-df68-42de-0709-af53649346d5@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 05:05:47PM +0100, Valentin Schneider wrote:
> On 03/09/2019 16:43, Radim Krčmář wrote:
> > The paper "The Linux Scheduler: a Decade of Wasted Cores" used several
> > custom data gathering points to better understand what was going on in
> > the scheduler.
> > Red Hat adapted one of them for the tracepoint framework and created a
> > tool to plot a heatmap of nr_running, where the sched_update_nr_running
> > tracepoint is being used for fine grained monitoring of scheduling
> > imbalance.
> > The tool is available from https://github.com/jirvoz/plot-nr-running.
> > 
> > The best place for the tracepoints is inside the add/sub_nr_running,
> > which requires some shenanigans to make it work as they are defined
> > inside sched.h.
> > The tracepoints have to be included from sched.h, which means that
> > CREATE_TRACE_POINTS has to be defined for the whole header and this
> > might cause problems if tree-wide headers expose tracepoints in sched.h
> > dependencies, but I'd argue it's the other side's misuse of tracepoints.
> > 
> > Moving the import sched.h line lower would require fixes in s390 and ppc
> > headers, because they don't include dependecies properly and expect
> > sched.h to do it, so it is simpler to keep sched.h there and
> > preventively undefine CREATE_TRACE_POINTS right after.
> > 
> > Exports of the pelt tracepoints remain because they don't need to be
> > protected by CREATE_TRACE_POINTS and moving them closer would be
> > unsightly.
> > 
> 
> Pure trace events are frowned upon in scheduler world, try going with
> trace points. Qais did something very similar recently:
> 
> https://lore.kernel.org/lkml/20190604111459.2862-1-qais.yousef@arm.com/
> 
> You'll have to implement the associated trace events in a module, which
> lets you define your own event format and doesn't form an ABI :).

Is that really true? eBPF programs loaded from userspace can access
tracepoints through BPF_RAW_TRACEPOINT_OPEN, which is UAPI:
https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L103

I don't have a strong opinion about considering tracepoints as ABI / API or
not, but just want to get the facts straight :)

thanks,

 - Joel

