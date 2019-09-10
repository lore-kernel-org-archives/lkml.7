Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9641C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12E921479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0jTNUyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392799AbfIJDWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 23:22:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41719 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfIJDWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 23:22:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so10636886pfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JwYl5b1PFnWQJ5Rk6doRyu3zqe4CdVYg/isoUZ798Ig=;
        b=G0jTNUyBUiEx0wDG+jJuHRfrOw9c2svHPf5dnKQ4hcIl++XTmFjIpjov64gPvZrMN2
         5p3hv0RyM5+YJfgPix0BsYiQAaOmhEZRWjGP5fwnUE/lAVMSDbTfL2zjq/Lh9QOMnCUy
         Cj1DtfyWVo4bMoqZsJredt0rZCu8xutPnY46D1VNr/4aRRfwh6qGjrWzrhZdMuP8VVEX
         dxj3sd5B0U5tyniScx4hCZJ786/ba/qKOpJpyobykBKMJcU+hzDGwArmcESYXDz67Ikq
         s7FwK7II62DMEvmgyICLXniG1DKD2dFAFKgdx6rgx1ZJihusUWA6UgRonFD9DNus8KAw
         GZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JwYl5b1PFnWQJ5Rk6doRyu3zqe4CdVYg/isoUZ798Ig=;
        b=HZPOs/H60A0dvvNWewm5ODJNLZB6wmheqSHVf2fTfYNUBmEAP2hoYXii1x4MUMvrFB
         SzpqOyz/PSNvctciGPOwa21x0rERqV+IwsZIaPRoOckQZ2i+YXP2S9ekU520IFH/0gW7
         Z2Wu9LJN8XOQ2MmSToBIKlTWl/9XhrQ6oyBUXX/xMw8V7NVn2owTLXcVVhECl7UDGS2F
         S9yScAnx1ldv/8LsB7vByCf4mH2YeWyLW4lihs9Vic5BOVVvsquQG+eZfhbZSrYRJv/Y
         4CCjHIwaTNCS+2mViJ/Lxuj3RfItS6s8NY2yXBYXjypJrMqg3PDbrySePflwHE/V+ZD2
         Q/+w==
X-Gm-Message-State: APjAAAXCMcJTJIkGxAJ216JJGVcU7pHEzfljhaGp/ciStP1ulo4f8RVc
        LlUgTcHyWr1P9LqE/NoGJl8=
X-Google-Smtp-Source: APXvYqydrZoWkytA9HmU06E46kp2OwAqeYpWK/HuuqLiHI+YR5VYvzvs6Uomj2K8Abzk0ZDm3iPMyA==
X-Received: by 2002:aa7:8d4b:: with SMTP id s11mr5417393pfe.132.1568085769167;
        Mon, 09 Sep 2019 20:22:49 -0700 (PDT)
Received: from localhost ([39.7.19.227])
        by smtp.gmail.com with ESMTPSA id f188sm19871488pfa.170.2019.09.09.20.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 20:22:48 -0700 (PDT)
Date:   Tue, 10 Sep 2019 12:22:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190910032244.GB103966@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
 <20190906124211.2dionk2kzcslaotz@pathway.suse.cz>
 <20190906140126.GY2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906140126.GY2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/06/19 16:01), Peter Zijlstra wrote:
> In fact, i've gotten output that is plain impossible with
> the current junk.

Peter, can you post any of those backtraces? Very curious.

	-ss
