Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C604C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8E221783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRGY3pii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKMN3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:29:55 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37449 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfKMN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:29:55 -0500
Received: by mail-oi1-f180.google.com with SMTP id y194so1762574oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GG3NLRv5OfdC4uOJwDiXKD2td6DOel2PDSVVDlug92E=;
        b=ZRGY3piik7TklMagNEr+qq4ou+cxbVEhizKBBshE3Sd1SN/k+Rsqy2sBY+BVhyj7qE
         j4PNeAFbgV6oI4vnWNygOotP0vmbRwPodlYwl17EZZKGbBW4TpOXiXLFLjfz+20/OV5x
         yI2UE903ok7kfWt9+KOunggSENBWZfk2rJA9wSLxqzMOwtZybT3WrJ23Lt/W8dfzFO7r
         waLebb8awC20ITrvq8Q1P01nl1EZT7BDdUsT3yxUF2ZCIvzXJWhJFr/qQwMNHlCSEPs0
         LJkFNS+4kR3p33JLovLQZg6JXnef8DBbVmJ2f3CU3uD9WD5aYah50+DIr9i2NQwfqg8D
         ixpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GG3NLRv5OfdC4uOJwDiXKD2td6DOel2PDSVVDlug92E=;
        b=OkDKP081DQ591ui4ODw7UU150HAs0ck0SqtbvYVE9pPD0ImlNBkI6ANLgNmgef8OEv
         qi5DVqeq4wSPfRFBX5hsOCQhxPOfXBmdNLUDkB7S7QTSf3q/edmLr3eoEuKLC1Lm3I9H
         zOaEMNqhWk0b1hk7JI/B1ur0423vS3IeN4ExD94RNE/y58aQD6j1ZcA89725q3WPPalb
         7mU/IsEwEECZv6s/77UrM4Ucch1UmbVhsZC3yT0H5mpzDyPmccAL+uAlQBnm6g/OVAW+
         w7940xb1Q9XvDs+ZmI5qUvYdd+38vDCiAfrKB381nrjwsPDYmVXWXymxSeHWo14BdQXE
         hYZw==
X-Gm-Message-State: APjAAAUEXpoww0xw8A6reIUGlGebSTEbiCLFL2w2CZf2ph+sIADe5U5U
        iNmjCff+HjsSDm7UHXKKQfjIMtMNirNr50ZzE2o=
X-Google-Smtp-Source: APXvYqxzyoR+2fB3I6xc7XURb2Z0ZKzZcsYyqtwnQsBYyiDo5H0qvqe6Ig1zciLGRR05M+wGP0V5y9m5L+mlMZSEpWE=
X-Received: by 2002:aca:2b15:: with SMTP id i21mr3113491oik.6.1573651794481;
 Wed, 13 Nov 2019 05:29:54 -0800 (PST)
MIME-Version: 1.0
References: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
In-Reply-To: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Wed, 13 Nov 2019 14:29:44 +0100
Message-ID: <CAM43=SP-CTHWdMCJwioUiEVSNnh-AgZj7YEK1i08TXHk3oCbLQ@mail.gmail.com>
Subject: Re: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns EPERM
To:     "Harris, Robert" <robert.harris@alertlogic.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 6:43 PM Harris, Robert
<robert.harris@alertlogic.com> wrote:
>
> I am investigating an issue on 4.9.184 in which futex() returns EPERM
> intermittently for
>
> futex(uaddr, FUTEX_WAIT_PRIVATE, val, &timeout, NULL, 0)
>
> The failure affects an application in an AWS lambda;  traditional
> debugging approaches vary from difficult to impossible.  I cannot
> reproduce the problem at will, instrument the kernel, install a new
> kernel or get an application core dump.
>
> Understanding the circumstances under which EPERM can be returned for
> FUTEX_WAIT_PRIVATE would be useful but it is not a documented failure
> mode.  I have spent some time looking through futex.c but have not
> found anything yet.  I would be grateful for a hint from someone more
> knowledgeable.


I just wanted to add that a colleague of mine reported the exact same
issue to me two days ago: a highly threaded application (the Erlang
VM) running in AWS lambda, futex wait calls occasionally failing with
EPERM.  I don't have more specifics than that, I've asked for kernel
version and the exact parameters in the failed futex call.

(Third attempt, really sorry about the noise, gmail's UI sucks.)
