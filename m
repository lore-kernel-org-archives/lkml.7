Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEC0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7692147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553453341;
	bh=O7WwLKZJhDTHk8h3DgBnKFODZLDNNLVGQjmP79/Yiy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rxiQHo/gMQTCrSRVG8KqrucL20sYXcR5IXhZItxYXixlz2yw0TJBleM5E/rdIbnBE
	 endyEpVAlx9agg3MNQEr5MwfSQ+Qggtt/K7IPVHjwzbMy27FUaYFWD4CDiF09qS7mf
	 RUEe/R2Dzwk1kT+cVk/sB+jhC1sAp0/dfnEPplLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfCXStA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:49:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32882 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:48:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so5919695ljc.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndkK6VwHx3xb4xU0AxgFMVrET1RjofRJzJnvlvrooLk=;
        b=gTDvC31vg0BkcvYNz5ozk4N9zB3/XJXosb8TtdSSjQsXKU8MfFbKhY+huhfxZYSVLi
         oxgUiZZOhJR1IgjQYvR/icGzyGQv7zmr9xmMLkWs2SKBWTUcFRKwloSdpPtpp14ffakc
         mfbw4hfs3xNZ+Hy25kQwc003rPuXVDECt5TQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndkK6VwHx3xb4xU0AxgFMVrET1RjofRJzJnvlvrooLk=;
        b=qyxuLpaKXgDvBk3C5KqvVBwMY6tYPkmFmh/DbhEkfLYYk7ju8/nEGruZpybVSg0Pu1
         SnLc+gwipeOj8m9sCuLkaa8bxLTqI5EB4/fT9/4BmgQvzZCbzw5/LAnriTRna2Ef24wH
         /89Prk24CvwVCWkWLJXWbCqOOFBjr9SPdcqrujV3tKgsocsasZkWQEcuchmarD9H83/e
         wQMPBImQSOdjMKp08H1L+m+LQlL8YoinxsGMjf/NcrX6vgP6q8UbC3GIEgtJk/yMs5+i
         ZFW2K4hsKP3gdgjPJlCKe3nxln/iR1qB240QC3ZQPervqA1wLG6sekUAhjC2FbUjqLqD
         TN5g==
X-Gm-Message-State: APjAAAWVETKFKE7jZypE89I374p6AHqgOKkROVL4+wTDLAUhXte9L4Uz
        QJn5WtLB84JYVDV4mBQdpmtpFQzPV/8=
X-Google-Smtp-Source: APXvYqzNyWMpFGVta/jjqpeEgd+AyVaEySjCQPukCoEJi9uoM0uE2k/B5vvTt8/J3aY8SDnwprFX0g==
X-Received: by 2002:a2e:4504:: with SMTP id s4mr10948623lja.150.1553453337550;
        Sun, 24 Mar 2019 11:48:57 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v11sm1637676ljk.19.2019.03.24.11.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 11:48:56 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h16so1409183ljg.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:48:56 -0700 (PDT)
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr10612821ljh.118.1553453336266;
 Sun, 24 Mar 2019 11:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674152.28403.9250472064220526031.tglx@nanos.tec.linutronix.de>
 <CAHk-=wgC4FQeT8Z6+gXnbsDFxRAD9sSELd8-G=6gQg4kxKKL4g@mail.gmail.com> <alpine.DEB.2.21.1903241929290.1798@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903241929290.1798@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Mar 2019 11:48:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixSEaRjAPT8ZiJhbs-5phzjSrRktz7tOCdSe5OCixfmA@mail.gmail.com>
Message-ID: <CAHk-=wixSEaRjAPT8ZiJhbs-5phzjSrRktz7tOCdSe5OCixfmA@mail.gmail.com>
Subject: Re: [GIT pull] scheduler updates for 5.1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 11:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Now doing a fresh clone from git.k.org (not ssh) shows me the stale commit
> from last week.

Now it gets me the right thing too.

Note that I have some git magic that means that I always pull from the
ssh side of kernel.org, just to avoid any stale issues:

 - my ~/.gitconfig does url rewriting to use the ssh//gitolite address

 - I have a prepare-commit-msg hook that then re-writes the ssh
address to the public address

so it wasn't due to mirroring latency.

Whatever. It looks right to me now, so I've pulled it.

               Linus
