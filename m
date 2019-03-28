Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A661AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F49217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OoQhSR+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1OkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:40:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42688 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1OkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:40:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so11708616pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=su5hUDVGA5wTPt+GZUHCzxW06LCBzo43uhfJs0GTLis=;
        b=OoQhSR+iKkIWNr/jpeg6QvhAN51oCNMtZeMAz9aSGP40ppc0YnS4WUELW3lhUwjUeZ
         ndcoFzMd5GGap1GCgZ8SwCddCu2saRDJ6ok2+/ZGJHRNgpkliRHHJfgnZ+ahNvrjs5KW
         9WX+Vv5N3ASKe4fayeObXHa/jkv9B8JymoGL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=su5hUDVGA5wTPt+GZUHCzxW06LCBzo43uhfJs0GTLis=;
        b=lLOlNdwqY8bVY0BE/yIAprcnUMOQiYClduZkDza9fXGsBFCelZXzVUs47wBuRhNHCM
         1ducWsIRAMRaUnXGZDYWkY6tzlvIqCKSHl6dG1vHAHs8UMJlPS0sK/M/Jp4TntxXGFH9
         hhfPdUX1JqcPx5O+CFTqqW+oDCLkfq7GO8cAMVU0P8W+F4an3lpBERzjpWr0IjHekkn+
         vRFF5nUrkoa1C0529+CO/MpiqUgJ6Sym4HiGE6qzQJ4ELG52GBajLgVXhhSCXqBx8snj
         2cBfMAwK5zHbsINPKVu5qgBu/8yHVP/RVcJTrFg3+j9lCSKYm2MzNvF5trC/u+tb/AmB
         MMbw==
X-Gm-Message-State: APjAAAVwVO/upor/mnPzccbNTR2GfQ3nn4EH9Es5g52KjV+jLyikV1+D
        MHjAnihD9ftiBtbMjirc1CTxJA==
X-Google-Smtp-Source: APXvYqw3tQ+i3uL9g0NHp+mIBhnfkpkTFqdE9c/sRudDrMvFebnVAq1yOdlvIl0bYClQHeCZeKFm5Q==
X-Received: by 2002:a65:6383:: with SMTP id h3mr39458734pgv.11.1553784000843;
        Thu, 28 Mar 2019 07:40:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u13sm49809367pfa.169.2019.03.28.07.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 07:40:00 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:39:58 -0400
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
Message-ID: <20190328143958.GB261521@google.com>
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
 <20190328023432.GA93275@google.com>
 <20190328142619.GA19441@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328142619.GA19441@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:26:19PM +0100, Oleg Nesterov wrote:
> On 03/27, Joel Fernandes wrote:
> >
> > Also, based on Kees comment, I think it appears to me that get_pid and
> > put_pid can race in this way in the original code right?
> >
> > get_pid			put_pid
> >
> > 			atomic_dec_and_test returns 1
> > atomic_inc
> > 			kfree
> >
> > deref pid /* boom */
> > -------------------------------------------------
> >
> > I think get_pid needs to call atomic_inc_not_zero()
> 
> No.
> 
> get_pid() should only be used if you already have a reference or you do
> something like
> 
> 	rcu_read_lock();
> 	pid = find_vpid();
> 	get_pid();
> 	rcu_read_lock();
> 
> in this case we rely on call_rcu(delayed_put_pid) which drops the initial
> reference.
> 
> If put_pid() sees pid->count == 1, then a) nobody else has a reference and
> b) nobody else can find this pid on rcu-protected lists, so it is safe to
> free it.

I agree. Check my reply to Jann, I already replied to him about this. thanks!

