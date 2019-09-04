Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1572722CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VfG/c4g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfIDPkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:40:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33515 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfIDPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:40:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so8429423pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GvicfsAfqa/gtGdsE0L36oJQ3kkI48A+dWUZ7j35D4o=;
        b=VfG/c4g5oJIBvmt5pWMZislpX+KLukRhZL1sG9G14pXUjLHjpAiQqcrVsJ7C9Aua3B
         m1rxH5DG8s2o4ykYcm+36c+MhrZuJZakaysa/qf8bCXs8NgTDJkxKOyS0pq/wwVrITWo
         mwxSXQB5B5KET4+28Vaqzh5UjgDIDkyCQGITA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GvicfsAfqa/gtGdsE0L36oJQ3kkI48A+dWUZ7j35D4o=;
        b=TTqlUyxQ8BV1z2968TLDtMb/n/tmCGzlSy9PiTnZpCW0uqZZmbObtwcVVh/ZUrgwJj
         psA0F513ahvNzq58S2Yl2KGvKpzvB5mW6ieIf+e5/LqVjgltRjtCfFvLraGKrTCbTyDW
         9x3mxZ0mtA9QOvHU5RqP7L/nepOwfEDOYUOaTlghB30+/CJUFYnlHCLFn1hQ3hlIWSnl
         1pgkEg/BK/RJvYNX9YcIeAeFkq0o1uGL7Hvxuc9VtSIg5ZeK+a8uZORfBfiKuM/a1H4x
         D2UPQPC0dMMx42mBobCw5hKr0D/f6VJhp/4yWMy5HtaWYikacu9FUdfA5zP+KmsqhS2M
         D/dQ==
X-Gm-Message-State: APjAAAVgYCNK/sLzt2cDclxC4AWMnRf6NJvobRoOk1FlpBrPbs+CTJYW
        xHydUtLULd0QXIcbSRMWeqVqmQ==
X-Google-Smtp-Source: APXvYqzUweEtiAVABd4fPedDHdh1xczj4h2M9w2tT85ztEkObsgSatUDVWY+La3Lw30eZxjecmlmmQ==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr35502649pgc.276.1567611602050;
        Wed, 04 Sep 2019 08:40:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s13sm24282593pfm.12.2019.09.04.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 08:40:01 -0700 (PDT)
Date:   Wed, 4 Sep 2019 11:40:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904154000.GJ240514@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com>
 <CAADnVQJzgTRWUAaH+L6qwJvHk0vsLPX3eWdZNUr5X77TuEgvPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJzgTRWUAaH+L6qwJvHk0vsLPX3eWdZNUr5X77TuEgvPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:25:27AM -0700, Alexei Starovoitov wrote:
> On Wed, Sep 4, 2019 at 6:10 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > I wonder if this distinction of "tracepoint" being non-ABI can be documented
> > somewhere. I would be happy to do that if there is a place for the same. I
> > really want some general "policy" in the kernel on where we draw a line in
> > the sand with respect to tracepoints and ABI :).
> 
> It's been discussed millions times. tracepoints are not abi.
> Example: android folks started abusing tracepoints inside bpf core
> and we _deleted_ them.

This is news to me, which ones?

> Same thing can be done with _any_ tracepoint.
> Do not abuse them and stop the fud about abi.

I don't know what FUD you are referring to. At least it is not coming from
me. This thread is dealing with the issue about ABI specifically, I jumped in
just now. As I was saying earlier, I don't have a strong opinion about this.
I just want to know what is the agreed upon approach so that we can stick to
it.

It sounds like the agreement here is tracepoints can be added and used
without ABI guarantees, however the same is not true with trace events.
Where's the FUD in that?

thanks,

 - Joel

