Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEDDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 23:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9FD206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 23:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lMsDbSqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfCJXym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 19:54:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44029 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfCJXym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 19:54:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id i8so2243015oib.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoSe6Z/a+RRQ6U0Ns6hRLVWf24WoPrnlmUg/LWRdcts=;
        b=lMsDbSquzK+wxeInWsUe1ndqpM9OM9/OB7dMQrMvZ9097++6Ct+wpXm0dqgb7ZjMyL
         mnqx0XfIpkzoj3r/+wUm5jvJX0lYV3hfaJd0jcSPb/keDEt4peF0a8NgAbV3h10yVcgy
         faZdoQg4zPIIaqHJQ7v3Vovrjqd2qjwZ2ipGKqFU1ljVegDQ4Z2ncr9m/1TiR1iCaFM4
         pMLwGTJI8ZEw/OgebS+k25P3TqVXeRLU4xX8OL7LKxMR/HWuJCu/ce/MOS1+ajJ+f4cf
         HaYNH/45TwyQGagvuLDV8rT4jbb2uUs7OpsJs/8eXeAAJvkFg0IZ55sa2HhDLJiHcOHa
         YDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoSe6Z/a+RRQ6U0Ns6hRLVWf24WoPrnlmUg/LWRdcts=;
        b=JEXGbUAjRqBfxIvR0Urkbb3c07ULmgoCotzx+ay81KNkG+pDx7jWNNTsHElH4yOL4C
         Suj0FNf3pvyjyUa1eN0b7mq0xnYHIoyEpNxnBAHtX/7sl9HHQk2l3SiyavVodBV/4d7O
         1cIPIV4A8zXZbyPPHkZJQbTPqDc+ILzXWSsVlXfkRQTY82qMPE1wJcpX5GkknOLA1vKO
         N7QKGvxdJXTMNJ7zqia1bp6i7Nf6iagtapLH2aJZZD6JlsUbQUURvsb10yHAGPpROC6e
         8r1PmbOQKgFE7RuT7jbRu8oX4f43c1EN1xWPdvazsfIK5bGhaVCoeyibzjxxRqXlUWPM
         OCqg==
X-Gm-Message-State: APjAAAVWgsbUCuhPoah6nbwVXmNqVDyYvdmvDJ1FjASE7QIDr+4JvpLm
        KY2PEyqbKxT0RTF9HKAyTsZkyLBxSni4mEJBy/uGXQ==
X-Google-Smtp-Source: APXvYqwFn91XEpww+BFQB83/xV8SzljK9yYHpQHlAWoikQE2Le/KJgxWPDHFRksbZv/CbhUUridG+auz58mLWbvTxrI=
X-Received: by 2002:aca:fc06:: with SMTP id a6mr15527931oii.0.1552262081496;
 Sun, 10 Mar 2019 16:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
In-Reply-To: <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 10 Mar 2019 16:54:29 -0700
Message-ID: <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Tony, who has wrestled with how to detect rep; movs recover-ability ]

On Sun, Mar 10, 2019 at 1:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 10, 2019 at 12:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Hi Linus, please pull from:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> > tags/devdax-for-5.1
> >
> > ...to receive new device-dax infrastructure to allow persistent memory
> > and other "reserved" / performance differentiated memories, to be
> > assigned to the core-mm as "System RAM".
>
> I'm not pulling this until I get official Intel clarification on the
> whole "pmem vs rep movs vs machine check" behavior.
>
> Last I saw it was deadly and didn't work, and we have a whole "mc-safe
> memory copy" thing for it in the kernel because repeat string
> instructions didn't work correctly on nvmem.
>
> No way am I exposing any users to something like that.
>
> We need a way to know when it works and when it doesn't, and only do
> it when it's safe.

Unfortunately this particular b0rkage is not constrained to nvmem.
I.e. there's nothing specific about nvmem requiring mc-safe memory
copy, it's a cpu problem consuming any poison regardless of
source-media-type with "rep; movs".
