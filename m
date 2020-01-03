Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87396C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68594222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgACI4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:56:42 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:41362 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgACI4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:56:42 -0500
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 65FB8C61AF3;
        Fri,  3 Jan 2020 08:56:36 +0000 (UTC)
Date:   Fri, 3 Jan 2020 09:56:34 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     J Freyensee <why2jjj.linux@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 07/10] proc: flush task dcache entries from all procfs
 instances
Message-ID: <20200103085634.6xkgb4aonivjhfnq@comp-core-i7-2640m-0182e6>
Mail-Followup-To: J Freyensee <why2jjj.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
 <20191225125151.1950142-8-gladkov.alexey@gmail.com>
 <8d85ba43-0759-358e-137d-246107bac747@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d85ba43-0759-358e-137d-246107bac747@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 02:03:29PM -0800, J Freyensee wrote:
> > +#ifdef CONFIG_PROC_FS
> > +static inline void pidns_proc_lock(struct pid_namespace *pid_ns)
> > +{
> > +	down_write(&pid_ns->rw_proc_mounts);
> > +}
> > +
> > +static inline void pidns_proc_unlock(struct pid_namespace *pid_ns)
> > +{
> > +	up_write(&pid_ns->rw_proc_mounts);
> > +}
> > +
> > +static inline void pidns_proc_lock_shared(struct pid_namespace *pid_ns)
> > +{
> > +	down_read(&pid_ns->rw_proc_mounts);
> > +}
> > +
> > +static inline void pidns_proc_unlock_shared(struct pid_namespace *pid_ns)
> > +{
> > +	up_read(&pid_ns->rw_proc_mounts);
> > +}
> > +#else /* !CONFIG_PROC_FS */
> > +
> Apologies for my newbie question. I couldn't help but notice all these
> function calls are assuming that the parameter struct pid_namespace *pid_ns
> will never be NULL.  Is that a good assumption?

These inline helpers are introduced to improve readability. They only make
sense inside procfs. I don't think that defensive programming is useful
here.

-- 
Rgrds, legion

