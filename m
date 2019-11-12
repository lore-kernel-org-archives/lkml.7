Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE937C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0C32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573580811;
	bh=7Y8Hb3QZllI6DGGQGslRYUwNUM4fcKBfxcH5VJhUWAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iPhK2wLFGo117Zjvl1YCGF93319jWZF/Ju03hNuaQ6I8s5Jt7Cs4nFrPwm/ufAW9k
	 ZLnGdyW+iD17nHKfhTibi8QmzZa5RDRvSil2W0GtbFo9WoGdudUZn6gJUyVMBRZvgS
	 OhCEkEoftrx72ifs+GyFMyxlfxw8BbE0fnxG3D8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKLRqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:46:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37090 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:46:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id d5so9295311ljl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVlyaDqVxwcBwMijqGJIeUn+ME/2/nMneuPXBZL4Dwo=;
        b=TC7qyElI9ex5Gsf+EyLBqVArIVhMd8/nbB2bUkBv5N8dYs77rNUDuhTuoRjN1Tharh
         B2MgnTZyFb6DByKhXi6H3/8zziIAdpgCz8CiFFuj4lDh9AJTYwh7xYKO1DIQKjnEWS3m
         qc39uUviKgPOY7jbfSfmq44Cq1WWBgtVuO6Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVlyaDqVxwcBwMijqGJIeUn+ME/2/nMneuPXBZL4Dwo=;
        b=VTMd8tZu+7qL+hdlzuHifFA6ClclXbclhAEUag3IgDUpAvzlc8WClAyEt+YmsTSbtD
         BBeCCilTuEQ3AsRrPVdmf8xts0on8EphDhub6vM/12IGht+1sMQ9PWoPyEdaLOSG1PZ1
         t4Gjtiiy/+f7GFhiVUqt9gyjd5aKHEaN8TI9jesBW7oBFmrdBoY7+6Mik8MMVcqneL7S
         fJYqaVQUxyVmTqzcZjf+CKPQ38l26jxebk7ovIGfO4inEpB6q2JBFKjBO0pxUduAwYnd
         1hno9vj0qLqWhyEjbF3iaVyQEKfmigxCabUnvU0+8KlQorDCDW5CCHarpRUZn1dshjwL
         0h0A==
X-Gm-Message-State: APjAAAWIOtQV8beBS24hFlHJ0xRLmTSdixL2LUAwPX169+LY1+RRmCyh
        UUP5yLNl+ZYp6pSzHHAD68utW/uCuR4=
X-Google-Smtp-Source: APXvYqyc/5fkRHVXhHBRsYk9tbDZMENg7UIG5aMMyJUoqGGEMfOZ2DFU2n10HOr+EPJ+2dDlPLSHCA==
X-Received: by 2002:a05:651c:305:: with SMTP id a5mr21698618ljp.144.1573580807643;
        Tue, 12 Nov 2019 09:46:47 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x5sm9614344lfg.71.2019.11.12.09.46.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:46:46 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id y23so18768761ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:46:46 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr21267782ljp.133.1573580806381;
 Tue, 12 Nov 2019 09:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.400498664@linutronix.de>
 <CALCETrU1i4_N8M0o=8hxxPFYisLsxpmDqM-GTsymORp9UeZYSg@mail.gmail.com>
 <alpine.DEB.2.21.1911121811150.1833@nanos.tec.linutronix.de> <CALCETrWX7POruLpr27mVoZ-CtVjz35tJBaZz0FNy9_eXfZo_fg@mail.gmail.com>
In-Reply-To: <CALCETrWX7POruLpr27mVoZ-CtVjz35tJBaZz0FNy9_eXfZo_fg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 09:46:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPX0xdMGjmZw2yM=aeYArq4V=x=kD7Yr1guMHbaL+Ubg@mail.gmail.com>
Message-ID: <CAHk-=wiPX0xdMGjmZw2yM=aeYArq4V=x=kD7Yr1guMHbaL+Ubg@mail.gmail.com>
Subject: Re: [patch V2 09/16] x86/ioperm: Move TSS bitmap update to exit to
 user work
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 9:42 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Right.  But your diff tool *said* the diff was in
> exit_to_usermode_loop().  Can you look at your .gitconfig and see if
> you have something weird going on?

I think it's just that the pattern to find "start of new function" is
confused by the "__visible" or something.

Don't rely too much on the function names in the diff headers. They
can be confused by labels, or just by other things. I think it ends up
being "does the line start with alphabetic character" that is the
heuristic for "this is a function header".

           Linus
