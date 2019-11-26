Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255082068F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574733546;
	bh=LHUQZ8GAjtzwzQUglsN7PFMkeMULtqDSaVITo0dnFik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0YtWL4vN/htWLx0COf/xmbHRsrqtBj170hN1S4ErVY/JqxhOy+k3fAoi/1nHtzPVW
	 TBxi2lucBbhcTUu4RULy1TTafDvOuTpFZBS6dMqmD8+y8o2Soz/UzLZR6ghxFWWb5n
	 3LPiRZwMXu/KSKjf9kmIay5EeWFCm6PtulvTIclU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfKZB7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:59:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44833 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKZB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:59:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so11615475lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 17:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtgS4AGmvnEOifgu2Dt4VbOy1bsdf4mvEndYAr4ZPQc=;
        b=Xcu+cb5O2TRvEmYjhRf68ZKdECWrEP4UqOWaPs6ps+DSWuyv4onfE367judclAVziS
         +C2IgAqMN/5ZRCLuU/DyFk9kn0jx94QeB0m6YUmx8qcLUXgMFhZqfYnwHO4pU0q8eSri
         u5hc3Hq2+9rvh6b1Ao1AXld8Rpmhd4L7sDx2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtgS4AGmvnEOifgu2Dt4VbOy1bsdf4mvEndYAr4ZPQc=;
        b=T8mZVB2UavjFQi0jBRiCb7PjquItnOdAHPOPGEZSW0bLso0rU3Qwxk6Npl0KkjhigZ
         2h1IfYeGLfu5IofA7vVgq3nQ7aCvdwB9n1QaefeGYf4YdusP37dLCRWz8BfjojZrFTLo
         sgk5hfbZep1Ya2gTcY7vhkKfRogEkdh4RCPWy0FWBoaeiRBdhTw5hlpyfOCpAtllpG6W
         Br5G96Z+ICKqkVoHAZoSpGvCpes5A7X32j6YxqQ1MSYF5goFxoT+1CxiWTgagHjcdY/J
         2eGPeimB/yAHrzQ7RWNF/ue/nR8ovflrgX/OmYLC6SswbIQp3TIKtGzpvoaaM8sgQIkS
         DkDA==
X-Gm-Message-State: APjAAAVoMQxserb3ZaucBuVT7JJbNzIDZbKrr1xeqtXgHDtkmHjB5pnn
        P2/REECNXDz+dAvbnNfJVY5JldwuFcQ=
X-Google-Smtp-Source: APXvYqyNQNLFsemr/IJ1LP/vtJyzj4N/vIkHrtJXElDiiU0es+iKNIitrCXTyRKX/oUyRPjwMNYnww==
X-Received: by 2002:a05:6512:4c1:: with SMTP id w1mr22696691lfq.141.1574733542332;
        Mon, 25 Nov 2019 17:59:02 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id g11sm4418497lfb.94.2019.11.25.17.59.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 17:59:01 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id t5so18258512ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 17:59:00 -0800 (PST)
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr24510476ljs.26.1574733540177;
 Mon, 25 Nov 2019 17:59:00 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 17:58:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com>
Message-ID: <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 2:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, here's a TOTALLY UNTESTED patch that may help pinpoint which
> thing it is that causes issues.
>
> It might also be so noisy as to be useless, I didn't think it through
> a lot.

Yeah, I ended up testing it between merges, and it points out a lot of
files. Too many to usefully narrow down which one then might cause
problems for you.

The main cause of that is that it will complain for _every_ O_PATH
open, because those use the 'empty_fops' and don't actually allow any
operations at all (neither read/write nor llseek). We could have
marked those O_STREAM, since they can't be used for any seeking
operations.

So to get rid of at least _that_ endless noise, add this to the patch:

  --- a/fs/open.c
  +++ b/fs/open.c
  @@ -748,7 +748,7 @@ static int do_dentry_open(struct file *f,
          f->f_wb_err = filemap_sample_wb_err(f->f_mapping);

          if (unlikely(f->f_flags & O_PATH)) {
  -               f->f_mode = FMODE_PATH | FMODE_OPENED;
  +               f->f_mode = FMODE_PATH | FMODE_OPENED | FMODE_STREAM;
                  f->f_op = &empty_fops;
                  return 0;
          }

the above is entirely whitespace-damaged, but you can see what it's
doing. That should cut down on all the noise generated by O_PATH
opens.

It might still be a bit noisy even with the above, but I think it will
at least be better.

              Linus
