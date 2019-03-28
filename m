Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E35C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9516D206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dw7eZLyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfC1CJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:09:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38664 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1CJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:09:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so16671820qth.5;
        Wed, 27 Mar 2019 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8C6Qcvs+zjdG37xdAf0MmJgzmAEwmI/aVOe+3YhBiGA=;
        b=dw7eZLyrjytCrLay06IUNJcNAIOlATD7v8m/vaV+JrUwn+NLNTjH4T+wWmGV4MG1t7
         oSzvakmPBh6cOSbvbnInxqqnQLrEofX51J7Oe9q+ei/6c+/s0Lr+pD1CpZcKUMiFDcll
         0nl2NPcuARjhjyQFy4W3s4sBXPEuRNREsEeFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8C6Qcvs+zjdG37xdAf0MmJgzmAEwmI/aVOe+3YhBiGA=;
        b=oLXwgEPm19BfZyt+iRzPZMBDkIjcinHer1lbPIGh7Vw/5axG+fzumIlH/6YY09u5Xs
         E2EMFMN4B6LlZKvwH0qbLV1XdEOLrYCIduEpwmdXyqRiTkxAoxEB5Z2x28/M6x7Q8spv
         oPKKe58PlszOkiN7JrpaAOj5apsjVivYWe/a0wppqY/+qCAOFIyKmYT7ZPXvpwG4b5Pu
         731oidc+/qZiqZmcpCuKl2Nab5w3oihUb7vuPmusa+K0Syrz20us23NAAKbv0zUmbaAl
         EUjvqJJwW4F5KnjiZMmg+9djTEmlSOIwqaumXahyswXVpJhgyC1swVw8wy556/PRg7XI
         4z0g==
X-Gm-Message-State: APjAAAXqDGGBiPZdNkyoCzJfrh791Ou+W9NhZw+X3VJ4M/LiHvRnq76/
        +I10tXq5MiXlLd75JnBpVlBdPMa6ELKZoTUIlxk=
X-Google-Smtp-Source: APXvYqzD6O/kBuFeN0L39gjm4WHHTyICNzO3ZyDYnI5dWpvqAQTMkkYCPREOiGZUs/5uvkDdh1nkiT14Xm18owDEzsE=
X-Received: by 2002:ac8:3687:: with SMTP id a7mr31543693qtc.284.1553738987129;
 Wed, 27 Mar 2019 19:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190328122300.02fc46c4@canb.auug.org.au> <CACPK8Xdx5TtG=7ZTgRg_V=obawreGrTG-aA2gESjpxcQY-wOBg@mail.gmail.com>
 <20190328015733.GI21724@piout.net>
In-Reply-To: <20190328015733.GI21724@piout.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Mar 2019 02:09:35 +0000
Message-ID: <CACPK8XexbzRH6V_iaAgL5NEihxr6AViz-aQe0eLdfPM=Oa=LbA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the rtc tree
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 at 01:59, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 28/03/2019 01:36:21+0000, Joel Stanley wrote:
> > On Thu, 28 Mar 2019 at 01:23, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the rtc tree, today's linux-next build (x86_64 allmodconfig)
> > > produced this warning:
> > >
> > > drivers/rtc/rtc-aspeed.c: In function 'aspeed_rtc_read_time':
> > > drivers/rtc/rtc-aspeed.c:26:16: warning: unused variable 'flags' [-Wunused-variable]
> > >   unsigned long flags;
> > >                 ^~~~~
> > > drivers/rtc/rtc-aspeed.c: In function 'aspeed_rtc_set_time':
> > > drivers/rtc/rtc-aspeed.c:57:16: warning: unused variable 'flags' [-Wunused-variable]
> > >   unsigned long flags;
> > >                 ^~~~~
> > >
> > > Introduced by commit
> > >
> > >   7f4d485413fb ("rtc: Add ASPEED RTC driver")
> >
> > Alexandre, it looks like v3 went in instead of v4. Do you need me to
> > send a follow up?
> >
>
> I didn't get any v4, I'll fix it up in the tree.

Thanks!

(Sorry, I fat fingered v3 and then prepared a v4 but didn't send it.
The only change was removing the flags variable.)
