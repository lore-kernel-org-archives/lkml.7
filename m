Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D96207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0A2z1TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfIRP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:58:28 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:41779 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfIRP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:58:27 -0400
Received: by mail-pg1-f171.google.com with SMTP id x15so82395pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kuawgKYd1ZO4hmm7LLtvr0pa9no04t6i2+r3+Gwk4x4=;
        b=l0A2z1TLXgxmmedq5++QkoO8DwxSNyr+T1b6Mzqo0NATMUz3eiscRJLFqMoH5KhzsJ
         u9dyUkO3k2ighuZYzJxywBe/eWWl+32r/Y/l+o07U5SrYgIhkRDUpBWizrmYf44rKcfW
         frSb0JL/ygJ++bYP1sXMh+kpZRLdaeaqOrdI/M65JpZNmgd9wbmzHPmBIC0V679HJwXz
         zZL+y8vQ7/5QoUQ2EDFCOE62C2B+/gjgcUkTmQf3ZgRU5FPX+w/SU4hPNN6uVQoPWNaW
         gtI/dqGgHOiAXMdvt69Mabmhz8JVgNf/eLcM/b6HFkLdmo2+vmk9W/ZG8OCgkoLXgZhR
         n9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kuawgKYd1ZO4hmm7LLtvr0pa9no04t6i2+r3+Gwk4x4=;
        b=A47R2yM8R/h/cNPAPxGFp1Op+mjdLfbB6XU7MuY6VfEnawMOH4YqTk63X7+Ms0EpAQ
         E595yGnbZFuIZ/qm4P5RKt5MAU5gmYzQGj8LjYHVCQszf9qIsNXIvVGEIxFHmcPWSMDI
         nRbtRCewG+fKpgH17t0b5eaR9fN/B+txmMVoKbJ8WRrSS1834ZN4zwjBBDfG97+ew+aW
         +ive4Jr50IVUmVjITRuZkvpHt4AMe/+GeWWdHp2EZjygNKA5k6IwxwXnSTOc/0WnAifW
         Zsxf69mc0UFtK+3RZWoYs5i7ryl1WlXV+EDCU7T0tDD9b8PglLIGM5sKQMChinfcoXVD
         mWWA==
X-Gm-Message-State: APjAAAUzH+ACXGHdtdJ8njxQ0rQ8DIpA5viAO071rFunysB8+cl4BmhO
        JS1XZ2KVXvzaoB9P11y+Hm0=
X-Google-Smtp-Source: APXvYqwl+D35M1mGQ5CVkx5D9cM30xhSLxrYJ8pZoQLGMu0DhVC153jK58vKQJWknJASA2CRgx/Sjw==
X-Received: by 2002:a17:90a:c24e:: with SMTP id d14mr4793076pjx.0.1568822306830;
        Wed, 18 Sep 2019 08:58:26 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id m24sm5190036pgj.71.2019.09.18.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 08:58:25 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 19 Sep 2019 00:58:23 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: printk() + memory offline deadlock (WAS Re: page_alloc.shuffle=1
 + CONFIG_PROVE_LOCKING=y = arm64 hang)
Message-ID: <20190918155823.GB158834@tigerII.localdomain>
References: <1566509603.5576.10.camel@lca.pw>
 <1567717680.5576.104.camel@lca.pw>
 <1568128954.5576.129.camel@lca.pw>
 <20190911011008.GA4420@jagdpanzerIV>
 <1568289941.5576.140.camel@lca.pw>
 <20190916104239.124fc2e5@gandalf.local.home>
 <1568817579.5576.172.camel@lca.pw>
 <20190918155059.GA158834@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918155059.GA158834@tigerII.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A correction:

On (09/19/19 00:51), Sergey Senozhatsky wrote:
[..]
>
> zone->lock --> console_sem->lock
> 
> So then we have
> 
> 	zone->lock --> console_sem->lock --> pi_lock --> rq->lock
> 
>   vs. the reverse chain
> 
> 	rq->lock --> console_sem->lock

                     ^^^ zone->lock

	-ss
