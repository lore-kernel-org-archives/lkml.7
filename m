Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2911C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAFC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DPO15W8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfC0WZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:25:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38407 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfC0WZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:25:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so15497410edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IIsRgaroL54/ziT7cI31qPHGAbRABa/nE2NtSsFTbsY=;
        b=DPO15W8AR+yzxsTg4xSG2u7OA64vTUz5DukNLlZ6RMr8V0Xr9vLROBYfKRvbW/Pi5o
         4TUJmrTQ5Ko6doDZjwNTPRP/cYrPkh9teBSq8VGiJKG9GhRvQx6IffUrmFy6/Kx7Zndp
         r4qSDFNSSSL1f0zDAiD3+iIs8iylZPMrDN7VwYe9mMtIBHlcECeWlsnei7dii7snYNn4
         BFVDz6e/g7gTVUBUVBuUMQ2l679I7MvF7jBw/FBl4306F/gGrONyYKGYxNs411h++CUw
         jRGi+GyOoa81NH51ZiYkF+W5PBRtwv65GCZp6eyb3Fh8ETC+3J0vG8TkzcDnDfBdLgdU
         +uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIsRgaroL54/ziT7cI31qPHGAbRABa/nE2NtSsFTbsY=;
        b=fPFpppBDoexqQp6rYu2lbSUC0Yksiz718YKvfNssdL2iMMuvbB+zaEIT0qDsXXJNOg
         MkiPVVAE3FHKTPpK0/Xmk/hv9waQlVPVH0pCVlTifJVC1brcjFR/ibt0uV6ysJZaft3j
         v5A+gS4QCmleLCgsgNAqVkt3+lZ3md+FqVKIbafi4Ljb8zxemxgZcMza7y8JQIHEw3/o
         kkxXnX0wjJl/TNj1ZSFWWbYV1Nx643EtyK3qFmXA2oBLaPtYb0seSxWDFHbQL5+Jmobz
         XiViExsd4LVVwOaUMx6efeysgNJbJSGaO4+CobE7UxQ7KDjcd8VLJX0csgJla75U809V
         AGAg==
X-Gm-Message-State: APjAAAXvyZJ9qfTh72cBzfqnCT5ttRKViYwiM8Zcqrpema93eyxGxf7i
        i+0ndmjCsEbfP/ax57YzDzPMOA==
X-Google-Smtp-Source: APXvYqwBQfBbld5on2v8FT8sj4P4/47IIKTfNTFxy14NlqSW/PPhM7rJSeA6rXGwV8vap6YlTCrEzA==
X-Received: by 2002:a17:906:2501:: with SMTP id i1mr21150951ejb.76.1553725546300;
        Wed, 27 Mar 2019 15:25:46 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id q3sm3881019edr.31.2019.03.27.15.25.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Mar 2019 15:25:45 -0700 (PDT)
Date:   Wed, 27 Mar 2019 23:25:44 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
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
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
Message-ID: <20190327222543.huugotqcew6jyytv@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
 <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
 <20190327213404.pv4wqtkjbufkx36u@brauner.io>
 <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> procfd_open(int procrootfd, int pidfd, unsigned int flags);
> pidfd_open(pid_t pid, int nsfd, unsigned int flags);

That honestly just feels like splitting openat into:
openat_dir()
and
opentat_file()
