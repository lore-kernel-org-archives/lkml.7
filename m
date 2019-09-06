Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065EC2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzHu9b16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfIFKJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:09:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45982 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733254AbfIFKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:09:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so3203217pgm.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPlEyz3pTYtQ2PRdAV0S+EQaWH5tHTmS4heiquzIdK4=;
        b=GzHu9b16+b83L8RCAs1A/8tSCMuuLX7crTu6pydCxnq9K7f0YxzOEes87MnbbrHGHN
         9YCHQ//OiR5bVRa176WJzUkFTxMTU7rypHyQ96JZ1sRS5wq3qxm2nHrrkM3q2012Drcv
         Nfo8T/hnSvh3L9FRX2u6wqY5XppxdpPAJ0RI51JkpWBUzxaHv8RVDE9oVqDo64sfxdzn
         uun6VxJQIy0H5gtrmwKNiGsBx7tn62rJSqE3Y+jQ3eThHEYN/RryM2JFPsC2mwp+l+VW
         HZqj89qkaaX5+uu0z8ktJt3nasDhAda2Q2a6+kHfc4NZAW1w0Niw3BbJHVJeKDQcPQ1f
         nNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPlEyz3pTYtQ2PRdAV0S+EQaWH5tHTmS4heiquzIdK4=;
        b=GVczzIrsVJSm1SnPDG52n+V3V8KYsEhDf/rNHwxTCw0WShkP60YifX3iAOIO44qAYX
         rwjTkYM6JM+T2nDb/7pUyOHi44L0JXhxz05veoIRkUk22jEyuYSHLky3TPjwI7dYwpLN
         SD4MOmsSjiydaMfock5hYE+KMydr9s8AmZoHuP9me64Nt9zx46TZjrS1/U+yZGxzzDpM
         6HN47T/af2j9cwPuwCDC3VQfVHQ2XZaPikkMiF4RL8eQYANDB2AZ3ys13Gdky0t/ctV4
         JQb+e92mT66gh2tUCZiwMgPGE8//1yabeqwb5lZpNZBYVKCFFhxt/Q+JNV3LhFxguanC
         O/FQ==
X-Gm-Message-State: APjAAAVY/O4mrtfPPinv+GHAIRc8iPiMlXvfAOytQ6gP+fohoVyMF4RY
        kEhyJjiWzbA9ln5gEnv0a8Xhy0/Z
X-Google-Smtp-Source: APXvYqxpGObgjVki9/w1RI1A8UxU46n8xgyMHyCMaDXVc7WQigU7hXMeNqpGROS52hE9VkNE3wklbg==
X-Received: by 2002:a17:90a:1c01:: with SMTP id s1mr8959839pjs.76.1567764588226;
        Fri, 06 Sep 2019 03:09:48 -0700 (PDT)
Received: from localhost ([175.223.27.235])
        by smtp.gmail.com with ESMTPSA id d14sm5997414pjx.8.2019.09.06.03.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 03:09:47 -0700 (PDT)
Date:   Fri, 6 Sep 2019 19:09:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906100943.GB10876@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906090627.GX2386@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/06/19 11:06), Peter Zijlstra wrote:
> Another approach is something like:
> 
> DEFINE_PER_CPU(int, printk_nest);
> DEFINE_PER_CPU(char, printk_line[4][256]);
>
> int vprintk(const char *fmt, va_list args)
> {
> 	int c, n, i;
> 	char *buf;
> 
> 	preempt_disable();
> 	i = min(3, this_cpu_inc_return(printk_nest) - 1);
> 	buf = this_cpu_ptr(printk_line[i]);
> 	n = vscnprintf(buf, 256, fmt, args);
> 
> 	c = cpu_lock();
> 	printk_buffer_store(buf, n);
> 	if (early_console)
> 		early_console->write(early_console, buf, n);
> 	cpu_unlock(c);
>
> 	this_cpu_dec(printk_nest);
> 	preempt_enable();
> 
> 	return n;
> }
> 
> Again, simple and straight forward (and I'm sure it's been mentioned
> before too).

 :)

---
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 139c310049b1..9c73eb6259ce 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -103,7 +103,10 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
        if (atomic_cmpxchg(&s->len, len, len + add) != len)
                goto again;
 
-       queue_flush_work(s);
+       if (early_console)
+               early_console->write(early_console, s->buffer + len, add);
+       else
+               queue_flush_work(s);
        return add;
 }
---

	-ss
