Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D71C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E4120838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="awumovmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfL0Bf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:35:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32993 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0Bf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:35:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so24090477edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 17:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2hkxx6EdZesk3LyhW8Bjdi5OF7N5XgZx/OPo6iWL4k=;
        b=awumovmJVECZ0Nk/zD/7/Ex5YMktKw7NhFajPm4bgFTiF2ETfkapjS8VlX3uLqpIRv
         6JofoXtruG/OJh5ZP2aFM8aE1WMGWcpoQpgjKTLp/hJjiPjkBlvWQnp7nh8qDj+Uuo+X
         qMEtfHNJZv98S6kmQcWJMShyoywEiEEU28hTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2hkxx6EdZesk3LyhW8Bjdi5OF7N5XgZx/OPo6iWL4k=;
        b=LKC+1rQ3xtmz8/+c0xdJ30baxn0CWfAOid9JFUxvItkCOI7IUWlQylXYSVElgnQEZQ
         dBrEBQOOkFnkt+VNwaKtavyKqs1ofy6S22Li+9gv5MDueb7ByV5nbffHkC5Nq6AYcUGe
         dz3zxb3bF4oaICOJgGL5UsKxuc71rLiyUSPhVEUcetFuBzP6bdFUrEGXHJ2kn6Z7c5l6
         BZHciL0Kdr6VvdHwcvywc9zFqxApQIyhuws8pVBEN2MlT4DtdZuDY7HIylTfQsrOaU52
         u+bO+LZP443+oMvJarbKa9tE9PWj791D6ZLKI6NXtnHEpnwA+JElZKcMG5j/eQDmU1WR
         2V+Q==
X-Gm-Message-State: APjAAAWlZNH5YJpDQXA2zD1ZmVQ7szrKMgPUu/r5kRIQIrw7VNvbWViO
        DkalvSJIHOwbqYegz0Q2NQJHl/fJeUJ2OxIWHJKTHQ==
X-Google-Smtp-Source: APXvYqziVcuWKxoTC5z2LyoMJWVCIQfGh0OJGrspzG1O5SgJ6+Lq/NGsxHbojw3SUweZkNqEh948ArUOFWHF6ZSqFe8=
X-Received: by 2002:aa7:d714:: with SMTP id t20mr53554307edq.93.1577410526273;
 Thu, 26 Dec 2019 17:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20191226180334.GA29409@ircssh-2.c.rugged-nimbus-611.internal> <201912270545.TQnRs9kG%lkp@intel.com>
In-Reply-To: <201912270545.TQnRs9kG%lkp@intel.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 26 Dec 2019 20:35:00 -0500
Message-ID: <CAMp4zn94deUbkXBrnX=Omw9-FmoZDANApqYUVsaV+VsXCX4Q-w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] pid: Introduce pidfd_getfd syscall
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 5:20 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Sargun,
>
> Thank you for the patch! Yet something to improve:
>
> All errors (new ones prefixed by >>):
>
>    arch/alpha/kernel/systbls.o: In function `sys_call_table':
> >> (.data+0x1120): undefined reference to `sys_pidfd'
This is a small typo. I'll fix this in the next respin.


>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
