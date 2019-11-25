Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9F12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574709902;
	bh=v6FGd1lqEgDtXL/wBt47STEzMUAYliz4YTSgwqaucwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TE1O4ZIF+Bz8W3+7H6KtlhWbABmiqS7sbnuUsTZqklAIQPz12sy11HgG2lnWmpMt3
	 1IrroQrU4RVSOVxmu8xdqgrdeV6/JzLjSs92f5hwSdDG+hGj2mtk1vSbH/nXBLJYCJ
	 IXgWfqYezZWvXhieDmq4I3/I9Ut8QpS6Ft3avfg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfKYTZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:25:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33912 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:25:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so19580272wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 11:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pX+jP0VMeyaCRPdibFeZwIbp3iegmjllINJQxyeM76Y=;
        b=PAj9cycX7gT6AU3M2k/O9wTEUn9aKHlIllLfKkLl8CmoMvTVxj7svge4B89KNS1fmG
         v/TVGLDxx1j1wf+Qc9ks2fkRwRhWcYVSZwz+tgiUtKJKSoEWajR/AtD8SEfzQt/SW7ml
         6Hm7eCG3iM9OeU1gc7QBbxCVHWZoDINTEuYDtsWbwO24FiH88cWmSOYixcGMaFyap58e
         RPF9lLWKYKo2RPyja1CXcGetveL+YGEwrHgE1wTGqqJjxFHRLdYvqfpWscEt5qmFV4K/
         JzP6I/tIYqSiqeHSswTQVrLbGJ9uhJBOp/ggMbKBJzBf9JOJqQTXIZfXef143Fc7Eg8m
         pgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pX+jP0VMeyaCRPdibFeZwIbp3iegmjllINJQxyeM76Y=;
        b=V3Af3FI474S3HpJCDTX4bvIFpyn9OZIwo25RqrhFh/wnpNTPKB1j3SnRxpyB4XcQNo
         umtCvwtBm0XFZNjDFsHOCEc+5tB8lKjiVujCXkgZLP29FOkdZJZQ4GmvGVBJHlfbtlY2
         Gi9V1ZJoeZAHu+F8iudME2n4gpcUkCePhBsTO3v6fw47aZbji7/H5IO4bOBy31CzMdS7
         aG5QTETzpt5B/3LA5DkC9RmZbuaWL2AMIFNZEuJ91X+MNbY+0+lu01/lWNxd9iq6P9Oc
         CYRhcTjUfARTKiQ7mHZJSue3uiTa0hiAFRItWQLjM4uqlkrA4zRfpHkA0+byWOpkDyNU
         Sj7A==
X-Gm-Message-State: APjAAAVUoYry842PF+llX9JZCm4SF/6qaxH4APDSU6em4uviTcQks8sT
        vJOJqpquGmhLNQ27/7X8W3g=
X-Google-Smtp-Source: APXvYqypDJR9W6mHaPZgbEKzvbARtv7zE245M/8c2P1uOBc2rdF/lAmg8V8dK+cJWyNeAyVgIkbs3w==
X-Received: by 2002:a5d:414a:: with SMTP id c10mr35429915wrq.100.1574709899503;
        Mon, 25 Nov 2019 11:24:59 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x7sm11425170wrq.41.2019.11.25.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 11:24:58 -0800 (PST)
Date:   Mon, 25 Nov 2019 20:24:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [GIT PULL] x86/iopl changes for v5.5
Message-ID: <20191125192456.GA46001@gmail.com>
References: <20191125161626.GA956@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125161626.GA956@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest x86-iopl-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-iopl-for-linus
> 
>    # HEAD: e3cb0c7102f04c83bf1a7cb1d052e92749310b46 x86/ioperm: Fix use of deprecated config option
> 
> This tree implements a nice simplification of the iopl and ioperm code 
> that Thomas Gleixner discovered: we can implement the IO privilege 
> features of the iopl system call by using the IO permission bitmap in 
> permissive mode, while trapping CLI/STI/POPF/PUSHF uses in user-space if 
> they change the interrupt flag.
> 
> This tree implements that feature, with testing facilities and related 
> cleanups.

Forgot to list the conflicts that may arise if you merge this after the 
other x86 bits.

Firstly the symbol bits would conflict here:

            arch/x86/entry/entry_32.S
            arch/x86/kernel/head_32.S
            arch/x86/xen/xen-asm_32.S

I've resolved them in tip:WIP.x86/asm if you want to double check:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/asm

but usually you do the resolutions better. :-)

There's also a conflict in arch/x86/include/asm/pgtable_32_types.h.

But there's also a semantic conflict that would trigger if you pull this 
after the x86/urgent bits, interacting with:

  05b042a19443: ("x86/pti/32: Calculate the various PTI cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise")

After that commit the CPU_ENTRY_AREA_PAGES value has to be precise, and 
edited to 41 in the merge commit if I did everything write with the pull 
requests.

This too is resolved in tip:WIP.x86/asm, in the following merge commits:

  22d7b9359a9a: ("Merge branch 'x86/iopl' into x86/asm, to resolve conflicts")
  7543765dd362: ("Merge branch 'x86/urgent' into x86/iopl, to resolve conflicts")

Thanks,

	Ingo
