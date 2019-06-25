Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27DF20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfFYKSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:18:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44432 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFYKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:18:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so17703174qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 03:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvRWz6V+haw2TlVaZgmCm6ymdnETNKgsFXH0cyBj35I=;
        b=hvhcWdm3dt+AIaJh1xApZwhUdh1xGQIcRAbTfZjWIyDkBuS/rukUrrjcE5BW/QZfyY
         hFLpW3WMp1Ya0pzoOfHTe789mCeVJ2dXmzWUehqkgKrjBSWftrmTNVIjEaR4RUDpesnT
         kvMel19GMn2Tij7WjducyYNdBBJ6MmpvbtReyUK0RMBzKihREmBjDf4QMq/RaWRA8Twy
         4MjqzEQvvb6ciYI/fVAAA4H6hTR+Fybx7ApJaeuF503dr//Hxhzw0M8d0IxUW06JRvKZ
         GLs/lEQ1nR5KCL1pMCY8fgEuWYp5Rdm/gI/gcIIyOLqEuqqL0j/tXiTbdBrIP8U//2YI
         AeTw==
X-Gm-Message-State: APjAAAUHpXWPhanNFP4zl2pzdKB7VC2lOJebxgasMTIejSusNcbfPW8A
        YNmfwfnTwBBNW0nb7ops2LVb9qrxziQtXkt2cm8C4Bii
X-Google-Smtp-Source: APXvYqydUzs35RA7rjZwhf8dA2rUVA2XPh5DwCQotX74TATCvoQLOnxXE7G0PbbxpaF2uoKqS36oASNCYDDDwDej0xk=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr62213510qve.45.1561457899397;
 Tue, 25 Jun 2019 03:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190625081912.14813-1-Jason@zx2c4.com>
In-Reply-To: <20190625081912.14813-1-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Jun 2019 12:18:01 +0200
Message-ID: <CAK8P3a3nnrm0pebbA2fx9dHYwH7vkYWuJAQVWRzzQikOkXYqcQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] timekeeping: cleanup _fast_ variety of functions
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:19 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Thomas,
>
> When Arnd and I discussed this prior, he thought it best that I separate
> these two commits out into a separate patchset, because they might
> require additional discussion or consideration from you. They seem
> straightforward enough to me, but if deliberations require me to make
> some tweaks, I'm happy to do so.

One concern I had was whether we want to replace 'fast' with something
else, such as 'in_nmi' that might be less confusing.  The current naming
might be easy to confuse between 'fast' and 'coarse'.

Another point might be whether we actually need more than one
kind of accessor for each time domain, given how rarely these are
used. In theory we could have the full set of combinations of fast:
monotonic/real/boottime/raw (but not clocktai) with ktime_t/ns/seconds/ts64
for 16 versions.  We currently have four, and you are adding another
four, but not the final eight. I'm not saying this is wrong, but
it feels a bit arbitrary and could use an explanation why you feel that
is the right subset.

For coarse, we have ktime_t and ts64. The _seconds() accessors are
coarse by definition, but we probably don't want to add _ns().
We also don't have the combination of 'raw' with 'coarse' or 'seconds',
as that seems to have no use case.

      Arnd
