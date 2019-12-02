Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A682BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7934A206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="k5OBlfOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLBVTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:19:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44260 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLBVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:19:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id d199so369450pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BDFi2KtUfHoxYhQyKwF8j1ECcKUBGo4/hE4QVcfZiuY=;
        b=k5OBlfOUiouOhGL4KZyw41pLaH30PzkB5d3ZDqtGV/Ol3dKliwN57h0InITL0WL2vX
         Ss72U23D08CWmhSmsy1She1V1pEOZy2IVux+qSo1YzkuqPk88MpxiAZbVyHawT8fqQWi
         pcmXULt3qf+94Pauot0hTlG85A4cOlnm+Fscg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDFi2KtUfHoxYhQyKwF8j1ECcKUBGo4/hE4QVcfZiuY=;
        b=gFzI/F5mwtjhGsjmhCE1BTi46PsqqhIBtZHq5EUesrM8PRrk6SJeRS780njigoz0D6
         fSwVtYMskV0aP3URNCj2BHEM9g8L3CStka8yV0KT5qiGkWRL2k2ovADd8dWMcKf8YifP
         4nlMw1LU6RJvJr6V57a/BNE66hhiiEN0WBvcFqQ457+V1yUQEdD3dnrPMJkfKlgbQ6CF
         Sv8IihvWKcwrXYS+WhcPdjydLxGox2FfxHGa0n6Lva+eYrsdULS+ntB9JAzAfBrwRNfR
         xxbC4OaGDZZyi3ZPyDqZJmzkKbrfXwXs9TXQtZnrp6UdA1XSbyACTk/D24dPH0VUEUvw
         epuA==
X-Gm-Message-State: APjAAAWkuEovH2yKtPs2H4iLntDIcqsT/fOm8HAjppz7Q2hkfz53ZyQS
        rwXiCXftbpNP3OoUqsglJKPjzA==
X-Google-Smtp-Source: APXvYqxSoc2SCTWEE4t/98ajNaXkB89lCMxgkBxngI0eYX8ZLLrTxHxWP3ZysSCHCSy6mvVMxbj+MQ==
X-Received: by 2002:a62:5807:: with SMTP id m7mr743978pfb.180.1575321558967;
        Mon, 02 Dec 2019 13:19:18 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a26sm398874pff.155.2019.12.02.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 13:19:16 -0800 (PST)
Date:   Mon, 2 Dec 2019 16:19:15 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, rostedt@kernel.org
Subject: Re: [PATCH v3] kernel: audit.c: Add __rcu annotation to RCU pointer
Message-ID: <20191202211915.GF17234@google.com>
References: <20191201183347.18122-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201183347.18122-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good idea to CC the following on RCU patches:
Paul McKenney
Steven Rostedt
(Any others on the RCU maintainers list).
And, the list: rcu@vger.kernel.org

Could anyone Ack the patch? Looks safe and straight forward.

On Mon, Dec 02, 2019 at 12:03:48AM +0530, Amol Grover wrote:
> Add __rcu annotation to RCU-protected global pointer auditd_conn.
> 
> auditd_conn is an RCU-protected global pointer,i.e., accessed
> via RCU methods rcu_dereference() and rcu_assign_pointer(),
> hence it must be annotated with __rcu for sparse to report
> warnings/errors correctly.
> 
> Fix multiple instances of the sparse error:
> error: incompatible types in comparison expression
> (different address spaces)
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
> v3:
> - update changelog to be more descriptive
> 
> v2:
> - fix erroneous RCU pointer initialization
>  
>  kernel/audit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index da8dc0db5bd3..ff7cfc61f53d 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -102,12 +102,13 @@ struct audit_net {
>   * This struct is RCU protected; you must either hold the RCU lock for reading
>   * or the associated spinlock for writing.
>   */
> -static struct auditd_connection {
> +struct auditd_connection {
>  	struct pid *pid;
>  	u32 portid;
>  	struct net *net;
>  	struct rcu_head rcu;
> -} *auditd_conn = NULL;
> +};
> +static struct auditd_connection __rcu *auditd_conn;
>  static DEFINE_SPINLOCK(auditd_conn_lock);
>  
>  /* If audit_rate_limit is non-zero, limit the rate of sending audit records
> -- 
> 2.24.0
> 
