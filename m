Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F12C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B0214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LDaoyqrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCMPJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:09:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41297 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:09:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id o129so1285997qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mj0DhrxZTmFLVOfVIzftegHQm2AO6E/ovwMv4xmvu1s=;
        b=LDaoyqrwIQfQtzAVT0xPlDuTTgmuqXB7UWiZt7DPjD5LTEYZ7cBl3P38NH2DbUoNC6
         F3tskJ/6xV9TYEbfQuxMKeQFi369+p1W8D13ofdxJ3ctcb1J6dH49WQYRD7vhc9E7NJT
         JLwT11ZVyacyc8+PzM6+ShLY3WzPH84Ap4tDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mj0DhrxZTmFLVOfVIzftegHQm2AO6E/ovwMv4xmvu1s=;
        b=uMwxlHNylxyu+Rj/XLpDXm4mCbvneT/iB2y/5SZ6/SMNuTm1Vps2qPOS3Tmmld8Pxl
         7pbQLUG0YAyeVQgumJXYZIG4twa+AXyZTtHKiHFpyea6ua1ysdmsYZ8sBxsM4rR5ee7C
         C/P09PhP0ZXyn1Jnbq/4rOpF0YQBQO0S7UNF2iXDPa1KLjjwLKpmZVVECaKHHmIXQLL+
         EJIBQbnvdxtNY8XcialP7GO1mBvoNYBbxzC6qBG0q0TSzk5Z3+t2FOBrNXypDiyd3SX6
         vGlv5u+vZR1EX4ijyIA1uealJnEeazONA8AM18gnJjRNuI6o14BdhLP+9F+sOzW+lk2L
         rT2A==
X-Gm-Message-State: APjAAAV3B18tzZ4iLmORYLPE0q33Amo3Zq76PbyuKkX3UAxFZ9vCO1VC
        XWDQvsBgdUqGMf6tJ5Xa0mB5ZA==
X-Google-Smtp-Source: APXvYqzPNw9uOiFocGo94IjlmAenfP6QkFBo3mpV4S8oKFNcWr2bHK/yyOxpn4BePaZ4YiIN7dfajQ==
X-Received: by 2002:a05:620a:109b:: with SMTP id g27mr32665247qkk.128.1552489792423;
        Wed, 13 Mar 2019 08:09:52 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id i1sm6438110qtb.0.2019.03.13.08.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 08:09:49 -0700 (PDT)
Date:   Wed, 13 Mar 2019 11:09:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        rostedt@goodmis.org, luto@kernel.org, byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Message-ID: <20190313150948.GA84821@google.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
 <20190311133939.GA29747@google.com>
 <20190311222903.GR13351@linux.ibm.com>
 <20190312150514.GB249405@google.com>
 <20190312152034.GZ13351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152034.GZ13351@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:20:34AM -0700, Paul E. McKenney wrote:
[snip]
> 
> >            Could we be more explicit in the code that this function can only
> > be called from an interrupt, and also we change the code comment to be more
> > clear about it (like the following diff)?
> 
> That would be good!
> 
> Nice trick on using dyntick state to check for interrupt nesting, but
> wouldn't consolidating the counters break that?  But is there a lockdep
> check for being in a hardware interrupt handler?  If not, could one
> be added?  This would have the benefit of not adding overhead to the
> scheduling-clock interrupt in production builds of the Linux kernel,
> while still finding this bug in testing.
> 
> (Another approach would be to use IS_ENABLED(CONFIG_PROVE_RCU), but
> a lockdep check would be cleaner.)

AFAICS, lockdep does not specifically track when we enter an interrupt, but
rather only tracks when interrupts are enabled/disabled.

But we could use in_irq() to find if we are in an interrupt (which uses the
preempt_count to track in HARDIRQ_MASK section of the counter).

I will add an in_irq() check that does the check only when PROVE_RCU is
enabled, and send a patch.

Thanks and it is my pleasure to look into this, quite interesting!

 - Joel

