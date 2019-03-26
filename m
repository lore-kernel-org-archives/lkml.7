Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A103C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2335D2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="aS3IM9hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfCZQXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:23:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37419 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfCZQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:23:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id v21so11317382edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/f3zwl1dB21rcdrfBXeBdunL5xhvMrWPAPDl495IyQI=;
        b=aS3IM9hR6/PivI8WcUGrqV+2AXvtLDzfx26v9VvUAaQh7z+g3/0Ju9bxwRW+Mjq/n9
         Owc1vnVFhgYD30vvS2cioyn/sx8pbNVHlxHCdl7oYG2Ffiayd/sqy0BztTY4M+WZvtxD
         LC7y7VygFw6K5930Mvm0lS071O4LwuB8UlguZ6EmTV5GUJUvI8k7ifJALza/jMSIfILO
         k62O1jXuNxVXcej2yyWc2pFDxpSRIoKSi1KERZXUV97DRRveQlNBpYvz8/sEpVBQDPGm
         99PL63xOfIN2jmCa4KwBrMSqCRTpnUKuNWzwM1NR5sceSRJkDX2nufo/D5yXZeTjJKAR
         ELVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/f3zwl1dB21rcdrfBXeBdunL5xhvMrWPAPDl495IyQI=;
        b=lvIhKZb9SkczK1zdAD/jl9bg25HorvGv+eNOa3VqNZl/ioQkYxpJemHIca1ydBz60M
         Nxi51k8lqw+eGie+6oRIUU15EZRsIP0ZORDfAnVAgP5JCpm9AKli/zBxKX1mdZ6Cxr9G
         kQa5QTvSQLT8K6vpR9pyvQqcAzhJh4oQjuw9gR12LDna90cxYcMpztkHZbT8udZuxwDx
         9TPE5QTi4fF3jcHIjK1UodnaT7KJqEE88/vFrCxqiX12Z5tBS7BqSUWqCIaMlMo16sX3
         mOTmHudy2i7Vs4WI+SKpRPSIpj51KKN7b60maUSngc8JPlkYf3KQSn6Ucm2RquB99G6r
         VrkQ==
X-Gm-Message-State: APjAAAW8d4yoKk7FtU4V5Mamu1/A6gyJuV9atB2Vwu/a5uSjKAeJlHf3
        p7Lwtbn7TNfSrg3XEDIAtwfa3Q==
X-Google-Smtp-Source: APXvYqyx3aTz7HpdPQOwOKdUfPPNiOcJaZOncwK1h1SCRKNH+V5LFVAVvVbWz7/wOKBasFQQr5Kcww==
X-Received: by 2002:a50:ec86:: with SMTP id e6mr2820130edr.204.1553617422089;
        Tue, 26 Mar 2019 09:23:42 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id t52sm1607446edd.54.2019.03.26.09.23.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 09:23:41 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:23:38 +0100
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
Message-ID: <20190326162337.o256x7hiodu2qfyg@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> Thanks for the patch.
> 
> On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > I quote Konstantins original patchset first that has already been acked and
> > picked up by Eric before and whose functionality is preserved in this
> > syscall:
> 
> We still haven't had a much-needed conversation about splitting this
> system call into smaller logical operations. It's important that we
> address this point before this patch is merged and becomes permanent
> kernel ABI.

I don't particularly mind splitting this into an additional syscall like
e.g.  pidfd_open() but then we have - and yes, I know you'll say
syscalls are cheap - translate_pid(), and pidfd_open(). What I like
about this rn is that it connects both apis in a single syscall
and allows pidfd retrieval across pid namespaces. So I guess we'll see
what other people think.
