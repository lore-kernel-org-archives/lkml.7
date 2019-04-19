Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B1C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B470D21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FEukazJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfDSAxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:53:13 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35494 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfDSAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:53:13 -0400
Received: by mail-wr1-f45.google.com with SMTP id o12so1778045wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 17:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=reMWGe81hoF/vvuKJ+4JQR1H9FwkqoUMbxtyhkxE3S0=;
        b=FEukazJtq1ezJQKm8043WwgrXJchb8r533cJT8INdSG5rUbIp/iRWsJeFXsNdWcRDb
         +5xjj7QpGOzCZxHXP/1NFI7DyTFKWvKif1Lz7ri51ZLlYN4pgYLBKSf0nVw230qrXuvw
         /PcVVkv2HER6X81+bj8lTkLhKbYxo2UiAWkOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=reMWGe81hoF/vvuKJ+4JQR1H9FwkqoUMbxtyhkxE3S0=;
        b=I0aiXLs2a4NBS14IkJBiX7WzmhNcHFZUCPSLJMnUWbGE/NBbtXMQk+1Zf2jYOn3wTC
         tLKdlQtrEp8+5K+w3r2eCzbPKFR8Pw/K3uDa9lkUseA7o2Bm2AM8ROMtL4FXVm4ygSMR
         aq1Za4V3nCXwBxeTThBYIurgUbg7xbXb8pbLKzfLsy77f36BHmHkhqnWlgdxN/EIc+ux
         6e7BY3bxQ/IOEADML1lnNXWSU17PlohrvaL+U5xW7A8YMVzZ1rYXFEUz3fgw3BFBTord
         lmM+9hWU4Nyjj6DjNy227rz7G8MMNk040MTzkQzXIJelcCFXbujsjk+Gx9jgY2mzLh43
         ZWQA==
X-Gm-Message-State: APjAAAXpIaNUZxv3zvo7/qHC67nqhfb0+p11Rb+ANxSepwSC8OctG+97
        WemlRQTXVWJ34INOSUVMt9HBbA==
X-Google-Smtp-Source: APXvYqz+bn7neBqKpQ+uSH0YkOp8QirPDi3Lx0YKgi5AdaluyXWlf3iIelLjui4lPo6Sh5yuIC3//Q==
X-Received: by 2002:a5d:5712:: with SMTP id a18mr669268wrv.219.1555635191545;
        Thu, 18 Apr 2019 17:53:11 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id v190sm4259614wme.18.2019.04.18.17.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 17:53:10 -0700 (PDT)
Date:   Fri, 19 Apr 2019 02:53:02 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
Message-ID: <20190419005302.GA5311@andrea>
References: <20190418125412.GA10817@andrea>
 <Pine.LNX.4.44L0.1904181324420.1303-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904181324420.1303-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you saying that on x86, atomic_inc() acts as a full memory barrier 
> but not as a compiler barrier, and vice versa for 
> smp_mb__after_atomic()?  Or that neither atomic_inc() nor 
> smp_mb__after_atomic() implements a full memory barrier?

I'd say the former; AFAICT, these boil down to:

  https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/atomic.h#L95
  https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/barrier.h#L84

  Andrea
