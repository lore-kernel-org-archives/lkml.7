Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86176206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WYMo99SV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfFFIRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:17:06 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43442 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfFFIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:17:06 -0400
Received: by mail-wr1-f54.google.com with SMTP id r18so1368204wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xBbVTGFBPyoozI6PnJzeKlugKc/WGoW+LUVu4QHH1d4=;
        b=WYMo99SVFkTvGA9Zt37cdMnR9ADrz+NkyZ2CbqrHFLx9y9H45y5QkEfbiYPeWFr2vR
         pXWQ4GexdZaM9gH7QBfxTy2AtdndSp7VdLuivf3HQm0Z7rydWHB7Vh/DhwrvzIvPc3I5
         IKuvJd3AFxGmNmSBAdUSucdTDV5caep8ctff4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xBbVTGFBPyoozI6PnJzeKlugKc/WGoW+LUVu4QHH1d4=;
        b=C/ZEHyY8xKPDNW34yfGAtga0vJqED3l/x95JZzPfUTLvlVf8IfdcYHdLNnV4l1ahmX
         XzTU/XehzoijF2lnIJlDIYsIarGluqtugu3jajtqDE4hGzGvVNv5dNlIJff1jWAkvCW0
         KK7tVSo/15KR8Qdwb2nSACtaVeLhTO7vgA3HTy93A81SBrL8DZtQiQ31Px57NYJkTbzM
         0Njuv+zNc2gdugokn0DLZDGWlWIXomPrju96Xjlsn1sj+9QfxAIESspev1HbAiKFy6am
         10DPRqoQ6Cq4yMFErARfmgLLvqKUGeafXksBDIDcNWbeN+/E5FhJKa49/ZvbYFrmvm2x
         2/bA==
X-Gm-Message-State: APjAAAW79HrhsnPZ7/GBfzzE9N4EFA3cdEf+1/4LL7mzGb3Qmo5f4BLh
        Y0XlpybTjRULRO3MbwblPJ+3Jg==
X-Google-Smtp-Source: APXvYqyCvJyLgsTzU5WwYciEIG85vyQHFaxQGkPZYjpIySUQ5B7lOY0gnGHyW2EgRTznsPfhZxn+tg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr16132368wrv.61.1559809024323;
        Thu, 06 Jun 2019 01:17:04 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id p16sm1681171wrg.49.2019.06.06.01.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:17:03 -0700 (PDT)
Date:   Thu, 6 Jun 2019 10:16:57 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>
Subject: Re: rcu_read_lock lost its compiler barrier
Message-ID: <20190606081657.GA4249@andrea>
References: <20190603200301.GM28207@linux.ibm.com>
 <Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This example really does point out a weakness in the LKMM's handling of 
> data races.  Herbert's litmus test is a great starting point:
> 
> 
> C xu
> 
> {}
> 
> P0(int *a, int *b)
> {
> 	WRITE_ONCE(*a, 1);
> 	synchronize_rcu();
> 	*b = 2;
> }
> 
> P1(int *a, int *b)
> {
> 	rcu_read_lock();
> 	if (READ_ONCE(*a) == 0)
> 		*b = 1;
> 	rcu_read_unlock();
> }
> 
> exists (~b=2)
> 
> 
> Currently the LKMM says the test is allowed and there is a data race, 
> but this answer clearly is wrong since it would violate the RCU 
> guarantee.
> 
> The problem is that the LKMM currently requires all ordering/visibility
> of plain accesses to be mediated by marked accesses.  But in this case,
> the visibility is mediated by RCU.  Technically, we need to add a
> relation like
> 
> 	([M] ; po ; rcu-fence ; po ; [M])
> 
> into the definitions of ww-vis, wr-vis, and rw-xbstar.  Doing so
> changes the litmus test's result to "not allowed" and no data race.  
> However, I'm not certain that this single change is the entire fix;  
> more thought is needed.

This seems a sensible change to me: looking forward to seeing a patch,
on top of -rcu/dev, for further review and testing!

We could also add (to LKMM) the barrier() for rcu_read_{lock,unlock}()
discussed in this thread (maybe once the RCU code and the informal doc
will have settled in such direction).

It seems worth stressing the fact that _neither_ of these changes will
prevent the test below from being racy, considered the two accesses to
"a" happen concurrently / without synchronization.

Thanks,
  Andrea

C xu-2

{}

P0(int *a, int *b)
{
	*a = 1;
	synchronize_rcu();
	WRITE_ONCE(*b, 2);
}
 
P1(int *a, int *b)
{
	rcu_read_lock();
	if (*a == 0)
		WRITE_ONCE(*b, 1);
	rcu_read_unlock();
}
 
exists (~b=2)
