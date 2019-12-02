Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA5C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255222070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AOzK5o8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLBXYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:24:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39213 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLBXYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:24:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id e10so1505016ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzQ+1A7+ETKD73tFjtgF7MkvN8fC39GSMBwN2Sm2LGs=;
        b=AOzK5o8hu+0IIvPKpWviWtgRkwf04TVyc5XvqhQbrMHvWzfWsQGqIE8DR+b6wesDP5
         TkI6FvODprL1Yl9ByZr37GnxnuEupSDssPFTacVSJ280XKDF8DR/S0qTm+aEBfcVeoQj
         urBvNDb/Iqyupc/P8NZdH2CM5I9OFH/H2JGHKi2DIZGh41vqA8Fl47rivdoldWZG+nSe
         rkYwSisb45DmbOhVfJem8UVM5/4A7Ypfgigo/dwhIjPbY64mEPmjQQXCdmiyAECBd2iu
         08cbvu+lzysPtRO1GyTRKQ8AJZK3m/xYzC/SHwNTI40VOagOpvTWqLSVyKaSiTOZMCFB
         LRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzQ+1A7+ETKD73tFjtgF7MkvN8fC39GSMBwN2Sm2LGs=;
        b=Ffsucgh/lJc9b0c99/emYRHJEcX3VTj7ypnlnriyxeHwkEIJrHLnW4aO7tlwLo7gbi
         IrQOsTukIEAX8mX9qnu07M3++dYOiPQEFruR7Mc8329qKYPAELUNcGSEYcmcnxRvBQ6b
         Xcgna19vxh2NPhl9ZQOZVcxRW8s0oZdJ2hBtZWxmKtFdQ2EOyQsR6v/I47wsaHzKaarm
         /Mtiz1EK4toUvR/ovP3XIXvmIOCk4E58IEf5uJbu8Xm/SUZpomqAaqCnJjCruTPYEoqD
         LNrrIYAgWyR/Dhdu6v8zQNNfLIvqdHpWhXFv5B4oVG3/cnsu4lo7JeGpH1R1Y7adoG0Q
         jvaQ==
X-Gm-Message-State: APjAAAX0lVzRXAXcWh3IAEElUMxopRM3mqr1wKfX+fUqJwv+rOQpuC5d
        tDsT6H62dpm87BU1LAtJhSwWysgxtdFfymwc7FmU
X-Google-Smtp-Source: APXvYqykUQo2KP90VW0MNxkrGcDGJ4i6AJcEymHsB4IKVcZLiqRu7unrYT+Jeupmhlc8Z/8+gCMxFOuX8RJXtya79Bc=
X-Received: by 2002:a2e:970e:: with SMTP id r14mr712772lji.57.1575329080094;
 Mon, 02 Dec 2019 15:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20191201183347.18122-1-frextrite@gmail.com> <20191202211915.GF17234@google.com>
In-Reply-To: <20191202211915.GF17234@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Dec 2019 18:24:29 -0500
Message-ID: <CAHC9VhTTS43aKQojtoBRRipP7TwhaVnK7DAqpFN0J0_FNLY+sw@mail.gmail.com>
Subject: Re: [PATCH v3] kernel: audit.c: Add __rcu annotation to RCU pointer
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, rostedt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 4:19 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> Good idea to CC the following on RCU patches:
> Paul McKenney
> Steven Rostedt
> (Any others on the RCU maintainers list).
> And, the list: rcu@vger.kernel.org
>
> Could anyone Ack the patch? Looks safe and straight forward.

FWIW, this looks reasonable to me, but I don't see this as a critical
fix that needs to go in during the merge window.  Unless I see any
objections, I'll plan on merging this into audit/next once the merge
window closes.

> On Mon, Dec 02, 2019 at 12:03:48AM +0530, Amol Grover wrote:
> > Add __rcu annotation to RCU-protected global pointer auditd_conn.
> >
> > auditd_conn is an RCU-protected global pointer,i.e., accessed
> > via RCU methods rcu_dereference() and rcu_assign_pointer(),
> > hence it must be annotated with __rcu for sparse to report
> > warnings/errors correctly.
> >
> > Fix multiple instances of the sparse error:
> > error: incompatible types in comparison expression
> > (different address spaces)
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> > v3:
> > - update changelog to be more descriptive
> >
> > v2:
> > - fix erroneous RCU pointer initialization
> >
> >  kernel/audit.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index da8dc0db5bd3..ff7cfc61f53d 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -102,12 +102,13 @@ struct audit_net {
> >   * This struct is RCU protected; you must either hold the RCU lock for reading
> >   * or the associated spinlock for writing.
> >   */
> > -static struct auditd_connection {
> > +struct auditd_connection {
> >       struct pid *pid;
> >       u32 portid;
> >       struct net *net;
> >       struct rcu_head rcu;
> > -} *auditd_conn = NULL;
> > +};
> > +static struct auditd_connection __rcu *auditd_conn;
> >  static DEFINE_SPINLOCK(auditd_conn_lock);
> >
> >  /* If audit_rate_limit is non-zero, limit the rate of sending audit records
> > --
> > 2.24.0
> >



--
paul moore
www.paul-moore.com
