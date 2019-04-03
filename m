Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4073C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279D2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCy7AnfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDCPNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:13:21 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:36969 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:13:21 -0400
Received: by mail-lj1-f176.google.com with SMTP id v13so15235376ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4+ELUeI9XqzsIFrW1Yov7j70MDy7sYet0rClq9sbIU=;
        b=BCy7AnfSEpoggVO2Kb9VPO0zsSDtEMfdzt3phhnTSynkec8yszAqxGNS1JdPxZALzb
         Lnci3wkRhnyUkzGdu+bXygB4/PqRmFhsctSbmqMxXyL5ISLfM1US6IOgWKfSvkkrCqWm
         7UFKvxNTU89x3GGaLr1eqt0yyZ0G1hZKqsAYBs+anAAxt1+mZV26Lf9xjosT20jMQpb5
         q1euvDSkH92flbqdY6iiazouIesdo69o5CKBGv26nmyA4SuTG9Cg2sidB/p5kNg34ojd
         TgCoHbvDVhyvey/cPvNknCHhhMOsDLWrBxxvvggTOCKWez9D5s/WPtyM4Q6NMU5zTaiC
         nKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4+ELUeI9XqzsIFrW1Yov7j70MDy7sYet0rClq9sbIU=;
        b=MkRsY1uuu61MU8sbQWfSIZNc9LLDlGooLb4BX4CjwfZy5f2U2x/aoYiMmQgPePwVeX
         2ChxYm2F2Rp6+JTNqTOEQXxtvA6O48IWZIrX8ePQKJg1n4jhSpOkKAC5egZo/Lu060r+
         f/KPBLsONHk/Gs+ltNT7Djgm+1XIbrEpzaSwJvCNOAit8Xk+NyStTnJzWF+W1jDXGr+X
         /+YkyzgMTibAfyTN6sR/ff2ezlVjUkkedx4GKbfwRhy5KOzZfBS7WJNHy7u0ceUTkO8I
         Qi7FXcI6HXJ2coy2wjkJBNXatuKHlw3V+9GTttqmKE9KB9TgEX3YohdcmZvWj5gCfdrX
         GYmQ==
X-Gm-Message-State: APjAAAXjktAi3HAi3TqpDxbso+ZEaEi7gp/y5zMatNMFpgT2jVS2TpXd
        FDJ7gul/YCzHJXCKG90eKb8=
X-Google-Smtp-Source: APXvYqzsurfdl5eSpzhnaAMrIUtR5Hu2xi7qBbbI+QuQ/HkQaf6sFuGTVJuCPa3YK6YgsX2BxlPn8g==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr160427ljg.93.1554304399374;
        Wed, 03 Apr 2019 08:13:19 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id j28sm3260865lfh.81.2019.04.03.08.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:13:18 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 1178246041B; Wed,  3 Apr 2019 18:13:18 +0300 (MSK)
Date:   Wed, 3 Apr 2019 18:13:18 +0300
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
Message-ID: <20190403151317.GG1421@uranus.lan>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:59:32AM -0400, Vince Weaver wrote:
> 
> so moving this to its own thread.
> 
> There was a two-part question asked.
> 	1. Can the perf-fuzzer crash a Pentium 4 system
> 	2. Does anyone care anymore?
> 
> The answer to #1 turns out to be "yes"
> I'm not sure about #2 (but it's telling my p4 test system hadn't been 
> turned on in over 3 years).
> 
> In any case the perf_fuzzer can crash my p4 system within an hour or so.  
> The debugging from this isn't great, I forget what the preferred debug 
> things to enable in the kernel hacking menu are.
> 
> Here is one crash that just happened:
> 
> The instruction at RIP is unhelpfully
> 	./arch/x86/include/asm/processor.h:400
> which is
> 	DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;
> 
> Though looking at the assembly it looks like
> 	p4_pmu_enable_event() is called with NULL as the paramater.
>

Interesting! I'll look more carefully at evening. As far as I remember we
rely on active_mask bit set completely, not sure how it could happen that
we get nil here. Thanks for pointing!
