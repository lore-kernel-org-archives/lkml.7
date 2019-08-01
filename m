Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63762087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TenVpUmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfHAKfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:35:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46498 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfHAKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:35:15 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so29867112iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF0do9wY3cyTRjOGDYpGmka2aPziK/+CZ1VE8F7DUC8=;
        b=TenVpUmM6bUvbexacfk8sJuh56uipvsMM7q+VxUe4DOkUPtEq5koFfaUOR7qA0FfWn
         EcT4YoOE6QFL/YfxbO1LnjjdwJz05Nq3KdpwW9H3TwROFJM31myL+qjzXZrMmlz7GWHv
         kWikwnNZcRuYgeTxVtM9ntxnThgbwZ4m2FmVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF0do9wY3cyTRjOGDYpGmka2aPziK/+CZ1VE8F7DUC8=;
        b=CaMYiIM7tpcxkrimc2QO3Uww5E40o34SHU4cI42DUw8Vogh4gOF3QZsRuYAtMJr5cA
         LFNrd9wbpJbCuOJW2gasMmReDHupFJYfvMiPeMTCFDw33orDMbdio2Ps85X0vXh5PgQe
         6L2KgezCSR1dHr1LjkcY6s9hrLWxmgIALfSzQrkNKk58N7h33U5uQ2mD2GNc6niju8xL
         dYBLP+w1PhwL0ASYHr8BIOmvXKtAIoHL3UPlxkWrs8US8MoYZ1w4E/pR1ff1qEzarweg
         1abZ4qvpKdaCftLJ+jYqzPQBTkmWDUrYXhmQOGdRFmQ+RMyIsvcq2h36qFj8cjSvRWhn
         iTsw==
X-Gm-Message-State: APjAAAWYpEeIzyQhtH5mBgg13RFmDwOvn8mGzyN4VMq1sIf+JSVHiVGB
        agAnuAe5BLzDP8liLhRUHt2cm1v4tOVuzfZum90=
X-Google-Smtp-Source: APXvYqxj0yaxuEmTXKenSnXaY/8xd4RXWC9zZFQtW0TVFTjoaY1r4goJ0orqWVClOITHQZ7OVVV7sUBj8YCoLSgOZIE=
X-Received: by 2002:a6b:ba88:: with SMTP id k130mr2923170iof.212.1564655714393;
 Thu, 01 Aug 2019 03:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190724094556.GA19383@deco.navytux.spb.ru>
In-Reply-To: <20190724094556.GA19383@deco.navytux.spb.ru>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Aug 2019 12:35:03 +0200
Message-ID: <CAJfpegscn7B+TrD5hckXkpHEb_62m6O9-kFOOehWyC89CPFunw@mail.gmail.com>
Subject: Re: [PATCH, RESEND3] fuse: require /dev/fuse reads to have enough
 buffer capacity (take 2)
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, gluster-devel@gluster.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:46 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Miklos,
>
> I was sending this patch for ~1.5 month without any feedback from you[1,2,3].
> The patch was tested by Sander Eikelenboom (original GlusterFS problem
> reporter)[4], and you said that it will be ok to retry for next
> cycle[5]. I was hoping for this patch to be picked up for 5.3 and queued
> to Linus's tree, but in despite several resends from me (the same patch;
> just reminders) nothing is happening. v5.3-rc1 came out on last Sunday,
> which, in my understanding, denotes the close of 5.3 merge window. What
> is going on? Could you please pick up the patch and handle it?

Applied.

Thanks,
Miklos
