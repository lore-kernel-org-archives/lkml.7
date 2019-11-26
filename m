Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0102075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574797852;
	bh=PJJvjHXAofqLmu0WfsCB9VUY6nRNoTbh+T/qp4YtI9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sgK2uxkNCpKWdtqngetUNk8IKrw6js3NcKMi+QUbrtI7zz2JJ6WH67CgQwT3j9w2B
	 OuZCakCa1B1KqWPDVl3vfqwU/Nswekof51CfH3/wGZWm5DpfRIvj4EwHa02fnfW2fT
	 Vuvo7aNCFCfZ00eru99vs7pnlFAyw8BMxXfizjrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfKZTuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:50:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46776 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:50:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so20487709wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 11:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/tMewCSYdyfn+L7GfDnRAKYDrh2mFjiFkJGGeqNoMiY=;
        b=pOCnkJGK5RwKOSfVZuawo3iWK4nlOr0uhE+SX45+xeA+SnVvuh59pfGOtF6hJ26mNa
         YTxJhsgp5Tu9PWAsq6eEIVP/VSsgK73ZVv111qHUYyMjclcpphhXPKjFHsF4cKE0LS0E
         X4lnRy+6nWU7sRG9sIAt6oCGOjt+L9p1QHKXWPAcbhjmxFX5nIATpmN3/dsXqHh5t0bs
         ZGAZL0US3GMA+aqvnwrAnXx9i3UgHtLlB1w9ow0hpGwRXIxIn0GpHTgRCAeWZOfASxah
         a0QCgTs2StUtgKCwuTA66vQ/l4y463Kxc50B3+/O+Sw0tPRXUx5N2DSlSaW/LlyRpWab
         O1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tMewCSYdyfn+L7GfDnRAKYDrh2mFjiFkJGGeqNoMiY=;
        b=S0u6JaqZmmgqGexxXasIbgsTVToLv/BHVrhD5d34S8/vEzc9J77QhZaaaW7efr9dbB
         ay6x9wiTsIrIe+6Cqs2yoGAAu8GhxDJNHB0aud1sF6JhiIsm3e3dfqQPz0CvsJ4Xvhoa
         3e2tS2wfI6X7Zi5Vfoj7U+fqO6vr08N3K0UGYLzX4wm0HFXXsS7xuFVKnS83s9hCYJBs
         WKEU5T8XGWVt3w6bUCjZBQc5L9N/+h71kPTZUGHKwcBW70jUGncrKn4nD4fESZ4GTCRG
         XmyxaDRaRxwJ2dNFUitubfkMADigH92PHIl7LasYFpsV34YEFoN5OTTOD1MPxwkqIw0i
         k9FA==
X-Gm-Message-State: APjAAAVnFVXAv73RjZ9YyPqcDs9+korvmru1R3rFMMKrHweh0Gkrb3Fq
        Yq81k6jOMWvM3OKsDwg+RTs=
X-Google-Smtp-Source: APXvYqyA2VQhPA4tI5GtMlM4c3kOPlYEIqwuLZILs2+go4T+SccCxLDsHzqSS18U/LZryY2q5BN/2g==
X-Received: by 2002:a05:6000:1602:: with SMTP id u2mr41199641wrb.249.1574797849162;
        Tue, 26 Nov 2019 11:50:49 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q15sm4441105wmq.0.2019.11.26.11.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 11:50:48 -0800 (PST)
Date:   Tue, 26 Nov 2019 20:50:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [GIT PULL] x86/iopl changes for v5.5
Message-ID: <20191126195046.GA28296@gmail.com>
References: <20191125161626.GA956@gmail.com>
 <CAHk-=whswxd9b0A9Sr5YhjcGbA0WKrB8Rrtx89PLKeP6RdKT3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whswxd9b0A9Sr5YhjcGbA0WKrB8Rrtx89PLKeP6RdKT3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Nov 25, 2019 at 8:16 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > This tree implements a nice simplification of the iopl and ioperm code
> > that Thomas Gleixner discovered: we can implement the IO privilege
> > features of the iopl system call by using the IO permission bitmap in
> > permissive mode, while trapping CLI/STI/POPF/PUSHF uses in user-space if
> > they change the interrupt flag.
> 
> I've pulled it.
> 
> But do we have a test for something like this:
> 
>    ioperm(.. limited set of ports..)
>    access that limited set.
> 
>    special_sequence() {
>        iopl(3);
>        access some extended set
>        iopl(0)
>    }
> 
>    go back to access the limited set again
> 
> because there's subtle interactions with people using *both* iopl()
> and ioperm() and switching between the two. Historically you could
> trivially do the above, because they are entirely independent
> operations. Does it still work?
> 
> Too busy/lazy to check myself.

Yes, I went through the code with such scenarios in mind and I believe it 
all works correctly: the two bitmaps are independent and the granular one 
is preserved across iopl() interactions. But to make sure I'll write a 
testcase as well.

In any case I agree that this kind of behavior is very much part of the 
ABI, so if it doesn't work like that we'll fix it. :-)

Thanks,

	Ingo
