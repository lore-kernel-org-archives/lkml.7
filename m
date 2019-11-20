Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB452243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CE0dlbug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfKTKcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:32:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39626 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKTKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:32:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id v138so22046283oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1foUI+kEt19/UqgoFCikIfHMIMozwp3Ih3L2RLMTA8=;
        b=CE0dlbuglNqXy2BlcP7q3N761DtVQcx05J0JODV4+Hk9+NBkfiJANif4o6d2WztNvY
         06iBIMfYeADhBZtqwz6NBo71IQ3W4vr9/ESJxJvWEHLqE7UHpTrHAhYCJotnNrwe/X6E
         CO5Qyu/TayZBGEDdjVEIxljHaQw8IUZ1POuJWzCfGjoPEw2I+CK67WguHu4MaDG7nZo8
         mzkyhXDyblw/5ObPcbaTQE/eE9L9LVVLodZcX62ytzmxRxc0NACwzbPdez8nYgwlAzjc
         CVNn1NRo3SDkPesG48CRkuqq3ceeua1Jydq0SdO0OwP163mllhE2r7ChGDC2T+sYQOqy
         gkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1foUI+kEt19/UqgoFCikIfHMIMozwp3Ih3L2RLMTA8=;
        b=mcVmDgh01o+jz2ii1sWkqprLh107K3vu40ewnSH7E6mjeXzYFxbbr+e3PhtBuyE+Wq
         0gQzzCErKtY6GaHnGW1NOZ2c7rF5knLmLNBywmnCt8D4R/ZDgOzQg5/72LfHdkkq6zjA
         df7+pz+EYm9DRPVKlxINOGZw0I0WnNNZPXUjPfWoBKEWQF3wTy9vz3WoEGcSMFlq5jz7
         IWcWOyOA4cEz/I2e3jP4yJCC4Ix/So45mQp6aNIF87nboOH8XIvfI/fPpTsAgt4HBV/u
         KoBm7+O+G97GH0b9QUP83dVvOXdc4z6TezOd+DuAEDrAZGzk7PgT058B8ln7cWpsmJiK
         OJDA==
X-Gm-Message-State: APjAAAVL8lpHZxUTW+9QyrytiHHP9WwlWROlnebRSLf9MndGA0qFeImY
        XGpEeTmMXv1lCgEJ4uhkAPKqpau9MjNMtrjRrcKoJw==
X-Google-Smtp-Source: APXvYqy9Wpp96M3gp+iHDtkEnvMax7RFGRnqfW55xF2x17eOwfM5gmaD626DxC/wepDeXnk4uHt9tX7wp1fMgkxb7dM=
X-Received: by 2002:aca:4a84:: with SMTP id x126mr2037189oia.47.1574245933839;
 Wed, 20 Nov 2019 02:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <87lfsbfa2q.fsf@linux.intel.com>
In-Reply-To: <87lfsbfa2q.fsf@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Nov 2019 11:31:47 +0100
Message-ID: <CAG48ez2QFz9zEQ65VTc0uGB=s3uwkegR=nrH6+yoW-j4ymtq7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 5:25 AM Andi Kleen <ak@linux.intel.com> wrote:
> Jann Horn <jannh@google.com> writes:
> > +             if (error_code)
> > +                     pr_alert("GPF is segment-related (see error code)\n");
> > +             else
> > +                     print_kernel_gp_address(regs);
>
> Is this really correct? There are a lot of instructions that can do #GP
> (it's the CPU's equivalent of EINVAL) and I'm pretty sure many of them
> don't set an error code, and many don't have operands either.
>
> You would need to make sure the instruction decoder handles these
> cases correctly, and ideally that you detect it instead of printing
> a bogus address.

Is there a specific concern you have about the instruction decoder? As
far as I can tell, all the paths of insn_get_addr_ref() only work if
the instruction has a mod R/M byte according to the instruction
tables, and then figures out the address based on that. While that
means that there's a wide variety of cases in which we won't be able
to figure out the address, I'm not aware of anything specific that is
likely to lead to false positives.

But Andy did suggest that we hedge a bit in the error message because
even if the address passed to the instruction is non-canonical, we
don't know for sure whether that's actually the reason why things
failed, and that's why it says "probably" in the message about the
address now.
