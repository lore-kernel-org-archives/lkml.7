Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9171CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F3207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAju3yDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfJVV6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:58:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45854 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731217AbfJVV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:58:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id b4so2563371pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eXGzF7dq1xTVTq11IVCExXEYGAuBuij8za1gI6IMyEc=;
        b=mAju3yDxsrfMAx8IHyZc18wnEhu0bCutzIoDjvCKoK5fFtrdmhM5TfQ2CCYV18ulAi
         zKUeeufW8u2rbgQNA4wAogwFIDoz1FQeHu3LsxSNHQJTKK+OKhKqGXkGSbOewTRLuJax
         iY3Kzu/sFzzthqMUMAIaot3ExJpNNrdXu5nusuKqWB4FB5YdLIRCfo61qIaO4yrv77ol
         XhNo9fYAAsxhCitI8gOcm8xsp8cLyE+mGREVT2b4qKyHAO3j9cJGIa3QW/9ZJq8hLKsh
         DGqHqZzIXrjy9gNxutWcrfiPPpltHGE49XlV4QEJ40myofebi+u1cR5jAQYXxz/LRCBf
         8Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXGzF7dq1xTVTq11IVCExXEYGAuBuij8za1gI6IMyEc=;
        b=pj/xyolzAuzQ1UOvDGaCxaD92ByVEE07n0+MT7OUdWUkOzT1dj3TJOl/pspA1ZKF3P
         UN95wtQ1Aw9DeRYKt5le6vJfUCBRmbLiqWK4HbviYPihGHLsq04BdSXwxBTwFuaB2SEZ
         RHcUoMW8N1EynU1iI8XmbBH2hf1vPbDzWeJrbKMKZOT7mPqf7GnBXRQcbOHaUcR3b9Da
         HCqAg5yUCO6J8F7er6E8sYzeIrws3Y3IvAls/6LwJjjiaIrhxgGukUmukt85WJDUIBZt
         8GnOadsei9dlJ4yrmQq8iDWL3htdwlMFRB6yQtJE/EW8A0YIVBwR+1QU4laapKZnPpXd
         pbQA==
X-Gm-Message-State: APjAAAXtZWjVOrdOdjLcBKAaK+gxmRtF8DUI25ZfULMjjOzYZJJrFxCP
        4QtRtjJKyPAXR5r9kruDPmK1GvW+
X-Google-Smtp-Source: APXvYqxMAKTn9qWk7Ka8q1g5HsxUjI25Ren7t315F41Aa1IGxjlJeoWMvHmfoQeU3zQCqZPljukcPg==
X-Received: by 2002:a17:90a:8c92:: with SMTP id b18mr7271418pjo.136.1571781526026;
        Tue, 22 Oct 2019 14:58:46 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1833])
        by smtp.gmail.com with ESMTPSA id g35sm19141045pgg.42.2019.10.22.14.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 14:58:45 -0700 (PDT)
Date:   Tue, 22 Oct 2019 14:58:43 -0700
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
Message-ID: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
 <20191021231630.49805757@oasis.local.home>
 <20191021231904.4b968dc1@oasis.local.home>
 <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
 <20191022071956.07e21543@gandalf.local.home>
 <20191022094455.6a0a1a27@gandalf.local.home>
 <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
 <20191022141021.2c4496c2@gandalf.local.home>
 <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
 <20191022170430.6af3b360@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022170430.6af3b360@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:04:30PM -0400, Steven Rostedt wrote:
> 
> I gave a solution for this. And that is to add another flag to allow
> for just the minimum to change the ip. And we can even add another flag
> to allow for changing the stack if needed (to emulate a call with the
> same parameters).

your solution is to reduce the overhead.
my solution is to remove it competely. See the difference?

> By doing this work, live kernel patching will also benefit. Because it
> is also dealing with the unnecessary overhead of saving regs.
> 
> And we could possibly even have kprobes benefit from this if a kprobe
> doesn't need full regs.

Neither of two statements are true. The per-function generated trampoline
I'm talking about is bpf specific. For a function with two arguments it's just:
push rbp 
mov rbp, rsp
push rdi
push rsi
lea  rdi,[rbp-0x10]
call jited_bpf_prog
pop rsi
pop rdi
leave
ret

fentry's nop is replaced with call to the above.
That's it.
kprobe and live patching has no use out of it.

> But you said that you can't have this and trace the functions at the
> same time. Which also means you can't do live kernel patching on these
> functions either.

I don't think it's a real use case, but to avoid further arguing
I'll add one nop to the front of generated bpf trampoline so that
ftrace and livepatch can use it.

