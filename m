Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787CFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F112073F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIViTYeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfK0F3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:29:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfK0F3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:29:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so10208869pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 21:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGK+ULtfQAwtVprH1HVEYd0b3Bl+iwzMbxZKRpXwyhA=;
        b=VIViTYeh7HxV+i9Gir8odWMfV02isZz3zK3o0eY3y1n+WyM4ki8jABXSBq7KmtssLG
         y8c1Mh18pvZL3nOWiYIqxtKB6yoErwjuxT6yjMLok690nnZivrm8AxV40bZ3N2OT1JVe
         1F0XIi+yXdfiRcMKnQ0W6D5a05Dxa0lHj1AQxmPk9QwmM0cBVwfvlZZ5GUKsN8GBLoLl
         oOU6kcYsx3LJF+Ahy+8BOXjYhCXLz6LyMgtpzCefYEu/239pheqI9zEkxIsK4IT4eYXu
         LE9lgMHATwpOu0RA7V6xtTT2/mUIf9+knrSDxaUiXYV5oD7YF2ZHbGrHzeJDLDyLfT9d
         ZSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGK+ULtfQAwtVprH1HVEYd0b3Bl+iwzMbxZKRpXwyhA=;
        b=GJlNYNiluZWs9Q2HyPj1GsfZd4JOL2A46gITuB6Dkq7IfwXbVi3pgvtx6ujmykMPDU
         ooZT8RxFpNEDJVzleA3RaFzzbw5a1SI5jhj+LSOTp04ihDOTrh09ZTA2V3jSOF53WpqS
         KDwfJPpREgmGuCH/yaVVWJFQ1gFh8SVihHgyDr7qDGDdEtVjEbZ4+goJ8S35FZoGwhk9
         IPYooQNL0vgqQKev4ZKRVdd5Czuhw9dbn3pRQOpmFSmfg533QATWnhe1IOtrooX5RZBi
         IKmDOIyGnWQq4zVxiAXeBIizH+fRbQdS0JZN7wqh4mcaRupRhoSZFLMtRUStslVHnbxR
         fm2A==
X-Gm-Message-State: APjAAAUiWZp/+t6eDiUrORGDuf0Y7UK26MMNCXnv7VBsGkxZjfLaY/Bm
        LYD0IgtEITp2ZIvMow13Fgo=
X-Google-Smtp-Source: APXvYqzxw222HkDIvEgoVoeHtvUCNMvqOSbBGEu3aSnUiacJfErpDJTINHnrg4lFk5kWawSMOii5PA==
X-Received: by 2002:a63:204e:: with SMTP id r14mr2830105pgm.101.1574832543122;
        Tue, 26 Nov 2019 21:29:03 -0800 (PST)
Received: from workstation-portable ([139.5.253.146])
        by smtp.gmail.com with ESMTPSA id m5sm4801910pjl.30.2019.11.26.21.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:29:02 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:58:27 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20191127052827.GA9782@workstation-portable>
References: <20191126172723.GA12759@workstation-kernel-dev>
 <20191127022925.GB157739@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127022925.GB157739@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:29:25PM -0500, Joel Fernandes wrote:
> On Tue, Nov 26, 2019 at 10:57:23PM +0530, Amol Grover wrote:
> > add __rcu notation to RCU protected global pointer auditd_conn
> > 
> > Fixes multiple instances of sparse error:
> > error: incompatible types in comparison expression
> > (different address spaces)
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> >  kernel/audit.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index da8dc0db5bd3..30e7fc9b8da2 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -102,12 +102,14 @@ struct audit_net {
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
> > +RCU_INIT_POINTER(auditd_conn);
> 
> Looks like this causes a build error. Always please build test your patches
> in the very least. And I also did not understand how RCU_INIT_POINTER can
> even be used outside of a function. In C, executable code cannot be outside
> functions.
> 
> Is doing the following not sufficient to fix the sparse issue?
> 
> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 49b6049b26ac..c5d4b5a2dea1 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -108,8 +108,8 @@ struct auditd_connection {
>  	struct net *net;
>  	struct rcu_head rcu;
>  };
> -static struct auditd_connection __rcu *auditd_conn;
> -RCU_INIT_POINTER(auditd_conn);
> +static struct auditd_connection __rcu *auditd_conn = NULL;

I ran a quick checkpatch and it gave me this error:
ERROR: do not initialise statics to NULL

So in order to fix it I decided to INIT the pointer (and failed)

Should I consider this as a false positive?

Thanks
Amol

> +
>  static DEFINE_SPINLOCK(auditd_conn_lock);
>  
>  /* If audit_rate_limit is non-zero, limit the rate of sending audit records
