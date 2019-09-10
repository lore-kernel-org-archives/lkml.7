Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B951DC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865792084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdHrkPqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbfIJDTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 23:19:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39278 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfIJDTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 23:19:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id i1so1805826pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 20:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o7+s5dHDsNMT31sW4MR0WrezJccEAL/e3o6mXDjKbYE=;
        b=vdHrkPqj6RvDVimyUnRVQht0b2m6XUHPQnG6QtxuiOF+WhFiQAnylgGmn/vyknaf91
         Q22ToDqa7veciSm/797X6KK3/rwqA9n0nNfgfm7q6EJPhYRUTStSKfc3ocWpQmrgP38c
         Vd+HWWdvmFJgXsww/JE2ogu506vROfVHAbhytkIYUYOw+4QeJq3WQKVzpsmv3hguNmwz
         dr4nAUsFBByntM5XhP6zyn4oHbcp0gNZO4CKabwHGP0cYwubJIvL9driwje407MznQhH
         MYwD8LgXBrHUS+GZdGrY5x/0FLKYe1EG/sPJRI8HRSG7f0voD9SKs09hl9ePHHfDa9q6
         dHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o7+s5dHDsNMT31sW4MR0WrezJccEAL/e3o6mXDjKbYE=;
        b=fZazmBjaUBMi4chrTeCaEEM8LjvDtwprOgZxyBVf1ywGq1BCdTj5bxf43lMue2a4Ac
         njJpD85yp75MSiNEUHCFF2PhhQOU7vGTGo4pJ9lC6nLroofgmX9vO2TyL+XvqkXogGmS
         9wyWyf0tGFcAjlINOyZ59tjGPMGJyrqXF4HkGeAPwZ4/zvU1D14JCzGsqPFkOlBo59aH
         TtHWcS3/dPbSpi7CSN4b/Jhs8Wifj6usbUCVbLTti7JCN0c88+iuu3elK+VWgk3Qa5JF
         L4FINrmTOyICxReDYSWIC8oaTmQgGW4uriu1b0m1MVjspMqdHvgVAiX+ERmqy5vEaoS4
         nL5w==
X-Gm-Message-State: APjAAAUINzPKwjIc1ejzEE7baXhjo7fBkcjlRy6IYcFbVmHGEay/G/cl
        4a+pDCty/sDGyDf5eUwFQYM=
X-Google-Smtp-Source: APXvYqw39I7xOfK/BZ/IZbeS1ESR99/D5ZgGYfiKeMQ7M3ZvMXLPuWzxtLMsl5ofQb99FQDH56ppDw==
X-Received: by 2002:a63:20a:: with SMTP id 10mr25051127pgc.226.1568085553732;
        Mon, 09 Sep 2019 20:19:13 -0700 (PDT)
Received: from localhost ([39.7.19.227])
        by smtp.gmail.com with ESMTPSA id u11sm8886674pfm.113.2019.09.09.20.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 20:19:12 -0700 (PDT)
Date:   Tue, 10 Sep 2019 12:19:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
Message-ID: <20190910031908.GA103966@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de>
 <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <20190809061437.GE2332@hirez.programming.kicks-ass.net>
 <CAHk-=wiG55kT0MRprt+Opbpcc=ebugC_rz4d6-whtAGXri3TwQ@mail.gmail.com>
 <alpine.DEB.2.21.1908100745260.7324@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908100745260.7324@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/10/19 07:53), Thomas Gleixner wrote:
> 
> Right now we have an implementation for serial only, but that already is
> useful. I nicely got (minimaly garbled) crash dumps out of an NMI
> handler. With the current mainline console code the machine just hung.
> 

Thomas, any chance you can post backtraces? Just curious where exactly
current printk() and console_drivers() hung.

	-ss
