Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45891C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3BC2541F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTLm6a7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfE3Fpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:45:30 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34965 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfE3Fpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 01:45:30 -0400
Received: by mail-ua1-f65.google.com with SMTP id r7so2045457ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cM0pxdkktIwtckIEKuMloCnwIAX2mlYUlZjtqoSteus=;
        b=uTLm6a7FmuQr3Ww5TrE8ju7nqeqMk6VgDEIe/0WkW4WrBIMllpo8Q9bNoBOTDsB7BS
         8/0/MWxEbE3vAEA/r+70ry30rb/8T3J+0kALevEe0kbY148aVfSatFODEPsfmTQr+cBS
         8yUui0furqOKB3RJv6gjfVFh8pyd8SvEsgl3Rh2mK14KJFRv2DHm7TjEl57tKvDNd5dQ
         eigKB9oQDpml5yfaYzGcTHA0Nb5MZgB38sEoBkx7vJQ2hEP0Yvd1/P3P6WXDttJMBehD
         lBFTZvTKUO8dNMuH2EMpSkfCfTufVvQ33JtA0WJu4kx/pyy+ASdFuqNn42TB/Kw6zDaJ
         HQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cM0pxdkktIwtckIEKuMloCnwIAX2mlYUlZjtqoSteus=;
        b=IDSHMdaMTVAqvm4V2zXfsB9ffRSh6EyboYBKTVm6HojBvCTHj0RCRzU6Nfmwuey7Wz
         Ay3CyOmE313w3jfcGunMQG09QvUsIcvaE1atQkCDZ73Od/x+x0hpni5V/vDSy6kuMRnw
         D2UihancYkrhR77eQkj2Mah3/hWlxZ+8Qd7jqxnkXqvxSHdC0yYu/d+x+JNKBtISiwLR
         pBV9OJBZsh1FuMkFwzAqCUYZZFDZpJPQRCvURh17a+2a3qe1G4eHgzwCATWC+3KxRIDz
         PsulTGx4QLobw8fLk2y5FeKYr0IGF58Vl9dUlv2oAlY4CQ2OfSLwRAC8moQPJt1QkzLd
         F3aA==
X-Gm-Message-State: APjAAAWO+vgNSUfLMz9/QiurC14UjWZHsYEJbd4sB65ZEjn6EPoXLa2h
        dRyYwObTfSR+BL5gKfR34ADj/0xjk1rQB6BgIvM=
X-Google-Smtp-Source: APXvYqyH4m9TJk/Rb+/MkwbrL7U3L/W9OjNTQcWYsXAMUABUVWzGoSKKk0POOolcMUBm7hhsYj/aZnQTHSAVvi6hkXE=
X-Received: by 2002:a9f:3241:: with SMTP id y1mr928222uad.107.1559195129051;
 Wed, 29 May 2019 22:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFbcbMATqCCpCR596FTaSdUV50nQSxDgXMd1ASgXu1CE+DJqTw@mail.gmail.com>
 <20190528071053.GL11013@uranus> <CAFbcbMAi_QhoT=JyU6NjNiJJwFbXF4Z1eV8TtfLv9UWJT-K_CQ@mail.gmail.com>
 <20190529121831.GU11013@uranus>
In-Reply-To: <20190529121831.GU11013@uranus>
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
Date:   Thu, 30 May 2019 13:45:16 +0800
Message-ID: <CAFbcbMCLwoBB8syLCSU8i0Hc7OMnHT4A+AzWdmF5g9BzbY7CXQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: fix possible spectre-v1 in do_prlimit()
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though syscall `getrlimit` , it seems not works after check_prlimit_permission.

And the speculation windows are large, as said[1]:
>> Can the speculation proceed past the task_lock()?  Or is the policy to
>> ignore such happy happenstances even if they are available?
>
> Locks are not in the way of speculation. Speculation has almost no limits
> except serializing instructions. At least they respect the magic AND
> limitation in array_index_nospec().

[1] https://do-db2.lkml.org/lkml/2018/5/15/1056

On Wed, May 29, 2019 at 8:18 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 10:39:52AM +0800, Dianzhang Chen wrote:
> > Hi,
> >
> > Although when detect it is misprediction and drop the execution, but
> > it can not drop all the effects of speculative execution, like the
> > cache state. During the speculative execution, the:
> >
> >
> > rlim = tsk->signal->rlim + resource;    // use resource as index
> >
> > ...
> >
> >             *old_rlim = *rlim;
> >
> >
> > may read some secret data into cache.
> >
> > and then the attacker can use side-channel attack to find out what the
> > secret data is.
>
> This code works after check_prlimit_permission call, which means you already
> should have a permission granted. And you implies that misprediction gonna
> be that deep which involves a number of calls/read/writes/jumps/locks-rb-wb-flushes
> and a bunch or other instructions, moreover all conditions are "mispredicted".
> This is very bold and actually unproved claim!
>
> Note that I pointed the patch is fine in cleanup context but seriously I
> don't see how this all can be exploitable in sense of spectre.
