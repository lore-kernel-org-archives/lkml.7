Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C57C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4244920856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE1iE2xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfIRFTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:19:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfIRFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:19:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so247831pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 22:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KwKus1csg567N9iCD9/ZjfmVoAmhu5yYnWcQE8aRGhw=;
        b=eE1iE2xt3bToB9fWtUmqao9fpiWsB0ODWezOdYJlLhM41TFCLGLmIOYjNXgDkbLvIp
         GGh6vc9RE2mrKtSmYzqlXrD2TmUE6QyA9BL4d29HhvYtQOIHCCRvzCufXKMmJRF0BIE2
         GdynWzqxR7DWqSz2FMQbIaz6T4rixPYFnHate/7xqEKrr4zFi7aIuVvTKxIpaHoogmAh
         lHwcu+eybp4f9pGKXy6RE+xlilMs7FS/sbZe7H1LcYajzgLXVk/uXr24D94qEdPJJDQF
         +Brw4ZV5dF7mQuz7D102b2DkkmDcKt3Bh7+6uFBiR3ZimR3lzzbjDW229C1PUbr8y9FN
         rw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KwKus1csg567N9iCD9/ZjfmVoAmhu5yYnWcQE8aRGhw=;
        b=O2U3ukRUjM1aq72eQmkGvFeghaTWsvDguYJZv+DLtYMJCR6nLhH13lEdzof86YwZWK
         B/+/F3cFQQdkNIJ5PQ/eBTBJ5vFxBtXGjh4GSKgZ4/NmUMkBcZX0PkmPeqsozueKVNFU
         Nevg957f6tybIjuQ1yFpTyc965ubBKAWNFBP/uvV3/SdtHQ+Vaz/2MayhacBzYhb01p4
         NWWviXhSvjVspu3P7kTQVtNNjQqgcfGE7gXVgOVEoH3a9YhD/f6OPny7GGuKyLmR71qs
         KOF4d/VrqZcr4Bt+Ha6N0oZWL2y1SzipZbuOA/acpN9i0erAWX6xqbA+2lBvUn9OHozR
         TTgQ==
X-Gm-Message-State: APjAAAU7o1HV7vw2PlfAUlRNsWAfmhB/6ndzxvt4P1CJHn7SU+I2ep7V
        HL0s/2B+eBpEwuJ/38lTAEE=
X-Google-Smtp-Source: APXvYqxpH7pdqsI3WKY7F+nwE0X//yxTtHwenn1p0XJPy61xLCPFv8gRDyKaleys4wQ2NzPpANjRXA==
X-Received: by 2002:a17:902:b08f:: with SMTP id p15mr2420585plr.158.1568783978787;
        Tue, 17 Sep 2019 22:19:38 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id m24sm3573283pgj.71.2019.09.17.22.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 22:19:37 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:19:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
Message-ID: <20190918051933.GA220683@jagdpanzerIV>
References: <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home>
 <20190918023654.GB15380@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918023654.GB15380@jagdpanzerIV>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 11:36), Sergey Senozhatsky wrote:
[..]
> For instance, tty/sysrq must be able to switch printk emergency on/off.
> That already means that printk emergency knob should be visible to the
> rest of the kernel. A long time ago, we had printk_emergency_begin_sync()
> and printk_emergency_end_sync(), which would define reentrable
> printk_emergency blocks [1]:
>
> 	printk_emergency_begin_sync();
> 	handle_sysrq();
> 	printk_emergency_end_sync();

Some explanations.

How did we come up to that _sync() printk() emergency mode (when we
make sure that there is no active printing kthread)? We had a number
of cases (complaints) of lost kernel messages. There are scenarios
in which we cannot offload to async preemptible printing kthread,
because current control path is, for instance, going to reboot the
kernel. In sync printk() mode we have some sort (!) of guarantees
that when we do

		pr_emerg("Restarting system\n");
		kmsg_dump(KMSG_DUMP_RESTART);
		machine_restart(cmd);

pr_emerg("Restarting system\n") is going to flush logbuf before the
system will machine_restart().

I can also recall a regression report from 0day bot. 0day uses sysrq over
serial to reboot running qemu instances. The way things currently work
is that we have printk() in sysrq handler, which flushes logbuf before
it reboots the system. With printk_kthread offloading this "flush logbuf
before reboot()" was not there, because printing was offloaded to kthread,
so the system used to immediately reboot with pending (and thus lost)
logbuf messages.

I suspect that emergency flush from sysrq is easier to handle once we
have one global printing kthread.

Suppose:

	logbuf

	id 100
	id 101
	id 102
	...
	id 198   <- printing kthread
	id 199
	id 200
<+> sysrq, a bunch of printk()-s in emergency flush mode
	id 201 -> atomic_write()
	id 202 -> atomic_write()
	...
	id 300 -> atomic_write()
<-> sysrq iret

When we park printing kthread, we make sure that the first sysrq->printk()
will also print pending messages 198,199,200 before it prints message 201.
When we unpark printing kthread it knows that there are no pending messages
(last printed message id is in the logbuf head).

It's going to be a bit harder when we have per-console kthread. If
per-console kthread is simply gogin to continue from the last message id
it printed (e.g. 198) then it will re-print messages which we already
printed via ->atomic_write() path. If all per-console printing kthread
are going to jump to id 300, because this is the last printed id on
consoles, then we can lose some messages on consoles (possibly a different
number of messages on different consoles, depending on console's kthread
position).


Once again, I'm sorry I was not on LPC/KS and maybe you have already
discussed all of those cases and got everything covered.

	-ss
