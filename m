Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D90CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2B2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoonVEZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfCZQRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:17:22 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34940 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfCZQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:17:21 -0400
Received: by mail-vs1-f68.google.com with SMTP id e1so7994959vsp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiPy2/xWT1s77HTXp6h8odZGoNhH4PVouVtFUK4dcD0=;
        b=YoonVEZvBLBVD3kYQ8iYjGsWsfvI67Zs5P9BSwS6f+wobaEP+2NDT0VDLqzqa45AGg
         iepyCp8wP1XAOqU+j+uuQb+5qmY090NiytHCBdTyQIr4igkS9fkfWjtsOUwbPdHu4iRy
         O51supj8Q29ITGLsvU6IuLtM6dtSYhkzIB9/dj56jpf6iKbvtBNHkWLUnKVoFLAhJ+iT
         Am0i2PLsMg+P95a53AqXffgZVHTo/l31sh0Xsizl1dNDyghLw+CZo6N0TcOKDWQ/mzHY
         khPz24bk6RGDHvLFTeXPl0SrR8Mv8NKbR9hQI+oBZRR4K4ufo+u2lVnRHhB1W82XlDyw
         rArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiPy2/xWT1s77HTXp6h8odZGoNhH4PVouVtFUK4dcD0=;
        b=W3fZxRPDM5SrSMOrOpRlPg6Lp9Usvi43wqCApNmzuDuOFZJYk6zlsE8m3uc7SwNe5g
         +8GbeR/WbSk6ORzcuFeAcfMP7JPIEebIB82jvuMGKgAT9PEd9Klr5DyzCPVEusHK6cy9
         AsrH8brAC660x60pUo0akFvpVrbO89EHlLbnDcjVLmZJbJh42+xuyATKChFFeB0Ya44t
         810gZ7E4/FMN50Cvzlt1e8YRD5VQiLa5145IrOiXD3oJ3yi5w2VMOAxSsyRASVucMlql
         kr1XFLztnvRZuiIYvEbIes+aMgHCj05IQF0i3zOCiPNNcZV1dv9uW/NXSLRoyYz59WXu
         MXKw==
X-Gm-Message-State: APjAAAX4DUeIWBpgNLYt4tCdFnGWAkupHfqMH/TTlw7I6+ge/68t7E71
        FCRXf9lQOB9Q6ftXsk74FhmvWT0qpDZRB9oFI0HELA==
X-Google-Smtp-Source: APXvYqwR4k4VKwqTjs6Is51eOvrYPu3yfmvndm6Bh8FAUhQw1JThm0dPrY+/DKb1q2+5mfqvzjE2xjlQvGfU23IiX4w=
X-Received: by 2002:a05:6102:18d:: with SMTP id r13mr2810562vsq.171.1553617040333;
 Tue, 26 Mar 2019 09:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155513.26964-1-christian@brauner.io> <20190326155513.26964-3-christian@brauner.io>
In-Reply-To: <20190326155513.26964-3-christian@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 26 Mar 2019 09:17:07 -0700
Message-ID: <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.

On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
>
> The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> I quote Konstantins original patchset first that has already been acked and
> picked up by Eric before and whose functionality is preserved in this
> syscall:

We still haven't had a much-needed conversation about splitting this
system call into smaller logical operations. It's important that we
address this point before this patch is merged and becomes permanent
kernel ABI.
