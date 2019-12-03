Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919C1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AED20833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575357216;
	bh=ifhbmliWKO4DCq+/b+fovxWuQeq7OYovvmneKazQCus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GL8X1mz5CZNtcV5PLrTfsisf7onL2+WHhyN9z3BPK4Yb7Tfp+D5IEPhKWVi7MObiT
	 gcXHQyTUj8hgczrSkma/um5HmStMGyCaFs15vBOgePheGF6z1yi3kRtvuiQBJUPLn8
	 adEcUNHC4pSppq0yNQWoA3PRyEwD8DmaPA+itbgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLCHNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:13:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36692 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfLCHNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:13:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so2299836wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MPmc2yKpVIqENGNvQ5QiBP91kZNjvhfLwX75BD1xrb0=;
        b=KvgUuDi6gSeK9XzO5cOLGcOy6oJtQ3gYOzbxopL2NWzRCQHYThvhmSDMzCqThiaVNc
         6hkObABluux9sT1YO6l/b4BuyUd9+ySmmKQjNMQRhd5tX44oki3bSqL1XGURHM/ht9UG
         3BRDiNU4dHNnwu6W5oeIZeijCniGUYFBqjle90yD/yPDlDT9Y1DeI0F9E2VHQWVZ3qZX
         72NYhZKmUnmezrBkARd8mtSDZzBGMQkegCODQak3yfXYdEJ4ar4OYrLaMVaLuz1ig0Pb
         uZChIMTht0LEtm5isXudlRxgPsm4duQwr2vC3Pn9VIWg8lST9uEbyYZPbnO/ghO/6+jD
         NWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPmc2yKpVIqENGNvQ5QiBP91kZNjvhfLwX75BD1xrb0=;
        b=CAHKlmPJaOxULCHDYZDd7+j+DDisw9h+dJICtkRAAMDTZFnYQtq9BiH/OsD+R8zeFU
         B55tEKm1IdsgN35lnhN+p6g+KkI7jsd4G6Zm+mtmDLMcCPv3rADEdyjmw7XDUrfokdmW
         HLBKzfbCrbLviS86eFzMQ8d/ICJFBcKiq4z9sLir3ZbCFk/eUZtGWJBQ9MMCfiNP/BVw
         9lru2TGlAkI9QWGwkEZgvCANv2kLFadAUsgBCAkq792wY7TbSoKYXvQor4gIdK225ZbI
         MZg3EJCnFjIPHP5Fuas1yWEXrfbHSeCBH31NXQXN1i/PahjeCelgq1ot2fvhDZgDJsRD
         WJqg==
X-Gm-Message-State: APjAAAXNddty71uqERhfT42MOjsGviexAZxZvcqz/7OXcDfXelf5CQdL
        3LpVG8F7SSw4tMJPXCe1lKY=
X-Google-Smtp-Source: APXvYqw55GXTYTUtTnbIFdVW5UMYNt5vunZuT4QC+A5SqcvTYPSk18ZIz9rdPTnD/N2z+SWENqT/9A==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr3362216wrj.344.1575357212367;
        Mon, 02 Dec 2019 23:13:32 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a186sm1867835wmd.41.2019.12.02.23.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:13:31 -0800 (PST)
Date:   Tue, 3 Dec 2019 08:13:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191203071329.GC115767@gmail.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202210854.GD17234@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Fernandes <joel@joelfernandes.org> wrote:

> On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> > Anders reported that the lockdep warns that suspicious
> > RCU list usage in register_kprobe() (detected by
> > CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> > access kprobe_table[] by hlist_for_each_entry_rcu()
> > without rcu_read_lock.
> > 
> > If we call get_kprobe() from the breakpoint handler context,
> > it is run with preempt disabled, so this is not a problem.
> > But in other cases, instead of rcu_read_lock(), we locks
> > kprobe_mutex so that the kprobe_table[] is not updated.
> > So, current code is safe, but still not good from the view
> > point of RCU.
> > 
> > Let's lock the rcu_read_lock() around get_kprobe() and
> > ensure kprobe_mutex is locked at those points.
> > 
> > Note that we can safely unlock rcu_read_lock() soon after
> > accessing the list, because we are sure the found kprobe has
> > never gone before unlocking kprobe_mutex. Unless locking
> > kprobe_mutex, caller must hold rcu_read_lock() until it
> > finished operations on that kprobe.
> > 
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Instead of this, can you not just pass the lockdep_is_held() expression as
> the last argument to list_for_each_entry_rcu() to silence the warning? Then
> it will be a simpler patch.

Come on, we do not silence warnings!

If it's safely inside the lock then why not change it from 
hlist_for_each_entry_rcu() to hlist_for_each_entry()?

I do think that 'lockdep flag' inside hlist_for_each_entry_rcu():

/**
 * hlist_for_each_entry_rcu - iterate over rcu list of given type
 * @pos:        the type * to use as a loop cursor.
 * @head:       the head for your list.
 * @member:     the name of the hlist_node within the struct.
 * @cond:       optional lockdep expression if called from non-RCU protection.
 *
 * This list-traversal primitive may safely run concurrently with
 * the _rcu list-mutation primitives such as hlist_add_head_rcu()
 * as long as the traversal is guarded by rcu_read_lock().
 */
#define hlist_for_each_entry_rcu(pos, head, member, cond...)            \

is actively harmful. Why is it there?

Thanks,

	Ingo
