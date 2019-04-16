Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A36C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD08E20857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555400091;
	bh=7vimyrKrT4i/KjB8atJljNvV4U+fYCJg1iYSDchaZCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m4/zfWZnrOsMAVr8QwyJA/k0eGKUWN9tTTiPBmj96v7fTqKMpWzbYhw0prHSjKAil
	 q6PD7li2HsRqQ08mwLzjwpa5ELQaBg1EWXpnnc94DEUY3bQmv1sDrffsIPSpzIsJP+
	 xdP6IALQv9dWnaQIRpxitb5G6/hcpiGipi7zp6b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfDPHeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:34:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34184 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfDPHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:34:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so1672438wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mkoSdOor3prGzzN6JE1yPzhhOlDqFnk43U2JtGpW8+4=;
        b=avOi66Pe57NEXYhLYp/kgYdx9ocSr4U6Pcfdgf+zecIGv+Y8c6jMrH56EN5ias943v
         c+00tmCD4SPbeoEi+QX0BS87cabeIwS4coPM8IIXTHErhfOucjb4xBq0ermuAQLd30nz
         Sl4LnRlAZOQ6zT3+ApE78/5fhhyxitMgDooSi5V5MX3JvFGGE1+VxzJEEI8cSJ81pouQ
         /Puh8SBXTdmeXLNPVI6QbMhs7cUs/VquH8C8pEkTOirXHmv2gz9IrewUKyQxQI3oeuCe
         B5YbEwsf6BaQFGoMSB35bGX2r3jkxsY9NhWKaFlyKE3F2NjrqhD/ebjLHM9vw3EUUMrz
         cBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mkoSdOor3prGzzN6JE1yPzhhOlDqFnk43U2JtGpW8+4=;
        b=Z6XGs2qPT30JzXiHMw38Iikok9DIt2195MQtMcYATk7QYJwE2Zg40bz0GTfbFfE6HT
         7gflu0U309UVZ2eEMvkPYZk1hydYhqZG0dZvLijxHk38FFP8iaUHFNEsSEfF9IVQhEOG
         /qT9nMwtjfSx4LIKRctQ/dU4RDUVcAuV08LbMKTEpmdi4v+zDo0R2/hFJtH3yz5avp7a
         ZHOkDwnRFQFOgJjl4ab88UEMuNgf9RfskPDgrch1Gzw3ZlsQRjmw4hO7wU0T/LUt14H6
         xOWlBZUZPg2AwHWGvus46oBS0bjvqxz7ZDdV7Nt6Ilckk1Jcm1gR4J8ZP7g3MgIbtIu3
         Zcfw==
X-Gm-Message-State: APjAAAXGajS3a0bCD5nmyUR3TRKOUpqjL5bCSCqtJ3y7+WqyvgouXHTy
        uCAXe7MSIZmXJkZMGAywFLE=
X-Google-Smtp-Source: APXvYqxy3W3EBoT+cmkOx5XicQL7waKfwKA9cRwM40EZV3MSlKirpHeM+Ju2eRmARv2cTDIsmMHJCA==
X-Received: by 2002:a1c:cbc5:: with SMTP id b188mr25073403wmg.87.1555400088119;
        Tue, 16 Apr 2019 00:34:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 61sm171950162wre.50.2019.04.16.00.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 00:34:47 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:34:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190416073444.GC127769@gmail.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Reshetova, Elena <elena.reshetova@intel.com> wrote:

> > 4)
> > 
> > But before you tweak the patch, a more fundamental question:
> > 
> > Does the stack offset have to be per *syscall execution* randomized?
> > Which threats does this protect against that a simpler per task syscall
> > random offset wouldn't protect against?
> 
> We *really* need it per syscall. If you take a look on the recent stack attacks
> [1],[2],[3],[4], they all do some initial probing on syscalls first to discover stack addresses
> or leftover data on the stack (or pre-populate stack with some attacker-controlled data), 
> and then in the following syscall execute the actual attack (leak data, use
> pre-populated data for execution, etc.). If the offset stays the same during 
> task life time, it can be easily recovered during this initial probing phase, and
> then nothing changes for the attacker. 
> 
> [1] Kernel Exploitation Via Uninitialized Stack, 2011
> https://www.defcon.org/images/defcon-19/dc-19-presentations/Cook/DEFCON-19-Cook-Kernel-Exploitation.pdf
> [2] Stackjacking, 2011, https://jon.oberheide.org/files/stackjacking-infiltrate11.pdf
> [3] The Stack is Back, 2012, https://jon.oberheide.org/files/infiltrate12-thestackisback.pdf
> [4] Exploiting Recursion in the Linux Kernel, 2016,
> https://googleprojectzero.blogspot.com/2016/06/exploiting-recursion-in-linux-kernel_20.html

Yeah, so if there's an information leak from the kernel stack, don't we 
now effectively store 5 PRNG bits there for every syscall, allowing the 
systematic probing of the generic PRNG?

The kernel can execute millions of syscalls per second, I'm pretty sure 
there's a statistical attack against:

 * This is a maximally equidistributed combined Tausworthe generator
 * based on code from GNU Scientific Library 1.5 (30 Jun 2004)
 *
 * lfsr113 version:
 *
 * x_n = (s1_n ^ s2_n ^ s3_n ^ s4_n)
 *
 * s1_{n+1} = (((s1_n & 4294967294) << 18) ^ (((s1_n <<  6) ^ s1_n) >> 13))
 * s2_{n+1} = (((s2_n & 4294967288) <<  2) ^ (((s2_n <<  2) ^ s2_n) >> 27))
 * s3_{n+1} = (((s3_n & 4294967280) <<  7) ^ (((s3_n << 13) ^ s3_n) >> 21))
 * s4_{n+1} = (((s4_n & 4294967168) << 13) ^ (((s4_n <<  3) ^ s4_n) >> 12))
 *
 * The period of this generator is about 2^113 (see erratum paper).

... which recovers the real PRNG state much faster than the ~60 seconds 
seeding interval and allows the prediction of the next stack offset?

I.e. I don't see how kernel stack PRNG randomization protects against 
information leaks from the kernel stack. By putting PRNG information into 
the kernel stack for *every* system call we add a broad attack surface: 
any obscure ioctl information leak can now be escalated into an attack 
against the net_rand_state PRNG, right?

> No the above numbers are with CONFIG_PAGE_TABLE_ISOLATION=y for x86_64, 
> I will test with CONFIG_PAGE_TABLE_ISOLATION turned off from now on 
> also.

Thanks!

	Ingo
