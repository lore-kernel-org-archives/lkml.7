Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69348C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E317206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="ZY/elBvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCU1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:27:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47014 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:27:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id s24so171580otk.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H25MVH73mz8040/LKGCGwU30UKovzFtKl+b9eb82tRM=;
        b=ZY/elBvfMU7Ae6o1FvttndbYthsFI8NsAT4HDGbIF/bwY8rOoeFpqqCnce4AmKOf0l
         teNw+Bewd+8PiEBE0cxss2x4rgLoJzpZ/aUiWvd7cyS+7y2vsTa+FKbOF+Da66jD6MH7
         +Ywb50pn09IGzxuNTLRgnav7/PpyH+kgfuNgMWEFtPNGa1v1TtGX2ToEVkNlU43eHVok
         OuWQ8R8ZhMKfnj8fhMhUS3AkbYvIa2G1NaquhyVVmUNdTbi6I3xKjl6lg5wr6STcbyKG
         lsvh9NrREO5PYJTJGdX9CKstzmLUMMnN2skSLX0qBhL+MHHkuG/zlvI9YIT9w/jmSJKb
         +Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H25MVH73mz8040/LKGCGwU30UKovzFtKl+b9eb82tRM=;
        b=NAk6gstNWxVOPhzxCLidcEcFZSMLu3CbNDMb0KKXipIApCTIp3NlA5kR914I1cBYho
         3b+uL7GKURVZh7k7SxrmRvAN6ycftkDrs7cmzw0ZNpWsuHA4nRDnuU/++9g5QphIAoBt
         jAhag/dhQzzJuOXnHAW1sJmavBVsSAfud3vVych8qWE/u+jnytVYl7wfJFjjo5gQbH8o
         9rB72UuDke1GQNQivuajkUBHho6ywCOmpLdnQcnDkENEaRgnm9S+nEn87+079qrAlncr
         U/VoM3tu6GqxN8nZoC37L79KeuDcPUUDmggZAroirFILTlEZQ/ktuJP23E7cl3frve//
         P4ow==
X-Gm-Message-State: APjAAAVdOKcKqWFTJdibOrqxcZQvXprjJqyAc8Ix89Y2SId6TlZsl0Hj
        qj8YqxZwg4QeiZiwar+I6c58KQ==
X-Google-Smtp-Source: APXvYqxVgWNyoRQ0fDaEH31uxy57nbGDDaNTqsr0CiY6q6Vvj4LCHHmER6qAMQ9qASPCvac3Ixofuw==
X-Received: by 2002:a9d:d63:: with SMTP id 90mr1078089oti.333.1554323251628;
        Wed, 03 Apr 2019 13:27:31 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:ad73:c2c3:c242:6ded])
        by smtp.gmail.com with ESMTPSA id g21sm7138140otk.12.2019.04.03.13.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 13:27:30 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:27:29 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: linux-next: build failure after merge of the ipmi tree
Message-ID: <20190403202728.GD2479@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190403143323.156ac503@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403143323.156ac503@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:33:23PM +1100, Stephen Rothwell wrote:
> Hi Corey,
> 
> After merging the ipmi tree, today's linux-next build (x86_64
> allmodconfig) failed like this:

Paul, any opinions on this?  Is just running this in a workqueue
the best idea?

-corey

> 
> drivers/char/ipmi/ipmi_msghandler.c: In function 'free_user':
> drivers/char/ipmi/ipmi_msghandler.c:1268:2: error: implicit declaration of function 'cleanup_srcu_struct_quiesced'; did you mean 'cleanup_srcu_struct'? [-Werror=implicit-function-declaration]
>   cleanup_srcu_struct_quiesced(&user->release_barrier);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cleanup_srcu_struct
> 
> Caused by commit
> 
>   487ecb21fa66 ("ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier")
> 
> interacting with commit
> 
>   f5ad3991493c ("srcu: Remove cleanup_srcu_struct_quiesced()")
> 
> from the rcu tree.
> 
> Based on the comments in the rcu tree commit, I have reverted the impi
> tree commit for today.
> 
> -- 
> Cheers,
> Stephen Rothwell


