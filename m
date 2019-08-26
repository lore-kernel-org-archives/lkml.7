Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D1C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57E421852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="HTFzbbyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfHZOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:52:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38002 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfHZOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:52:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so14270966qkh.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lhk4ps2Zdoy+aA3Z362ilgq6ODDDLrQbUgEhy2SNBH0=;
        b=HTFzbbyAuoOgB+shLGbS5vkreQw0WFo080S0q9L52eKRPlNHS/4Mt/3zWGyEZwKKEs
         FZRj8z1URofbb5V6lmKcmmhqdbtMfXNF+wZw1OQ9r3xQHkoQkLoNWoQH4uzVHo5Ajj/O
         em2wSbAdGvBAx42/jUV3MODHnx/2mgMK2v9AEFk0hZZ5UHuqgfWWz1SM2i9DdRNvB6em
         GoKRZUW5lubFCME6n0Mz8lGgeedMl8Wtip3I9rkXbCMfzKURpiwun2Tm2C+I5S6Bgt6n
         MoCjfxliti0pVr2kEZsXSZoqsShsTx/rvg5+Qun6VJLIRtWv2KEBRJPGyI4Gi/a7RjJp
         UCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lhk4ps2Zdoy+aA3Z362ilgq6ODDDLrQbUgEhy2SNBH0=;
        b=fjA0fGb4GjqbSHtPtmdAXwHfkCNWWIxU53pttggK0gzij00fd3XzBM0L2zEceHGcqF
         WNsrXlzhTxmk7FpdcPr+KSyfOTNRqNFFoUKuFY09hILm545//U+KWlzXGh9/UuUq6prz
         FyrNg/Uk/tpsrrypIG44s5Y5mjTPnWLvSHwYzEltrBYUNDU1XW0Yp+khLIWqyXVZQYJN
         vjdjiKTA3l4dEh0VTo1mHDEQ2kLauL4JTtPuVm1GVIZUVyC0FWs8adWELfmQvVUZ1nmb
         Qd+HuUjjjbsmcNDDhsJ++Rh7EN9B6GGDSN7Ew9fB6mPL7grw7onkuwiwk1XMgsBcvc31
         Npiw==
X-Gm-Message-State: APjAAAVAxVoQroq00URvvj40KqzYgsAtoXD9hsybwzJagdwcNeRbSYCy
        Ds/1WK/LjSmRq6rhhSt+9ZDDVEsLukHsXkikTccyykCSHf8=
X-Google-Smtp-Source: APXvYqy6gsKerGcq08pDu4KgA+s9hKTuGu/EOJ2sv7K2uJcmfQ9QsYZsHhVsoalgC65CDrc/IiSKan8+lkwRbbDptT4=
X-Received: by 2002:a37:4dc5:: with SMTP id a188mr17394794qkb.206.1566831123952;
 Mon, 26 Aug 2019 07:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190825215833.25817-1-flameeyes@flameeyes.com> <98427b15d2a5cc93c72867bb7800df6c38f1f7bf.camel@perches.com>
In-Reply-To: <98427b15d2a5cc93c72867bb7800df6c38f1f7bf.camel@perches.com>
From:   =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>
Date:   Mon, 26 Aug 2019 15:51:53 +0100
Message-ID: <CAHcsgXTDoVGPhGg+wkcu4CYDxyRMc8+wzUZ_qbJ-L6EomkRN6g@mail.gmail.com>
Subject: Re: [PATCH] cdrom: make debug logging rely on pr_debug and debugfs only.
To:     Joe Perches <joe@perches.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 11:13 PM Joe Perches <joe@perches.com> wrote:
> > -     cd_dbg(CD_OPEN, "entering register_cdrom\n");
> > +     pr_debug("entering register_cdrom\n");
>
> debut output for function tracing can also be removed
> and ftrace used instead.

Oh, nice! I have never had to go this deep into a driver before, so
I'm pretty much an ftrace noob, but that pointer actually made the
whole debugging _much_ easier, too!

I'll send an updated patch series now that (thanks to that!) I managed
to make the device I'm fighting with work.
