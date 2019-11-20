Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668DEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9AE2251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYpO4a7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfKTMZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:25:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34255 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfKTMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:25:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id w11so1051510ote.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYgI0VLRNUN7kGlwtQOhcKfVKjsn5CpZCcyjwK+JBuU=;
        b=oYpO4a7otTiBBVP2Fikj8E9kvgnt5fpa5QuIOuCHoF/4MGJFOD7z2MRs1GseXm/lDt
         dijXE9CE8DP92UddlX2Cr6URFziJCO/0Bp5h5KCYs8bPmSlDQTJVlMzNsqmc/q/V3omb
         +Rc4mfhwnRYbvYOaZAPKCcnNaUrvDBxgEhPBCxB+ErD44INKJbxOQDMAb3tnOJDiAIPr
         vFAFH53/HyVZ/OSA0KFuDxByweOVbZghH5W9gcGAivrM45sLXV100RM2wAt/HuDANOzY
         dBKHzBO3d6p38VgJjWFoBchGMQDAwtewx0NjOOqS5eTbZzZos/XJTWgxwTSvfKaRDP0s
         9pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYgI0VLRNUN7kGlwtQOhcKfVKjsn5CpZCcyjwK+JBuU=;
        b=g0qTar3CjWtdfMifgyhbhqBvoW3d6aWD9Xw+Bb5toFGaRRJSuIHtN7d48Lvg4L2yEb
         TU1RpT5bAy/VSpkdXLy5BEzbbVDVsR4x63UoZ9VRt5ar3i2MT7szUxoAVwfqzyJxiSN1
         tNzlrlOELj4ikilSwdfsj5DonRQP69DFCYRIDLgkijxGMtV5ldtSjnFfc21DX1Ht534e
         MwTYzgkqQSH472D9Q04/NY29fWwIALzh+KBqHDCwWJtFjXV3ZM7BtmHnmwZ9Eu/Yt4PX
         pe22IA/kguVpVXuzhQSqOOspKOirllCmfiQCDaQm5QZ9feI+VknY1J+O7dm2KehsOtFZ
         9gzw==
X-Gm-Message-State: APjAAAUMs7LVWvOWKMTHBbS47+Vu97zRbiyfpmtT0RAjRoHZ8SCigB4V
        GnM5Ofde+LlpEciiQG5xDKI3N/ColGVfP/ISlH/g4A==
X-Google-Smtp-Source: APXvYqzV/XPTNNQftDth4ZwuUlSM9e55pt+OjWoaLNyA6VorFcN0WeTaH3xFH3TZ3JUOur/FXML9rdEHqjjwcIHmwKM=
X-Received: by 2002:a9d:7e8a:: with SMTP id m10mr1856077otp.180.1574252756578;
 Wed, 20 Nov 2019 04:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20191120103613.63563-1-jannh@google.com> <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com> <20191120112408.GC2634@zn.tnic>
In-Reply-To: <20191120112408.GC2634@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Nov 2019 13:25:30 +0100
Message-ID: <CAG48ez26RGztX7O9Ej5rbz2in0KBAEnj1ic5C-8ie7=hzc+d=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:24 PM Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Nov 20, 2019 at 12:18:59PM +0100, Ingo Molnar wrote:
> > How was this maximum string length of '90' derived? In what way will
> > that have to change if someone changes the message?
>
> That was me counting the string length in a dirty patch in a previous
> thread. We probably should say why we decided for a certain length and
> maybe have a define for it.

Do you think something like this would be better?

char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
