Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AD2C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB17206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577154595;
	bh=DSQS0uHBNC9Ui3z1SA4ieLxiBxYjVLA1pvOoujpbOvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Wwqc1PoHUdNcXCFXXkUNb/Gc09Vdm16S9wesyH+AU+Mh81fn1fwVr4mryFILB2O7c
	 kyOdT5Q9rD49jaEunW2GEo5KhRn7TMOPkx+9k2jMNy1pKOgaQgVYDWzPpaTLYnZz83
	 se2I5gOxfztUbJW7Zvr0OmYJHhM7yep+FUgMdrbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLXC3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfLXC3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:29:54 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770CE20882
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577154593;
        bh=DSQS0uHBNC9Ui3z1SA4ieLxiBxYjVLA1pvOoujpbOvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mBOamR3e8+z/oxuQ1j6arsjUSXZzjlhMM4HvwMIBzxIH0PnwI3vD0y6J79ccnKo8X
         DVK+NzbOAuvhO9t9AREqK8/n+jmOBhUq+hrD4x5Lzu4meIgw/Aq56f9vXJtZCiBv6N
         w94bwVmE4Fl4guBclpw34hSD8o5Dpk5G3lj9oiXU=
Received: by mail-wr1-f41.google.com with SMTP id g17so18621049wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 18:29:53 -0800 (PST)
X-Gm-Message-State: APjAAAVb2qYyMSD0/+JWvOYSqEz+14OBf4NC50d3t62riM7GZQGLYy5q
        gVOZ+VmGb+VTRVz0Rv6bWRske9v5j5qR44+W3VmH8w==
X-Google-Smtp-Source: APXvYqz5QXY27AstGyElWlUnUHM0Y/Cls6krR6JAY/F6G6Ra4+oArxsi2W6pHlVu1RWJHAU5CqdrqYSugVUavqgLJoc=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr34152116wrn.61.1577154591966;
 Mon, 23 Dec 2019 18:29:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577111363.git.christophe.leroy@c-s.fr> <d0f8dfb26c025d3e3eee1b5f610161ca19b942df.1577111367.git.christophe.leroy@c-s.fr>
In-Reply-To: <d0f8dfb26c025d3e3eee1b5f610161ca19b942df.1577111367.git.christophe.leroy@c-s.fr>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Dec 2019 18:29:39 -0800
X-Gmail-Original-Message-ID: <CALCETrWyek-xatdsUFbFvHzT+bps_bjtQoVq8MAFsS1rcZCtEA@mail.gmail.com>
Message-ID: <CALCETrWyek-xatdsUFbFvHzT+bps_bjtQoVq8MAFsS1rcZCtEA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/10] lib: vdso: inline do_hres()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> do_hres() is called from several places, so GCC doesn't inline
> it at first.
>
> do_hres() takes a struct __kernel_timespec * parameter for
> passing the result. In the 32 bits case, this parameter corresponds
> to a local var in the caller. In order to provide a pointer
> to this structure, the caller has to put it in its stack and
> do_hres() has to write the result in the stack. This is suboptimal,
> especially on RISC processor like powerpc.
>
> By making GCC inline the function, the struct __kernel_timespec
> remains a local var using registers, avoiding the need to write and
> read stack.
>
> The improvement is significant on powerpc.

I'm okay with it, mainly because I don't expect many workloads to have
more than one copy of the code hot at the same time.
