Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F308FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B162070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hRuf95R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLBXfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:35:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37012 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:35:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so761468plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NqtaB9MKOQhSliHwumWMYNqfR+eF1LGGZAxjF3ljDPg=;
        b=hRuf95R5Q6W5esJSAoe7/lzgpx0Qx+VAvNE1tzQ0cBJ4fEhgxAIRCF1FrGjy7QIa39
         BqZ7RMIsqyVEki1+/pZIUo3SXoEWrgnGK4poCpb1GtfT1a1AtuQWRBwlBemwyCB3eS9x
         6A46kaANsw1PWgvxCCt3gUZeNPfJkb0t7JDrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NqtaB9MKOQhSliHwumWMYNqfR+eF1LGGZAxjF3ljDPg=;
        b=Syp+K3j/1stRUJc12FqOSZgCNkDMpfimwYoZatiRAuRmsdLJp3PKGtX2iW7bMKlXc4
         r1KbzxFeAZR8dGZOAeapUPmZoX7N5k+X7lrRw09vmj4E2srBOqN0b3rwL4ownzjJR8PV
         zumD1YUq+L8yUlB81G2aTDUNGaFSW6ANh8l6i3rlUz9QNiU2e4eussP8g2/bKwnIhYju
         DQ8qYSzmM8iKj3nT1xJkn1XxCvEVwlCzQRhO3EYchaQaz0Xt5pq02InsCp1Kq+yJ59CH
         Fz5o1PGI+6BlspPIOQp+YJAaU0Q05pAGCe27Yr6DBt99V+G7+GiKQMk1+H6pbL5GeqzZ
         kvpw==
X-Gm-Message-State: APjAAAX5jtrzMNJDlQ1ggdncJEgxpzAelxRzM0dDXAYqP+DQPS5PCNw2
        MVVkbxeF2O9uxQVS/wcbCcHuAA==
X-Google-Smtp-Source: APXvYqwi12259yJbqYXkvJ9Obbu0PA3rzoi2KUWw1tLwRCP44TS0LXGWkJD+SD/WZ0yQglnk8HAcNA==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr1790521plr.191.1575329700251;
        Mon, 02 Dec 2019 15:35:00 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h9sm596572pfo.139.2019.12.02.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:34:59 -0800 (PST)
Date:   Mon, 2 Dec 2019 18:34:58 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Amol Grover <frextrite@gmail.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, rostedt@kernel.org
Subject: Re: [PATCH v3] kernel: audit.c: Add __rcu annotation to RCU pointer
Message-ID: <20191202233458.GN17234@google.com>
References: <20191201183347.18122-1-frextrite@gmail.com>
 <20191202211915.GF17234@google.com>
 <CAHC9VhTTS43aKQojtoBRRipP7TwhaVnK7DAqpFN0J0_FNLY+sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTTS43aKQojtoBRRipP7TwhaVnK7DAqpFN0J0_FNLY+sw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 06:24:29PM -0500, Paul Moore wrote:
> On Mon, Dec 2, 2019 at 4:19 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > Good idea to CC the following on RCU patches:
> > Paul McKenney
> > Steven Rostedt
> > (Any others on the RCU maintainers list).
> > And, the list: rcu@vger.kernel.org
> >
> > Could anyone Ack the patch? Looks safe and straight forward.
> 
> FWIW, this looks reasonable to me, but I don't see this as a critical
> fix that needs to go in during the merge window.  Unless I see any
> objections, I'll plan on merging this into audit/next once the merge
> window closes.

Sounds good, thanks!

 - Joel


> > On Mon, Dec 02, 2019 at 12:03:48AM +0530, Amol Grover wrote:
> > > Add __rcu annotation to RCU-protected global pointer auditd_conn.
> > >
> > > auditd_conn is an RCU-protected global pointer,i.e., accessed
> > > via RCU methods rcu_dereference() and rcu_assign_pointer(),
> > > hence it must be annotated with __rcu for sparse to report
> > > warnings/errors correctly.
> > >
> > > Fix multiple instances of the sparse error:
> > > error: incompatible types in comparison expression
> > > (different address spaces)
> > >
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > ---
> > > v3:
> > > - update changelog to be more descriptive
> > >
> > > v2:
> > > - fix erroneous RCU pointer initialization
> > >
> > >  kernel/audit.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index da8dc0db5bd3..ff7cfc61f53d 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -102,12 +102,13 @@ struct audit_net {
> > >   * This struct is RCU protected; you must either hold the RCU lock for reading
> > >   * or the associated spinlock for writing.
> > >   */
> > > -static struct auditd_connection {
> > > +struct auditd_connection {
> > >       struct pid *pid;
> > >       u32 portid;
> > >       struct net *net;
> > >       struct rcu_head rcu;
> > > -} *auditd_conn = NULL;
> > > +};
> > > +static struct auditd_connection __rcu *auditd_conn;
> > >  static DEFINE_SPINLOCK(auditd_conn_lock);
> > >
> > >  /* If audit_rate_limit is non-zero, limit the rate of sending audit records
> > > --
> > > 2.24.0
> > >
> 
> 
> 
> --
> paul moore
> www.paul-moore.com
