Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F5ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FBE206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="D+YHUacq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfJINGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:06:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34214 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfJINGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:06:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id 3so3331125qta.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jqe/coE5F1tFeFAB+cBZL0Rw3251E35i3lRoHeRm+YY=;
        b=D+YHUacqyIDaP+HxhuqrHJTtHXqUHgfWPKFPD/755jbIsX4oMxZdkNf2QSgZknuE4B
         IQHND/Iqc2+ok8R8obzFhitheYoydOy8Jxbqa5itMCOTR16bfdQ+YDpP5dPRDenWFGTO
         UlcRgKnKua15NqhnF40nP7a85WjGopV1yCnfWlQMgb9/PB7FTTW2/vP/3Ef1vLj0nYbU
         /lnrKHZOb/K+0ucPueJ+6L4dRUs0Ev/9Z3n+Cmbxov/l4IQT+ay/l5BWeATPgU8nzlt6
         yRk5UfCdDhUIN7QMiyXMCY1LpsDSTJkW+Y0SGPFbMAZV6hW3ooiXCnGSJB4pxbxF4lDh
         Fd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jqe/coE5F1tFeFAB+cBZL0Rw3251E35i3lRoHeRm+YY=;
        b=kxTKZyzqoja4EphjrAHktxxlWDtiFdtR7Tje3PZcJis4U3whTGfDbikzhMel4WK3jR
         tTKJGBpKRehWr1aSxfvwI8S3ZJsmjmh1QBxorpE+c/m5RhKBhDm2u1ffv4pm1/PpEA/3
         zCOJxcqnoDtdHNSqRvllqKrInFRbU93KFxxZQqQV/r8CNAqbPkTh1Axhtea4pgyjWdy0
         WxNLoe0R9rqehJ9Wvq3MX1Djf4x2M9SMvOiLkmjrr4ExlYdkM/jj7cIY607nUnPoPFjU
         hCIbattbCVo3VSN8TPD0Fp638bMMNo6k3VCfhpcJFT7zSEOCdOH3aOYsh5H90yPTbobs
         FREQ==
X-Gm-Message-State: APjAAAWc9E/l8gpLd9xOTa+DIdiJAOHj3cG7lrzBn8Moi1qVksam6m0I
        uNSzVlnBSB0xkGPc4ll2J4QUwg==
X-Google-Smtp-Source: APXvYqxIqtJYNIz8QZFuUM3Jyfukcsp7Ga1poe1jEyqOVYx15RH5y17R82L6MXskkwYnxVUP9ifIFQ==
X-Received: by 2002:ac8:3462:: with SMTP id v31mr3260844qtb.330.1570626404804;
        Wed, 09 Oct 2019 06:06:44 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z5sm896980qkl.101.2019.10.09.06.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:06:43 -0700 (PDT)
Message-ID: <1570626402.5937.1.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Oct 2019 09:06:42 -0400
In-Reply-To: <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
References: <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <20191007144937.GO2381@dhcp22.suse.cz>
         <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
         <20191008082752.GB6681@dhcp22.suse.cz>
         <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
         <1570550917.5576.303.camel@lca.pw> <20191008183525.GQ6681@dhcp22.suse.cz>
         <1570561573.5576.307.camel@lca.pw> <20191008191728.GS6681@dhcp22.suse.cz>
         <1570563324.5576.309.camel@lca.pw>
         <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 13:49 +0200, Petr Mladek wrote:
> On Tue 2019-10-08 15:35:24, Qian Cai wrote:
> > On Tue, 2019-10-08 at 21:17 +0200, Michal Hocko wrote:
> > > On Tue 08-10-19 15:06:13, Qian Cai wrote:
> > > > On Tue, 2019-10-08 at 20:35 +0200, Michal Hocko wrote:
> > > 
> > > [...]
> > > > > I fully agree that this class of lockdep splats are annoying especially
> > > > > when they make the lockdep unusable but please discuss this with lockdep
> > > > > maintainers and try to find some solution rather than go and try to
> > > > > workaround the problem all over the place. If there are places that
> > > > > would result in a cleaner code then go for it but please do not make the
> > > > > code worse just because of a non existent problem flagged by a false
> > > > > positive.
> > > > 
> > > > It makes me wonder what make you think it is a false positive for sure.
> > > 
> > > Because this is an early init code? Because if it were a real deadlock
> > 
> > No, that alone does not prove it is a false positive. There are many places
> > could generate that lock dependency but lockdep will always save the earliest
> > one.
> 
> You are still mixing the pasted lockdep report and other situations
> that will not get reported because of the first one.

The lockdep report is designed to only just give a clue on the existing locking
dependency. Then, it is normal that developers need to audit all places of that
particular locking dependency to confirm it is a true false positive.

> 
> We believe that the pasted report is pasted is false positive. And we
> are against complicating the code just to avoid this false positive.

This is totally incorrect as above and there is even another similar example of
the splat during memory offline I mentioned earlier,

https://lore.kernel.org/linux-mm/1570460350.5576.290.camel@lca.pw/

[  297.425964] -> #1 (&port_lock_key){-.-.}:
[  297.425967]        __lock_acquire+0x5b3/0xb40
[  297.425967]        lock_acquire+0x126/0x280
[  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
[  297.425969]        serial8250_console_write+0x3e4/0x450
[  297.425970]        univ8250_console_write+0x4b/0x60
[  297.425970]        console_unlock+0x501/0x750
[  297.425971]        vprintk_emit+0x10d/0x340
[  297.425972]        vprintk_default+0x1f/0x30
[  297.425972]        vprintk_func+0x44/0xd4
[  297.425973]        printk+0x9f/0xc5
[  297.425974]        register_console+0x39c/0x520
[  297.425975]        univ8250_console_init+0x23/0x2d
[  297.425975]        console_init+0x338/0x4cd
[  297.425976]        start_kernel+0x534/0x724
[  297.425977]        x86_64_start_reservations+0x24/0x26
[  297.425977]        x86_64_start_kernel+0xf4/0xfb
[  297.425978]        secondary_startup_64+0xb6/0xc0

where the report again show the early boot call trace for the locking
dependency,

console_owner --> port_lock_key

but that dependency clearly not only happen in the early boot.

I agree with you that it is hard to hit because it needs 4 CPUs to hit the exact
the same spot.

> 
> Are you sure that the workaround will not create real deadlocks
> or races?
> 
> I see two realistic possibilities:
> 
>    + Make printk() always deferred. This will hopefully happen soon.
> 
>    + Improve lockdep so that false positives could get ignored
>      without complicating the code.

There are certainly rooms to improve the lockdep but it does not help in this
case as mentioned above.
