Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1BCC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C3720820
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569085409;
	bh=sf6P4Cu9MGU/vCciEzlt/RzV7/QT5qo+KHsCiIDd13M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ak7YWv1DZ/jm6yueM46xunLCcu0tLr0XzKaDO/z2punHp8r7DdhKEEgmVIkZ8uGS9
	 GtdNt4L15dDrb0i3vQMXgXmC+LAPNI1NYi8nY8SHyyDY2iPn7X96MiXjRrtsfrokhl
	 FtiOTE0esfU2clXBU95IfM5NnG6KlgzaCVl/hKbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407840AbfIURD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:03:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34631 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406192AbfIURD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:03:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so8435618lja.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4lBlA32XM51F7x2UJZ2nG8Ecnvr2QR3fqZqJb49bB4=;
        b=WpEh4bkq7Bi1TfqOi5U+R2G0rSoVVQiTSN6lA9Jgwfz50akGHCgQNveg+EP/Jez63c
         Iu/x/vKmNBOSrfGE7VnfN0xmGrhrxF9gUldqfVKZB2zksWHlGpsRvt4gT66LHU3XyWrx
         /TovJzktZ3cRO3ywx7UpQjlwFSzvqVL3p0JzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4lBlA32XM51F7x2UJZ2nG8Ecnvr2QR3fqZqJb49bB4=;
        b=NtAI8cKjqVDeNeNPbLItnHljxKEYhGUGkxYemAtYsNoAOWQqPJF00oFw6n90fFJRG4
         0nxmFj7qTgMWJ+RS4bFtKLwRCZoltqrH+TFqrucSmE2hbF/fW+mWvjUz7T3eQU5vkMjG
         nBBIrx0umcl3GQnEANUwYA7Qn5u8dp9e9proOrdc6ihvpDXhryO17GE0sLfJmamoxq5t
         TnnFtXHDUFotdv8e1Idc1ii8bpNXOdNvcqvF/JtdO6REqA6FUyPgBZ2GhK+6rVbVmCx0
         MqwpLerXWeNNlPzP4msoKCQwRUyeow/1pio6W5Dx2ZxH0JPl8Ph7Q4LO/30rHnJP+3la
         u3Lg==
X-Gm-Message-State: APjAAAVykkSW6iEHBoXqNV0Q7A/FQYP4bUq5/Q3bD8udgljKnppbNHOW
        wMFM8ZU1yl/Pvf8rXeJf9dA7drviYgU=
X-Google-Smtp-Source: APXvYqyAuoPA+lUl/ft4UPCdCP4WxqNAv8T/vJVoM9i56LCO1evFGpB8FCRcNUlzr2g0FzUQV7LLfg==
X-Received: by 2002:a2e:58a:: with SMTP id 132mr11721184ljf.132.1569085405155;
        Sat, 21 Sep 2019 10:03:25 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c16sm1181621lfj.8.2019.09.21.10.03.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2019 10:03:24 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a22so9972841ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 10:03:24 -0700 (PDT)
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr3117435ljj.165.1569085403946;
 Sat, 21 Sep 2019 10:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190920231233.GP1131@ZenIV.linux.org.uk> <20190921031117.GA22426@ZenIV.linux.org.uk>
In-Reply-To: <20190921031117.GA22426@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Sep 2019 10:03:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZwiod6jf3mQwnbTij6GxDuu5A=Fmgz0qzxie8tNdkWw@mail.gmail.com>
Message-ID: <CAHk-=wgZwiod6jf3mQwnbTij6GxDuu5A=Fmgz0qzxie8tNdkWw@mail.gmail.com>
Subject: Re: [RFC] microoptimizing hlist_add_{before,behind}
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 8:11 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> My apologies ;-/  Correct diff follows:

This is similar to what we do for the regular list_add(), so I have no
objections to the micro-optimization.

Of course, for list_add() we do it by using a helper function and
passing those prev/next pointers to it instead, so it _looks_ very
different. But the logic is the same: do the loads of next/prev early
and once, so that gcc doesn't think they might alias with the updates.

However, I *really* don't like this syntax:

        struct hlist_node *p = n->next = prev->next;

What, what? That's illegible. Both for the double assignment within a
declaration, but also for the naming.

Yeah, I assume you mean 'p' just for pointer. Fine. But when we are
explicitly playing with multiple pointers, just give them a name.

In this case, 'next'.

So just do

  hlist_add_behind:
        struct hlist_node *next = prev->next;
        n->next = next;
        prev->next = n;
        n->pprev = &prev->next;
        if (next)
                next->pprev = &n->next;

And honestly, I'd rename 'n' with 'new' too while at it. We're not
using C++, so we can use sane names (and already do in other places).

That way each statement makes sense on its own, rather than being a
mess of "what does 'p' and 'n' mean?"

                  Linus
