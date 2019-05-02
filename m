Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F74C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852A320675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Q5+YixOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEBPN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:13:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44138 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfEBPN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:13:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so2420465edm.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ttmCfNHKGzwxlnjGzyfTPAX1HPNHfiu4VdFi4O4DyQ=;
        b=Q5+YixOwtcl+4zO8aokgXqzbO7ByEAkjAnbpMDQrK4aspKQdO1tAFLBz+ibAf4JtRP
         MtMrpJw5pe0RFpGVfEop3W90oWWUwX5I0wk5pFmvmyJhFT+I7y4tFJinNoDX7kJTsAlm
         fFqDhTB5HMnuI5k1jOoOv6rvphRB5LLIVVtaAk5LYH9W91mjFL1qq+AE/3j1kGPUh5WV
         0jm4iC+W0StEUWkM1MCPma0j7kQCAWnicl5ebOnigmHSo9cj6Ci/HuMdpbN6nZXZZGdI
         SiMtVGt2MPvc70vSMUouOo/mZ6CKZ8wcQ1cmBpm08QPkRsCmmRkYojOFbsGO5981F6Pc
         7zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ttmCfNHKGzwxlnjGzyfTPAX1HPNHfiu4VdFi4O4DyQ=;
        b=eO3kRvBsIN4KJq2Aufoqz3oKt1za9WBCX4nDC07nPwRKtVoJq4jlcDWgINCkfVF2ia
         13yVKd/t171mVVibiZZWRkk3BPohpMGcRYkfDVdZr0Cbz5/IqxiSC7/K9A7tXZ8CPWh9
         e81ILrz+UpsvN/t2uI30ViUowr2sFN86VV9pevCfFKm4uJfGKvgLt6XG/WzXgh7u+1Ui
         8RI8xCiLBenOj6KM+JuQTK31USuVW1NLV2su9XX+TnOgLrxVVFFL++PFGMPvAdcbkVlE
         XxoShsuK0s0n5sAlKKkCPVTPI5aQAC4HQ/SeDW9KipIxI0QMASkst+PP8sN8Sh+y+JeM
         11UA==
X-Gm-Message-State: APjAAAXoppyMK2D8BvpoD9TByEvM1vX57XUUB26znrzEAGwLPcyJaCUI
        dh4y2kfgUEq0fXFcj4bbzkBsJQ==
X-Google-Smtp-Source: APXvYqzbZnPxesYqJUHH3LTOVolsqPtEh2mVGBACgK9pOLdw3TSBtApNqX1UDZ0UjivMgf6LtqPiAg==
X-Received: by 2002:a50:a3dc:: with SMTP id t28mr2892874edb.256.1556810003605;
        Thu, 02 May 2019 08:13:23 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id o47sm65156edc.37.2019.05.02.08.13.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 08:13:22 -0700 (PDT)
Date:   Thu, 2 May 2019 17:13:21 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2 1/2] Add polling support to pidfd
Message-ID: <20190502151320.cvc6uc3b4bmww23k@brauner.io>
References: <20190430162154.61314-1-joel@joelfernandes.org>
 <20190501151312.GA30235@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501151312.GA30235@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 05:13:12PM +0200, Oleg Nesterov wrote:
> On 04/30, Joel Fernandes (Google) wrote:
> >
> > +static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
> > +{
> > +	struct task_struct *task;
> > +	struct pid *pid = file->private_data;
> > +	int poll_flags = 0;
> > +
> > +	poll_wait(file, &pid->wait_pidfd, pts);
> > +
> > +	rcu_read_lock();
> > +	task = pid_task(pid, PIDTYPE_PID);
> > +	WARN_ON_ONCE(task && !thread_group_leader(task));
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Ah, this is not right, we can race with de_thread() which changes the leader,
> in particular it does leader->exit_signal = -1 to indicate that this thread is
> no longer a group leader, but pid_task() can return the old leader.
> 
> We are going to check thread_group_empty() below, it won't be true in this case,
> so this race should not make any harm.
> 
> Just remove this WARN_ON(). We can't use has_group_leader_pid(), it can return
> false if pid_task() returns the new leader.
> 
> Otherwise I see no problems.

I'll remove the WARN_ON() check when applying this. Can I get your
Acked/Review, Oleg?

Christian
