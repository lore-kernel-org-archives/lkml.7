Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AAAC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D042087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfDTM0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:26:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfDTM0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:26:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E37270D6A;
        Sat, 20 Apr 2019 12:26:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA4955D71C;
        Sat, 20 Apr 2019 12:26:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 20 Apr 2019 14:26:21 +0200 (CEST)
Date:   Sat, 20 Apr 2019 14:26:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190420122614.GD17468@redhat.com>
References: <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com>
 <CAHrFyr6qqj-q9nSVuNhFL5WOcuQstAFvaDu2544OpeMe6jawQw@mail.gmail.com>
 <20190420115125.GC17468@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420115125.GC17468@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 20 Apr 2019 12:26:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Oleg Nesterov wrote:
>
> Note that we need
> thread_group_empty() only for the case when the task is traced,

Damn, sorry for noise... of course this is not true, I tried to say that
notification won't come otherwise. Nevermind, lets discuss this when we
have a patch. I already got lost in this thread and I have no idea what
are you all talking about ;)

Oleg.

