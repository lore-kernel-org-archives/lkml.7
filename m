Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A02086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554091479;
	bh=7WoHb0wDjSSxBczd9iCtoGJuNOTKKsXWQT0ii7Ad5og=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=swKiOVPLzwHX38lzTZfVrF9sR2oGtv+sEeG2sblZpukP8gKbP76H06bVvV+yf+BJ+
	 EXXmjjPvjIlRU6XQYbZLw6pTIzmhLX3FnzRkpxH/iTdiLqdWRyqdtqbgx/WEx3jsPI
	 /btHqtib9joyxyf6EeiUigum6RipR4gtH65gjExw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfDAEEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbfDAEEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:04:37 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF9220896
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 04:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554091476;
        bh=7WoHb0wDjSSxBczd9iCtoGJuNOTKKsXWQT0ii7Ad5og=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v116QGx/09iF+eE7WwZpFUgYBrlCaSCRXJZvpv8JEvYKlcQPK+65o7N0byDs0wI01
         KxCCM2Qvh541WdPVz65j/C77AXdMQdoEAHJuSgp/f2I51WAbk/J5HXhCW9Xz0rOV0o
         YL4McgzC/ektX7UzmcQnjKXxRqZIZN8zjdT0ZOMU=
Received: by mail-wr1-f45.google.com with SMTP id t17so9927166wrw.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 21:04:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUN61J+RrYaUDvu5S2wBCOD+ctkGNquI2FgCQcuJafSRyiWld+7
        IS++Nva0VrDVFf4xBzrE9D+xuYK41y0d8mUOesmZyw==
X-Google-Smtp-Source: APXvYqwJTuGVmsbe07ke+4nk4heFxuSYxSSUcI8LjhI5wZrlsGw2qvu12tviyPm7tGcTAoR4TytSffOxZqtKE8UUSxE=
X-Received: by 2002:adf:f344:: with SMTP id e4mr37629178wrp.77.1554091475130;
 Sun, 31 Mar 2019 21:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190331214020.836098943@linutronix.de> <20190331215134.925961976@linutronix.de>
In-Reply-To: <20190331215134.925961976@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 Mar 2019 21:04:24 -0700
X-Gmail-Original-Message-ID: <CALCETrWoN4atfWxK1jg5D5FtarhfApJBcegvXYxTnpDjSt7NyA@mail.gmail.com>
Message-ID: <CALCETrWoN4atfWxK1jg5D5FtarhfApJBcegvXYxTnpDjSt7NyA@mail.gmail.com>
Subject: Re: [patch 02/14] x86/idt: Remove unused macro SISTG
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 3:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> d8ba61ba58c8 ("x86/entry/64: Don't use IST entry for #BP stack") removed
> the last user but left the macro around.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/idt.c |    4 ----
>  1 file changed, 4 deletions(-)
>
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -45,10 +45,6 @@ struct idt_data {
>  #define ISTG(_vector, _addr, _ist)                     \
>         G(_vector, _addr, _ist, GATE_INTERRUPT, DPL0, __KERNEL_CS)
>
> -/* System interrupt gate with interrupt stack */
> -#define SISTG(_vector, _addr, _ist)                    \
> -       G(_vector, _addr, _ist, GATE_INTERRUPT, DPL3, __KERNEL_CS)
> -
>  /* Task gate */
>  #define TSKG(_vector, _gdt)                            \
>         G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
>
>
