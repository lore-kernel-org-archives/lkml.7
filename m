Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ADDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14A321783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6jZ5D4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfJVDz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 23:55:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35004 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbfJVDz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:55:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so9771305pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZAPGJLGkpLt03GDqGjl9b9EckNEBlsALSuZc6+cH8/4=;
        b=d6jZ5D4c6r3NrKHZbJkqoTviZCD8ZqX60zbv6be60XasYUIuTDOduZHnFMJsLa72Xz
         x9n/GTFtEr4m1RZyyg/1ramZ1jo3OmdO+Y7SYmX7rYnc2ypWX03ek9Wa5zC4Y+tMFJnU
         /zVwHuXcny5FfFnyKtK7C1IcQuHseCqzimtG660aZiuA/3m/RXdfScipE1wEIH7K80jZ
         Kt62zfznqbgzTtdIBgf9VMSOwloLk207gRRZ/M5i5ILTRN4X17X5eCVnR8O7R92RR05k
         xp9eqiFXyj3zMPNCOycy2ttjvIJqc6UNvjr17eBeZiz+Zmm/xAt79VkqXJFNAS7oYt1O
         s6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZAPGJLGkpLt03GDqGjl9b9EckNEBlsALSuZc6+cH8/4=;
        b=quhV9PotrMntqS4lyhn4jtZsjhkZb/eIa7xt2aqQuRs93e0wY3EhrUeDMQ2cPD7Vgl
         Z6DSDohX6+rgIzRv6Hy/vErXJGRx7IpEUmVpcvp9bki8E0bAt8w49lVlV0v7E1vjnESo
         3AK4Rh78lAmB7rqXG1Xw8BpjMtFwmoqmnvLETQEnSCB6T+EhYazQjgKaYyIgJryh2b3V
         ENeeLAaqnu1NUhd1cf7RYHepEypQTE2xxkFNZCNG1e+cd9FV08SERpDDK1BNWluRODuX
         Xu+Ky+1GPwiH75xlJvZ4e+4Hseu6St5ak3KLZRX+9Oe1IjskQ0PIehXompAhrsh1ZiRL
         FBkg==
X-Gm-Message-State: APjAAAXm7n6EHYWJA7iCoPm+SMTq3Uk6R154PK8+O7FadLAIViWg5CsJ
        2zXH8GsK4a+RSw1J90PwQoU=
X-Google-Smtp-Source: APXvYqxvMSQCdFnvF/ClWtdev/15UTiIVsTDUqmidFubVcHpf1/7TznCmQTDBKDWIDsMmvKZnheNAw==
X-Received: by 2002:a63:798c:: with SMTP id u134mr1390014pgc.255.1571716527302;
        Mon, 21 Oct 2019 20:55:27 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::5ac])
        by smtp.gmail.com with ESMTPSA id a17sm17824887pfi.178.2019.10.21.20.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 20:55:26 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:55:24 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022035522.mz5l7edak3beor5u@ast-mbp.dhcp.thefacebook.com>
References: <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
 <20191004112237.GA19463@hirez.programming.kicks-ass.net>
 <20191004094228.5a5774fe@gandalf.local.home>
 <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
 <20191021204310.3c26f730@oasis.local.home>
 <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
 <20191021231630.49805757@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021231630.49805757@oasis.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:16:30PM -0400, Steven Rostedt wrote:
> On Mon, 21 Oct 2019 20:10:09 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Mon, Oct 21, 2019 at 5:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Mon, 21 Oct 2019 17:36:54 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > >  
> > > > What is the status of this set ?
> > > > Steven, did you apply it ?  
> > >
> > > There's still bugs to figure out.  
> > 
> > what bugs you're seeing?
> > The IPI frequency that was mentioned in this thread or something else?
> > I'm hacking ftrace+bpf stuff in the same spot and would like to
> > base my work on the latest and greatest.
> 
> There's real bugs (crashes), talked about in later versions of the
> patch set:
> 
>  https://lore.kernel.org/r/20191009224135.2dcf7767@oasis.local.home
> 
> And there was another crash on Peter's latest I just reported:
> 
>  https://lore.kernel.org/r/20191021222110.49044eb5@oasis.local.home

ahh. I missed the whole thread. Thanks for pointers.

