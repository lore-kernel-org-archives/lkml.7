Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE25207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cQos73Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfFFIjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:39:06 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55376 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfFFIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:39:05 -0400
Received: by mail-wm1-f48.google.com with SMTP id a15so1170776wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7W4AZwmqFUjZP9AmWoxftQySqTDv4cSCVrTgTUVf7H4=;
        b=cQos73BvgyiB1IQg1OSNrvkqRifL47HYGi5e4Nx6PhXHRgSZwW/eVPfwQyHtd3Dh0L
         KE1tKX8cfKJ/QRgGu3UABnZupi1wAtGK7aPYoTak22AKAOzDaoC5oCxU+HZV3eeZPWUt
         +X8DmH8DRgukz6TnG9GSm4rV6+ZYE2JC2Xml8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7W4AZwmqFUjZP9AmWoxftQySqTDv4cSCVrTgTUVf7H4=;
        b=nkboVhpqTM4pJClYQIPf6rJ3Ie7YgXD8/Z7EZHTHNT2aILqn5cGyX+hyD5tOCtsVZy
         F2GoK1Dvus84+tVNDBUmWEV6N24gvru5XhlHU4nkl7udUO8Om0hrOBbioI0WgrvGiXYP
         +zFJjdNjmRspx/syZNtq6JPcx8wPYBGhemZ8ry9Sab25DS34WtGlXhAjPKrR9urRlaI9
         EFUzmunOdr2iyALlsV6lRdEBAL6UOg79ISlNF6rz2RUDQzLB6l43D17pCrDXnohGp3cN
         ZG5dzMsUUC5lpz5TXw5jxcWhJo4eimegWZ9r2kD55d2o93lo6aAkNHe7J6aaI1XVwbpK
         76UQ==
X-Gm-Message-State: APjAAAVSHCfOEXRodFzr7aH9GMkPZbDjYR+EegOqr1ErLLg8kGG2UTuA
        6dD/0XiCUzvqWM+pfeQxXfWlMw==
X-Google-Smtp-Source: APXvYqxI6aQUuskRypHMcd/HfB7YUgAcRnE+c1mMH+wiMTozaFTrPbPqe4oDqYXjqjcaH9UF3hDz8A==
X-Received: by 2002:a1c:3dc1:: with SMTP id k184mr26163386wma.88.1559810343349;
        Thu, 06 Jun 2019 01:39:03 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id q21sm1076707wmq.13.2019.06.06.01.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:39:02 -0700 (PDT)
Date:   Thu, 6 Jun 2019 10:38:56 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: rcu_read_lock lost its compiler barrier
Message-ID: <20190606083856.GA5337@andrea>
References: <20150910005708.GA23369@wfg-t540p.sh.intel.com>
 <20150910102513.GA1677@fixme-laptop.cn.ibm.com>
 <20150910171649.GE4029@linux.vnet.ibm.com>
 <20150911021933.GA1521@fixme-laptop.cn.ibm.com>
 <20150921193045.GA13674@lerouge>
 <20150921204327.GH4029@linux.vnet.ibm.com>
 <20190602055607.bk5vgmwjvvt4wejd@gondor.apana.org.au>
 <CAHk-=whLGKOmM++OQi5GX08_dfh8Xfz9Wq7khPo+MVtPYh_8hw@mail.gmail.com>
 <20190603024640.2soysu4rpkwjuash@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603024640.2soysu4rpkwjuash@gondor.apana.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:46:40AM +0800, Herbert Xu wrote:

> The case we were discussing is from net/ipv4/inet_fragment.c from
> the net-next tree:

BTW, thank you for keeping me and other people who intervened in that
discussion in Cc:...

  Andrea


> 
> void fqdir_exit(struct fqdir *fqdir)
> {
> 	...
> 	fqdir->dead = true;
> 
> 	/* call_rcu is supposed to provide memory barrier semantics,
> 	 * separating the setting of fqdir->dead with the destruction
> 	 * work.  This implicit barrier is paired with inet_frag_kill().
> 	 */
> 
> 	INIT_RCU_WORK(&fqdir->destroy_rwork, fqdir_rwork_fn);
> 	queue_rcu_work(system_wq, &fqdir->destroy_rwork);
> }
> 
> and
> 
> void inet_frag_kill(struct inet_frag_queue *fq)
> {
> 		...
> 		rcu_read_lock();
> 		/* The RCU read lock provides a memory barrier
> 		 * guaranteeing that if fqdir->dead is false then
> 		 * the hash table destruction will not start until
> 		 * after we unlock.  Paired with inet_frags_exit_net().
> 		 */
> 		if (!fqdir->dead) {
> 			rhashtable_remove_fast(&fqdir->rhashtable, &fq->node,
> 					       fqdir->f->rhash_params);
> 			...
> 		}
> 		...
> 		rcu_read_unlock();
> 		...
> }
> 
> I simplified this to
> 
> Initial values:
> 
> a = 0
> b = 0
> 
> CPU1				CPU2
> ----				----
> a = 1				rcu_read_lock
> synchronize_rcu			if (a == 0)
> b = 2					b = 1
> 				rcu_read_unlock
> 
> On exit we want this to be true:
> b == 2
