Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCBC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C449206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577037075;
	bh=7MPOTz1DIgDiQf1QcGR5zNg3tAWegjXLIRI34b28UMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JckmnIKq3an0aMsGJSLSgaUsFtzHqPUF8pPgfqxHuCHKg2JKB9oVJoSEdy/75Fuid
	 xmntjjbmaO1VJWgndJoPdu3NCiHgyIXrIyYNamegs2DNEh6NlOqnEiQ1JCIj4iDShs
	 28U/4uFcrwpUlEYs+s8+Yxpf2JFwCMoQRV456Z6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfLVRvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 12:51:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32988 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLVRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 12:51:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so10984169lfl.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+DFRZm1mZCG8Q4iFUUSl87IJ9WC5zykHr6alPq0ZLo=;
        b=CQ8K6tZmrYw+i7cLRAX6nHHWBuA0WZCjyD1+ygJortD1DDEXd5VUtlYicd8UB1mI62
         u7NC/dlgoayz6shYBUr0GxxKdDUXPS9FLAP4nfrxjjyeNFGvs0cWJ/yiwbhnGE1BHFIo
         ow2Mg7DSIY0wQAnnfuT4xNkYfh9ioXkz9mqrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+DFRZm1mZCG8Q4iFUUSl87IJ9WC5zykHr6alPq0ZLo=;
        b=eRGJwjVjlgqMS3MWWN/v8weaGy0FOZSeaRkiBbXzAHA/giVZKYu0tSglS6pg1KnkgY
         G5dkpDk36byjhaoGWgiREVkikDJ2f/+R89cWXu7m6ir29P9mnfKSnejhDS7o6mU3szuq
         A7GK1zIdBCiP163EdMPM1bA2hsALrxoSXdaTsVGKiR1pX2jQ3SRU8d6FYu56JHRnBYK9
         DdsaF29CBiT2Fqvw9CU7ZRlOMYquzF23Co8EYMANHUCH8ZLmMvxj6FYENwsyScvhWxdN
         y5+3vK3mjrMkqG7RNd1ym+5pf7GXdqC5L7R9ir0s6Ct6TXdbhIpXBv5NmtPsCI8IrYCQ
         6kdw==
X-Gm-Message-State: APjAAAVsJWgbav524V42zNVGPfY3u+umHSPo1P3ew7mrkEbCFaxIp6Wk
        oa1ahUZzvqImMGvzOES1P/fAqDIlNW8=
X-Google-Smtp-Source: APXvYqz2nBVCgs5Bq1PNEKOYItwugPHx8OTC+TWox6mnoUsjMmbqEf8yM45FhZaJaep4Q6B/Hazfkg==
X-Received: by 2002:ac2:5388:: with SMTP id g8mr14420310lfh.43.1577037071281;
        Sun, 22 Dec 2019 09:51:11 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c27sm6852490lfh.62.2019.12.22.09.51.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 09:51:10 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id r14so10962315lfm.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 09:51:10 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr14384920lfm.29.1577037069868;
 Sun, 22 Dec 2019 09:51:09 -0800 (PST)
MIME-Version: 1.0
References: <65b22cd4e8bb142c5b7b86bc33fb08de6f318089.1577017472.git.jstancek@redhat.com>
In-Reply-To: <65b22cd4e8bb142c5b7b86bc33fb08de6f318089.1577017472.git.jstancek@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Dec 2019 09:50:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGB-Xt1CPbLQ3wY5KENq48Ws5WNwHz+aQp+gmZY+47EQ@mail.gmail.com>
Message-ID: <CAHk-=wiGB-Xt1CPbLQ3wY5KENq48Ws5WNwHz+aQp+gmZY+47EQ@mail.gmail.com>
Subject: Re: [PATCH] pipe: fix empty pipe check in pipe_write()
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, rasibley@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2019 at 4:35 AM Jan Stancek <jstancek@redhat.com> wrote:
> Problem is that after pipe_write() reacquires pipe lock, it
> re-checks for empty pipe with potentially stale 'head' and
> doesn't wake up read side anymore. pipe->tail can advance
> beyond 'head', because there are multiple writers.

Thank you. Patch is obviously correct, applied.

I wonder how much that whole "cache head/tail/mask" really helps, and
if we should strive to get rid of it entirely (and just make
"pipe_emptuy()" and friends take a 'const struct pipe_inode_info *"
argument).

Oh well.  I've apple your one-liner, but next time I might decide the
cleverness and slight code generation advantage might not be worth it.

Hopefully there won't _be_ a next time, of course ;)

             Linus
