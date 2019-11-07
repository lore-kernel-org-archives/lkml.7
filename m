Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5CB2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG5ZE3xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKGTY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:24:26 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:35170 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfKGTYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:24:25 -0500
Received: by mail-io1-f44.google.com with SMTP id x21so3603528iol.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1Fne7fVseXN7JpRhlsyrXM5qJoZrsw0VJvMW6KPvZ0=;
        b=OG5ZE3xDyaGK6p52nR8NCMZrSvPRGz4vrjoa65OE7EJ6LCZHun+e0rnpQ4BmxeMKpx
         JPFQ9IlnZORfl2zhct+nyhnZLiPNGL07lVjGupf/BwcP11vuecq+jmeAnKTjKMaU61Ur
         d02f64SO2aj9A9JFUNWJTSOCQX5kMxLY+Y9WaL3Jf47jP2pJN4oIssmN5mJtW2ZWS7CH
         V9ZDUc/xpFTWHwTWiZ6+1MFn8KVN1B6fjEwB8eyhcAk3JOIUB68R/94g5zd14kRm7XCC
         Fk7CHN8myc/PhmObGmHbaRNkBP9zlw5yePN8Wys4rHTbGZBiXDP+sFV8h3tg+nyjSzG0
         fT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1Fne7fVseXN7JpRhlsyrXM5qJoZrsw0VJvMW6KPvZ0=;
        b=MayEdssWDjYzEJif/k4XStBaOclsOL6cZcHZnXKqooqtdposJD9D4ZNQ7nZG/NrrBd
         v33LhlHxsxzt+qZhzQ+lfl3+86poVVSpgbfQhI+6phN5P88jjDQrdMIJUo4hDOx+C3Wx
         34OqlY7nXsQuxJ+7uhPQqKr0/cVUAt5SGirl0iWDg/SRFqLpjyXndqxHRDWBEW7Bq5SQ
         XAoFF/RISo+DGFSjuc0FN6bAYqAnHDo3vauuNLxdXR4Pjun9LtfLlAOfAXvttIkuuGLx
         OrrDHZiqmMGOI61FA9PROBezVMyfiYEkBCdYQHi3g+hECeWoBph2XGXTFd1xHhNtThKy
         PW7g==
X-Gm-Message-State: APjAAAWvS2PrIpmmDHE9W59ccFS/CIlm+pAj+e8AP7OAEm+TEmWsvaoj
        oIkK+H5TvuNsy+bDSmUhjYDHGnczrq7Oc032kA==
X-Google-Smtp-Source: APXvYqxP/ObKEXjO2NiMAVKju6Feed0mbAQPLbEhhGEODNFg8EWp+oRdbkWUoAmYPVfxAiqd9LrEe751/mjP+WHAKnc=
X-Received: by 2002:a5d:8450:: with SMTP id w16mr4981251ior.11.1573154664973;
 Thu, 07 Nov 2019 11:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de>
In-Reply-To: <20191106202806.241007755@linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 7 Nov 2019 14:24:12 -0500
Message-ID: <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 4:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Sane ioperm() users only set the few bits in the I/O space which they need to
> access. But the update logic of the TSS I/O bitmap copies always from byte
> 0 to the last byte in the tasks bitmap which contains a zero permission bit.
>
> That means that for access only to port 65335 the full 8K bitmap has to be
> copied even if all the bytes in the TSS I/O bitmap are already filled with
> 0xff.
>
> Calculate both the position of the first zero bit and the last zero bit to
> limit the range which needs to be copied. This does not solve the problem
> when the previous tasked had only byte 0 cleared and the next one has only
> byte 65535 cleared, but trying to solve that would be too complex and
> heavyweight for the context switch path. As the ioperm() usage is very rare
> the case which is optimized is the single task/process which uses ioperm().

Here is a different idea:  We already map the TSS virtually in
cpu_entry_area.  Why not page-align the IO bitmap and remap it to the
task's bitmap on task switch?  That would avoid all copying on task
switch.

--
Brian Gerst
