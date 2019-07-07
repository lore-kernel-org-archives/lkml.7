Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B18BC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFB920850
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562512299;
	bh=DlD0ZqCFs4Sd1QYpz2g8ouRwGt4Zydb3dTYVQkQrzig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S6UCZ3XmU7eRg0bJZPbFGn+jnHSgBmgYja9wi1vD3NwASHnvJUKeowVCvCpvIS54l
	 XdVb57IDpuqzOrDwQ151kmuSpfm071uXbUR3aPsVspQLY43mdlY3ZB5lR77qqx0gdY
	 7r/5JHFBQkk26vfpN+S/Uan5EzHHuPjAVFkJwpgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGGPLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 11:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfGGPLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 11:11:37 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563CB20830
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2019 15:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562512296;
        bh=DlD0ZqCFs4Sd1QYpz2g8ouRwGt4Zydb3dTYVQkQrzig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yMBTRU9v7y9YWuA6gCalyBmzTkpUjdkduuwvitKnTbmancNxL4i30NpQDVthB3HwD
         jxKgJiQxlD94BaskHuw/HvXvCCpCJbhyizTcJRoymZSQZSdMQGWlBoOCWI1KexXTWx
         IXMCjp3v/MsZRM909BAgA4QC61nJOke6AjntemzQ=
Received: by mail-wr1-f45.google.com with SMTP id g17so4249373wrr.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 08:11:36 -0700 (PDT)
X-Gm-Message-State: APjAAAXmW6PlBCb5GBxCPU0F53eRo+p0TFSSM0enZmHl+cXKNZOpaDr/
        /apbB6pY++SEq3ESH/yaR2whJJl9LLrdl4y3UNiXBg==
X-Google-Smtp-Source: APXvYqyWbGcQcVA+N1/vE8Kj0IRVb9gkPX2Fa0wpX+8TJxmzeamY666aQ5xzH2AS/3E5fOYZ6ocuaerfmRSIZvZD/PU=
X-Received: by 2002:a5d:4309:: with SMTP id h9mr13538308wrq.221.1562512294975;
 Sun, 07 Jul 2019 08:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
 <CALCETrXvTvFBaQB-kEe4cRTCXUyTbWLbcveWsH-kX4j915c_=w@mail.gmail.com>
In-Reply-To: <CALCETrXvTvFBaQB-kEe4cRTCXUyTbWLbcveWsH-kX4j915c_=w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 7 Jul 2019 08:11:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUzP4Wb=WNhGvc7k4oX7QQz1JXZ3-O8PQhs39kmZid0nw@mail.gmail.com>
Message-ID: <CALCETrUzP4Wb=WNhGvc7k4oX7QQz1JXZ3-O8PQhs39kmZid0nw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 7, 2019 at 8:10 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Jul 4, 2019 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Despire the current efforts to read CR2 before tracing happens there
> > still exist a number of possible holes:
> >
> >   idtentry page_fault             do_page_fault           has_error_code=1
> >     call error_entry
> >       TRACE_IRQS_OFF
> >         call trace_hardirqs_off*
> >           #PF // modifies CR2
> >
> >       CALL_enter_from_user_mode
> >         __context_tracking_exit()
> >           trace_user_exit(0)
> >             #PF // modifies CR2
> >
> >     call do_page_fault
> >       address = read_cr2(); /* whoopsie */
> >
> > And similar for i386.
> >
> > Fix it by pulling the CR2 read into the entry code, before any of that
> > stuff gets a chance to run and ruin things.
>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
>
> Subject to the discussion as to whether this is the right approach at all.

FWIW, I'm leaning toward suggesting that we apply the trivial tracing
fix and backport *that*.  Then, in -tip, we could revert it and apply
this patch instead.
