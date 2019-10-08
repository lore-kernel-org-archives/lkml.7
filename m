Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A16C35280
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1698121871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCEpS9kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfJHQf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:35:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45050 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:35:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so14545568otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZeF9+x7oA1LkT60KPu6aRKTIGksyJ9mdpR8n367HKI=;
        b=jCEpS9kZZoxfVWjoZh+93nUsTUTlU358yVr8bpGo3tSg7PHOrbIkUuF6i4hwfUtpSg
         o7+43jzDmAIjU5KF78mIrOGAE6WVYVblEsABdznS7UHciO5aF9oxXCE3GXpgMIKCsgWO
         Nu0JSU95/DwEb1RIN4vgAupU7Af0eycfAW5vRFe8zHcUwnLPvFjShPoJ/HVNqs38c9iu
         jM0CrtMBuJwIDv86gU+LEquR+Pj+ZxZUcS9klCO6VbfEqQTEJ3qFv9t1JzrWuYms4w+B
         aibsOHRD3JvWJwJo+IsbO3iM3vIYG500Nh59c5rA3jIOsFFJi9bXHh14AeU4Ved+jNGz
         XaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZeF9+x7oA1LkT60KPu6aRKTIGksyJ9mdpR8n367HKI=;
        b=KuMzaG0WxK3lDc8WanjpwM8b8RFvt5+MmbrahNVwQjDNSYy7D2W6KOnPnm3k7Ix4e5
         9ckvQGIYU2ElSfLpVSJZCcXhewgg4dZhHv5ETzD8oj64vXDbEeKwu1STr+c3reXxt6kY
         pkprSsZYK1tNtGcN/Z7fClg1KOW28lR4joXWqBRvnMQ/OCPFocXXKS+96Z6JBrKWpITy
         4RqrsG6UlVqZVc1oddzJZTDPAeW0zop6UELDFaLTrdeFrX4JkXuCY1PLW9Ln+n+E6Hw8
         JCQ+XYoq9gvn5IpYnFFd5i2AAKbudUQAXZyV8S8o6Fmb+CfWOVFLusgx0pnEWdOZYxoY
         Ad+Q==
X-Gm-Message-State: APjAAAXsXEiLM4eVo2/o8U/6HGPpPSQu5Mwo0dIf4DSblNMufrR/2Fk5
        pDrUs0EWCEy/jOcV5d1IUFA8Im9TKPLpsVCevFF2so+TmjFfsA==
X-Google-Smtp-Source: APXvYqwpq1gGDDxcpdjmaiFHe46d7qsdzIN6UKWO6eyD2QJpl40suKR9yK4izkhTqpq7ovBYpEtSqYkPcxDlstqMVKA=
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr26631718oto.23.1570552556380;
 Tue, 08 Oct 2019 09:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191008050145.4041702-1-boqun.feng@gmail.com> <20191008163028.GA136151@google.com>
In-Reply-To: <20191008163028.GA136151@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Oct 2019 18:35:45 +0200
Message-ID: <CANpmjNP0Vt4i7nWXPd2g4vaqkE3J2K1M_BiEMrtGqVcRE8khtw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Avoid to modify mask_ofl_ipi in sync_rcu_exp_select_node_cpus()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 18:30, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Oct 08, 2019 at 01:01:40PM +0800, Boqun Feng wrote:
> > "mask_ofl_ipi" is used for iterate CPUs which IPIs are needed to send
> > to, however in the IPI sending loop, "mask_ofl_ipi" along with another
> > variable "mask_ofl_test" might also get modified to record which CPU's
> > quiesent state can be reported by sync_rcu_exp_select_node_cpus(). Two
> > variables seems to be redundant for such a propose, so this patch clean
> > things a little by solely using "mask_ofl_test" for recording and
> > "mask_ofl_ipi" for iteration. This would improve the readibility of the
> > IPI sending loop in sync_rcu_exp_select_node_cpus().
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> thanks,
>
>  - Joel

Acked-by: Marco Elver <elver@google.com>

If this is the official patch for the fix to the KCSAN reported
data-race, it'd be great to include the tag:
Reported-by: syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com
so the bot knows this was fixed.

Thanks!
-- Marco

> >  kernel/rcu/tree_exp.h | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 69c5aa64fcfd..212470018752 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> >               }
> >               ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> >               put_cpu();
> > -             if (!ret) {
> > -                     mask_ofl_ipi &= ~mask;
> > +             /* The CPU responses the IPI, and will report QS itself */
> > +             if (!ret)
> >                       continue;
> > -             }
> > +
> >               /* Failed, raced with CPU hotplug operation. */
> >               raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >               if ((rnp->qsmaskinitnext & mask) &&
> > @@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> >                       schedule_timeout_uninterruptible(1);
> >                       goto retry_ipi;
> >               }
> > -             /* CPU really is offline, so we can ignore it. */
> > -             if (!(rnp->expmask & mask))
> > -                     mask_ofl_ipi &= ~mask;
> > +             /* CPU really is offline, and we need its QS to pass GP. */
> > +             if (rnp->expmask & mask)
> > +                     mask_ofl_test |= mask;
> >               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >       }
> >       /* Report quiescent states for those that went offline. */
> > -     mask_ofl_test |= mask_ofl_ipi;
> >       if (mask_ofl_test)
> >               rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> >  }
> > --
> > 2.23.0
> >
