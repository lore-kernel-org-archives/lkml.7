Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6723BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3410621A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583754;
	bh=lBGShbgNAZafb6HAUnA0jtUAhP+E3fOW1pt9o5HZi4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kBH+HQTH3wxLNQKcmDnyH3AotgKfvjYo5lEo3dJKoF8FBsJhgZ0FQ5iU/EtYBo2zC
	 fydGScr1nuxNXo8FwJmZPZOjC2+V0gdWrrlG52/L91a5HtLKdGr0HGneVfLJ10GsOn
	 nzQXeItsVQd5jk748LedkazFhAnCXOsLaYtLM07E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKLSfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfKLSfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:35:52 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A76222C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583752;
        bh=lBGShbgNAZafb6HAUnA0jtUAhP+E3fOW1pt9o5HZi4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D+U0uTPgZixxLYpqk44oFE5xr3PXwirkjnss7APMo045Di05C3MSSXL372J7nxnNt
         XeqSTGvisRolumTWJEHaFL3Ga6KHCX/wktSVB450Z2xl/SOUFWewVvO9fhWn4d099s
         hJeFo59UbOoZe5of72eArqrG+3LfTPtbmFfIiUiA=
Received: by mail-wm1-f45.google.com with SMTP id j18so2990441wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:35:51 -0800 (PST)
X-Gm-Message-State: APjAAAVZI3z4e052vSBBGXOMEnUj3zOmMuG27ZYm++x9ZI1cgeuwHbus
        SuvY9bYukdvDOT5WPMCX9Ve66u8+ZCfk2fdzfqkFSg==
X-Google-Smtp-Source: APXvYqyCGdwwa81Y/7SY4vBpb0VNeghITCIZRnYoLK6IyYBhpKx8dimaSbr542g28X3IkqUqxfj7R8KgxqLDLmSVemI=
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr5397655wmd.76.1573583750471;
 Tue, 12 Nov 2019 10:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.881699933@linutronix.de>
In-Reply-To: <20191111223052.881699933@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 10:35:39 -0800
X-Gmail-Original-Message-ID: <CALCETrUsSF=KnjaFouDeh2DobU2o583dJOUTqVFmRcU1gFLT5A@mail.gmail.com>
Message-ID: <CALCETrUsSF=KnjaFouDeh2DobU2o583dJOUTqVFmRcU1gFLT5A@mail.gmail.com>
Subject: Re: [patch V2 14/16] x86/iopl: Restrict iopl() permission scope
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The access to the full I/O port range can be also provided by the TSS I/O
> bitmap, but that would require to copy 8k of data on scheduling in the
> task. As shown with the sched out optimization TSS.io_bitmap_base can be
> used to switch the incoming task to a preallocated I/O bitmap which has all
> bits zero, i.e. allows access to all I/O ports.
>
> Implementing this allows to provide an iopl() emulation mode which restricts
> the IOPL level 3 permissions to I/O port access but removes the STI/CLI
> permission which is coming with the hardware IOPL mechansim.
>
> Provide a config option to switch IOPL to emulation mode, make it the
> default and while at it also provide an option to disable IOPL completely.

Acked-by: Andy Lutomirski <luto@kernel.org>
