Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9883C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A848A2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272691;
	bh=RY7deLFuQ2+MXOQ+UyRqt5TEtBMVYn3waYXdiSMSnN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kYOCVLJSraKpPU27gdoEMlb7jgFCPfrDE7BLTMqaFvMEA0GhdtJPn3wA1fTM+AxbR
	 FeDiBdsX83wFgCaV1dcJadnaaojiKaL60L1RR1pxQGmSK9s7vWAwCBhCO+Ng/pcMy2
	 53cq/gkKDHB4MKJ0oHKw0n0U5X91qC1poZwzgdOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfDZJ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:58:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53538 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:58:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 26so3066686wmj.3;
        Fri, 26 Apr 2019 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YJCStWT0dNYPW3ntuISaTY+7m2TzWui5U3rbJsecnt4=;
        b=K85URiHSmAJ1R+AeUwGYyucXzeBGpSgFJxfInaFSv6ntKK/zvtuQaZaAHMqosXdqCQ
         PSwdwnK8AfCbRsW/xqF3cWnqK+cd8FYKwm1lw4QCJH13elJblsFe8d0B4rJmiaypHx2V
         BPKTRORhHEpvy4fMFoXLQACGi5sY1E9IPfW7Gus8e0NvyirHI1shKtQemU1+usuMcDvY
         yN+f5fiDh8kXry7A7CVvtVKcIK+17pib8MkhZzdPsM+nfv/EpYuyK3O/gTwUr/EbM0oj
         VIpstDsdgthviqEU9Rm/RpgvIMDfui0KeJJYGLxqA7m8pSj8BmzEJj7hUPmI0hkzSEgV
         0w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJCStWT0dNYPW3ntuISaTY+7m2TzWui5U3rbJsecnt4=;
        b=P0G4Bbxo3ompvRS5A5SGaJpDh9G6UQQC4m0Kn5MIkK0lecGtTDCWI5XgKcPviNqPlF
         WpdlGMY3OSYog/weJWOicxMd5BN0A0keXJWnnz9+x3sskMbB3FqktvRrJq9jT4FEMrKZ
         2+0t3Epnh1BK6P4wRdZKXMRLhnmvgVgAaI6qnvO+W9+obAPGUPcyFVx577RC/Q8Vsl0g
         HH6fozK8GuFnccppPf/8Gq4LiZ20PIjo+hemnTVmAvRSPQz/Iilp4cUgejqp/ROcKbpu
         nqEWv4vJyJimoCPwgts7wnKf2VDYHWaKWa0IJtRmluvHXcV02K+b8WHYw2weHx80cvDp
         D+7Q==
X-Gm-Message-State: APjAAAXrQPxqRwRs7KDpW7SaNg8oabjxbbiufdKgVFlLfoQBG0H4bknA
        xnvHWTmtdG48C+V/9nlBc10=
X-Google-Smtp-Source: APXvYqxU4xRSO//2LeLOAQNJAxp8x2iYJV7YGaHBJl6zzDXEGkhWiOOILZ/XwIJJg56oj/prXk8sRw==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr7232803wmc.51.1556272685405;
        Fri, 26 Apr 2019 02:58:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 4sm20102389wmg.12.2019.04.26.02.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 02:58:04 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:58:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
Message-ID: <20190426095802.GA35515@gmail.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
 <20190426083144.GA126896@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426083144.GA126896@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> I really don't like it where this is going. In a couple of years I 
> really want to be able to think of PTI as a bad dream that is mostly 
> over fortunately.
> 
> I have the feeling that compiler level protection that avoids 
> corrupting the stack in the first place is going to be lower overhead, 
> and would work in a much broader range of environments. Do we have 
> analysis of what the compiler would have to do to prevent most ROP 
> attacks, and what the runtime cost of that is?
> 
> I mean, C# and Java programs aren't able to corrupt the stack as long 
> as the language runtime is corect. Has to be possible, right?

So if such security feature is offered then I'm afraid distros would be 
strongly inclined to enable it - saying 'yes' to a kernel feature that 
can keep your product off CVE advisories is a strong force.

To phrase the argument in a bit more controversial form:

   If the price of Linux using an insecure C runtime is to slow down 
   system calls with immense PTI-alike runtime costs, then wouldn't it be 
   the right technical decision to write the kernel in a language runtime 
   that doesn't allow stack overflows and such?

I.e. if having Linux in C ends up being slower than having it in Java, 
then what's the performance argument in favor of using C to begin with? 
;-)

And no, I'm not arguing for Java or C#, but I am arguing for a saner 
version of C.

Thanks,

	Ingo
