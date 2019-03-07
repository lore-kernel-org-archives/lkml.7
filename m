Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7CA20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq6rUGnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCGGvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:51:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40772 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGGvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:51:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so10496910pgo.7;
        Wed, 06 Mar 2019 22:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KcpAjxItQtRdfmbFR5ol1O8lZk07GyVE3FTdvbCP6S4=;
        b=lq6rUGnMtWNRwoD7/s6LPRVjHa03aGduQ/ILI1dSlzhfY5qjsFQ2/bL7KoKzKOuLJk
         VDVqw1j1RplNcBXAbHp12RaVKsR/NHslBuI9cvJddDFKg7Y4JzTnvbk3pgjdvvTsTrJS
         hONvQxuybOVp6YaY1Vf3wO9qNz8XQWIdob6uWakD7e4x6IsXerGqC6O/4oF9dbYte4PQ
         HygbFcmWWsGUtgLrIDuaWgIaAjYWkRSR6tYh24KVBrOnladykeiVaprJMQGwEwf4pPWY
         bqaQBljctMy6L7NE4Zv2gBG3xfIDeBTaikEAAt5RvNrvgxaiJlml6u/zH/Lgp3fPfxnW
         jXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KcpAjxItQtRdfmbFR5ol1O8lZk07GyVE3FTdvbCP6S4=;
        b=NF8uFW3b9yQEvh0BSKaOMhIPgJoUQUun3RT3w6FU37Iu5WI4oFM33v89EYKgBBs/vD
         CuYmsdJhxbtM93rpA+otA6+UmY3is+TrFJmOxO8/zWuuwjpTJofqfhp/CM3vM0vjuFt2
         f5B9hsl5+7I85EgXATxVVGB8Qh6Aca7FB7THBPn130svvScyTGHWFcLFItqcLu1Y3JBQ
         2g0Muc4i39MmXHTzWOEMD2FK2v3Kr6oVewN/quv38uQmAEg19bTmnhvqx0IJpao2/NoX
         OF8Hqf80Y0s1MA61WwAyHC8RZpYAeaecTcd5W6pcM/UiUkzGJtjKkIVHVXoyQDdIYjYv
         rOaQ==
X-Gm-Message-State: APjAAAU85mTYjwG+icxdFtCXvxCXh084YN5P4eLZRpC83EulkQj+Y8OP
        8DtSaUjg6Srm2RU2JA7mMx8=
X-Google-Smtp-Source: APXvYqzBV722wiFTwTn1CWzfU2waOOzbqzpv3WqFLD6fCQoLaGadyRIEjjBnqdHhqa3fk3U72/iDag==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr11489620plk.106.1551941469761;
        Wed, 06 Mar 2019 22:51:09 -0800 (PST)
Received: from localhost ([175.223.39.30])
        by smtp.gmail.com with ESMTPSA id z18sm12202057pfl.164.2019.03.06.22.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 22:51:09 -0800 (PST)
Date:   Thu, 7 Mar 2019 15:51:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190307065106.GB425@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
 <87r2bjbt47.fsf@linutronix.de>
 <87k1hbbq2m.fsf@linutronix.de>
 <20190307064152.GA425@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307064152.GA425@jagdpanzerIV>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/07/19 15:41), Sergey Senozhatsky wrote:
> This sounds concerning. IMHO, netconsole is too important to rely
> on preemptible printk and scheduler. Especially those netcons which
> run in "report only when oops_in_progress" mode. Sometimes netconsole
> is the fastest console available, but preemptible printk may turn it
> into the slowest one.

+ oops may end by the time kthread becomes active.

	-ss
