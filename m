Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA17EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8453520865
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLBW0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:26:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A1A2073C;
        Mon,  2 Dec 2019 22:26:41 +0000 (UTC)
Date:   Mon, 2 Dec 2019 17:26:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, rostedt@kernel.org
Subject: Re: [PATCH v3] kernel: audit.c: Add __rcu annotation to RCU pointer
Message-ID: <20191202172639.1c9ad544@gandalf.local.home>
In-Reply-To: <20191202211915.GF17234@google.com>
References: <20191201183347.18122-1-frextrite@gmail.com>
        <20191202211915.GF17234@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 16:19:15 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> Good idea to CC the following on RCU patches:
> Paul McKenney
> Steven Rostedt

I'm fine with this if it doesn't cause any rcu splats with sparse. Not
sure if use cases of RCU requires RCU maintainers Cc'd. Although we can
usually keep people from misusing it ;-)

-- Steve


> (Any others on the RCU maintainers list).
> And, the list: rcu@vger.kernel.org
> 
> Could anyone Ack the patch? Looks safe and straight forward.
> 
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
> >  	struct pid *pid;
> >  	u32 portid;
> >  	struct net *net;
> >  	struct rcu_head rcu;
> > -} *auditd_conn = NULL;
> > +};
> > +static struct auditd_connection __rcu *auditd_conn;
> >  static DEFINE_SPINLOCK(auditd_conn_lock);
> >  
> >  /* If audit_rate_limit is non-zero, limit the rate of sending audit records
> > -- 
> > 2.24.0
> >   

