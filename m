Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8E0C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96CB206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564637402;
	bh=FqipvXd82HolAbu3Pa+FA938ekh3l6I5gKhcjjB/BwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BjhVeYKYUjtFby9LwcIJWkvQTN41hipNBaJZe8o/B7RqolPW2mObNJaaas0KkalE4
	 2+6+Acnjwvt+bpPRGw/49YYDAUOk1GCTKV/KJCcqA97/q3yst9996/vdwiX3CBW6Nb
	 bu71WDbZpYTc/+MxXv0/jqVRlTvo0Su7zOgu5t+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfHAFaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfHAF37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:29:59 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B195E21773
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 05:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564637399;
        bh=FqipvXd82HolAbu3Pa+FA938ekh3l6I5gKhcjjB/BwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=10OoK6vV447j7lOnfoghBTaufVjOqdgbCIFwLQaUN2QDnhCNq/Hbc9PYANALBN0q2
         yoEiJcEFLenNizt4CoWmhalqyJwE4bbbaNjgrLi1xipY0J7hffyxhOEvB/CdP/Dpt8
         KnAtTT/dyaVe7HTpDu8tYrbptimUiHl/HPl3cr9Q=
Received: by mail-wm1-f48.google.com with SMTP id w9so2749049wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:29:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVpw25Lg6biHt4D0LEEVeYgneg9KRyF5BL5YEjE7N3EVItbxr2O
        QIMzfj+TLDJR+NIZLM+V7PfAka4CsluGQmgkpVYHMA==
X-Google-Smtp-Source: APXvYqwqyyhl/YzClxHO3xu5wRMyrUtVRl6n7dkFS6nFyiKVwQJibI/OsNXt3XS6gOCqjj8j69Enu8cxseortGZ/E50=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr52974634wme.173.1564637397150;
 Wed, 31 Jul 2019 22:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-2-dima@arista.com>
In-Reply-To: <20190729215758.28405-2-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:29:45 -0700
X-Gmail-Original-Message-ID: <CALCETrWHEcaG9gZe6ACt5H1H+P8D0RobrJ_bf4Wf9ts40NMM9w@mail.gmail.com>
Message-ID: <CALCETrWHEcaG9gZe6ACt5H1H+P8D0RobrJ_bf4Wf9ts40NMM9w@mail.gmail.com>
Subject: Re: [PATCHv5 01/37] ns: Introduce Time Namespace
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> From: Andrei Vagin <avagin@openvz.org>
>
> Time Namespace isolates clock values.

> +static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
> +{
> +       struct time_namespace *ns = to_time_ns(new);
> +
> +       if (!thread_group_empty(current))
> +               return -EINVAL;

You also need to check for other users of the mm.

> +
> +       if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> +           !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       get_time_ns(ns);
> +       get_time_ns(ns);
> +       put_time_ns(nsproxy->time_ns);
> +       put_time_ns(nsproxy->time_ns_for_children);
> +       nsproxy->time_ns = ns;
> +       nsproxy->time_ns_for_children = ns;
> +       ns->initialized = true;

I really really wish that setns() took an explicit flag for "change
now" or "change for children", since the semantics are different.  Oh
well.
