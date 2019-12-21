Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC88B206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qCRXjEvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLUX1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:27:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUX1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:27:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so7247664pfb.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HEmZZukzj2SW5GPtr7DXQtejZIIVJMFpYqi+rGbIeHc=;
        b=qCRXjEvK3FW59zErd5qNjoropEEmHyOByBkC6gLLJEKM/tbqmfCDxExpAjsYDuo2cK
         ZDrYTc1+CvI1vWS0dH5wqQhEgDnkhJUMKyko6t7w9wpbHItBNelMLeA6DsxKfdNz0NWe
         9IMtO6GpcvUgZgLyR15gOz068sDit9g+Degp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HEmZZukzj2SW5GPtr7DXQtejZIIVJMFpYqi+rGbIeHc=;
        b=cR55TUDIrVdxKEXdnGEqEzve/TL38wqWSzXt3Yy8+A+xYOJMSUqSWp3UuOSFMvOxrt
         /cgkQ/4UgK8HJP46qFJ0bAzQRm37hU3dnpCFTkdU296wqlim1hLyiA7cNqdYW8rWrkmt
         7SykfJSEVS8DKU/pjRgG7UUozX7y9XqWS2P6OVjGy/5eoafDRlJHCp0eJQEx3v+OlLip
         4ZOMOyMuEtBGa0xx836ePQcXjBot0WCUoagp1aXNLs28Y65hgt/SOwmjYYwNxYJPwtry
         RD8+fBgq1ueFGcFAqFbp6YnbwRx37aQOIqLYA8z5dntatjuGhEFI0nIA4RpX6fbczfzl
         hCxQ==
X-Gm-Message-State: APjAAAVwxy8XcC88A/OQbtJOzLIWshBD4tLiS078oNL4QKxJlEiZ4k9U
        Rr2Zlh2IeTV41GCLTuzWWB5/4A==
X-Google-Smtp-Source: APXvYqyiARfhrneCiqBALllYbrSMObMCjhtUs5Mb/fxbzNbiXtGb6M35R413rPViHbkZqTaCg+3Jbw==
X-Received: by 2002:a62:8f0d:: with SMTP id n13mr11417163pfd.38.1576970869113;
        Sat, 21 Dec 2019 15:27:49 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q7sm15456513pjd.3.2019.12.21.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 15:27:48 -0800 (PST)
Date:   Sat, 21 Dec 2019 18:27:46 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, ambroise.vincent@arm.com
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq enable/disable
 events
Message-ID: <20191221232746.GB67625@google.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
 <20191204160407.GB17404@google.com>
 <6b5b74cede87a61d5f04f2a95bc4389830467fe9.camel@st.com>
 <68b3b7db-d278-6cd2-f2b6-cbba05df6db4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b3b7db-d278-6cd2-f2b6-cbba05df6db4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 06:45:25PM +0000, Valentin Schneider wrote:
> On 07/12/2019 00:00, Antonio Borneo wrote:
> > At login:
> > trace-cmd record -e preemptirq:irq_enable sleep 1
> > trace-cmd report trace.dat | head
> > and I incorrectly get only the offsets to _stext:
> > cpus=1
> >            sleep-197   [000]   280.378022: irq_enable:           caller=0x1afaS parent=0xc00091S
> >            sleep-197   [000]   280.378026: irq_enable:           caller=0x54d34S parent=0x78e00000S
> >            sleep-197   [000]   280.378029: irq_enable:           caller=0x1afaS parent=0xc00a84S
> >            sleep-197   [000]   280.378032: irq_enable:           caller=0x263dS parent=0x78e00000S
> > ...
> > 
> > With this patch I get the expected/right result:
> > cpus=1
> >            sleep-210   [000]   525.177583: irq_enable:           caller=trace_hardirqs_on_thunk parent=entry_SYSCALL_64_after_hwframe
> >            sleep-210   [000]   525.177587: irq_enable:           caller=__do_page_fault parent=(nil)S
> >            sleep-210   [000]   525.177590: irq_enable:           caller=trace_hardirqs_on_thunk parent=swapgs_restore_regs_and_return_to_usermode
> >            sleep-210   [000]   525.177593: irq_enable:           caller=do_syscall_64 parent=(nil)S
> > ...
> 
> FWIW Ambroise (in Cc) and I were staring at some irq enable/disable traces,
> and encountered exactly this on a Pixel3 running a mainline kernel. With
> Antonio's patch we got the expected result, so you can have:
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>

In BCC, we use the binary trace record of this tracepoint and don't interpret
the text output.  There we lookup _stext value (I believe from kallsyms) and
then apply the offset to that and do another look up for the final symbol.

Would it be possible for Ambroise to work more on this patch so that the
trace record size is not doubled?

> >> I am not comfortable with this patch at the moment, mainly because it will
> >> increase the size of this rather high frequency event. But I'm not saying
> >> there isn't an issue on 32-bit. Let's discuss more.
> >>
> > 
> > Sure, the pressure on the trace buffer will increase on a 64 bit system, but in general it also has more memory than an embedded 32 bit system.
> > The key point is, instead, can we feel safe with a 32 bit offset in a 64 bit system? Is there any guarantee a module is loaded within 32 bits offset from _stext?
> > 
> 
> You're better placed than I to know if and when this is the case, but I
> wouldn't use this in a production environment. To me this is more of a
> debugging tool (and a really good one at that), so I am less concerned
> about the memory overhead.

The issue is with poor trace buffer utilization, you could overflow the trace
buffer more easily, and lose trace data. The reason I came up with the stext
delta approach was precisely to address this and it worked when I was using
this tracepoint. Let me find some time this evening to work more on
Ambroise's patch.

thanks,

 - Joel

