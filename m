Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC8821473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPlduTHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbfFMPJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:09:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42368 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbfFMN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so5614171wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mF/t8Vc3YmpUfAcfOp8dmky92LVPXpVO+34OWoDYALY=;
        b=JPlduTHaMif6czcMYjH+iK3zHDfuBg7MK5yig5ap/g7Ag1fTaFELEs+YoZW0y+d87C
         CU7htdxBFUN1SyhltslOLJT6dQoJReGZO+5fNgwDQI95qKOnCCY/9os6cBZXB/Re8G1u
         CnHQ2fKTzh8PM+cRx6udFksTDCI7/Bx2Eu8mAKwp9/usIFA8uMSXxtTaE5XcFpmVGg49
         vQGf6oOAXmZTw/dzqRwarMDvsm57qIcYj59YYrXGQi50dmU/glilhfLvp+dxsbqxM867
         zGtdcpKV6rNx8TbP0n1cvTETY/aZHlFHXGfq0agJBMWutPMajKINRzxMxQVtrBfQjjoh
         ovWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mF/t8Vc3YmpUfAcfOp8dmky92LVPXpVO+34OWoDYALY=;
        b=Xh3S2EGeEL5MHkhqDir2n/ZeSC8aPIOfNV2eWTphERIlh8virXkGcYTwC5diuUOyuH
         4713BBK6Ul/aqJzV+gB1ox83GjnQA3gba415Lh+7DqJ/93rdcTLy4VjouadZXnMC/52B
         Q+zEBpFrdXgifvI3DF0rc14C0qe6x4BDOCJcxsTAxmJmSnSBoOQQ/m5j6TlmnUrCiNs0
         ZxVuzDuQrpkE8TOhbUjeIxFRH/NUKnYU8g3lx7dc2RR0reKaBx5ZLPvyoZvyVduEylSY
         FTrloWU4EUtEOYf71mM/t6FoFmtloq3KNo99lDd/WO5dIFAh3xpXKR0TFwSAZfJrv7w3
         cb2w==
X-Gm-Message-State: APjAAAWnpPW6arMPSfhsKmuqhZKQg8HI6b3TwVs2MRjbYJPBUZvxa22N
        wIYfZgNRbKF7XAMlNEQ5kYo8wZBRWLi+drqV9PX7z04F
X-Google-Smtp-Source: APXvYqyGOk8mUWlcXn6d0r8IOUWdlMmLErqfMy6ExuXDc0C9puukqfkBOpVqz/zUvE5BpXaMuiDvB5XAxpVkVRjDQ7Q=
X-Received: by 2002:adf:f68f:: with SMTP id v15mr9752218wrp.4.1560434256044;
 Thu, 13 Jun 2019 06:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190530000819.GA25416@obi-wan> <20190604202149.GA20116@obi-wan>
In-Reply-To: <20190604202149.GA20116@obi-wan>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 Jun 2019 09:57:24 -0400
Message-ID: <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay with non-blocking
To:     Yrjan Skrimstad <yrjan@skrimstad.net>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 4:22 PM Yrjan Skrimstad <yrjan@skrimstad.net> wrote:
>
> On Thu, May 30, 2019 at 02:08:21AM +0200, Yrjan Skrimstad wrote:
> > This driver currently contains a repeated 500ms blocking delay call
> > which causes frequent major buffer underruns in PulseAudio. This patch
> > fixes this issue by replacing the blocking delay with a non-blocking
> > sleep call.
>
> I see that I have not explained this bug well enough, and I hope that is
> the reason for the lack of replies on this patch. I will here attempt to
> explain the situation better.
>
> To start with some hardware description I am here using an AMD R9 380
> GPU, an AMD Ryzen 7 1700 Eight-Core Processor and an AMD X370 chipset.
> If any more hardware or software specifications are necessary, please
> ask.
>
> The bug is as follows: When playing audio I will regularly have major
> audio issues, similar to that of a skipping CD. This is reported by
> PulseAudio as scheduling delays and buffer underruns when running
> PulseAudio verbosely and these scheduling delays are always just under
> 500ms, typically around 490ms. This makes listening to any music quite
> the horrible experience as PulseAudio constantly will attempt to rewind
> and catch up. It is not a great situation, and seems to me to quite
> clearly be a case where regular user space behaviour has been broken.
>
> I want to note that this audio problem was not something I experienced
> until recently, it is therefore a new bug.
>
> I have bisected the kernel to find out where the problem originated and
> found the following commit:
>
> # first bad commit: [f5742ec36422a39b57f0256e4847f61b3c432f8c] drm/amd/powerplay: correct power reading on fiji
>
> This commit introduces a blocking delay (mdelay) of 500ms, whereas the
> old behaviour was a smaller blocking delay of only 1ms. This seems to me
> to be very curious as the scheduling delays of PulseAudio are always
> almost 500ms. I have therefore with the previous patch replaced the
> scheduling delay with a non-blocking sleep (msleep).
>
> The results of the patch seems promising as I have yet to encounter any
> of the old <500ms scheduling delays when using it and I have also not
> encountered any kernel log messages regarding sleeping in an atomic
> context.

The patch is fine and I can apply it (I don't think there are any
restrictions on sleeping in sysfs), but this code only gets executed
when you actually read the power status from the card (e.g., via sysfs
or debugfs).  Presumably you have something in userspace polling one
of those files on a regular basis?

Alex
