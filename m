Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE737C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A492184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GCsnbASr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfC2CfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:35:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43760 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfC2Ce7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:34:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so438264pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 19:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ad/kiIdPGWWMeEmCjMG6KosZyGtuE1TQZqZZmfMDVo=;
        b=GCsnbASrq/WKxKMm7HPkawag56fcHwAQkxBiWXrBH+f5NnrowlUfd5NrE86iUs5Mv9
         YQRelAf4dhomQOMm3Atvb88m3vDgY+d9xutyfBTyjeD4ktdUhQ3Qs54K/ioMsoiC8aH9
         LaOilKLnea4RICrqOoQiZ926CpFjapEL7qOOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ad/kiIdPGWWMeEmCjMG6KosZyGtuE1TQZqZZmfMDVo=;
        b=f6x3QmEs19kNckINPUy/RgngjHQMRKe/TwthCkYB74qA2ErfXrpofpH8ekyKgF5xRj
         7oT/kEltXg9S7rdxb8WhAne3DuqsJakvmHs5x8+jg8t002TKzs/rq9YXiz1GBhjPQZZe
         ZW63CKZNi/uAFJ740iz5R2namECJYXTZbVvAw09Iu0S0ydHFUkm6YN02RyvzEFENLuSa
         Awt03pmyCp/vkgpk9+e4AiwmbbgTv/CtSQ4c/lbHiuWUUYp6ojreDtKefYLrkEKLeAJj
         hTfqEMxXxmMv6cPKh1gK+UkVJuzWh9peDjErM0F+AVNrWndWHhPZHvYD9mCyGDnbXe5f
         LHCg==
X-Gm-Message-State: APjAAAXsfQuJK7YoBkBWHCptDM8YK8rZ8vHg9eymB4kWtY3F8cXSckrd
        UclaNGaidkWEULj8VQ6RE0cR5g==
X-Google-Smtp-Source: APXvYqxXkgoEYutgt7QftOoF5JWQNw8/LC0q+L812dmEt7yJAM3Oly0ZkdebXGDMAjtuJMCpZT0mQw==
X-Received: by 2002:a63:4b14:: with SMTP id y20mr3192535pga.15.1553826898810;
        Thu, 28 Mar 2019 19:34:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g67sm674749pfg.94.2019.03.28.19.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 19:34:57 -0700 (PDT)
Date:   Thu, 28 Mar 2019 22:34:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
Message-ID: <20190329023456.GB194158@google.com>
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
 <20190328023432.GA93275@google.com>
 <20190328142619.GA19441@redhat.com>
 <20190328143958.GB261521@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328143958.GB261521@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:39:58AM -0400, Joel Fernandes wrote:
> On Thu, Mar 28, 2019 at 03:26:19PM +0100, Oleg Nesterov wrote:
> > On 03/27, Joel Fernandes wrote:
> > >
> > > Also, based on Kees comment, I think it appears to me that get_pid and
> > > put_pid can race in this way in the original code right?
> > >
> > > get_pid			put_pid
> > >
> > > 			atomic_dec_and_test returns 1
> > > atomic_inc
> > > 			kfree
> > >
> > > deref pid /* boom */
> > > -------------------------------------------------
> > >
> > > I think get_pid needs to call atomic_inc_not_zero()
> > 
> > No.
> > 
> > get_pid() should only be used if you already have a reference or you do
> > something like
> > 
> > 	rcu_read_lock();
> > 	pid = find_vpid();
> > 	get_pid();
> > 	rcu_read_lock();
> > 
> > in this case we rely on call_rcu(delayed_put_pid) which drops the initial
> > reference.
> > 
> > If put_pid() sees pid->count == 1, then a) nobody else has a reference and
> > b) nobody else can find this pid on rcu-protected lists, so it is safe to
> > free it.
> 
> I agree. Check my reply to Jann, I already replied to him about this. thanks!
> 

Also Oleg, why not just call refcount_dec_and_test like below? If count is 1,
then it will decrement to 0 and return true anyway. Is this because we want
to avoid writes at the cost of more reads? Did I miss something? Thank you.

I don't remember very clearly, but I think Kees also asked about the same thing.

diff --git a/kernel/pid.c b/kernel/pid.c
index 2095c7da644d..89c4849fab5d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -106,8 +106,7 @@ void put_pid(struct pid *pid)
 		return;
 
 	ns = pid->numbers[pid->level].ns;
-	if ((refcount_read(&pid->count) == 1) ||
-	     refcount_dec_and_test(&pid->count)) {
+	if (refcount_dec_and_test(&pid->count)) {
 		kmem_cache_free(ns->pid_cachep, pid);
 		put_pid_ns(ns);
 	}
