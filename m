Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D62922CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VmifIS+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfIDPq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:46:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbfIDPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:46:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so7267358pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j0l523Ij4e8m//xpFaU6A50xYdK/8fF+iRy7KtwFx8U=;
        b=VmifIS+Hzwcp7gvGnIH7uWKsaXk17f+X12W5SfvHDPzJ5fQUft4XIzSDX0m9dJAbGe
         og9/FW4LFKTQhe6hz4+1gun/ezqkxxbrHoZj7cr0Ex6q3b7o3CyHD8TKoJhatirZLoBm
         tNjR1ftQcuI2/Wlak80JL65Uqk86OP18E3dTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0l523Ij4e8m//xpFaU6A50xYdK/8fF+iRy7KtwFx8U=;
        b=Lk6G7UXFRyOkViPVIoxUb2NzgQwRmUglZokpSGSgmqhxArb+uLAlnkRvPiu3hE51ZO
         JYgaECuN7HVv0X+74K0lJkn+zc7izMcphGMJ4mbI65OCDte9oyAQSjRy2kbiQJOzyP5X
         wiZHUzfVMdpCFqS1eUWdfVLH7eaksESqsdhxGTT1cHY/nZfX08rQrZVOdNZkLjERyJ30
         rq3qcgivzPrZ6ZsoZDY3LIpVijYdpoEblU4gkKiQJGH0TChw5XtFkkyBG+Dz/Q6xsZ5I
         wrhGy804lGGwJtFXTeBAKYV5U8peroitUvpmagFO5r8OL6gaODWBTANHMo2tKbrzzioi
         5weQ==
X-Gm-Message-State: APjAAAVrzunoTIGuqJAD68ev6o30wGGWK+gLzKUrDYJQV/wQSPlCnnA2
        0pTxIWqyOppUULnu+ehTsrxHbDkj82g=
X-Google-Smtp-Source: APXvYqw8nlWr2mvzRU3Jynbuwe79iUGOEiUK2ov9JQYV3oMhDWNxUa5BgLDCe3ZM/lvZgxySSfM3XA==
X-Received: by 2002:aa7:90c1:: with SMTP id k1mr45696911pfk.46.1567611988668;
        Wed, 04 Sep 2019 08:46:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 127sm7721561pfw.6.2019.09.04.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 08:46:27 -0700 (PDT)
Date:   Wed, 4 Sep 2019 11:46:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
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
        x86@kernel.org
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904154626.GL240514@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com>
 <20190904142017.kz7dj2cc43wvs4ve@e107158-lin.cambridge.arm.com>
 <20190904144159.GE240514@google.com>
 <20190904145759.xljofuqibwbwxzfx@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904145759.xljofuqibwbwxzfx@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:57:59PM +0100, Qais Yousef wrote:
> On 09/04/19 10:41, Joel Fernandes wrote:
> > On Wed, Sep 04, 2019 at 03:20:17PM +0100, Qais Yousef wrote:
> > > On 09/04/19 09:06, Joel Fernandes wrote:
> > > > > 
> > > > > It is actually true.
> > > > >
> > > > > But you need to make the distinction between a tracepoint
> > > > > and a trace event first.
> > > > 
> > > > I know this distinction well.
> > > > 
> > > > > What Valentin is talking about here is the *bare*
> > > > > tracepoint without any event associated with them like the one I added to the
> > > > > scheduler recently. These ones are not accessible via eBPF, unless something
> > > > > has changed since I last tried.
> > > > 
> > > > Can this tracepoint be registered on with tracepoint_probe_register()?
> > > > Quickly looking at these new tracepoint, they can be otherwise how would they
> > > > even work right? If so, then eBPF can very well access it. Look at
> > > > __bpf_probe_register() and bpf_raw_tracepoint_open() which implement the
> > > > BPF_RAW_TRACEPOINT_OPEN.
> > > 
> > > Humm okay. I tried to use raw tracepoint with bcc but failed to attach. But
> > > maybe I missed something on the way it should be used. AFAICT it was missing
> > > the bits that I implemented in [1]. Maybe the method you mention is lower level
> > > than bcc.
> > 
> > Oh, Ok. Not sure about BCC. I know that facebook folks are using *existing*
> > tracepoints (not trace events) to probe context switches and such (probably
> > not through BCC but some other BPF tracing code). Peter had rejected trace
> > events they were trying to add IIRC, so they added BPF_RAW_TRACEPOINT_OPEN
> > then IIRC.
> 
> Looking at the history BPF_RAW_TRACEPOINT_OPEN was added with the support for
> RAW_TRACEPOINT c4f6699dfcb8 (bpf: introduce BPF_RAW_TRACEPOINT).
> 
> Anyway, if you ever get a chance please try it and let me know. I might have
> done something wrong and you're more of a eBPF guru than I am :-)

eBPF guru and me? no way ;-) I have tried out BPF_RAW_TRACEPOINT_OPEN before
and it works as expected. Are there not any in-kernel samples? Perhaps Alexei
can post some if there are not.

thanks,

 - Joel

