Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B659C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0265820878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sejCTUVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfDXFnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:43:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44316 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDXFnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:43:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so4179762pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 22:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6HIZTkS3Ox8iXaeKIsvQHo6rr7RP7xjOKxUXvZEMDZs=;
        b=sejCTUVDzsykocveLP8Mc5h43M3uPsL9O44qSiQMFXvM968FB8pYrzHMWyBCh5sDaC
         a9RLZdcP5r+AOXiUpj8aVmM68s/YyMQxPTWrKGOqrqx2jmN3zC/nhpIQ25wt6PrF8rRY
         pdWZ5dL7CZ3FolB01yeN1ztrShz7Aii+Qw5hjFTXDkSWpODVCfIkJyROySyuWOe3i0DB
         qkppFzhpksQMDo7fgqElDx4ITIXJ79UwNdP5jFboHCSYofxb/rTT134K58+NOYdV37An
         Xs2zP3ZlC429HGXP2zu7e1XcOI5LqqZ3qRJtKcDqSG+wjQyEMvTz877kmqQPhPtGZXtk
         4mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HIZTkS3Ox8iXaeKIsvQHo6rr7RP7xjOKxUXvZEMDZs=;
        b=AFTnBZRDyP7C6/iI4dGlme2OgXk72tiQfL9qB9gcFsH0dYl7GP5TOuuo7AKOD0jRiP
         n6dugP7EX9fag6UsRKlzJvrvAB6wADGkWS0c8JtXYrx1J3+cnpb4R+lPJ5OYiBOxsHKJ
         AzjvevhTuDdXOdZj/4GfV8l5UPSqs7Rgg0FWCOkEvWEhs0nioaamQwf4TPulqHyf2Wr4
         Am1SHpxZz6aeb/junDzZRqvgrXzeguuVsF2YTvWrznDCU2KCG5rQ3y43pinWSalYYgok
         DEM8UZOiszSZWWF15KQvRXE1UlspE7bC2kvJ7enuwTshRjf4nOoW7LdGhWeW1OpkMgLe
         ujHw==
X-Gm-Message-State: APjAAAVoFOj7wBKKHATSc9gKt2i+4hmUy8rbcwzx7vAdlTFLi5vC0nbr
        4I6YkRgUBjQH1F6k+3axk8wx2MnE
X-Google-Smtp-Source: APXvYqwgCjmYB5yhAIxByFNRFJF47oQpEnJKaCoxklRrv9REVXh0fdRvyFoCwEU5Kb4orZWT+D6rLQ==
X-Received: by 2002:a65:6656:: with SMTP id z22mr11164388pgv.333.1556084590568;
        Tue, 23 Apr 2019 22:43:10 -0700 (PDT)
Received: from localhost ([175.223.32.169])
        by smtp.gmail.com with ESMTPSA id f27sm6407193pfk.111.2019.04.23.22.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 22:43:09 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:43:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/2] Access console drivers list under console_sem
Message-ID: <20190424054305.GA28894@jagdpanzerIV>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423094801.377b8059@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423094801.377b8059@gandalf.local.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/23/19 09:48), Steven Rostedt wrote:
> > 	RFC
> > 
> > 	Normally, we grab console_sem lock before we iterate consoles
> > list, which is necessary if we want to be race free. The only exception
> > to this rule is console_flush_on_panic(). However, it seems that we are
> > not fully race free - register_console() iterates console drivers list
> > in unsafe manner in several places. E.g. the following scenarion:
> > 
> > 	CPU0					CPU1
> > 	register_console()			unregister_console()
> > 						 console_lock()
> > 	  for_each_console()			  // modify console_drivers
> > 	    con->foo				    kfree(con)
> > 
> > So I have two quick-n-dirty patches, which remove unsafe console list
> > access.
> > 
> > What do you think?
> 
> I just skimmed the patches and haven't done a thorough review, but the
> concept seems sane to me.

Thank you Steven. Let me know if anything doesn't work for you.

I have vague memories of a kernel Oops at con->foo dereferencing
(saw a message on linux-rt-users list a while ago, if I'm not
mistaken). And it seems that we have some races in printk code.

	-ss
