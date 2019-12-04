Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A8C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9483A207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575453957;
	bh=72vHxWhhM1b2KQUqflr1ck/cNWmjrG5bchbgRbzqaI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RFta6wTjsFL9yQGCbadN/8ybhgGsTgfn8znsfqEe5Iy2cZOjN2wQwc/D/IId8cFIw
	 hGV+8LmL3HMTfIV/IJuUCNvZ1N9bdT6jOd2DM88D/IXe5IrC4KLqg6iXrZ/Th4Axoi
	 3fVDERWxTZdnLwU08P1G35M82Ofmha026Hk6ywKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfLDKF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:05:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43516 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfLDKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:05:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so3153195wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aa/PDEF2Bw8Qk1nIOGLiLyjqeTR32fS388AjMQcdSb0=;
        b=oKCE/2aTpDTBQsuRcdkMMCSiM2z0PXLpYXwRx15wB48GBkdc40Gmkxk+aG+syH+tZi
         VBb11f441bHNjn8aWMisfJrIfaRHpci+icNxQq3NkEEDr/stCmEUXlJzUv2pVzWvnjmU
         vvq/+AEB9Rgf/fm6j5U0xDTPpbsJo+/ToiQrxSiviwUrcwR7QOLVQiqd/dL4C5CCFIRo
         bAk9itMr+K54hIsYMeDuo4E0yyFWabAmhj0icz7oLIrMhMYWmFX5oKwqoVbcPJzS1Xmr
         z/OmE0NeJ3bwJS2Odn9aSbIVjjSuUUu2S6Ol5LQyAVYUjUdwzx0yqL7wCSYC02OP1OIp
         yLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aa/PDEF2Bw8Qk1nIOGLiLyjqeTR32fS388AjMQcdSb0=;
        b=P7TeFK6gDr6Y+phQS9bhMmZsauQlc15qRLtQMhGzV7kfmRZqbz+QWHeHMUowgXVy35
         2mCKDyakfENmCawiKmMSuaBSoqeDcHeLOaXnFcEYT9rGkOuExi8RYLW4JxDzDBCB2K8d
         7iHD1wB+b5A5Sd7BYEL3z3NteBvDTFWKwNkeNLvcclaroSHfLspMJ8v34v6LTVZvGJml
         i7AI4jHeKqUWNXi/Yde+r7Kk71AbIZ5I/sZfFqclmToKSJVV8YC56rJIhf362uPXhOU0
         b6lp1zXX3LkTvYoHY9gwgo0mnSvw/6hvgk04l9OBYlMT0/cBDpQWZ99MocaR/z+76/Tf
         QskQ==
X-Gm-Message-State: APjAAAUFBzyaLN5V1wQKtelb8vFcw6u8UJActw3A2BXlJFIeT0eKL+YG
        HHOYWVD08MjXKqfXKoe5ShQ=
X-Google-Smtp-Source: APXvYqyq9PEWAPLkLOxxiLhP1cQpA57zORVCDrYZzafsKZqFMGCiTllY0gW8wJGczxRRihbNnczxXA==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr2933755wrv.197.1575453952707;
        Wed, 04 Dec 2019 02:05:52 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w188sm6473193wmg.32.2019.12.04.02.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 02:05:51 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:05:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191204100549.GB114697@gmail.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
 <20191203175712.GI2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203175712.GI2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> >  * This list-traversal primitive may safely run concurrently with
> >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> >  * as long as the traversal is guarded by rcu_read_lock().
> >  */
> > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > 
> > is actively harmful. Why is it there?
> 
> For cases where common code might be invoked both from the reader
> (with RCU protection) and from the updater (protected by some
> lock).  This common code can then use the optional argument to
> hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> called with either form of protection in place.
> 
> This also combines with the __rcu tag used to mark RCU-protected
> pointers, in which case sparse complains when a non-RCU API is applied
> to these pointers, to get back to your earlier question about use of
> hlist_for_each_entry_rcu() within the update-side lock.
> 
> But what are you seeing as actively harmful about all of this?
> What should we be doing instead?

Yeah, so basically in the write-locked path hlist_for_each_entry() 
generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
correct?

Also, the principle of passing warning flags around is problematic - but 
I can see the point in this specific case.

Thanks,

	Ingo
