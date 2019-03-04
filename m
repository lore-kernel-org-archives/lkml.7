Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D48C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF94720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIwaJLX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCDQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:25:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38345 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfCDQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:25:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so4290658oic.5;
        Mon, 04 Mar 2019 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTnTWpeeE+CiV9lF7EKLxXS6uvkQq6oVoshcbDcQFHE=;
        b=aIwaJLX8fAJARmQAXKN+Bt026UwSWI0hT4PfxUBE9vM0XHl5WUdnES5ij/+/67qDht
         neLoWMziY9HEnAetneJSvwPVVnD/NkGt+1KGmopv4lJw0mv3C1Vm05cBaGjgUVKES3BA
         cq478rdxNjbXBirYSbAYOvZvNfLsgWetZrEfYlJ/Ys+iNr2Laqy3Sl6LfgQdWV53LmNU
         +L4mbvMqxHXzI6xiVqvqynngAUNRRPVXj525zv+PfOouLwhUm/cjhtO8r6HMAEv9KHJ2
         s4b6ojkEJzZ6uz4P8M2hhTXZxP6VqkJA/M3JQqU3prSQAindqQhLZuY5DyBiOcGfGpmb
         9KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTnTWpeeE+CiV9lF7EKLxXS6uvkQq6oVoshcbDcQFHE=;
        b=Bo4LphJil1dUhjSc2lDMIW/b1Ex07GPsLrY+XxXRPy0ZRx/nf2smkz5ty8Dxmkdbri
         oHOv04hI+zqe9nArn4MI+2TBYbIIY6Hb1NtmJTIPOVwpxrV/lli0n21jNrof4ZmjsSG8
         mi25/dKuelPdWqQUjxEwGStV1y2nuJ8dKxI2Ua95bYzuHzQQ3j1Az6DebLe4etUCSIIA
         OM+WLvd5LBUZccD7K+V4QRKVpKXpqEIqzPQMOMYRBZhBzQ7Au9ERq0k9byWHZ3XFBUd5
         1UBjL4I1VPAfIonBWpO5f/GJscL+VLbgEeioZeaAWvhtDDIFgUnf1Q3RMs8QFDCavjqz
         xiTw==
X-Gm-Message-State: AHQUAubiwPXNv/aRctHTe5HQjwopEbb4IKNdtZPnv2kRW6kwerVrbASG
        C/ha74kTKGLFG+Olp4Qwe2yEaVVSutfa3i/5ZdqH4jTz
X-Google-Smtp-Source: AHgI3IZfY4xH72Ud2Z0jZvklOuLruer5i2WjjxuLztJVqvarSKJKS0zOtWgMpVxCDfws/KAq3fVkNvtaAVFUSWOUPlM=
X-Received: by 2002:aca:3142:: with SMTP id x63mr11980855oix.92.1551716712873;
 Mon, 04 Mar 2019 08:25:12 -0800 (PST)
MIME-Version: 1.0
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
 <CAGngYiUkdehPwyN-oEBrUOpBzvkHef=TwyjCXKYawB54pmAdVg@mail.gmail.com> <20190303143813.3b5a3f22@archlinux>
In-Reply-To: <20190303143813.3b5a3f22@archlinux>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 4 Mar 2019 11:25:01 -0500
Message-ID: <CAGngYiW0Sf1mg-F18p_NeJZUMsvvceRn4HvNXAkdLaS9AfFDMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: light: Add driver for ap3216c
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 9:38 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Hmm. Just been thinking a bit about the events on here and wondered
> if it is possible to mask them through careful use of the threshold
> values - i.e. can we stop the hardware generating the interrupts for
> the ones we don't want. It would be unusual for hardware to be
> designed where this wasn't possible.

Excellent point! People with power / battery constraints take a dim view of
receiving interrupts when no-one wants them. So disabling them in h/w
is definitely the way to go, if possible.

And yes, this also makes a non-issue of thresh_en visibility concerns, if any.

>
> Alternatively if you have a scope or equivalent to verify if it is doing
> these as a multi byte read and working that would be even better.
> It is not uncommon for hardware to implement fairly standard i2c features
> like this and not document them because they weren't what the test code
> the docs writer got given does! (may not be true here of course)

Or alternatively, the current chip rev supports undocumented multi-reads,
and the next revision silently drops support, thereby breaking the driver...
Been there, done that, got the T-shirt :(
