Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA0C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E3220644
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567671197;
	bh=xTzl3Bs9KH6EaXx8AUbfuR0tf5A0ejhhKi3vWyW3Qmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aRfajsMpXXlklxfpCIhWX6qd5IVHGAtSHnz3Zo7cgXVoZ1ud5+ed8HR0a2kl1KZ6l
	 8/3RMY/NqympoH/Z2e6ACawRQS/ZvcwoVi23KCVGVsvMvUWwgJj9XGZ47+IleM+naF
	 NxOskaDiuFEj0F0HPBIya8AS6vb8WKt81g51ftys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfIEINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:13:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36472 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbfIEINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:13:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so1751116wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2o/1YFznLwjV3F8hw+vjLNUnsNfENj5CCyIBGxY1daM=;
        b=QBTwnI40rOBh5j4QFkUbcDyDSPIS8IiSzfmmBZo2mUizQqXiSkFvJE4gFfoXzuVlV5
         1PrBh/IZ+ea5PRVyv/cC0ccviNZWlbHWP4sG+Yqi9gcco0j7v20pNv6HSl12YdzsnVun
         r4U9lfPClmyWBHaPfVMMYSQfKyuiXFS+auWTEW7GnjZ0qniacDOD/v6fX3R8/NkEYqdj
         hPCilQbUMLg4EBxacqbbbJu35nljeAwJPxmfXcdk9FaUnBl7uMMIeTd0m11TQQDJhpaX
         usGeCfceJoA94et6qeTtONBOUMwJmwTchcEWZRT3fAQ1NWj2RqzpkfpU6w2m5pVOIM9n
         1+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2o/1YFznLwjV3F8hw+vjLNUnsNfENj5CCyIBGxY1daM=;
        b=aZiS4OB4BLxeC6Gz5ztIuwgFON9RNdcPgWDYRxjAHhqN53cWac75YyvfPSKrTAHy19
         MTnYZzm6TOehujMLcZJuria2a6OK3M+5ByaPreox+4paptUe5hpENwo4/VYNy602UqjT
         Nrb8M3QUIl9+hrIzEIiLgBWTUXbLvcJ62pRk3CMX4f1PaHRBEOBBAtKLJgLruoqBJEtd
         sqKVHOlN+DJUFtJv3rZOUWVHAS9Bh5As2/9jGQkDdkEpX7kEr4D8Nl4Mj8fgt//WC7ZW
         3iJUYUHVYhyU2GJOImIg57DJoe7lqlFfhFHMP50/rtuHwxmjEzqTcrVKmASn7aJAkgti
         3REg==
X-Gm-Message-State: APjAAAWcuy6qtaXkCS8DTr3/NZzSa/ZiMp9OVBGaYuAQ1NEEAQW60gCg
        OJlUPW56TU4smoCZhbniC0s=
X-Google-Smtp-Source: APXvYqwigSNUr/U++R/UjraGEXmAABPisGmBPQx06e+pxK1ev5HaH5FE2Wy+sKcOymRYenFqiLUf4g==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr1733036wmh.157.1567671193801;
        Thu, 05 Sep 2019 01:13:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q25sm1342343wmj.22.2019.09.05.01.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 01:13:13 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:13:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>,
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
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190905081310.GA46285@gmail.com>
References: <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com>
 <CAADnVQJzgTRWUAaH+L6qwJvHk0vsLPX3eWdZNUr5X77TuEgvPw@mail.gmail.com>
 <20190904154000.GJ240514@google.com>
 <CAADnVQK+bSzFdZmgTnDSgibhJ81pR19P6hFArqmZa_xKA1r1VQ@mail.gmail.com>
 <20190904174707.GV2332@hirez.programming.kicks-ass.net>
 <CAADnVQJFXq0n1J+vFMwhNgGNBYXK+EsFaE_Zebp84wMOLN8TNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJFXq0n1J+vFMwhNgGNBYXK+EsFaE_Zebp84wMOLN8TNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Sep 4, 2019 at 10:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Sep 04, 2019 at 08:51:21AM -0700, Alexei Starovoitov wrote:
> > > Anything in tracing can be deleted.
> > > Tracing is about debugging and introspection.
> > > When underlying kernel code changes the introspection points change as well.
> >
> > Right; except when it breaks widely used tools; like say powertop. Been
> > there, done that.
> 
> powertop was a lesson learned, but it's not a relevant example anymore.
> There are more widely used tools today. Like bcc tools.
> And bpftrace is quickly gaining momentum and large user base.
> bcc tools did break already several times and people fixed them.

Are these tools using libtraceevents?

Thanks,

	Ingo
