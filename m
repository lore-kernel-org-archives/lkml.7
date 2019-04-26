Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244E52084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLMWO8Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDZQSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:18:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41822 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:18:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so1957584pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=de4bNe6ru3D+sukfth4RLcI7Zhp1IspHKcI6VPzFIT0=;
        b=DLMWO8Q00VLneKlpiu6QGqSzIXoFQXOSrbGxnAP2X7EVfPq91WjP7D7CfqmbeU8gm7
         6iM4WIdBgyw/SiCdQDL/tifZ1jCvGkIZwHAzWYuX4JV46OVQ8plIPPB3qJB5lkwP7uVL
         R4qAex8maEqzJEohumuEfuWnkrOTP+gqW/BRoK4B2sAg+K9u/DT6+100coIsJGFe6aK3
         ZrsrNzuu15FJY4yorZ43fHbvxn4eSvnaNjE0Gx0vq5IcvY9Lhx8kQBM0zjq9mwwwlISw
         PdAWSgiC/8Vb9G8ydR66VnE2w1TTP0Ojtz05faNhZw5YdnxUwLHwX/FdCdbqE29cYJ9w
         4JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=de4bNe6ru3D+sukfth4RLcI7Zhp1IspHKcI6VPzFIT0=;
        b=ULAQ2aQkWitERpsUMu5P4cxJTzp2mD/r7e+RKesAQYU0R2dSQ3aQq0QahOzdf0Wll3
         qKYrrZ2Q6+3FIMLU4etnKYWVsrcKpF+8RFl/Ex/ppehpJq2rAH2aQtZkfvCCPJXbq16s
         5tlTNV0CYbcoGhN3+bRdiQizcncY9LDYq10FzSnYJJyRvaJ4t79tancCl7J8cS5BTsYX
         y6QMuy39vdp2Vfa81ea+kZJH4E6v0+2pjLLxz/dOB8aJKzbBrYqFREhrk82Thuu0ijZO
         3HkaKM1SBKq28LZYwbjODWvwk5dCkjEZGxg8B0hnEwWKZeCb3iEg1RXbpVs1ofiYBfDO
         BiDQ==
X-Gm-Message-State: APjAAAUbN+CePRZV7PLGRKk6qowX9vQgLJ+72vDtcEm5PAIKDKVFPNBU
        SPodE+ZmscmwxgxgPtb4wPlcM9Pr
X-Google-Smtp-Source: APXvYqx15GFlsFQGXDfEwBwENj7CEB0nt9L7aalCE9ijLJoaPHbYdwI2tQgT0tOiubwaG8OX+l07LQ==
X-Received: by 2002:a62:ee0a:: with SMTP id e10mr47038892pfi.6.1556295530046;
        Fri, 26 Apr 2019 09:18:50 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id l4sm35149983pgh.17.2019.04.26.09.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 09:18:49 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 27 Apr 2019 02:16:40 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v4] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190426171640.GA7413@tigerII.localdomain>
References: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
 <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
 <20190426135316.GA505@tigerII.localdomain>
 <20190426141426.h7hpvhr3rqp7umbk@pathway.suse.cz>
 <20190426164302.GA26127@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426164302.GA26127@tigerII.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/27/19 01:43), Sergey Senozhatsky wrote:
[..]
> > The console waiter logic is effective but it does not always
> > work. The current console owner must be calling the console
> > drivers.
> >
> > >   Hmm, we might have a bit of a problem here, maybe.
> >
> > Hmm, the printk() might wait forever when NMI stopped
> > the current console owner in the console driver code
> > or with the logbuf_lock taken.
> 
> I guess this is why we re-init logbuf lock from panic,
> however, we don't do anything with the console_owner.
> 
> > The console waiter logic might get solved by clearing
> > the console_owner in console_flush_on_panic(). It can't
> > be much worse, we already ignore console_lock() there, ...

Hmm, or maybe we are fine... console_waiter logic should work
before we send out stop IPI/NMI from panic CPU. When we call
flush_on_panic() console_unlock() clears console_owner, so
panic_print_sys_info() should not deadlock on console_owner.

It's probably only problematic if we kill a console_owner
CPU and then try to printk() (from smp_send_stop()) before
we do flush_on_panic()->console_unlock().

	-ss
