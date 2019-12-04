Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A20C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F6520674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MoobJeAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfLDEUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:20:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33204 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLDEUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:20:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so2958877pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 20:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TbHocbRRpqYJUnqZHtXqYEyOtGT/8yMitXiw8MvdmVs=;
        b=MoobJeAp1JZQEejGBa6wxHWnnww541jlVn/zR+WtwArJE5V5lYykLoay7QvuHx8iGu
         akwQOT0eC1UZ5XT4Vx0McDl7sfqP8tKLptf7gXwP6s+/PCd1kHcEkIOyqrYfwSXeR4/Z
         sO+1C01XLhy5+SYIWepG4vbi5MUOGuynedanM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TbHocbRRpqYJUnqZHtXqYEyOtGT/8yMitXiw8MvdmVs=;
        b=YYSdcle6Q6WOmonfYaGAuY7Oor1hAcI6YLC+Ja1bn0cp6yHNp/vQTjzCcMBBpDCyrn
         O3lhBZQ4ICZNa/fvW40Cy8uQ7QdXcjdcQ7WWB35bTztty2lUXKRrXMKcvraHSO+fO66N
         TTePUN5Q8b9V28Yvr1L+YlBeQSLjZr4rSQFpIXT3I7MMYdx33DBGQw0LUBapzag2/JKH
         vtYaAr+NlCfzMYqUF4Sa9Re7mAAZTNPagQ3Zxn+ivi6Oa/UN8jL/5U4alb/+WBpnSWuP
         6U+RS8A9IMBPIrDy3VDtrIGgU1ieOJ+yp/z0wfug+v8ouf/+L8rc5CZ0/uMT1WXO4eRe
         Ktpg==
X-Gm-Message-State: APjAAAXpcYHQ1CbgKe8cfhOY9S1MtQxKz1LARTSyGvNzP/s9DShOAwW+
        C5gC/on/qrDh5JxFaGMKpbg3hw==
X-Google-Smtp-Source: APXvYqy8NJykSVgAseSuUyW8Aj34k8HvBlp0h8pb7NkjrVeTtKWvKl7NS0w9kgYbOA9okO5MapkbOg==
X-Received: by 2002:a63:f716:: with SMTP id x22mr1378944pgh.351.1575433240667;
        Tue, 03 Dec 2019 20:20:40 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h9sm4526765pjh.8.2019.12.03.20.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 20:20:40 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:20:39 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191204042039.GC192877@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
 <20191204040959.GB192877@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204040959.GB192877@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 11:09:59PM -0500, Joel Fernandes wrote:
> On Tue, Dec 03, 2019 at 08:13:29AM +0100, Ingo Molnar wrote:
> > 
> > * Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> > > > Anders reported that the lockdep warns that suspicious
> > > > RCU list usage in register_kprobe() (detected by
> > > > CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> > > > access kprobe_table[] by hlist_for_each_entry_rcu()
> > > > without rcu_read_lock.
> > > > 
> > > > If we call get_kprobe() from the breakpoint handler context,
> > > > it is run with preempt disabled, so this is not a problem.
> > > > But in other cases, instead of rcu_read_lock(), we locks
> > > > kprobe_mutex so that the kprobe_table[] is not updated.
> > > > So, current code is safe, but still not good from the view
> > > > point of RCU.
> > > > 
> > > > Let's lock the rcu_read_lock() around get_kprobe() and
> > > > ensure kprobe_mutex is locked at those points.
> > > > 
> > > > Note that we can safely unlock rcu_read_lock() soon after
> > > > accessing the list, because we are sure the found kprobe has
> > > > never gone before unlocking kprobe_mutex. Unless locking
> > > > kprobe_mutex, caller must hold rcu_read_lock() until it
> > > > finished operations on that kprobe.
> > > > 
> > > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Instead of this, can you not just pass the lockdep_is_held() expression as
> > > the last argument to list_for_each_entry_rcu() to silence the warning? Then
> > > it will be a simpler patch.
> > 
> > Come on, we do not silence warnings!
> 
> By silence, I mean remove a false-positive warning. In this case since lock
> is held, it is not a valid warning.
> 
> > If it's safely inside the lock then why not change it from 
> > hlist_for_each_entry_rcu() to hlist_for_each_entry()?
> > 
> > I do think that 'lockdep flag' inside hlist_for_each_entry_rcu():
> > 
> > /**
> >  * hlist_for_each_entry_rcu - iterate over rcu list of given type
> >  * @pos:        the type * to use as a loop cursor.
> >  * @head:       the head for your list.
> >  * @member:     the name of the hlist_node within the struct.
> >  * @cond:       optional lockdep expression if called from non-RCU protection.
> >  *
> >  * This list-traversal primitive may safely run concurrently with
> >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> >  * as long as the traversal is guarded by rcu_read_lock().
> >  */
> > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > 
> > is actively harmful. Why is it there?
> 
> Because as Paul also said, the code can be common between regular lock
> holders and RCU lock holders. I am not sure if this is the case with the
> kprobe code though.

Here are some more details on the kprobe side of things:

get_kprobe() can be called wither from preempt disabled section, or under
kprobe_mutex lock as evident from also the code comments on this function [1]

If called from a preempt disable section, then it is in an RCU reader section
and no warning will be emitted by use of hlist_for_each_entry_rcu(). This is
because hlist_for_each_entry_rcu() will internally check if preempt is
disabled.  However, if it is called under kprobe_mutex lock, then we have no
way of knowing in hlist_for_each_entry_rcu() if lock was held. So we must
pass the lockdep expression (which tests if lock is held) to the macro so
that the false-positive warning is silenced.

thanks,

 - Joel

[1]
/*
 * This routine is called either:
 *      - under the kprobe_mutex - during kprobe_[un]register()
 *                              OR
 *      - with preemption disabled - from arch/xxx/kernel/kprobes.c
 */
struct kprobe *get_kprobe(void *addr)

