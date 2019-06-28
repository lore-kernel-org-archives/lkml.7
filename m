Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7994F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBV36za1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfF1WHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:07:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35729 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1WHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:07:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id u124so5063002vsu.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74OPjw61WfkdZEzSLsys8fgk6PifSSbknmVm2NEw5mE=;
        b=tBV36za12EawEv+1kbBGR9K45WvHbqKoMnvnBxWlnxnKqTayTKKBcageg21+paIXxV
         No38B6UUFmHsPBIHSfqd7vqJbd4VTh2HkjSNwJRIWqU3Zti8tNUIy7eaYfkiY8IQp+/t
         tAsWyQAbKtw9eu/3jOA4d6asamy7qXNdkO6MR2cz+VauhTtNO2WIWCh2aH/bdxTXxQse
         aJVPi1C12NEKeaggLsETQ/4BEZ/jGjE+aDz4s8IiyD4u2qhEPDjnGho74HjhYhXvF/nW
         wVipQaRl8ifcIxPTB17H9x2nqOhqEHQkhWpiQcewmEbSRnKPork3BN0A5uCOBdovIChP
         Eyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74OPjw61WfkdZEzSLsys8fgk6PifSSbknmVm2NEw5mE=;
        b=oBqhN0mbu+HvNKVjcVuqBjCopMiqA3QGVjR8lE2F0Kx9jc89PJHc7Y3VjHTMqfhweI
         9TV+CtUgR8uq1wRHiOqe5985WsfSc+WbaCcCsqT42nY6o3jAkBoNbrQ/A3Rt0dVc+Nba
         TIedQ4stw1LS0GnPOYsvcRyPGb241WA4fWzGpLOf1jxwmwcxuVDuBqalKiwDC+SjvwxB
         a90xaOD0mjA4ujN1iXLcUnM99Hum83mcWKzAijN+MDmm8t/N6kR08Iou6hEx6m0oGX/4
         K2bXS2jf54J6rFb9WJHip/BesNY9Rj7Iwgnv07uhrp2nLFZjbXbLNcntogatu3Zp4Sgn
         5Qrw==
X-Gm-Message-State: APjAAAWTaW6vsgnibWapTSIHjLPzz2nO4UZ7AK/RXCOpCtVg3qRBZInV
        +hhI37CbHgrNgwuvM13F8PbkLpnM9JsqyefsSUbExA==
X-Google-Smtp-Source: APXvYqwi+0sgRo6Yub93+YheljK4dvBVbSMCg9kwJeqfDTIYGWL86EBMwZgwzty3wSzHhEgmMJtgVl3Np9sV6nUOv7A=
X-Received: by 2002:a67:e98f:: with SMTP id b15mr7973070vso.209.1561759638724;
 Fri, 28 Jun 2019 15:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190628045008.39926-1-walken@google.com> <20190628165642.r754xozttawmg5yh@linux-r8p5>
In-Reply-To: <20190628165642.r754xozttawmg5yh@linux-r8p5>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 28 Jun 2019 15:07:06 -0700
Message-ID: <CANN689HZDmN3aNf7--MOy1=Erctuqo=3inHHwYqDH+v98B8YTA@mail.gmail.com>
Subject: Re: [PATCH] rbtree: avoid generating code twice for the cached versions
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On Fri, Jun 28, 2019 at 9:56 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
> I think this makes sense, and is more along the lines of the augmented
> cached doing the static inline instead of separate instantiations of the
> calls.

Thanks for the review.

> >Change-Id: I0cb62be774fc0138b81188e6ae81d5f1da64578d
> what is this?

Gerrit code review insists on having this footer on every commit. I
forgot to remove it before submitting. Please ignore it :)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
