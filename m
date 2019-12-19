Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3B8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731A72465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576723719;
	bh=2EXJXzAEGIHXEfPa6nkVtL3FzloAs4v91fJ3KzYNT5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JAj7OfxUleImneiJjVr/lWmRIJI4EI6Db4RLYIyruq4yVHuKdlBFrBYGk9wGhEddX
	 6wJZO8B4DknVJiheQB3t4lPd7qJOndeniU3vKjaTL60Zpl3qlGkLxOV66zqAQhLVvl
	 L4XaHL2ZK31NXfDOkPNbM0+xkuwsZbOd5xZ05nTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLSCsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfLSCsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:48:38 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4B024680
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576723717;
        bh=2EXJXzAEGIHXEfPa6nkVtL3FzloAs4v91fJ3KzYNT5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KtDVa4AYNTPZy8VE550NbmwG03kUR++u4xYHWWU0WooYL65BsDijqksELTit44lFs
         TTMzUwVCIMNcOpicLAlYVQ7RHWp9MHtlUp+tt/AAeCI7WGs5SeqYHRxrFfT66kDd1W
         7T5rFAZDXHUlzstHWKH832zo0+yVN+h89jiImX+I=
Received: by mail-wm1-f45.google.com with SMTP id p9so3897714wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 18:48:37 -0800 (PST)
X-Gm-Message-State: APjAAAVMCRP9hG364jyxnFO8w4nL1ZOoPAeSMhPqsFAjp9pomMmTqUTz
        /AT8+wzHGJxcqMkkJw+1OtybyCeKYkBRrmH9vxnnlg==
X-Google-Smtp-Source: APXvYqz3T1fk02wqZ4ZsJBtNovun0jn9i9cho/RL8rpMgcUxRsvat0cJbxk7KwzJT6edcjcjxUq61FkYWwUNSFDjxtc=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr7154296wmg.38.1576723715742;
 Wed, 18 Dec 2019 18:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20191126110659.GA14042@redhat.com> <20191203141239.GA30688@redhat.com>
 <20191218151904.GA3127@redhat.com> <CAHk-=whNhwFigBDSnyrfJYxr-uAe6PHiWTcHcZzPW+vZ3eWAXw@mail.gmail.com>
In-Reply-To: <CAHk-=whNhwFigBDSnyrfJYxr-uAe6PHiWTcHcZzPW+vZ3eWAXw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 18 Dec 2019 18:48:24 -0800
X-Gmail-Original-Message-ID: <CALCETrWJ8PLbxvX6yuP7Q3kz_=dZinacUd-3-OqUkZNSMCE34g@mail.gmail.com>
Message-ID: <CALCETrWJ8PLbxvX6yuP7Q3kz_=dZinacUd-3-OqUkZNSMCE34g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86: fix get_nr_restart_syscall()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Dec 18, 2019 at 7:19 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Andy, Linus, do you have any objections?
>
> It's ok by me, no objections. I still don't love your "hide the bit in
> thread flags over return to user space", and would still prefer it in
> the restart block, but I don't care _that_ deeply.
>

I'd rather stick it in restart_block.  I'd also like to see the kernel
*verify* that the variant of restart_syscall() that's invoked is the
same as the variant that should be invoked.  In my mind, very few
syscalls say "I can't believe there are no major bugs in here" like
restart_syscall(), and being conservative is nice.
