Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F91FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BF72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CABYa7xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfCYT7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:59:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37205 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbfCYT7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:59:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so10489447wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VtwMp7N3+dPcWIGLIDHqlGDupoF1jb2q2KyRCg+HtNU=;
        b=CABYa7xMtEz3gLMGjJrX6udViaHyNAqlvtBGHY0Kf/BCUqc5ywxN5M0JiW3fS6YuiQ
         uRwcAsbqY8Z8pXIicsWa7K+UsR6p5nwhp8r0nTeTiUivfMhjNQarnEWzyQ/8uS0j6taf
         vDgI6TWsXK95EgjG5BhO0C6+dOfcDFVCSlBdXmfyXJRJV+rbJIEicVzHe73aOPYjpj+t
         G9IEocfXH+oqLEQrLOPQ2v8PBD7FRXPwtd2wFWtQWPp14OU0dkNzgTAD94irON8Gh36S
         T14CNSAjz5KGTjlU8lm6lVIloyU8aQZukvQRGL2Ub9+IDQavyxUhRTYO+DIF38hkQgH7
         Jl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VtwMp7N3+dPcWIGLIDHqlGDupoF1jb2q2KyRCg+HtNU=;
        b=otIgzBZ9SN7Dsrx35MLGDOFxB8dvi51tuCU+HV7sSK4E79u2kKWNzsEOy35o0IRc2J
         yvDo89U0GrZyhGwzq7TIUCoQ+kuNu7LwpDdyRN2bZ2g8n7OPAFzfDWbP66DDuh7lR0Wl
         dk6/ISElfPDTYTnBanLyEb5p+JuvXoKozapNHiKTmxChTAWB1V5U2ij6AVnyQIryiPo4
         qdHzXp18d9AR5ql0+fSu5ZgJUCEHN/qgXbqEUUdPO5IlExsO68wapaIZZeS/6587/csv
         c4CmJOgzETdl7AWkM+1JQT3rT1Uh7ftf5f3hnOuNanM9/uCcq2CNZh15iLCrGHNDEVVs
         OvEA==
X-Gm-Message-State: APjAAAXoB73jIvqj1PBSgj7VD76dFqMZqP5cB0XV5GpNF3ACAI+WyB3/
        pfh84LPhx/X2vw4Stw9bKFXjvg==
X-Google-Smtp-Source: APXvYqzQkldz2kkcT+IjVAgA99RsGI77JaWtCWFsAcLNtPwzVswOzfzDwCeB24xugAbkJ9AD45mJRg==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr503422wmc.32.1553543972713;
        Mon, 25 Mar 2019 12:59:32 -0700 (PDT)
Received: from brauner.io (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id e1sm25288382wrw.66.2019.03.25.12.59.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 12:59:32 -0700 (PDT)
Date:   Mon, 25 Mar 2019 20:59:30 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Cc:     "jannh@google.com" <jannh@google.com>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>,
        "luto@kernel.org" <luto@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "bl0pbl33p@gmail.com" <bl0pbl33p@gmail.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "nagarathnam.muthusamy@oracle.com" <nagarathnam.muthusamy@oracle.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "dancol@google.com" <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidctl()
Message-ID: <20190325195929.4ptq3lnm6bkvtvxx@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
 <20190325162052.28987-3-christian@brauner.io>
 <071b12db-f84e-8666-d70a-1b6cce71f9c0@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <071b12db-f84e-8666-d70a-1b6cce71f9c0@nextfour.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:20:54PM +0000, Mika Penttilä wrote:
> Hi!
> 
> 
> > +SYSCALL_DEFINE5(pidctl, unsigned int, cmd, pid_t, pid, int, source, int, target,
> > +		unsigned int, flags)
> > +{
> > +	struct pid_namespace *source_ns = NULL, *target_ns = NULL;
> > +	struct pid *struct_pid;
> > +	pid_t result;
> > +
> > +	switch (cmd) {
> > +	case PIDCMD_QUERY_PIDNS:
> > +		if (pid != 0)
> > +			return -EINVAL;
> > +		pid = 1;
> > +		/* fall through */
> > +	case PIDCMD_QUERY_PID:
> > +		if (flags != 0)
> > +			return -EINVAL;
> > +		break;
> > +	case PIDCMD_GET_PIDFD:
> > +		if (flags & ~PIDCTL_CLOEXEC)
> > +			return -EINVAL;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	source_ns = get_pid_ns_by_fd(source);
> > +	result = PTR_ERR(source_ns);
> > +	if (IS_ERR(source_ns))
> > +		goto err_source;
> > +
> > +	target_ns = get_pid_ns_by_fd(target);
> > +	result = PTR_ERR(target_ns);
> > +	if (IS_ERR(target_ns))
> > +		goto err_target;
> > +
> > +	if (cmd == PIDCMD_QUERY_PIDNS) {
> > +		result = pidns_related(source_ns, target_ns);
> > +	} else {
> > +		rcu_read_lock();
> > +		struct_pid = find_pid_ns(pid, source_ns);
> > +		result = struct_pid ? pid_nr_ns(struct_pid, target_ns) : -ESRCH;
> 
> Should you do get_pid(struct_pid) here to keep it alive till 
> pidfd_create_fd() ?

Yes, indeed. You and Jann both pointed this out! Thank you.

> 
> > +		rcu_read_unlock();
> > +
> > +		if (cmd == PIDCMD_GET_PIDFD) {
> > +			int cloexec = (flags & PIDCTL_CLOEXEC) ? O_CLOEXEC : 0;
> > +			if (result > 0)
> > +				result = pidfd_create_fd(struct_pid, cloexec);
> > +			else if (result == 0)
> > +				result = -ENOENT;
> > +		}
> > +	}
> > +
> > +	if (target)
> > +		put_pid_ns(target_ns);
> > +err_target:
> > +	if (source)
> > +		put_pid_ns(source_ns);
> > +err_source:
> > +	return result;
> > +}
> > +
> >  void __init pid_idr_init(void)
> >  {
> >  	/* Verify no one has done anything silly: */
> > diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> > index aa6e72fb7c08..1c863fb3d55a 100644
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -429,6 +429,31 @@ static struct ns_common *pidns_get_parent(struct ns_common *ns)
> >  	return &get_pid_ns(pid_ns)->ns;
> >  }
> >  
> > +/**
> > + * pidnscmp - Determine if @ancestor is ancestor of @descendant
> > + * @ancestor:   pidns suspected to be the ancestor of @descendant
> > + * @descendant: pidns suspected to be the descendant of @ancestor
> > + *
> > + * Returns -1 if @ancestor is not an ancestor of @descendant,
> > + * 0 if @ancestor is the same pidns as @descendant, 1 if @ancestor
> > + * is an ancestor of @descendant.
> > + */
> > +int pidnscmp(struct pid_namespace *ancestor, struct pid_namespace *descendant)
> > +{
> > +	if (ancestor == descendant)
> > +		return 0;
> > +
> > +	for (;;) {
> > +		if (!descendant)
> > +			return -1;
> > +		if (descendant == ancestor)
> > +			break;
> > +		descendant = descendant->parent;
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> >  static struct user_namespace *pidns_owner(struct ns_common *ns)
> >  {
> >  	return to_pid_ns(ns)->user_ns;
