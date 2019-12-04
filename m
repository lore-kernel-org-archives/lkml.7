Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7481720684
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VGo9s+Lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLDEKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:10:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37916 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLDEKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:10:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id t3so2682249pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 20:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+NMKEGi5YQB3S16N7pcM/EgIV2YEwt1oQqjoU8N0kRQ=;
        b=VGo9s+Lu4iuswDFoMAS7KSlibO075l9zMxbudCtLyHl0P+hGLHKY64TJmasAbP1H4y
         9jdQ82MP2wAgg0Zz0DVxT+lfZZQPQxg/LxazED0RhZWELvAXb5o+9EG0iB0R6ovWLOBf
         CeLDvSnb/QrSz6Sad+epJRoOGThwtym4CJ7PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+NMKEGi5YQB3S16N7pcM/EgIV2YEwt1oQqjoU8N0kRQ=;
        b=h1a9cc7rbhoh33qB9dpAK9smRIh0qFT/+6mhi81vhZgiOYS/hOghY5HS5tus9j9GXw
         JAM/jK9JHGoP+/Xc3EUCDkU79dB3LLLjSXYei2+Trc0N6jM3yGdYSDzlb6Ivy+Adz/n1
         Wsr1LEYbOZRkWHBVJNBD9OxqG3ztABd3l9JFuCkIa+f4K6fTdnUGwwGmylV4j7zNFQ+i
         aNUOwilTHE6l94sDRtYeAaKGy3n0eKxH6+LEL3qI+3CySL6DiN+FmFqzFO/TFU2W0645
         eHohLbppVlwCItDlT2RFf+C9Tansw6EdCrdCkVhUKm30TAWrqHjhAiGt6EA6oeKXYEGd
         Nb7Q==
X-Gm-Message-State: APjAAAVBW9N+OoYlYERC85rX2mxLF5F1vya01qR9OFca6JYTlMJJHwQc
        /5dpXTsewedFJ3kKmwCvskYkOg==
X-Google-Smtp-Source: APXvYqz9UaGRn/w/Qscmpeb9sSZt6Xy26YPf0sIm4qFOtJyuprp9KdK8AhGcFGdZJ9IAPUPP/2XsxA==
X-Received: by 2002:aa7:9988:: with SMTP id k8mr1457694pfh.200.1575432601189;
        Tue, 03 Dec 2019 20:10:01 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e27sm5864856pfj.129.2019.12.03.20.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 20:10:00 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:09:59 -0500
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
Message-ID: <20191204040959.GB192877@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203071329.GC115767@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 08:13:29AM +0100, Ingo Molnar wrote:
> 
> * Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> > > Anders reported that the lockdep warns that suspicious
> > > RCU list usage in register_kprobe() (detected by
> > > CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> > > access kprobe_table[] by hlist_for_each_entry_rcu()
> > > without rcu_read_lock.
> > > 
> > > If we call get_kprobe() from the breakpoint handler context,
> > > it is run with preempt disabled, so this is not a problem.
> > > But in other cases, instead of rcu_read_lock(), we locks
> > > kprobe_mutex so that the kprobe_table[] is not updated.
> > > So, current code is safe, but still not good from the view
> > > point of RCU.
> > > 
> > > Let's lock the rcu_read_lock() around get_kprobe() and
> > > ensure kprobe_mutex is locked at those points.
> > > 
> > > Note that we can safely unlock rcu_read_lock() soon after
> > > accessing the list, because we are sure the found kprobe has
> > > never gone before unlocking kprobe_mutex. Unless locking
> > > kprobe_mutex, caller must hold rcu_read_lock() until it
> > > finished operations on that kprobe.
> > > 
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Instead of this, can you not just pass the lockdep_is_held() expression as
> > the last argument to list_for_each_entry_rcu() to silence the warning? Then
> > it will be a simpler patch.
> 
> Come on, we do not silence warnings!

By silence, I mean remove a false-positive warning. In this case since lock
is held, it is not a valid warning.

> If it's safely inside the lock then why not change it from 
> hlist_for_each_entry_rcu() to hlist_for_each_entry()?
> 
> I do think that 'lockdep flag' inside hlist_for_each_entry_rcu():
> 
> /**
>  * hlist_for_each_entry_rcu - iterate over rcu list of given type
>  * @pos:        the type * to use as a loop cursor.
>  * @head:       the head for your list.
>  * @member:     the name of the hlist_node within the struct.
>  * @cond:       optional lockdep expression if called from non-RCU protection.
>  *
>  * This list-traversal primitive may safely run concurrently with
>  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
>  * as long as the traversal is guarded by rcu_read_lock().
>  */
> #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> 
> is actively harmful. Why is it there?

Because as Paul also said, the code can be common between regular lock
holders and RCU lock holders. I am not sure if this is the case with the
kprobe code though.

thanks,

 - Joel

