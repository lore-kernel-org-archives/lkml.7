Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7209C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A861C215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575011056;
	bh=uhDeoEXCBO0HogFGnukVx1aSChe0lTpZjI9nsMgzglU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wTguGZ8Ku6RrKQEeBeF2EMzFBK8AJshCr4U/l93G0AvoQWKrivFAnfa1O5PtrUnDJ
	 CNmNXCXYUqpuVNro70TLWDi93E/gfEHCDP4Ornrg/rEHQN0sFxBxAPxEBIxHpYViAo
	 TvisTIM8Y/2IQz9m35K3N+v8FXuGcesAk7YuJZiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfK2HEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:04:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44301 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2HEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:04:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so33622101wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXChBmsSKdAnlVBk3b3I2SyZMaioWsiZLWdJUbZg8Nw=;
        b=jMSk0bhyXxsFxVEP7RDkjEosOH8mvfvIar4CKELHv5HTpIQ76ndnJn4xy0AAOgtECR
         h4piZ0kXyMrnjSYZgsNLWAg3T+lWWGVjnlhwP4PcLsAudDJkbfXWE8A0bQ+nEHYT03oM
         TaBQcNvBweg9c9UolaMJUlxMxAJNs6CLwABcUiMbcD7OVstqAXwwthiMyxh4KufRQAuV
         pIkeVpFstQd0cVLzoZkdE7Z9M29/CCio2nVkHHElRRUAQJBD2WX33AOxXP7THnrjBSoT
         KRsSpR2Fp8z3vJOPvULT4978WyecS9wj+vcHsZe0undy0ff6zjdZMVv1GLeEnHy+w0WN
         HgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXChBmsSKdAnlVBk3b3I2SyZMaioWsiZLWdJUbZg8Nw=;
        b=chUY3pxnGXBUueH+bD8Ago2UB2w5ZAM5ROpYUozaolXrHWfa97UeOq8mjnVSD14pKY
         OlHTsEeFus9VPTQ3Qw0/1jrgHyB76ITbhekNEV6zBomBiJx86+Os6sL5zvDtsz64MCz3
         sNk89u/aMBxqIie6x39w6XmjF6QMEyU9/vM7wcZxeoKKeW34p60xMMMpnHkKaYx/SOXB
         gY3bGMJVEZ8fJAAPBgawr19zPNbRUECStHUC9djxyfcjinhd8B251w819wfcMrBm47fL
         Zf0Ed+vMHT0lO3x0TAcJ0IMxt3nRlZzYnQf9AHiHB7LZGH6Umzzg3yRboNVGHaLM77wC
         5RLw==
X-Gm-Message-State: APjAAAWAaLmlW5ZudNSDB3GudCn3K7KWFiUh86bS+cAm99aJKtCHkQZp
        1tQrb87PMkj445D1zSGSWuCBvD7Z
X-Google-Smtp-Source: APXvYqz8lQA/Bj/ckMw7mSr0aDNTOp2XLnBEl/yR4nNfP1wNBSvmlhB9NFMLP0RV1STrPlB7V32CVQ==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr15441653wrk.53.1575011053195;
        Thu, 28 Nov 2019 23:04:13 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g11sm12886881wmh.27.2019.11.28.23.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 23:04:12 -0800 (PST)
Date:   Fri, 29 Nov 2019 08:04:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] spinlock_debug: Fix various data races
Message-ID: <20191129070410.GA23979@gmail.com>
References: <20191120155715.28089-1-elver@google.com>
 <20191121183257.GA124760@gmail.com>
 <20191121194418.GA239776@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121194418.GA239776@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Marco Elver <elver@google.com> wrote:

> On Thu, 21 Nov 2019, Ingo Molnar wrote:
> 
> > 
> > * Marco Elver <elver@google.com> wrote:
> > 
> > >  static inline void debug_spin_lock_after(raw_spinlock_t *lock)
> > >  {
> > > -	lock->owner_cpu = raw_smp_processor_id();
> > > -	lock->owner = current;
> > > +	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
> > > +	WRITE_ONCE(lock->owner, current);
> > >  }
> > 
> > debug_spin_lock_after() runs inside the spinlock itself - why do these 
> > writes have to be WRITE_ONCE()?
> > 
> > > @@ -197,8 +197,8 @@ static inline void debug_write_unlock(rwlock_t *lock)
> > >  	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
> > >  	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
> > >  							lock, "wrong CPU");
> > > -	lock->owner = SPINLOCK_OWNER_INIT;
> > > -	lock->owner_cpu = -1;
> > > +	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
> > > +	WRITE_ONCE(lock->owner_cpu, -1);
> > >  }
> > 
> > This too is running inside the critical section of the spinlock - why are 
> > the WRITE_ONCE() calls necessary?
> 
> Although the writes are inside the critical section, they are read
> concurrently outside the critical section, e.g. in
> debug_spin_lock_before(). In other words, the WRITE_ONCE pair with the
> READ_ONCE that are *outside* the critical section.

Fair enough!

Thanks,

	Ingo
