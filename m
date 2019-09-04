Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF18C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE4208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j8BzkZJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfIDPdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:33:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44241 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfIDPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:33:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so11430127pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3kcbaL/1fESm1XYy129LIbIvwPTrSucVHChLcYsxsWQ=;
        b=j8BzkZJv0O8HVhwRw3qMr1dggn4YXfZl1q/RlZVu+OLzV2jtURAQe8aPl+jdcTeJpa
         OxS0PlsSLfjqP9CiI2xtkaMxj/Jt4F/6qpv7HQ0ue0dA3MxB7oEHcwrnWxHQ/7ftxMcg
         EQVUF3m6Sm8qptj/LXedVF66waaxzuYDtsvcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3kcbaL/1fESm1XYy129LIbIvwPTrSucVHChLcYsxsWQ=;
        b=UKtAM/054b6dHGKF+NCJ2mZ82lnknpJdFXvzJb8BsErSkp2rzRZH4hQM89BZgerjdG
         ET14pScjsXs/1tLz8QlJE1VYKlQjs0G/cshslZmMBlM6t3mZ+LtPWMh8hkZ8co9KTM/A
         TVu2cwdKhWFdAuTWpiX1cAj9klBYZMWx92IRrH4jqZ201g8UPy8I0ueITojUHW0/5+bH
         kC2VxxktML0wNu9qFOb1k3W7Bp2q4AsZVA3suhMbmhFtyol7tBZQ6C4CMoXZexxiNlTb
         7x6W/nQgHjVWKMW/3aKQHQG8Fk9+kG6Hw6TLW+gYl+wmns+/oxoOKbZtdRI/liqz5yUY
         2BzA==
X-Gm-Message-State: APjAAAVdpmfsWcMKN6grtIaAKBA7FbQGTQwhX5I720jXfUc32dVIUTgI
        cTKu0LLVzhhjGqWW+He3uEo7xg==
X-Google-Smtp-Source: APXvYqwRo8tS4ffSfRcrepXI+v0YsYS0IP4WrQL/xxVzIl1GBhwSqroiHAAM7nsQ+imN2IU+VME2Vw==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr35165804pgc.20.1567611211761;
        Wed, 04 Sep 2019 08:33:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s5sm5679088pfe.52.2019.09.04.08.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 08:33:31 -0700 (PDT)
Date:   Wed, 4 Sep 2019 11:33:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904153330.GI240514@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904081448.GZ2349@hirez.programming.kicks-ass.net>
 <20190904131154.GF144846@google.com>
 <CAADnVQL3CsB6z98BFWd8wn7WKk+W4UVH2NbzrhJgeaU-D-n3ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL3CsB6z98BFWd8wn7WKk+W4UVH2NbzrhJgeaU-D-n3ug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:26:52AM -0700, Alexei Starovoitov wrote:
> On Wed, Sep 4, 2019 at 6:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > True. However, for kprobes-based BPF program - it does check for kernel
> > version to ensure that the BPF program is built against the right kernel
> > version (in order to ensure the program is built against the right set of
> > kernel headers). If it is not, then BPF refuses to load the program.
> 
> This is not true anymore. Users found few ways to workaround that check
> in practice. It became useless and it was deleted some time ago.

Wow, Ok! Interesting!

thanks,

 - Joel

