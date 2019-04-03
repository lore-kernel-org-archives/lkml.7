Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E8CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB00920663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="YyG1v9XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDCVMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:12:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37090 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:12:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so87267oif.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P+aYZK57wHQTt5L5xi6/UUv5j3EJAdj7ccnhzx/pVxs=;
        b=YyG1v9XWo7fqj8Ml6ZgLgeZAjIqniL8uvq4UMOHwHx+MRiMGvVt14XTV0hKHSwtvFV
         CLknJu/nU0U4SejxvT24NtwcoAnaUdSe944V0nTMoWimgmBt9EGYqfeb0T0+MEu4JgxH
         UXRPWg9lk3ISTy56yIcER64pQUNHCJtCWwzd3wVSrXvftDbQijwISJxXOsbZ5Jpia0bf
         ZzLGFWbM+K9HSGgnajEBJRUPtNUs/GjbT5p7xiUOQECWoMMsoXpmzBpbxHJIkmDzrsQL
         5Gs/0OlyA4141+TVxTGCNdI62/GTfV0TN37kuG8ctxgpha8A4zY8em0/b2xc1OYdi9hx
         sL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P+aYZK57wHQTt5L5xi6/UUv5j3EJAdj7ccnhzx/pVxs=;
        b=FMNhbfVIg9UbToLGI+nYiGBtqAva8fBLOwDSHyn7mqI8DqNT+Ly54/+3rUabPAGvqR
         HLBJROT1kpOq2NGQikT//pBpZiPr+k5GESBm8sPgKQxsivrye1JZvhzgNRBJyfEGglnv
         xEREtaU8HAC9soFp+NJyXvii9gfAr3wpIyltyQuVIufeK0kNjWDkvaPkirpyhUk6ueZU
         GaNpFd5EXoKZXffV8/rss/LWqG24YMjKlSWIsZD+fae/+GaeniyiQkinzpJYKTnG5nuW
         d/ZSe4P7wZkQd+xHdQ/hgwxAn7qqhkVMmC6XO+7GHjpy4VmISYMrKYVzBuLOerTtQLtb
         RnPQ==
X-Gm-Message-State: APjAAAXDZADOHsdmErvNBd8B3nAk37Q8h2WbHKQyTNMnJSXewOPzjO03
        2ueZRsmV2YbVlZBP8N22VUZyAg==
X-Google-Smtp-Source: APXvYqwbQ4ouE3F1DSVihd7YVlA+LVdjT+A0fu8rzo3Z3Ow0W/U5Zjx2iv1/1B/HV7PfL6uyV4nSDg==
X-Received: by 2002:aca:f410:: with SMTP id s16mr1087238oih.87.1554325935443;
        Wed, 03 Apr 2019 14:12:15 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:ad73:c2c3:c242:6ded])
        by smtp.gmail.com with ESMTPSA id c136sm7862845oih.14.2019.04.03.14.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 14:12:14 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:12:12 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: linux-next: build failure after merge of the ipmi tree
Message-ID: <20190403211212.GE2479@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190403143323.156ac503@canb.auug.org.au>
 <20190403202728.GD2479@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403202728.GD2479@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:27:29PM -0500, Corey Minyard wrote:
> On Wed, Apr 03, 2019 at 02:33:23PM +1100, Stephen Rothwell wrote:
> > Hi Corey,
> > 
> > After merging the ipmi tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> 
> Paul, any opinions on this?  Is just running this in a workqueue
> the best idea?

Well, I just that patch using a work item and pushed it up.  Seems
to work ok.  That was already done for other things in the driver.

> 
> -corey
> 
> > 
> > drivers/char/ipmi/ipmi_msghandler.c: In function 'free_user':
> > drivers/char/ipmi/ipmi_msghandler.c:1268:2: error: implicit declaration of function 'cleanup_srcu_struct_quiesced'; did you mean 'cleanup_srcu_struct'? [-Werror=implicit-function-declaration]
> >   cleanup_srcu_struct_quiesced(&user->release_barrier);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   cleanup_srcu_struct
> > 
> > Caused by commit
> > 
> >   487ecb21fa66 ("ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier")
> > 
> > interacting with commit
> > 
> >   f5ad3991493c ("srcu: Remove cleanup_srcu_struct_quiesced()")
> > 
> > from the rcu tree.
> > 
> > Based on the comments in the rcu tree commit, I have reverted the impi
> > tree commit for today.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 
