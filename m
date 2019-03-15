Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E4721871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Toeo1V79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfCOQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:05:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbfCOQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:05:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so5593681wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XLI2HCON5YgIbqI6uqZN3/0Os3N+01JmEtsAvmHd1rg=;
        b=Toeo1V79ZYn11mZRN1vRNh2/DnToeUdoNIz9mzs7vY9Tdbg+bhLlIDJXTH4kJm5BPW
         Tf/wDPov8M4kPF+ekvSRQVW54MqRQeZRx/HfHbu8vLygxdf5cc2piCEbCqgFyreQq7fz
         5IMvClESW6EDjsyYW3MjdhmEbH0Omyc4qHHjkcsWgHSzLyHP8LB8uEUZRN5xR3pKgmLe
         YbHgFZZjr/vnHZSJiUdfGea0WJ/YGmF6pf/m2jOtS9Qcmumno8uuiCqSClAor/PwJL0f
         fIL0nS8fGybPHhp0L3vpjalQ6Kahkz/aRJDpPVhWYU4TcMoPzr29TqbttbnfvSVC8oRV
         f3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLI2HCON5YgIbqI6uqZN3/0Os3N+01JmEtsAvmHd1rg=;
        b=o3ae9OQCXeOG1rPHZHnyOmrAfTuxbeKqNlZv+kZQZemMgEAITIgPVDNEpj3iFGwo5s
         0Vd5byGfUCKqRBypZc8xGs/DdYXyiB625J2xUN2pUuowTYkh6JrX2Yyp/vFro6h6ALFr
         zBjUn0APd5hQqcLjr4vDSmgy44pZFPWzBjGwgaemS4hru9M/yvZIBu2gQJ7GC38Pd3td
         +CQBQWIuymHiOxxpa3GRnT+ILmXE4oZx6zeS5xz6Ev6/XgdG2vAhstOtUOXYgmMCcKih
         Tbdef3j02fFbZgTcGKan1I5NNf6wN/nM0c14U0ifB3mGZFQvMjJLTWuml2wBGQHEKjwr
         0T3w==
X-Gm-Message-State: APjAAAWC/cl6bwtgTMAF9VWGrVSpoEEdfMnbkCL00RlwP2DWHnYrNqea
        w2FSvnZ4ulDONol9TMIROQ==
X-Google-Smtp-Source: APXvYqz3wE8AimYf5L7jMgwY063Xfygyg9VY13ilhsrE1gyqbxGI+M5aCLFy0mmQRNHQwUb/y7fvSg==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr3050467wro.144.1552665920875;
        Fri, 15 Mar 2019 09:05:20 -0700 (PDT)
Received: from avx2 ([46.53.240.56])
        by smtp.gmail.com with ESMTPSA id s6sm3012783wmf.42.2019.03.15.09.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:05:19 -0700 (PDT)
Date:   Fri, 15 Mar 2019 19:05:17 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] elf: simpler check for -EEXIST
Message-ID: <20190315160517.GA2135@avx2>
References: <20190314204208.GA18143@avx2>
 <52458645-823f-825e-660f-7b01d5dbb979@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52458645-823f-825e-660f-7b01d5dbb979@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 07:02:23AM +0900, Tetsuo Handa wrote:
> On 2019/03/15 5:42, Alexey Dobriyan wrote:
> > 	PTR_ERR((void *)map_addr) == -EEXIST
> > 
> > is a very complicated way of doing the obvious.
> 
> Michal suggested me to explicitly use PTR_ERR()

without any explanation why...

I wonder what documentation does this line need?

	map_addr == -EEXIST


> for documentation purpose in
> a reply mail to https://lkml.kernel.org/r/20180418115546.GZ17484@dhcp22.suse.cz .
> 
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  fs/binfmt_elf.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -375,8 +375,7 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> >  	} else
> >  		map_addr = vm_mmap(filep, addr, size, prot, type, off);
> >  
> > -	if ((type & MAP_FIXED_NOREPLACE) &&
> > -	    PTR_ERR((void *)map_addr) == -EEXIST)
> > +	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)
> >  		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> >  			task_pid_nr(current), current->comm, (void *)addr);
> >  
> > 
> 
