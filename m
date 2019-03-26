Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF38DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBEB206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WAdfCSi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfCZQbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:31:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40861 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbfCZQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:31:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so11332117edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KCnacKrc8DFlLRcPU7Ki/x6yPvPH4stxBokp6jHB87I=;
        b=WAdfCSi7Z4am1r0dJAr7cAl5FLgFwRjXhX+3WR07yfRNXBXd7bJHeQe88mlwGncbG5
         NSDhZIIPcaWgQr1auVMPeWfJOc4hF2BbJeBIuFOLc/q05DprgpFg/9PJs2QGMvldxUNG
         pj/eJE2UafShwf6zoQcfhHhbokZ6xIa9oi+YlT1CqNU8J7dtCfDtC26r2LufEpl/PsA7
         DFfJArN+sBkfIxiUyD6N2Lo1aAd9RiFsxMQmi1KSaaq1lJfnIa9UmIhA0czzH5hC7kSU
         MFFx70ZF0G2KtfRxu5fEje78SXKPcbokoLjRLkgHg44lnx16hJlt/XjUNR1zdN9RMRaD
         zcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCnacKrc8DFlLRcPU7Ki/x6yPvPH4stxBokp6jHB87I=;
        b=t9TgpjA0/A4hspsKQ/U63wSu/ZgBqaVK87ePE2PoUWEfqAwo+GovlVAGFMHep1kwrD
         jTwineM0eMw1DbcHOUA41f/3DAe6XVcv4Bzs7D5m7wjSjK3ok4UviI/vxR9UiefBibMd
         EnPSYL57Eelor2BooDsQM+4GhSKYH5w5owoJ1yaK49dqY4QN5+HINkZ2nIvhzmh42O88
         bS5AMB1HXYM+Ls0uQPTygZvEAvUeSdrh5SR22PmxiZRydlXReLq1aKmPgqGUhlNi/N84
         wRraFJ0BTvs13RmcCfHb2C0rl9Y+Tmx8BKQ76KSguynrjMxeVJqm+OTg2vekNZ8EHDLS
         fD+A==
X-Gm-Message-State: APjAAAWJ7ipbQ0r92HEqUwJmrnuSgFbPEzulJb4E3m0AjDS3bxu5D4I1
        PDpGxfztR+K3dc33KE5kCTJ0Gw==
X-Google-Smtp-Source: APXvYqxiUMrsRejY4do88gs7Nlilwir7nvQ6viDBqxHZuHZtuXQmKwqLKxDUhtCB/LgsLBdXJ43l+w==
X-Received: by 2002:a17:906:3482:: with SMTP id g2mr18064953ejb.214.1553617906280;
        Tue, 26 Mar 2019 09:31:46 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id d23sm1663882eja.42.2019.03.26.09.31.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 09:31:45 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:31:43 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
Message-ID: <20190326163142.4eh5qpgiqvygf26w@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326162337.o256x7hiodu2qfyg@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > Thanks for the patch.
> > 
> > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > I quote Konstantins original patchset first that has already been acked and
> > > picked up by Eric before and whose functionality is preserved in this
> > > syscall:
> > 
> > We still haven't had a much-needed conversation about splitting this
> > system call into smaller logical operations. It's important that we
> > address this point before this patch is merged and becomes permanent
> > kernel ABI.
> 
> I don't particularly mind splitting this into an additional syscall like
> e.g.  pidfd_open() but then we have - and yes, I know you'll say
> syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> about this rn is that it connects both apis in a single syscall
> and allows pidfd retrieval across pid namespaces. So I guess we'll see
> what other people think.

There's something to be said for

pidfd_open(pid_t pid, int pidfd, unsigned int flags);

/* get pidfd */
int pidfd = pidfd_open(1234, -1, 0);

/* convert to procfd */
int procfd = pidfd_open(-1, 4, 0);

/* convert to pidfd */
int pidfd = pidfd_open(4, -1, 0);
