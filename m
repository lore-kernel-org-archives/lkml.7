Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE8C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109BF2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym5531K9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbfGRKL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:11:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41791 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfGRKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:11:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so12403481pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s9DT+PnaINXuv9oV1a0Ft7cKsvtMXtYwpq9P51Iz0jY=;
        b=Ym5531K9rdO392M7jAuvruX+alhuJi7Nzi/Qf3G1JhevvTuQAQRyoSU5q3sbGuYXAa
         caq2XuCqcfKL6NOEg4+cLFesMlRGBouFDDlP9B4nvq9rv/TCRI6MtByBt55vH4R1xk1X
         TAwHG1DteMqFyXZlWqs2InoygHSGLj/USrw5fL5BrQo66Pwb+L2lZOf7YXbukxJ2bPf4
         OwDmBelFAClsX5fyMufooyazE1b18aSwifmVzg0XSqpIY8ogb9ehCFndquoAyQ4125WH
         uIVM3lbjSy3WV5Uea0ozbkhCDud+wBsC4wfDR7Pxyolb6p9zeAs1v+JyIs6iSjhvJSLW
         nwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9DT+PnaINXuv9oV1a0Ft7cKsvtMXtYwpq9P51Iz0jY=;
        b=q7JEY9F9IlZz1s669JhcIJtfQzCKPnkDiQv+u2RJ8I790580T/JCMZy1KMEnE0AwE0
         n17zxL+ihYW/FDhIRoyOaO7kr/bqMfh+GtJEhzRAZrAOpAXO75D+4R4v48M+xMz509w8
         YyoQ3npm8FBkSur4f+ojy5HKG1xxdGJVKfbr6R+0TM0R9GE2laeKe914rIAXDfuM6XgW
         0xLFJwDaF+T1QG8v9fhjkSJtocGbRr+bpBHuxtYDKbcVS1gnaFLEve07Bd9kEsCAnu0w
         L2Wq0zAY7nIuymzrChQf1fwzOPbVF/yVCdN3GJYKhlJnCrIq3ZW+T20x5j1w+6MH2rz/
         BofQ==
X-Gm-Message-State: APjAAAUw3LGLuvhOlmYpzeIFARJaxDVJN7S46iODrA9jZ9Js1Y8r2jYu
        JbJlvnKp3rw4zxQ43GaYeftnm0nf
X-Google-Smtp-Source: APXvYqzGF58o+OEoT0EIVTSvp51t+mzaXnA4x5C8fWZi/Hrr42rzvsQGcHA0MS/naRe8j8tS7xxoNA==
X-Received: by 2002:a65:5183:: with SMTP id h3mr46687819pgq.250.1563444717807;
        Thu, 18 Jul 2019 03:11:57 -0700 (PDT)
Received: from localhost ([39.7.59.92])
        by smtp.gmail.com with ESMTPSA id p23sm30339045pfn.10.2019.07.18.03.11.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 03:11:57 -0700 (PDT)
Date:   Thu, 18 Jul 2019 19:11:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>,
        Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190718101123.GB10041@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716072805.22445-2-pmladek@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/16/19 09:28), Petr Mladek wrote:
[..]
> +int printk_bust_lock_safe(void)
> +{
> +	if (!raw_spin_is_locked(&logbuf_lock))
> +		return 0;
> +
> +	if (num_online_cpus() == 1) {
> +		debug_locks_off();
> +		raw_spin_lock_init(&logbuf_lock);
> +		return 0;
> +	}
> +
> +	return -EWOULDBLOCK;
> +}

A side note:

I'd say that we also need to clear console_owner and re-init
console_owner_lock spin_lock, panic CPU can spin forever
otherwise; and I think it would also be reasonable to re-init
console_sem's spin_lock, yet another lock on which panic CPU
can spin forever. (Assuming that one of remote CPUs that we
have NMI killed had owned any of those locks).

Console drivers' locks are mostly OK, as long as drivers check
oops_in_progress in ->write() path and act accordingly, but
printk() has to deal with more than one lock (logbuf_lock)
before it invokes console drivers.

	-ss
