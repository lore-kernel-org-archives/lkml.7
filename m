Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65837206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573580595;
	bh=2yd10KHYTLI5s6gMxqmI4NvWYQwboiddj2FXrknzmy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C8K8VbyzoAzR020+RZex12AKAZrFZrthiXlJX082t87Jtg882c7FY8bGzkjwGav1d
	 gTqp7ZlDZTZNmLAEVw3IEIV8KEH4Qif8r8nSI51f/dxUsG2qmfb4U4BfNsIA4IC7B6
	 6guUBM5VXnpRgJZyeRjhjbmivZjzb1ze2McmI0UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKLRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:43:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33090 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKLRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:43:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so18805294ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBqefimeVs+AYlMba+nG3Ifymts3na+gdpNY2rCXiUk=;
        b=diHQe+yBS1ptQml1pfafp+kWY2eFlTIw5aehrJHkBhZ8198TLnziuPuv+aWPbMESa4
         ZLgW0hXjhFPDrgdFG9RXdXxqYD1Ejn46fc1vZ1auR9hlb58u47fldPax7D6iEk6grtjo
         EpEWHP7zBGk+CKduo6ZBne9+0TPwuTpetW/Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBqefimeVs+AYlMba+nG3Ifymts3na+gdpNY2rCXiUk=;
        b=bkCOh7q5tBEv1arraX2jR323zticS6zAE7tV7ErJ8xO1nG5do44zTFGiAQkWskUlFC
         +hC1y8E/wRYsuHwco1Cx2OEU7mE/pujX3U1WOATGZ2w7Y7Vom1vqjmBADSMeVKzuuIHf
         z2/yYNUmXcAszMJMIE3b0SREhxbkb8VUEVelalXjlCAWDBjzgChR79qKODegRiw19ncq
         +enfGwe6WI2Xom1FNAxoNvIgmL5Ap3eOUD9Y9ZCeAZLAJ97lt0EMBjMZr62CtVnvJpBs
         h1VvlZAiGW5uyKzbxD8053NP/24uaG2gtQ8gAzb7Lyx7gRN4igYh975IHjMssFWnxOtT
         G73w==
X-Gm-Message-State: APjAAAVBdtw70fjFPCIWMyz2iDCaVBKobcQlO9TS1IGw7wZ9GGykECtx
        /1ubuSD4gJXwZkfEu/75Gw9WRRxt/i0=
X-Google-Smtp-Source: APXvYqwExbn24tvd6TOpmzkWelEN2EDrv6/JMV1xSfdwQJg0De9lPc7wOyHGger2NYbqU2d1tC9ByA==
X-Received: by 2002:a2e:898d:: with SMTP id c13mr21538374lji.54.1573580591500;
        Tue, 12 Nov 2019 09:43:11 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v6sm10300484ljd.15.2019.11.12.09.43.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:43:11 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id y186so7758253lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:43:10 -0800 (PST)
X-Received: by 2002:ac2:4c86:: with SMTP id d6mr20463115lfl.106.1573580217235;
 Tue, 12 Nov 2019 09:36:57 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
 <20191112165033.GA7905@deco.navytux.spb.ru> <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
In-Reply-To: <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 09:36:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com>
Message-ID: <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 9:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. I thought we already then applied all the patches that marked
> things that didn't use f_pos as FMODE_STREAM. Including pipes and
> sockets etc.
>
> But if we didn't - and no, I didn't double-check now either - then
> obviously that part of the patch can't be applied now.

Ok, looking at it now.

Yeah, commit c5bf68fe0c86 ("*: convert stream-like files from
nonseekable_open -> stream_open") did the scripted thing, but it only
did it for nonseekable_open, not for the more complicated cases.

So yup, you're right - we'd need to at least do the pipe/socket case too.

What happens if the actual conversion part (nonseekable_open ->
stream_open) is removed from the cocci script, and it's used to only
find "read/write doesn't use f_pos" cases?

Or maybe trigger on '.llseek = no_llseek'?

                 Linus
