Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08AC21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563823052;
	bh=sj/NapaJkv7odoswmmfqtEZQCYs7mpK3iyrXxfrff9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nJxj1WnRB6bDDxJlj57O55SwmpmDwhApmDf77XpfFQfElv8WpWro0Rjwy12LavmdG
	 bA85a8lJFQhcC7AIXdxBaN5RdurNVNpcG64A4hqyMdqjKDuywoBOb8OBBAbahGj0l+
	 iJ4ZjWmMUErqkmudzI3NHyvzvLgJAOHL40xT02No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfGVTRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfGVTRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:17:31 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5898C21955
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563823050;
        bh=sj/NapaJkv7odoswmmfqtEZQCYs7mpK3iyrXxfrff9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wDPM9sRsfT4Z3VAOL4IwXsXdy0yBnCeprDkV9C2Fvu/HFHhKafZkOkblS3nR65W/7
         wq9VQHTLUsx5RbtNfdFAq9Yox67mhPbxnnbLzhcNZ7T8lg0OJHlKMYq7lXQcqTh7wK
         1JhIUHB3BFwaRdJoExnULcR8fsZ9mJ7N4+TXJ8NQ=
Received: by mail-wm1-f43.google.com with SMTP id s15so15025077wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:17:30 -0700 (PDT)
X-Gm-Message-State: APjAAAVHz/6ngPnKrYenHIBGLVGAoNF1f86EWWvLY4c5BOfkL3tLllNO
        bT7fBAsvzCYKl64IL43n3SxHwwE4WMRmeWZraYB1sA==
X-Google-Smtp-Source: APXvYqycSv3esUwwzzu9uIVNs59R9FpJBEWDcpoDitlz2jTCYunKkwsVqjuw0DjotF0Z5sn1ZMnEnQhE2VsPAJujKH8=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr65360867wmk.79.1563823048881;
 Mon, 22 Jul 2019 12:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190719170343.GA13680@linux.intel.com> <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook>
In-Reply-To: <201907221135.2C2D262D8@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 22 Jul 2019 12:17:16 -0700
X-Gmail-Original-Message-ID: <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
Message-ID: <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:39 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 22, 2019 at 08:31:32PM +0200, Thomas Gleixner wrote:
> > On Mon, 22 Jul 2019, Kees Cook wrote:
> > > Just so I'm understanding: the vDSO change introduced code to make an
> > > actual syscall on i386, which for most seccomp filters would be rejected?
> >
> > No. The old x86 specific VDSO implementation had a fallback syscall as
> > well, i.e. clock_gettime(). On 32bit clock_gettime() uses the y2038
> > endangered timespec.
> >
> > So when the VDSO was made generic we changed the internal data structures
> > to be 2038 safe right away. As a consequence the fallback syscall is not
> > clock_gettime(), it's clock_gettime64(). which seems to surprise seccomp.
>
> Okay, it's didn't add a syscall, it just changed it. Results are the
> same: conservative filters suddenly start breaking due to the different
> call. (And now I see why Andy's alias suggestion would help...)
>
> I'm not sure which direction to do with this. It seems like an alias
> list is a large hammer for this case, and a "seccomp-bypass when calling
> from vDSO" solution seems too fragile?
>

I don't like the seccomp bypass at all.  If someone uses seccomp to
disallow all clock_gettime() variants, there shouldn't be a back door
to learn the time.

Here's the restart_syscall() logic that makes me want aliases: we have
different syscall numbers for restart_syscall() on 32-bit and 64-bit.
The logic to decide which one to use is dubious at best.  I'd like to
introduce a restart_syscall2() that is identical to restart_syscall()
except that it has the same number on both variants.

--Andy
