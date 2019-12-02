Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEC5C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A67206E1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DlQBanX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLBXee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:34:34 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46174 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:34:34 -0500
Received: by mail-pj1-f66.google.com with SMTP id z21so548464pjq.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z3rcMZkJZGj62FT1K1YiTzywyH6333nfY23ubK0gAps=;
        b=DlQBanX7XJUT9sN8nElYX0zHDgV759OWftBOocBhB1kN7kPYUUl/oD2UVC8y2Dk0sz
         h9Hn455e9FjDObkfMID44wWUG7qhj6n70RPn2JgNrgS39TQ01A/IfJ6v36jTRdVwRFdq
         vWn/SzPcaUP88D0FOc9ujYpHcYcn1tXqrbIOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z3rcMZkJZGj62FT1K1YiTzywyH6333nfY23ubK0gAps=;
        b=d+MxrqwCAtgjQtpR/suVEJqKQc46RlshUIRm0hVqBHu1Xdi4DVQc7I9LWy8UxIJR0X
         HeB2pD9eY3epvC2m84OGDMzZxeYwul/n9IAfKeJ0M4gmEW8FbiM0i/MwysL4M7rsGBA4
         8WP8/oTkH5oU15KvqX3/ThYQPE3US/6cnSzYOIhgc7kqAnN4TdP//5ueamicKlvxw1ec
         SwF/3H1JR24rAf7gB/MJfedlbxegWhI0TSY0L75r4czDG00MKyAlsz88duo6OtjVKpuZ
         Eb0vaKPWYxTSWoVltj1uiyxwmB/Z77sSRJw+WEjd1a0QQlNzheCvQRWRhbX4ZtzrCGyB
         yMMA==
X-Gm-Message-State: APjAAAX0vh6bLx81FlnjxVVPCmPgOngh0XZrFTIHi2y8Iyf7aCzvCAU5
        Bdk1a18RY0VzygfJFMhi2IhLUTFCe7E=
X-Google-Smtp-Source: APXvYqxez88BfsSLdu0FphGWimROK+AQJM1Q600m7NCFYfCJF83uF/DiHX9wb+ydfYGeHCbWMkiGHQ==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr1882143plf.213.1575329673560;
        Mon, 02 Dec 2019 15:34:33 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f13sm617154pfa.57.2019.12.02.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:34:32 -0800 (PST)
Date:   Mon, 2 Dec 2019 18:34:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Amol Grover <frextrite@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, rostedt@kernel.org
Subject: Re: [PATCH v3] kernel: audit.c: Add __rcu annotation to RCU pointer
Message-ID: <20191202233431.GM17234@google.com>
References: <20191201183347.18122-1-frextrite@gmail.com>
 <20191202211915.GF17234@google.com>
 <20191202172639.1c9ad544@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202172639.1c9ad544@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 05:26:39PM -0500, Steven Rostedt wrote:
> On Mon, 2 Dec 2019 16:19:15 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Good idea to CC the following on RCU patches:
> > Paul McKenney
> > Steven Rostedt
> 
> I'm fine with this if it doesn't cause any rcu splats with sparse. Not
> sure if use cases of RCU requires RCU maintainers Cc'd. Although we can
> usually keep people from misusing it ;-)

Yes true :) Thanks for taking a look.

 - Joel

> 
> -- Steve
> 
> 
> > (Any others on the RCU maintainers list).
> > And, the list: rcu@vger.kernel.org
> > 
> > Could anyone Ack the patch? Looks safe and straight forward.
> > 
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
> > >  	struct pid *pid;
> > >  	u32 portid;
> > >  	struct net *net;
> > >  	struct rcu_head rcu;
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
