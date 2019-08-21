Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56C0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D12422CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDh1flxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfHUVnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:43:07 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44759 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHUVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:43:07 -0400
Received: by mail-yw1-f68.google.com with SMTP id l79so1524189ywe.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh39CY7OKDO4zGxrF3Tom1rSCBIenfklbHsSPnOIW5A=;
        b=mDh1flxQMt84OrIH1YADm/mAFBaDJX+S+ZjFk5nrTwD/xeAnqlUKzJQ1rRRxdoSCAT
         M9WWHHiFGBlbXKN1m/Nf3GC7Cd/+lH4Ebaf9r7gTcid2OB7D66Ufnz8zmRPThAsqOvrU
         dT0uif0mW22hFLKMxHl28mLX1/nlXfHcu4QwZI7Q+whEIGi9eg58GjKTFCutCa4T8Paf
         sJ1MVANY0FpVae45yFZHQBZGNgwu7DUt85P7wpuekKTLikDL5y7UkOq4nI/qVkWOvnnh
         YBp2N+fd0Ll5rJAzyP+FHrJmddQV3ZANKqLpkZcLdv8KYP1yltxQum2SKaOg9Cu4To8A
         6pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh39CY7OKDO4zGxrF3Tom1rSCBIenfklbHsSPnOIW5A=;
        b=mzFps4bD6OazWk592QI0FogeDmpnXLuKwP7/oiVHIeVWVFp0I+4QM1tlcFY0gRmIg0
         2ifk9DIcfzf6tliyoXU12V/Z7W8+owroQ1HtIFKj3RrMfqekDMHh6EbRX4HfEUTZKej1
         2n6GD5NYNVKdHT3cCOz0K/f10kWzDJzrdXPGLOg2iAUYg0oI1/ywACEYtxwKt9b+XxqY
         +Tze9BUB1bCGyIjGsIibz6YsXnBk26HiX3K5tiRlehUaRpP0M0kQ68p1EQm27kr0wfg5
         w4AElL2EG+SM3dR9d0WDr5Fmu/WcdSiKzxmiIpvRdtAwpuGBp5Zz0bB/PZGbMaQaOcjC
         v5DQ==
X-Gm-Message-State: APjAAAU2baZfbvsmkVLLNxeEbjigDaruaYrID1WqwBuTbCaO2UTw2gCr
        muxw5YhqS14QA+nRv3PU2XZKdYeC1vvMH4SpxNQ=
X-Google-Smtp-Source: APXvYqx2NzKpu4nH/AyVuBWvWNwwxl/NNMsVJepqyt6Crnjtjx7BPXKmQgOUnhJpuUqhRgxBbamZCRasVfKFfYaycD4=
X-Received: by 2002:a81:608a:: with SMTP id u132mr3521701ywb.474.1566423786210;
 Wed, 21 Aug 2019 14:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com> <20190820064620.5119-1-drake@endlessm.com>
In-Reply-To: <20190820064620.5119-1-drake@endlessm.com>
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Wed, 21 Aug 2019 22:42:29 +0100
Message-ID: <CAAMvbhH=ftMoh9eFVR3YgN9DVSLaN5tXa-vTsBocY8YuL0Rc1A@mail.gmail.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, hadess@hadess.net,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 at 07:47, Daniel Drake <drake@endlessm.com> wrote:
>
> Hi,
>
> And if there is a meaningful way to make the kernel behave better, that would
> obviously be of huge value too.
>
> Thanks
> Daniel

Hi,

Is there a way for an application to be told that there is a memory
pressure situation?
For example, say I do a "make -j32"  and half way through the compile
it hits a memory pressure situation.
If make could have been told about it. It could give up on some of the
parallel compiles, and instead proceed as if the user have typed "make
-j4". It could then re-try the failed compile parts, that failed due
to memory pressure.
I know all applications won't be this clever, but providing a kernel
API so that an application could do something about it, if the
programmer of that application has thought about it.
It could be similar with say, a hadoop application. If the hadoop
process detects memory pressure, if could back off, and process the
data more slowly and not try to do so much at the same time.
The kernel could also detect which processes are contributing most to
the memory pressure (trying to do mallocs) and give them less
processor time, and instead ask all processes to release some memory,
and those processes that understood the kernel API for that
notification could actually do something about it.

I have also found, for the desktop, one of the biggest pressures on
the system is disk pressure. Accessing the disk causes the UI to be
less responsive.
For example, if I am in vim, and trying to type letters on the
keyboard, whether some other application is using the disk or not
should have no impact on my letter writing. Has anyone got any ideas
with regards to what we can do about that?

Kind Regards

James
