Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59BAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680920652
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555482301;
	bh=AlCfs73gal5qJDmaf1rMhJf9TNvOPQGC2fS4J93IkPQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=lqYkmh4WV4vJzjK0/C8u0B8IFfjSTkwBpQ5lvpccFuzJUgQ2RRJ7Ya0REQiilTslP
	 /IBgJr/inuSTf/+nYfbioyh/PrCoNXfztIlGvO0dOhkrHUc811ZR6YOOOybSccAKI0
	 MpGlxJVmk4sJ/SmdkDFu+HY2jRwJ7aCLoxrsbSqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfDQGZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:25:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33108 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDQGY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:24:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so3872870wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2PjcmvrABpd6cCJE5j+0tfntNTBziDJepmVxsiGdyw=;
        b=mXjb5o5RFE3YfoPv6ncZ8WaT7KajxzWbxtLq6AFKkaAAn8QJXyAUVbMI11+N2hUFm4
         2I+QViX3ErU21eaL0G7HGK1avb5KXUmzms7Oy68bQgdMJc+7xN8lN5uUVXD+D7z4RAt6
         KTdCJ+/zo1nSN09EWpYWe+Sb0Zx6AA4/fyNP673fb9PvWTPN2mcncta/CcTjYgsci2jx
         TA0TBoBYVHl3jmme9UUq82AAPAMXYz2RclH8pPOBKtO4Pa5GbWW2ZKXrbBYjq7y0W9Lj
         jHkG/uVqLJ/qFjddo27/WIDOI9O6jV+SKdf0nUJ7JXtBdp8bBauydaXUd3q/HBBlAx4d
         KHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2PjcmvrABpd6cCJE5j+0tfntNTBziDJepmVxsiGdyw=;
        b=PlLr28lEPXLRsBcbcsmrlhNRIcF369EYUjG7/lnCLsl7yQwTDQmBgQcjadYyo4WH65
         8ppTxC7g9AshM11sUUZsKvghA+4d/cyb00gQm29/LRY9Xr6LJqVoGO6KCzrbW2FbOXpo
         XYPrRyPwqsltYVozykVTyQC5XBdrdi8wb/PQ/FUi/FhCOuhgMWo7F6YYJILnAEeGCeE5
         5IePQrsHGR46J7yYZSN02n1lXE6tptDZnGolyGnU1m+CGqox1HgSZiYscj8ROBKcQerG
         JGlBIP70OAN8cxB35lXPELIyGitTOZ1mO0FWQ62zBYze/F/DX+S6tgFkYuCvqsk9/siX
         lJBQ==
X-Gm-Message-State: APjAAAVs9Gittu5vZ1SOLekOZkQKHe5Mj9vKXMq0yKz8EZTCo9gGkreI
        fVz9KFUvYYFTvYDbcrQlhZ0=
X-Google-Smtp-Source: APXvYqzzwh6QNtQoUX9f/ClAi/29gjo6DbZmHnJFB0dtIJ2ZOXkoG0ps86hdlgANx6pdknuILa79rw==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr30710870wme.67.1555482297732;
        Tue, 16 Apr 2019 23:24:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b9sm2625318wmc.9.2019.04.16.23.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 23:24:56 -0700 (PDT)
Date:   Wed, 17 Apr 2019 08:24:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.COM>,
        'Peter Zijlstra' <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190417062454.GA45199@gmail.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416154348.GB3004@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Theodore Ts'o <tytso@mit.edu> wrote:

> It seems though the assumption that we're assuming the attacker has 
> arbitrary ability to get the low bits of the stack, so *if* that's 
> true, then eventually, you'd be able to get enough samples that you 
> could reverse engineer the prandom state.  This could take long enough 
> that the process will have gotten rescheduled to another CPU, and since 
> the prandom state is per-cpu, that adds another wrinkle.

Yeah.

Note that if the attacker has this level of local access then they can 
probably also bind the task to a CPU, which would increase the 
statistical stability of any attack. Plus with millions of system calls 
per second executed in an attack, each of which system call exposes a 
couple of bits of prandom state, I'm pretty sure some prandom attack 
exists that can make the extraction of the full internal state probable 
within the ~60 seconds reseeding interval. (Is there any research on this 
perhaps, or do researchers not even bother, because this isn't really a 
secure algorithm in any reasonable meaning of the word?)

Thanks,

	Ingo
