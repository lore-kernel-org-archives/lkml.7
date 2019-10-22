Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB086CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5C2218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMY3TtjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfJVOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:23:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41066 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJVOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:23:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so17430137ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CmWkhb6vTGmA7o07xtaY8CjnMRDKv3bRdyDTHLT94K8=;
        b=aMY3TtjCgIhqoj6nktRQT6Nc63J5skoHFCktywC++zSkTDfPnohR6uvD5IA+3xG/zO
         kHYeIgRj0OmX8W1GrqfuTLnqtQ4/qaqptJ3wud7rrP6DbieqR8mW/0x6trcrI6hJfuEP
         zbxrSyEWc7Xc1FziRSZ6rtWjTOpDp3grVcllEF7GzT96joRvg1vKDT1DrXk0v2WhxKVb
         SC8SbvJvUxRDc8Sr6gnUJ22YfdKnGlKZuf/H9F/gctkPWkjd87eVP3ZaTk1CrMi4jo90
         jIxujzNAuIESa5ZWHSwMz7FRk1wA5zY9ovDbYRs0P3l1TmWZRR6+yarVsTUfsMBKn/S8
         /Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CmWkhb6vTGmA7o07xtaY8CjnMRDKv3bRdyDTHLT94K8=;
        b=B+SQORdfY6XUUlkFfppfnctb7Y09kgt40I1jzYtK9rFIzuLtBZjgdgInYIaPnJfDT6
         P712ZgwjBWshv+BOxLTjTpBpvZvP8iHGOF0EIAGohCTzvw6LtZxtlRtqWLS3l9j8/qjv
         eSZ7+ekS2h6C70lUkHIhW7p2NDq3dv0w4XOAnY8P5MnYO8ACZrBzoKJgrbNXz3OK4A7P
         jtK7EIoQJBUQYCLslVBTFW4isOZHGLFTgwU0jKUu0Qaz//SQmxWhFcWR2qharBO3ers0
         PoOagGIJWxTM2Va/qPXxgMwR0GqCrfK4+I5vEU8zFH1ZK7jSO3/MY/kaoVFDxeT+AxP+
         XasQ==
X-Gm-Message-State: APjAAAWIOmoRKLPHbj6QzJoucRDJvudsey4U/UJ+rw9bCbtFHYAOMtEv
        E395OpltLuUPTlE9dTKhDrU=
X-Google-Smtp-Source: APXvYqzSwNG1IaaMHKmYq28oc6FNBMiqzaYKsGZMOhuP9X66+GZ/pmwkVYRBp6YZfx5N52rFTWasvw==
X-Received: by 2002:a05:651c:8b:: with SMTP id 11mr18449138ljq.98.1571754207322;
        Tue, 22 Oct 2019 07:23:27 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id m17sm24964063lje.0.2019.10.22.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:23:25 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 4B2D2460E3F; Tue, 22 Oct 2019 17:23:25 +0300 (MSK)
Date:   Tue, 22 Oct 2019 17:23:25 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
Message-ID: <20191022142325.GD12121@uranus.lan>
References: <20191019114421.GK9698@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019114421.GK9698@uranus.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 02:44:21PM +0300, Cyrill Gorcunov wrote:
...
> 
> I nailed it down to the following kmemleak code
> 
> create_object
>   ...
>   object->trace_len = __save_stack_trace(object->trace);
> 
> if I drop this line out it boots fine. Just wanted to share the observation,
> probably it is known issue already.
> 
> Sidenote: The last -tip kernel which I've been working with is dated Sep 18
> so the changes which cause the problem should be introduced last month.

I've just tried to boot with fresh -tip

commit c2e50c28eeb90c0f3309d43c2ce0bd292a6751b3 (HEAD -> master, origin/master, origin/HEAD)
Merge: aec1ea9d4f48 27a0a90d6301
Author: Ingo Molnar <mingo@kernel.org>
Date:   Tue Oct 22 01:16:59 2019 +0200

    Merge branch 'perf/core'
    
    Conflicts:
            tools/perf/check-headers.sh

but got the same issue. So I tried to go deeper, and here is a result: we're failing
in arch/x86/kernel/dumpstack_64.c:in_exception_stack routine, precisely at line

	ep = &estack_pages[k];
	/* Guard page? */
	if (!ep->size)
		return false;

so I added a logline here

[    0.082275] stk 0x1010 k 1 begin 0x0 end 0xd000 estack_pages 0xffffffff82014880 ep 0xffffffff82014888
[    0.084951] BUG: unable to handle page fault for address: 0000000000001ff0
[    0.086724] #PF: supervisor read access in kernel mode
[    0.088506] #PF: error_code(0x0000) - not-present page
[    0.090265] PGD 0 P4D 0 
[    0.090846] Oops: 0000 [#2] PREEMPT SMP PTI
[    0.091734] CPU: 0 PID: 0 Comm: swapper Not tainted 5.4.0-rc4-00258-gc2e50c28eeb9-dirty #114
[    0.093514] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[    0.096993] RIP: 0010:get_stack_info+0xdc/0x173
[    0.097994] Code: 84 48 01 82 66 85 c0 74 27 42 8b 14 f5 80 48 01 82 49 01 d5 42 0f b7 14 f5 86 48 01 82 4c 01 e8 4c 89 6b 08 89 13 48 89 43 10 <48> 8b 40 f0 eb 2b 65 48 8b 05 16 f4 f9 7e 48 8d 90 00 c0 ff ff 48

I presume the kmemleak tries to save stack trace too early when estack_pages are not
yet filled.

