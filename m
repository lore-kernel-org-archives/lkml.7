Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF71CC04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46D32070D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558051712;
	bh=6jLkthlx+re3NxR0T6A/PUTGkVlqnkyYyQ5mDJsqmRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nEiHuy932LOF4/wy60V87jzmAE0JRynQpzTJBkzax5SMcdNIhEk4crPYco8kAPCLK
	 /cqSijTyDdu9rKH1jTxMnDF8IZBnj2/JGJlJ/8rBNuoItbxfcCrwL2S31wr0Fn2ZXH
	 /MLR50z+gwDYYWwQGsLpPH29sL2NxM8TIbZs0/3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfEQAIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 20:08:31 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:45274 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEQAIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 20:08:31 -0400
Received: by mail-lf1-f46.google.com with SMTP id n22so3938337lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7aNvYWUCO6YrxXiAC0ARPuk5T1hcRQ+1DS9WOU1hfg=;
        b=L+HJmgVBbIb6HJRTyLyYpws/txBoU0FBSG9zeyKXtuG/hUE9jdY1TeO+FiL+A1wSj3
         vVWuQ8qozQfdl6pN0XGWMmHFff/XGAZSHYZ6wU70ceF7MJDY58xFx1Zc4rI8VblqsmuV
         npNGzb9f2oQHMqj9dowNldBJlTpS/Ba0XyiD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7aNvYWUCO6YrxXiAC0ARPuk5T1hcRQ+1DS9WOU1hfg=;
        b=IB4P3LNbS94Ybfc0BKkvCtOVu69wOtK6tJeJMti8jbNX0l+4rjvW5/Eme+FsLssxXE
         WfWW8DkirsZtHF1QHqyf5wqO4iMV8objUkQa6Fjy4X5G4FZ4jzEFVq59uqNOjjh3c3yb
         ZMbXvHp0mw2K43cKl4Wp4Y1/HbR9Ou2PTHLNBJa/q9P4XBm1RQVlyiUmYp2e2COtdllL
         2vzDTlJax3pawRVaGgqLpaIH772BIp3IqvE/oS66dVPOu60RaCeQ/HHw0GgNMg5c/EjE
         1yrC3UI0Y6SNbsYX0AgMKGDXga3C7FHfTy7bsMp9hFeAsAj/fXwsbgTYQUKsv9bUQEqz
         2K4g==
X-Gm-Message-State: APjAAAX6342Tk1cOBjwqNc2pRVGOR4gqTooa+EGTL8A4o61UfIPj5KKl
        b0g8MzOZ4A2rd6VeoLYv8coMDGfrzLo=
X-Google-Smtp-Source: APXvYqwSo8qk+wH4lI9DLU76IdSpbv6K/Q7RgT0oroBiEu7rVeWFYQrBZyFfm/Pm0FfIaqfa23m6BQ==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr23515391lfh.52.1558051708981;
        Thu, 16 May 2019 17:08:28 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h123sm1230659lfe.65.2019.05.16.17.08.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 17:08:27 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e13so4644319ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 17:08:27 -0700 (PDT)
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr3895210lji.189.1558051707294;
 Thu, 16 May 2019 17:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <14411.1558047621@warthog.procyon.org.uk>
In-Reply-To: <14411.1558047621@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 17:08:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJeAYaW+CA6cC8jEyJT5Z38z1suOwib43F-vFihD8bmQ@mail.gmail.com>
Message-ID: <CAHk-=wgJeAYaW+CA6cC8jEyJT5Z38z1suOwib43F-vFihD8bmQ@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-afs@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 4:00 PM David Howells <dhowells@redhat.com> wrote:
>
> Could you pull this series please?

I've pulled this, but I'm seriously considering just stopping pulling
from you entirely.

Not only is this late in the merge window, EVERY SINGLE commit I
pulled from you is from within a day or two.

And this is not a new thing. I literally dread stuff from you. Because
it's happened before, and it keeps happening. Out-of-window changes to
the keys layer etc etc.

Why does this keep happening?

                Linus
