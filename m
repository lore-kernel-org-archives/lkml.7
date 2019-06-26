Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F09C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3277620665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gbrS0w+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:50:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38115 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZVuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:50:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so3038pgz.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYzcb55D5fDYZJpA77KyVzeZrChGfiSNXIH61s2NG04=;
        b=gbrS0w+rlg9zyEZINMY3HjVDCPGhz5MyqmTAjBg1Fbugu3dqmjIQmqAfYG67PejOX2
         f2eL+rJpn1hkPmMBhkUEOKPTjTDtGNyeCGt/4bNEXxS9n+NzQIoiEQ2gMhkVBzmvfbTe
         /gP3nGAQ4miAQjejoxT0d8OD9VmeEPBmMwSFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYzcb55D5fDYZJpA77KyVzeZrChGfiSNXIH61s2NG04=;
        b=dCVjsfYu98G25IIKp+tYAMNcVkojeVOpm/nzb89qjRSiaxFxbmw4/1yyU2U9ZO1BrH
         svFWtB2NBnouJU7E3YgdiSy7uA7w/uHR8iDjA/YeVuCDeVPzXhJLIflJCjRD91riuqCq
         BtZMdbnlASjE2M+uBiv8WrFZ3RjTUEyw/1ms2+YxY+sytq7aDMQRkcB1Fqxjg9AqeRDG
         UnWGDBB5Z4yWKYAPX2FAWAzhLcrgB75XSMpTxAeGEKN9tkeRrQSBlFGG0jiXpNONAiwC
         M3lxEWSiyNrCJxEPCqsLyw7sdi+/Lx1NHv4IIKBF/l8Uy/8SzFXBay7QdjoOY2pRwsyQ
         qz+Q==
X-Gm-Message-State: APjAAAV7oGfRnux8a5+bViJLFYIXc8oa2c3hgXw+X2g6f8F/2uyC8M48
        wN8qOsubhynfH339aUv33lRHjg==
X-Google-Smtp-Source: APXvYqwfVAlFOB7s26jDV4AEoNGYTdz5In80RYc7g1IcpNe5bC/viaardLvXIqTJ6QQz/BYMRk/U6g==
X-Received: by 2002:a17:90a:b011:: with SMTP id x17mr1540506pjq.113.1561585843661;
        Wed, 26 Jun 2019 14:50:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e20sm217557pfi.35.2019.06.26.14.50.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:50:42 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:50:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH RFC v2] Convert struct pid count to refcount_t
Message-ID: <20190626215041.GA234202@google.com>
References: <20190624184534.209896-1-joel@joelfernandes.org>
 <20190624185214.GA211230@google.com>
 <CAG48ez3maGsRbN3qr8YVb6ZCw0FDq-7GqqiTiA4yEa1mebkubw@mail.gmail.com>
 <20190625073407.GP3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625073407.GP3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:34:07AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2019 at 09:10:15PM +0200, Jann Horn wrote:
> > That part of the documentation only talks about cases where you have a
> > control dependency on the return value of the refcount operation. But
> > refcount_inc() does not return a value, so this isn't relevant for
> > refcount_inc().
> > 
> > Also, AFAIU, the control dependency mentioned in the documentation has
> > to exist *in the caller* - it's just pointing out that if you write
> > code like the following, you have a control dependency between the
> > refcount operation and the write:
> > 
> >     if (refcount_inc_not_zero(&obj->refcount)) {
> >       WRITE_ONCE(obj->x, y);
> >     }
> > 
> > For more information on the details of this stuff, try reading the
> > section "CONTROL DEPENDENCIES" of Documentation/memory-barriers.txt.
> 
> IIRC the argument went as follows:
> 
>  - if you use refcount_inc(), you've already got a stable object and
>    have ACQUIRED it otherwise, typically through locking.
> 
>  - if you use refcount_inc_not_zero(), you have a semi stable object
>    (RCU), but you still need to ensure any changes to the object happen
>    after acquiring a reference, and this is where the control dependency
>    comes in as Jann already explained.
> 
> Specifically, it would be bad to allow STOREs to happen before we know
> the refcount isn't 0, as that would be a UaF.
> 
> Also see the comment in lib/refcount.c.
> 

Thanks a lot for the explanations and the pointers to the comment in
lib/refcount.c . It makes it really clearly.

Also, does this patch look good to you? If so and if ok with you, could you
Ack it? The patch is not really "RFC" but I still tagged it as such since I
wanted to have this discussion.

Thanks!

- Joel

