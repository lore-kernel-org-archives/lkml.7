Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6620C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9536420656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bWmIb+W1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfEHCA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:00:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33037 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfEHCA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:00:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so9101323plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7lkKlWarMcmCQ856FYfrh6ypdVg/VPirY77fSPvi4dc=;
        b=bWmIb+W13o7hQ7Arb4CrEiaXAnQXSkX6/b5Z/ZXsZRuwnYaV9W5ZyVrP6vAj5UADmr
         oJBIJtY494JAKpjGSlw9hLqo2E9zSMLkLnNkFodbwUgsdhs/UVyDYv5AI5RxGL7P7j2X
         w0F41/ZsHo+idE6xBP6NWAzvrTtQJuSJSd890=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7lkKlWarMcmCQ856FYfrh6ypdVg/VPirY77fSPvi4dc=;
        b=YWJFf9S+IUUa2cBiY2EA/98viLev2kjDmlGxBUZKKu4F+2rSXIaBOyL/tAgp7D4UsA
         HdtCJpEW7rlCQ6pKTMaO0CiEohszKPFMecXB2rYf3LWvwZ2fvvcWS9i8/Gs73BRgsJh6
         gywKsYJ5/V3r7tPub1dwvouRk5lGD7xG1rJ5hgkuYremzQkDYDW8JgOT4UjmcEoaSGiM
         AM1kKvKWiHqSFRwemGjdshaqLVHyfdL0QK8aGK1Y/kRs/VgCmiz8hrS0dahsPBfK1mR6
         qtdEbYBp00c9CPfbWqvybu1VU1Dhe2mGt2zrLcMBOMwTrrAG4OxtE+aYLSH0GTPP6zxZ
         1CDg==
X-Gm-Message-State: APjAAAWnQxUZbWy8YXna6qUbNg8pxiPCoEKvdM9jGWR3fMIBiRvDb086
        HV4YwRcM1uGQ7GTg0dT/DHOq931ZDMM=
X-Google-Smtp-Source: APXvYqw57+9AV/J9ht8xnAsWf4KN8plduZMRXaxqJxdD7UnLJjK/X1KkU9TLvi4LUBZ/1oPLu+PALw==
X-Received: by 2002:a17:902:e305:: with SMTP id cg5mr43978820plb.112.1557280826492;
        Tue, 07 May 2019 19:00:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s198sm30036178pfs.34.2019.05.07.19.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 19:00:25 -0700 (PDT)
Date:   Tue, 7 May 2019 22:00:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org,
        Michal Gregorczyk <michalgr@live.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Mohammad Husain <russoue@gmail.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        duyuchao <yuchao.du@unisoc.com>,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, netdev@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH RFC] bpf: Add support for reading user pointers
Message-ID: <20190508020023.GA184577@google.com>
References: <20190503134935.GA253329@google.com>
 <20190505110423.u7g3f2viovvgzbtn@e107158-lin.cambridge.arm.com>
 <20190505132949.GB3076@localhost>
 <20190505144608.u3vsxyz5huveuskx@e107158-lin.cambridge.arm.com>
 <20190505155223.GA4976@localhost>
 <20190505180313.GA80924@google.com>
 <20190506183506.GD2875@brain-police>
 <20190506205807.GA223956@google.com>
 <20190506215737.cuugrrxbhkp2uknn@e107158-lin.cambridge.arm.com>
 <20190507095242.GA17052@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507095242.GA17052@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 10:52:42AM +0100, Will Deacon wrote:
> On Mon, May 06, 2019 at 10:57:37PM +0100, Qais Yousef wrote:
> > On 05/06/19 16:58, Joel Fernandes wrote:
> > > > If you're trying to dereference a pointer to userspace using
> > > > probe_kernel_read(), that clearly isn't going to work.
> > > 
> > > Ok. Thanks for confirming as well. The existing code has this bug and these
> > > patches fix it.
> > 
> > 5.1-rc7 and 4.9.173 stable both managed to read the path in do_sys_open() on my
> > Juno-r2 board using the defconfig in the tree.
> 
> That's not surprising: Juno-r2 only features v8.0 CPUs, so doesn't have PAN
> or UAO capabilities. The SoC Joel is talking about is 8.2, so has both of
> those.
> 
> Here's some background which might help...
> 
> PAN (Privileged Access Never) prevents the kernel from inadvertently
> accessing userspace and will cause a page (permission) fault if such an
> access is made outside of the standard uaccess routines. This means that
> in those routines (e.g. get_user()) we have to toggle the PAN state in the
> same way that x86 toggles SMAP. This can be expensive and was part of the
> motivation for the adoption of things like unsafe_get_user() on x86.
> 
> On arm64, we have a set of so-called "translated" memory access instructions
> which can be used to perform unprivileged accesses to userspace from within
> the kernel even when PAN is enabled. Using these special instructions (e.g.
> LDTR) in our uaccess routines can therefore remove the need to toggle PAN.
> Sounds great, right? Well, that all falls apart when the uaccess routines
> are used on kernel addresses as in probe_kernel_read() because they will
> fault when trying to dereference a kernel pointer.
> 
> The answer is UAO (User Access Override). When UAO is set, the translated
> memory access instructions behave the same as non-translated accesses.
> Therefore we can toggle UAO in set_fs() so that it is set when we're using
> KERNEL_DS and cleared when we're using USER_DS.
> 
> The side-effect of this is that when KERNEL_DS is set on a system that
> implements both PAN and UAO, passing a user pointer to our uaccess routines
> will return -EFAULT. In other words, set_fs() can be thought of as a
> selector between the kernel and user address spaces, which are distinct.
> 
> Joel -- does disabling UAO in your .config "fix" the issue? If so, feel
> free to use some of the above text in a commit message if it helps to
> justify your change.

Disabling CONFIG_ARM64_UAO does "fix" it.

I will use the description above in the commit message as you suggested,
thanks a lot for the explantation of this!

 - Joel
