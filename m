Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D1FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D85821881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6vp5dOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfIBE0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:26:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44878 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfIBE0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:26:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so6759898pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 21:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S99dbtNIAtu+fwZeUFVd1C5ofXlsVXppc5advXWFAIo=;
        b=B6vp5dOerKyW4NLf3UQOZPvA11me7OSFejt3Ba+/aik9Ypvc1YRH4Gy5f3yQguT6Hp
         b42hHB6zRWE4baUzr6mo6N/czsMsbYnTn3p6TXA2w9g6eSi7q+aILehWfoLrG99ZvU8h
         4pHRV774A4iRLlwoQ3bO+PXNHKp0Se3avQaoHLwexcJHb6D1aAzkpDWIQVW76bA6wqPl
         HcjBBVmCi79YdtG0UNFPJs8ySVDxmd6CRzSrD2gsHx5DHQP4wNW93jXFvqs9sZWV3I3B
         OXHgrE+CMZ41dAY7Hz701SORZdVgS+RuYPmlnUWVhJkSIBZlpfinaHTnUZZh0CsW5zLw
         rXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S99dbtNIAtu+fwZeUFVd1C5ofXlsVXppc5advXWFAIo=;
        b=Sbynry7fgMCZberqERsvVyGjkBcMzt3uEvr840QgoHpqYgJGaWyCuohV5sqBJc/5hG
         40qW++ooxberg3PjtICnJHF2X9SdMx3iTq6hnu6tpPbmwg6T9LbNqiw4cY3GtTUFtAJf
         /VVrBh/DoQMrUwzucCsHCy0aKRygJs7k8RuK469N4uZjrn9nHo1O2wpztR0L+5GQxRPA
         jX3HdUE1qjTIcCYXaq39lWJoHRcBRrzOSqLTGFj4u4CkdEEfcVrscYG5ubN6Id0eTr2m
         evo4g4/4AVWIv0tB1J1e+Df+MkP7THkPcXlKRJyU6L54qBd11nTeWHP2G+H8QVL7FOMA
         kviQ==
X-Gm-Message-State: APjAAAULuZxad8FLuUhQ+Mb3x6SyyqMAkwyUecSS1++23RySuJEq2wP/
        q8erur34hXiEyuG9Bw88qA==
X-Google-Smtp-Source: APXvYqy1/ntAqH/lkVfec8bhetu106SKNH+oiBAtpTg7cylPfqWEAgUb9YKZna3G3hV1NsR8mP+xpg==
X-Received: by 2002:a17:90a:a47:: with SMTP id o65mr11128422pjo.90.1567398414855;
        Sun, 01 Sep 2019 21:26:54 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s7sm2730630pjn.8.2019.09.01.21.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 21:26:54 -0700 (PDT)
Date:   Mon, 2 Sep 2019 12:26:42 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCHv2 0/4] x86/mce: protect nr_cpus from rebooting by
 broadcast mce
Message-ID: <20190902042642.GA22792@mypc>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
 <20190830141156.GB30413@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830141156.GB30413@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 04:11:56PM +0200, Borislav Petkov wrote:
> On Tue, Aug 27, 2019 at 11:02:19AM +0800, Pingfan Liu wrote:
> > v1 -> v2: fix compile warning and error on x86_32
> > 
> > 
> > This series include two related groups:
> > [1-3/4]: protect nr_cpus from rebooting by broadcast mce
> > [4/4]: improve "kexec -l" robustness against broadcast mce
> > 
> > When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
> > to unexpected rebooting by broadcast mce. After analysis, I think only the
> > following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
> > to fix that issue.
> > 
> > *** Back ground ***
> > 
> > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
> > 
> > The option 'nosmt' has already complied with the above rule by Thomas's patch.
> > For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary threads if
> > nosmt=force")
> > 
> > But for nr_cpus option, the exposure to broadcast MCE is a little complicated,
> > and can be categorized into three cases.
> 
> One thing is not clear to me: are you "fixing" a hypothetical case here
> or have you *actually* experienced an MCE happening while kdumping with
> nr_cpus < num_online_cpus()?
No, I do not hit this issue by myself.

But from the following two commits:
commit 5bc329503e8191c91c4c40836f062ef771d8ba83
Author: Xunlei Pang <xlpang@redhat.com>
Date:   Mon Mar 13 10:50:19 2017 +0100

    x86/mce: Handle broadcasted MCE gracefully with kexec
And
commit 506a66f374891ff08e064a058c446b336c5ac760
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Jun 29 16:05:47 2018 +0200

    Revert "x86/apic: Ignore secondary threads if nosmt=force"

This issue is in practice.

BTW, clarify one thing kdumping (kexec -p) will not suffer from mce
issue as described in case 2. Only "kexec -l" will.

> 
> Btw, pls do not use lkml.org to refer to previous mails but
> 
> http://lkml.kernel.org/r/<Message-ID>
OK, I will.

Thanks,
	Pingfan
