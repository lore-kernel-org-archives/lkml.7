Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A8CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3A8208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSjQyz1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK2RcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:32:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726909AbfK2RcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575048742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lu1iN71LokIjGtjpqlGVpx9UlOqCL6Wwu7KcbuyxTxI=;
        b=CSjQyz1vUprYkf3yZ0DAXnqetQqzvpxJB4Ge6QQrPLg+pSZb87NQxfPVqBay0OweO8t17q
        68acDyPYJhGyB2liSDQD2ranoj5mp1kV7rYjsOYG998gnMATkbPwMkqQSR90Llrm0mvMrM
        QV+ldLzWCACnA9nd0wPjKEMYcqov2u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-jnDybVVFNViIOLXnnOZleA-1; Fri, 29 Nov 2019 12:32:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511391005502;
        Fri, 29 Nov 2019 17:32:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id A26F610013A1;
        Fri, 29 Nov 2019 17:32:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 29 Nov 2019 18:32:19 +0100 (CET)
Date:   Fri, 29 Nov 2019 18:32:13 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix
 get_nr_restart_syscall()
Message-ID: <20191129173213.GB3992@redhat.com>
References: <CAHk-=whA1h-7MKGdzyViwJR4_rqYKMP91FwuObWneBZE0yH81A@mail.gmail.com>
 <EB7AF2AE-6CA3-4395-AA37-BF92EE308A42@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <EB7AF2AE-6CA3-4395-AA37-BF92EE308A42@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jnDybVVFNViIOLXnnOZleA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Andy Lutomirski wrote:
>
> I think this doesn=E2=80=99t work for x32.

Why? get_nr_restart_syscall() can still rely on the "orig_ax & __X32_SYSCAL=
L_BIT"
check, debugger should restore regs->orig_ax correctly.

> Let=E2=80=99s either save the result of syscall_get_arch()

We can save the result of syscall_get_arch(), but it doesn't distinguish
x32/x86_64 tasks, so it doesn't really differ from TS_COMPAT.

> or just actually calculate and save the restart_syscall nr here.

sure, we we can do this.

> Before we commit to this, Kees, do you think we can manage to just renumb=
er
> restart_syscall()?  That=E2=80=99s a much better solution if we can pull =
it off.

Agreed.

Oleg.

